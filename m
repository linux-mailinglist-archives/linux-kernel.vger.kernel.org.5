Return-Path: <linux-kernel+bounces-87182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5073486D0CB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA60AB21485
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D7870AEE;
	Thu, 29 Feb 2024 17:36:12 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511716062E;
	Thu, 29 Feb 2024 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228171; cv=none; b=Bg2veMglUgwpUv2RYVTs1jDsLPhAeo8jelcVPU4JezQX1sr0ZepqeRpf8tlMEdGgGQfVXM+gDYQwQDinxhSAVPQcPA90rWZj/lniGfo5JXv5pgtyxcsXTIYAusBAq2qQW+OOOZso3PgJVj9oN8veetlm7uJ17BFfqjPv2sjr4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228171; c=relaxed/simple;
	bh=5lQsEr6Qh9tHM7o+Jd5giKSHuT+ZJAdZpli4wmPcN48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdzewnuJkMdK60uSqs1ofvGwsFAxQ6sTozx7wR7fXlO9pcbd9dBR6YP0HdB9kQJlNKIWPI4bPYKL5sMaMbgx2/3/MAgEFBY9VD593aNcEWmuJqM+2e9rogsX634+fUufiHDlcYp91qzKhvhuRfj0EMQAmaSVc9VDepwOt7NHueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a05210e560so44964eaf.1;
        Thu, 29 Feb 2024 09:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228169; x=1709832969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxEwKBuAzFb8rhBPqNIU8KxSxIjpcceOLSxQpziJruE=;
        b=P7Vwulba4Xdbr1pIjbXnQ/7EZGCaP5cYzQ5IwT31jt4nFdYfKTnLgLsVwATQXeoReN
         rze+/CUQksHt7ntitYyBm1aT1OoLkdh3zhvt4Wi15zSld34ZB7x6MnDA72UBm7/Mi0Uy
         kuVb0Mb2wNfR1IhIwRcpuP8vtTqUFkx+u3fr3onzvd/TnwmEelj2wbmwbNqK/Q9cGIqf
         bFpD77sjLrxw07tUKRD59sAqqWSCBNNyzNf4OiTrQaAOaTLi+/LjplnGTQd2s/TkJEwI
         djxdkg9jRIvLolh5X3/ovC5tNfo172QUY9j590F/wAvki+nhsSGQrm+IOTWRBKpDw/zp
         E8TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1UWxRrRMMohep3uHjvtkPFpxBmTGJSydmkCSzECM0Dp21vIvqy2WigJLL8onUAp6zoU7hpIpJgxVRK3wBp7S3T7qNs5xZQAakiuKd
X-Gm-Message-State: AOJu0Yx2/NqjoVWdXht+A8TAVaa1wxWPYUgP72sRo+ZKw/Av1hVbRV2Y
	CX/ueW6MMkEKkT5v0Mx//CThI6FPddFQk7/eZVbOYf4EmKS3DzVuActjGOaWFI2d8WUR3N7MMi5
	cq2qTYQzSvKzLUVA+8GmirOnGfGg=
X-Google-Smtp-Source: AGHT+IHSHULtjuulGXkkgXIXLdWokYIfmMcJqUGZZxuJPfoeScx8O2YVwHmCBwrCNkorYcyVsq5UUxrpvCxyIfyId0I=
X-Received: by 2002:a4a:d317:0:b0:5a0:2cbe:43dd with SMTP id
 g23-20020a4ad317000000b005a02cbe43ddmr2801222oos.1.1709228169391; Thu, 29 Feb
 2024 09:36:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229062245.2723548-1-avadhut.naik@amd.com>
In-Reply-To: <20240229062245.2723548-1-avadhut.naik@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 18:35:58 +0100
Message-ID: <CAJZ5v0h4Z_gND9nTBFeWmW+y5TMG-FjxmaFXPWPX7hRjWe9UPw@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: APEI: Skip initialization of GHES_ASSIST
 structures for Machine Check Architecture
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	james.morse@arm.com, tony.luck@intel.com, bp@alien8.de, 
	linux-kernel@vger.kernel.org, yazen.ghannam@amd.com, avadnaik@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 7:22=E2=80=AFAM Avadhut Naik <avadhut.naik@amd.com>=
 wrote:
>
> To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
> a set of GHES structures is provided by the system firmware for each MCA
> error source. Each of these sets consists of a GHES structure for each MC=
A
> bank on each logical CPU, with all structures of a set sharing a common
> Related Source ID, equal to the Source ID of one of the MCA error source
> structures.[1] On SOCs with large core counts, this typically equates to
> tens of thousands of GHES_ASSIST structures for MCA under
> "/sys/bus/platform/drivers/GHES".
>
> Support for GHES_ASSIST however, hasn't been implemented in the kernel. A=
s
> such, the information provided through these structures is not consumed b=
y
> Linux. Moreover, these GHES_ASSIST structures for MCA, which are supposed
> to provide supplemental information in context of an error reported by
> hardware, are setup as independent error sources by the kernel during HES=
T
> initialization.
>
> Additionally, if the Type field of the Notification structure, associated
> with these GHES_ASSIST structures for MCA, is set to Polled, the kernel
> sets up a timer for each individual structure. The duration of the timer
> is derived from the Poll Interval field of the Notification structure. On
> SOCs with high core counts, this will result in tens of thousands of
> timers expiring periodically causing unnecessary preemptions and wastage
> of CPU cycles. The problem will particularly intensify if Poll Interval
> duration is not sufficiently high.
>
> Since GHES_ASSIST support is not present in kernel, skip initialization
> of GHES_ASSIST structures for MCA to eliminate their performance impact.
>
> [1] ACPI specification 6.5, section 18.7
>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes in v2:
> 1. Since is_ghes_assist_struct() returns if any of the conditions is hit
> if-else-if chain is redundant. Replace it with just if statements.
> 2. Fix formatting errors.
> 3. Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>
> Changes in v3:
> 1. Modify structure (mces) comment, per Tony's recommendation, to better
> reflect the structure's usage.
>
> Changes in v4:
> 1. No changes within the patch. Just sending out to gather more attention=
.
> 2. Add Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/acpi/apei/hest.c | 51 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 6aef1ee5e1bd..20d757687e3d 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
>
>  static struct acpi_table_hest *__read_mostly hest_tab;
>
> +/*
> + * Since GHES_ASSIST is not supported, skip initialization of GHES_ASSIS=
T
> + * structures for MCA.
> + * During HEST parsing, detected MCA error sources are cached from early
> + * table entries so that the Flags and Source Id fields from these cache=
d
> + * values are then referred to in later table entries to determine if th=
e
> + * encountered GHES_ASSIST structure should be initialized.
> + */
> +static struct {
> +       struct acpi_hest_ia_corrected *cmc;
> +       struct acpi_hest_ia_machine_check *mc;
> +       struct acpi_hest_ia_deferred_check *dmc;
> +} mces;
> +
>  static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] =3D {
>         [ACPI_HEST_TYPE_IA32_CHECK] =3D -1,       /* need further calcula=
tion */
>         [ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] =3D -1,
> @@ -70,22 +84,54 @@ static int hest_esrc_len(struct acpi_hest_header *hes=
t_hdr)
>                 cmc =3D (struct acpi_hest_ia_corrected *)hest_hdr;
>                 len =3D sizeof(*cmc) + cmc->num_hardware_banks *
>                         sizeof(struct acpi_hest_ia_error_bank);
> +               mces.cmc =3D cmc;
>         } else if (hest_type =3D=3D ACPI_HEST_TYPE_IA32_CHECK) {
>                 struct acpi_hest_ia_machine_check *mc;
>                 mc =3D (struct acpi_hest_ia_machine_check *)hest_hdr;
>                 len =3D sizeof(*mc) + mc->num_hardware_banks *
>                         sizeof(struct acpi_hest_ia_error_bank);
> +               mces.mc =3D mc;
>         } else if (hest_type =3D=3D ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
>                 struct acpi_hest_ia_deferred_check *mc;
>                 mc =3D (struct acpi_hest_ia_deferred_check *)hest_hdr;
>                 len =3D sizeof(*mc) + mc->num_hardware_banks *
>                         sizeof(struct acpi_hest_ia_error_bank);
> +               mces.dmc =3D mc;
>         }
>         BUG_ON(len =3D=3D -1);
>
>         return len;
>  };
>
> +/*
> + * GHES and GHESv2 structures share the same format, starting from
> + * Source Id and ending in Error Status Block Length (inclusive).
> + */
> +static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
> +{
> +       struct acpi_hest_generic *ghes;
> +       u16 related_source_id;
> +
> +       if (hest_hdr->type !=3D ACPI_HEST_TYPE_GENERIC_ERROR &&
> +           hest_hdr->type !=3D ACPI_HEST_TYPE_GENERIC_ERROR_V2)
> +               return false;
> +
> +       ghes =3D (struct acpi_hest_generic *)hest_hdr;
> +       related_source_id =3D ghes->related_source_id;
> +
> +       if (mces.cmc && mces.cmc->flags & ACPI_HEST_GHES_ASSIST &&
> +           related_source_id =3D=3D mces.cmc->header.source_id)
> +               return true;
> +       if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
> +           related_source_id =3D=3D mces.mc->header.source_id)
> +               return true;
> +       if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&
> +           related_source_id =3D=3D mces.dmc->header.source_id)
> +               return true;
> +
> +       return false;
> +}
> +
>  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void =
*data);
>
>  static int apei_hest_parse(apei_hest_func_t func, void *data)
> @@ -114,6 +160,11 @@ static int apei_hest_parse(apei_hest_func_t func, vo=
id *data)
>                         return -EINVAL;
>                 }
>
> +               if (is_ghes_assist_struct(hest_hdr)) {
> +                       hest_hdr =3D (void *)hest_hdr + len;
> +                       continue;
> +               }
> +
>                 rc =3D func(hest_hdr, data);
>                 if (rc)
>                         return rc;
>
> base-commit: 07a90c3d91505e44a38e74e1588b304131ad8028
> --

Applied as 6.9 material, thanks!

