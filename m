Return-Path: <linux-kernel+bounces-160491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D3E8B3E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCF9285034
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E249A171678;
	Fri, 26 Apr 2024 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0o+32H/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2B15D5B4;
	Fri, 26 Apr 2024 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152330; cv=none; b=dRqggqWy/YP7krNoejP6apB72Ck2KW5XeG/z7Nz2cox5kjrsCL9nlbaOarPGeB/LBQFiuuoYu54tYfeQwMwoDQb13J/xyvUmVN9dezzZ0H5IFOJqWtFkHuyk3ycs156KYToLbSyiEF/FYZsYXf6VczRodyLhpOZPK5/MZSFzltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152330; c=relaxed/simple;
	bh=Q4NMk1LWHobI2cFlkQGEnn9B9bKM62Lmg3LIQHygs7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGuKwhuCUSUc9aqCrROJmAIxikECxJs1/bgH2lBgsuEmOtxl5s0hdNzGFxINURKyqmv4oVFbzM4gddL88mtcCLbtRJ+f257Wu/X8PyOTdXcGs/wf/VOiTByCTFELUwpZARAZj2bcJ1et6J9q7CUJnh7LP5OIxC8MiMdVnFdTXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0o+32H/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9FEC116B1;
	Fri, 26 Apr 2024 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714152329;
	bh=Q4NMk1LWHobI2cFlkQGEnn9B9bKM62Lmg3LIQHygs7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c0o+32H/vJV9bYx5Ho4HsNH5Ndk4QN/uEg+QKnO91w62UW8CFeVOdrRHFabLzOaij
	 HsVSmxT8f5kcoKAYvFx2dd7mJBuKHclIG73pVihPd6kn1aG0Wcw0mufZv8YlM8sz87
	 SA+BBvul43pbhxecfdTMRQZoMVUEuNq2rn676ouiqKFGvOxkqaVPUI+/DOX8SAohZS
	 FvOhA8HCQ23/MzLDi+XMOaGxCG9gXaL6ye24v/61PP4ws0u59DGcGyI0w54iVfk2RG
	 h/+qs/f1kljLIjHkUpXdn3dFOmLO78ZluCW3sKgA/pjqYi/kCzmChuF6VHG5jeG4b5
	 sFnVsbH7todtg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ad288442bdso443736eaf.3;
        Fri, 26 Apr 2024 10:25:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLclQiRz7CVfhnwqeeMfHe0yofkwmSoLjN/PVP4YUtC7sqAVBIqIqmXzp5JyLbP/wzxM8nt2iLypRV4fxaE3O0b9j0Oaf5Rv9U7YWuBGDCoiaPZUzvYoFu0f5D0XZdBcY0AoTCGt2Rww==
X-Gm-Message-State: AOJu0YzLv6p2LVwx+WGIsBtt27A87mgbb+Ny3qK/rjqmFMw5I9pm72/I
	UR5f2ipTrknR4sBpx7e9KcAw4eLfmrbS1juvG2cE/qrUEnicgF1TDEG1CYV7YXI0CeZLGk36BW5
	3zrcVEEa8td39mPsXSuuUDib/RLQ=
X-Google-Smtp-Source: AGHT+IHhmE2vUk7aKRQUcQQBItXDTuoDLciySuj2IxP8i7tqtQP+eDPHpHX5Av449I7nF2i0zRt8MaaP1hJJa3e3s/8=
X-Received: by 2002:a05:6870:781a:b0:229:e46d:763a with SMTP id
 hb26-20020a056870781a00b00229e46d763amr3885833oab.0.1714152328963; Fri, 26
 Apr 2024 10:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331051126.10024-1-rithvik.rama@gmail.com>
In-Reply-To: <20240331051126.10024-1-rithvik.rama@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Apr 2024 19:25:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0heV36XbRy8TynZuB_sLTKHQDPTiuG_KxX=yYoF4oU0Yg@mail.gmail.com>
Message-ID: <CAJZ5v0heV36XbRy8TynZuB_sLTKHQDPTiuG_KxX=yYoF4oU0Yg@mail.gmail.com>
Subject: Re: [PATCH] ACPI/ADXL: Added function for ADXL DSM Function 3
To: Rithvik Rama <rithvik.rama@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 7:11=E2=80=AFAM Rithvik Rama <rithvik.rama@gmail.co=
m> wrote:
>
> Current driver supports only Function Index 1 & 2 as mentioned in the
> ACPI ADXL DSM Interface. Added a function for ACPI Function Index 3.

What's happened that it has become useful now?

Who's going to use it and for what purpose?

> Signed-off-by: Rithvik Rama <rithvik.rama@gmail.com>
> ---
>  drivers/acpi/acpi_adxl.c | 54 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/adxl.h     |  1 +
>  2 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_adxl.c b/drivers/acpi/acpi_adxl.c
> index 13c8f7b50c46..5bf53662b737 100644
> --- a/drivers/acpi/acpi_adxl.c
> +++ b/drivers/acpi/acpi_adxl.c
> @@ -14,6 +14,7 @@
>  #define ADXL_REVISION                  0x1
>  #define ADXL_IDX_GET_ADDR_PARAMS       0x1
>  #define ADXL_IDX_FORWARD_TRANSLATE     0x2
> +#define ADXL_IDX_REVERSE_TRANSLATE     0X3
>  #define ACPI_ADXL_PATH                 "\\_SB.ADXL"
>
>  /*
> @@ -135,6 +136,56 @@ int adxl_decode(u64 addr, u64 component_values[])
>  }
>  EXPORT_SYMBOL_GPL(adxl_decode);
>
> +/**
> + * adxl_reverse_decode - Ask BIOS to decode a memory address to system a=
ddress
> + * @component_values: pointer to array of values for each component
> + * Returns 0 on success, negative error code otherwise
> + *

Redundant line.

> + */
> +
> +int adxl_reverse_decode(u64 component_values[])
> +{
> +       union acpi_object *argv4, *results, *r;
> +       int i, cnt;
> +
> +       argv4 =3D kzalloc((adxl_count+1)*sizeof(*argv4), GFP_KERNEL);

kcalloc()?

> +       if (!argv4)
> +               return -ENOMEM;
> +
> +       if (!adxl_component_names)
> +               return -EOPNOTSUPP;

This could be checked before allocating memory which is now leaked if
it is NULL.

This function generally leaks the argv4 memory AFAICS.

> +
> +       argv4[0].type =3D ACPI_TYPE_PACKAGE;
> +       argv4[0].package.count =3D adxl_count;
> +       argv4[0].package.elements =3D &argv4[1];
> +
> +       /*
> +        * Loop through supported memory component values
> +        */
> +       for (i =3D 1; i <=3D adxl_count; i++) {
> +               argv4[i].integer.type =3D ACPI_TYPE_INTEGER;
> +               argv4[i].integer.value =3D component_values[i-1];
> +       }
> +
> +       results =3D adxl_dsm(ADXL_IDX_REVERSE_TRANSLATE, argv4);
> +       if (!results)
> +               return -EINVAL;
> +
> +       r =3D results->package.elements + 1;
> +       cnt =3D r->package.count;
> +       if (cnt !=3D adxl_count) {
> +               ACPI_FREE(results);
> +               return -EINVAL;
> +       }
> +       r =3D r->package.elements;
> +       for (i =3D 0; i < cnt; i++)
> +               component_values[i] =3D r[i].integer.value;
> +
> +       ACPI_FREE(results);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(adxl_reverse_decode);

No users of this are being added.

For this to be applicable, you need to also submit a patch adding a
caller of adxl_reverse_decode().

> +
>  static int __init adxl_init(void)
>  {
>         char *path =3D ACPI_ADXL_PATH;
> @@ -155,7 +206,8 @@ static int __init adxl_init(void)
>
>         if (!acpi_check_dsm(handle, &adxl_guid, ADXL_REVISION,
>                             ADXL_IDX_GET_ADDR_PARAMS |
> -                           ADXL_IDX_FORWARD_TRANSLATE)) {
> +                           ADXL_IDX_FORWARD_TRANSLATE |
> +                           ADXL_IDX_REVERSE_TRANSLATE)) {
>                 pr_info("DSM method does not support forward translate\n"=
);
>                 return -ENODEV;
>         }
> diff --git a/include/linux/adxl.h b/include/linux/adxl.h
> index 2a629acb4c3f..f3fea64a270c 100644
> --- a/include/linux/adxl.h
> +++ b/include/linux/adxl.h
> @@ -9,5 +9,6 @@
>
>  const char * const *adxl_get_component_names(void);
>  int adxl_decode(u64 addr, u64 component_values[]);
> +int adxl_reverse_decode(u64 component_values[]);
>
>  #endif /* _LINUX_ADXL_H */
> --

