Return-Path: <linux-kernel+bounces-103518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72BD87C082
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806A6284695
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D8C71B54;
	Thu, 14 Mar 2024 15:39:23 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912471B20;
	Thu, 14 Mar 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430762; cv=none; b=B6vT26IkocdXlVtX5mOHk8218s1k3WLhLGKlxWkdhHA4AbrTV0NFJOaeGm0eqKLJM0g/tpxYH1Tk4ijppD8JQiL2LuPdFYNE3zveUD1l65cOiVUcZ3oT2YAgZIr0CO9a4Kn6WiU7V2N750OuKBLS3OQWrrN0OHVpgRD4gxhvTRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430762; c=relaxed/simple;
	bh=RqAwxC+r6BxzdQNPLjy42rMTlUFF3/b+ExPwj7EGxug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuaYoVHTCgf8M4sXVDygBzt0X5RDXwsLMsUrgDMlEaH5xHp7/Fuhtzlnq8AyfcNtLwOCHsbChGcx+YhLksEwGupvUh5Nsl04RPjRdyU0LXA0twMexNSjCDqdrzL4N2tRvhwfBT3yH+aGw9GSG5Fh5yiHkK+wdXZ8o9OrsXQdKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-221d4c52759so94481fac.1;
        Thu, 14 Mar 2024 08:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430760; x=1711035560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqfz94TfI8eBe+oW7+FvouKqicHZ2DlDCCTyZ/mvmvA=;
        b=D/3MR5H4w29YsUxdjc1JegJi9a+ZlWSoFX0HzkaAWFxYi1zmjCZ/nBYSzo9ILj5quz
         2JS7Lqq8MSwuAGz5xqFVOqKJGrijUZLhPQNOJe1ZXu7ljt1dEBX2Ta8AqN+V4dHpsRi7
         ahwkreRzjke58OP/pRfNcuGlLw9i9Y5LA2U1te5sn+aSWq44EJ5hAbga2qFIWXF1qXPJ
         3/sM0SYg+TpLF/VrrN962lcPY6DtplEzePAjDkN3eDl3yGaKx5G+AYkMB6Jm0j16vymS
         7IcYi+J7A3a0qOiikm9C8iRzSxm/9pICh/SfvH3BJjz96JYYLEy/e7Ld2+0q9vcAjDcj
         +XXg==
X-Forwarded-Encrypted: i=1; AJvYcCV+L9zDdLwOaDn30y5kew3Jp2AX6MysU4u7K6WRMRsDUlH8sgbdVW6Q4Dbsiyg5weMHEhh1O9+mRq4pgLXGKbGEdQecdv+csD1Bgp3+HRSqqdFx3wnZUPf52otVZiZTbDyDvcXA4T0anw==
X-Gm-Message-State: AOJu0Ywi7hZjcgTCp4HUcWiLmsbU9+kJW/FwEOiy0lUJTg3zAqXnynsH
	Lt8wHLOFOa/TvUQ114/bDd/2kXpLrRqcWgcpeJr8CqUCDTfMd3ly+V5nlQF3fGWT/pCJVAzL+n7
	YMoNRcOr444YxGR0Cz4ADjjw4HKc=
X-Google-Smtp-Source: AGHT+IF/hswpYvINAKDljbW7/WpSwgNIbI4X01V+IcBYS+xigRd3Ea7qNnvlJ20bncm7jOcmKJzV7VdD7YUbyQhSLYA=
X-Received: by 2002:a05:6870:5e4d:b0:221:3b96:4e84 with SMTP id
 ne13-20020a0568705e4d00b002213b964e84mr2263277oac.5.1710430760371; Thu, 14
 Mar 2024 08:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313214038.479253-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240313214038.479253-1-chris.packham@alliedtelesis.co.nz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Mar 2024 16:39:09 +0100
Message-ID: <CAJZ5v0hi_eGEu-ON5SLLwE_m_ut55FYtmn8eJ848FseHYV+F+g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: docs: enumeration: Make footnotes links
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 10:40=E2=80=AFPM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Update the numeric footnotes so that they are rendered as hyperlinks in
> the html output.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  Documentation/firmware-guide/acpi/enumeration.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Document=
ation/firmware-guide/acpi/enumeration.rst
> index d79f69390991..0165b09c0957 100644
> --- a/Documentation/firmware-guide/acpi/enumeration.rst
> +++ b/Documentation/firmware-guide/acpi/enumeration.rst
> @@ -595,7 +595,7 @@ bridges/switches of the board.
>
>  For example, let's assume we have a system with a PCIe serial port, an
>  Exar XR17V3521, soldered on the main board. This UART chip also includes
> -16 GPIOs and we want to add the property ``gpio-line-names`` [1] to thes=
e pins.
> +16 GPIOs and we want to add the property ``gpio-line-names`` [1]_ to the=
se pins.
>  In this case, the ``lspci`` output for this component is::
>
>         07:00.0 Serial controller: Exar Corp. XR17V3521 Dual PCIe UART (r=
ev 03)
> @@ -637,7 +637,7 @@ of the chipset bridge (also called "root port") with =
address::
>         Bus: 0 - Device: 14 - Function: 1
>
>  To find this information, it is necessary to disassemble the BIOS ACPI t=
ables,
> -in particular the DSDT (see also [2])::
> +in particular the DSDT (see also [2]_)::
>
>         mkdir ~/tables/
>         cd ~/tables/
> @@ -667,7 +667,7 @@ device::
>                         }
>         ... other definitions follow ...
>
> -and the _ADR method [3] returns exactly the device/function couple that
> +and the _ADR method [3]_ returns exactly the device/function couple that
>  we are looking for. With this information and analyzing the above ``lspc=
i``
>  output (both the devices list and the devices tree), we can write the fo=
llowing
>  ACPI description for the Exar PCIe UART, also adding the list of its GPI=
O line
> @@ -724,10 +724,10 @@ created analyzing the position of the Exar UART in =
the PCI bus topology.
>  References
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -[1] Documentation/firmware-guide/acpi/gpio-properties.rst
> +.. [1] Documentation/firmware-guide/acpi/gpio-properties.rst
>
> -[2] Documentation/admin-guide/acpi/initrd_table_override.rst
> +.. [2] Documentation/admin-guide/acpi/initrd_table_override.rst
>
> -[3] ACPI Specifications, Version 6.3 - Paragraph 6.1.1 _ADR Address)
> +.. [3] ACPI Specifications, Version 6.3 - Paragraph 6.1.1 _ADR Address)
>      https://uefi.org/sites/default/files/resources/ACPI_6_3_May16.pdf,
>      referenced 2020-11-18
> --

Applied as 6.9-rc material, thanks!

