Return-Path: <linux-kernel+bounces-83109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28B0868E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D57328408A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19E1139584;
	Tue, 27 Feb 2024 11:14:05 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC02137C38;
	Tue, 27 Feb 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032445; cv=none; b=gSgMORBhfbBBn5DsFsFSPFG6MJ7OIZz5rRPsxZYwTuEy4s+53U0uwJhmMEV7kwFhNlJaQWUtMHLmjnPhOb+WzE1Cx3G4fIZA9DseXEyrroC2d7AELnTkVGL6dVUXFPcL/2BDx+1/qDmDCeVqTwhvk5BmeAafGevUYZ7gTLjwITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032445; c=relaxed/simple;
	bh=MVXIRlrBqlDw6Ivndp/P8xBINKY02FK42546s1P+zn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3WksnEuuElTihBnCpIxcn5jxfM32Z782vjaEzb9RjXxs2vj0SNEeOPNMfP+4f02FlCLiZSyG9GXA728P2D7UD9LmojEr3XIVTb4A2z/c9uW55LkTcsdNwITJcbbUTUqpoxJmzVJsHFvGDqzCBZPiFIDc0p1YDCfWaSMI+cSzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a0b0a2819cso121604eaf.0;
        Tue, 27 Feb 2024 03:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709032443; x=1709637243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVXIRlrBqlDw6Ivndp/P8xBINKY02FK42546s1P+zn4=;
        b=r3blyjUfU3/AKmYMUKaeiGrmtDMFQ6nhk48NTQtFksHnVEsMoUwpWY1wRD3EB/zZGm
         4X99UzkR/ceZfH1C98BD5+pY2ysQKkQKMY9nFUP3XJmJsPj7jilt3FAkC7npG31VoIR8
         wB3sa2QlumYSD5FSw+Gu6FoGPgllIfROkQtgNIG5Hw/4qMo2wPeKSh/kTpxHv5Rxmdzv
         dX1PdrGBj61FiQPJ8Vuz4qiFAFH6k1GRtBsZ1UwZvXajLeZKNji3ruinK1fM/29UNBNj
         bgtIzVo4mdwUsw1GV2vE/HDHSLwewggR+YREQWzwF6I2fLbnXV2c5gvP7uaGXF5gn2hZ
         x3yA==
X-Forwarded-Encrypted: i=1; AJvYcCUYd9lNGbOlBLCp6Nq6XBxOQR5VKM5JmKc7apHvyJQiYUQfpfDfeH50Ur/nz27zu1L7SaOdNmxHTHe/Qsllpbxljye39ZRpzxp/WapDpBBvStBnszZEfYFdBOS/GWE2WnQL+yMLWC4EZw==
X-Gm-Message-State: AOJu0YwXPsTbHbu54MoSb28lXiF9KqMSxWJLQRWbXCsNDqdnw0zMBB8S
	WzfA+Y2+cEcNxEveFU2bMOOHJwqIUSoCA6t5xKMgLpu+3sQYD7/ouYtVc6g4CPF98WKkKbcrOOc
	v/QUIB1fUJ3lNSwmUmy8/Usq3Ovc=
X-Google-Smtp-Source: AGHT+IHwKvECtDn2ThFyzPDi1di21uzZhb9hT/KQBEm+6WSIlFIx6C8QxuYjWDZbhjciyHLhf6t4SAUVIcyyP1/DCcI=
X-Received: by 2002:a4a:d996:0:b0:5a0:4216:c5f0 with SMTP id
 k22-20020a4ad996000000b005a04216c5f0mr8840444oou.0.1709032442924; Tue, 27 Feb
 2024 03:14:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6021126.lOV4Wx5bFT@kreacher> <3283809.44csPzL39Z@kreacher> <20240227092844.00006d49@Huawei.com>
In-Reply-To: <20240227092844.00006d49@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Feb 2024 12:13:50 +0100
Message-ID: <CAJZ5v0jCPO9H-dCdew7LoUwg__wFwY60HYphxEgN_-=0Pe87Hg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ACPI: scan: Make acpi_processor_add() check the
 device enabled bit
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, kangkang.shen@futurewei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:28=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 26 Feb 2024 17:40:52 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Modify acpi_processor_add() return an error if _STA returns the enabled
> > bit clear for the given processor device, so as to avoid using processo=
rs
> > that don't decode their resources, as per the ACPI specification. [1]
> >
> > Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-=
device-status # [1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Sorry for lack of reply on discussion.

No worries.

> Your follow up mails never reached my inbox for some reason

/me blames spam filters somewhere.

> so I just caught up on lore. I'll keep an eye on
> the archives to make sure I don't miss further discussion.

Thanks!

> Agreed that functional isn't relevant here so this patch is correct.
> Also agree that it would be nice to clarify the spec as you mentioned
> to say that bit 1 is reserved if bit 0 of _STA result is clear.
> Depending on interpretation it's either a clarification or a relaxation
> of current statements, so should be uncontroversial (famous last words ;)

Right.

> +CC kangkang so this is on his radar as an ACPI cleanup suggestion.
> For his reference, discussion is here:
> https://lore.kernel.org/linux-acpi/CAJZ5v0jjD=3DKN0pOuWZZ8DT5yHdu03KgOSHY=
e3wB7h2vafNa44w@mail.gmail.com/
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for all of the reviews!

