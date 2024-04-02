Return-Path: <linux-kernel+bounces-128594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5168F895CE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53671F2195C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D0E15CD59;
	Tue,  2 Apr 2024 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue84BwGu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF515B98D;
	Tue,  2 Apr 2024 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086839; cv=none; b=r1zm7h4TnuuqEVJWeMwCUhXb2tXpXwQ1ct8jquhexHurHYkWfqd3PH8PMbjjgpfUEEMuhOTSjJ6E6/1xKH8MbOWjO87GVtXpRKDH8IWr8dWaxsUbRY1EpmiUXKh3qsdI8HtYUmPkl0H9uQHrsqZXXqpNVsPx9hLc6Q60obnWNGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086839; c=relaxed/simple;
	bh=JjsMiAsMrx1FADRwbTcj5FR+rfAA0/BlPrYl94uuDFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7A8ycHr/0w54IWmAMSwrc6GObEe+ri2wm6HpS6zFsBJc7IRUO3m8co6Uuu6SojlHYBqCgRYA2wpbd+8xT/dM8GSlGh8j1fRr75dHXiCPtKRiOCwxHsf1dw4r6zS8I8mUvNrwwaKKmhcKL1Q78bBUKByRwNvrpIKrvvO3/+NFqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ue84BwGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A932CC43390;
	Tue,  2 Apr 2024 19:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086839;
	bh=JjsMiAsMrx1FADRwbTcj5FR+rfAA0/BlPrYl94uuDFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ue84BwGuwO8F7y/5bSnkVDiho4U7LPqhLfhO/tV3HemCWFbuML/HabHOr/1Vrf44k
	 MyCkJQ8NvWpauNVCWjwpMFiSKzQhDp1zXQPrZFvfk1P1hwFiOgAxbluXaNQXG34J26
	 puJWL5EOOJTa2qHrbqpEqwDjJYODw0xqpII2yC1Hz3KQqSj4Jbezt0Kl97f4tstsRz
	 zr32TrpT5j7INkNEv33To1HkHKy5pOBrRxjZ4Y0IV6glxD+s0y1JCJfupSo2gL8Uq5
	 2yeXXpyI8VS/MTogQ77ds6ymrOHnHsLvX+3U7sGOVwe/hEklVQSRHXuV8rS/9v07o6
	 q2Of1FgJGBsNQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a4930d9c48so1088889eaf.1;
        Tue, 02 Apr 2024 12:40:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQxz1Sw4fZKKuC7L11Bo7vhZ1TxI6qHp/1j2Y/mkGkOGreG0KlYGt79pQyfdisO02CiyeX9RBIhHgFN0goGgLsubXGXPTk0Myv+14n1RpopgaS4F7hOZbQL0tJp6EVXmAD9Lt+bQCzQQ==
X-Gm-Message-State: AOJu0Yxr4L6Ugzw3eOKzDLMPdU238qyA5B+I109iLW+L8iKYguSBTOhO
	gqoduaP9txlPrZWWYplYMSzziMjVAR11CvFq55x6CxF1HCpjRVHBrEzBifuo0jjJUqr8LOcjQYM
	c+1tLlGWhxmroMV1cePvvySwIoH8=
X-Google-Smtp-Source: AGHT+IGFh/PeKcJPPYYo87cIDkTkH10FJMqvAD+DIqZbrEV1a1HQyycrPF7kCmTxHnlFz1L2mu0wPm9H+zv8DnVWH0Q=
X-Received: by 2002:a05:6820:2289:b0:5a4:6e23:e335 with SMTP id
 ck9-20020a056820228900b005a46e23e335mr15513677oob.0.1712086838999; Tue, 02
 Apr 2024 12:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SY4P282MB3063A002007A252337A416DEC5382@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SY4P282MB3063A002007A252337A416DEC5382@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Apr 2024 21:40:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0icbgfNbt_5TibMWuxU=+SgdQxy8S0xFQkSY5MoPN77hg@mail.gmail.com>
Message-ID: <CAJZ5v0icbgfNbt_5TibMWuxU=+SgdQxy8S0xFQkSY5MoPN77hg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: thermal: Continue registering thermal zones even
 if trip points fail validation
To: Stephen Horvath <s.horvath@outlook.com.au>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 10:37=E2=80=AFAM Stephen Horvath
<s.horvath@outlook.com.au> wrote:
>
> Some laptops where the thermal control is handled by the EC may
> provide trip points that fail the kernels new validation, but still have
> working temperature sensors. An example of this is the Framework 13 AMD.
>
> This patch allows the thermal zone to still be registered without trip
> points if the trip points fail validation, allowing the temperature
> sensor to be viewed and used by the user.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218586
> Fixes: 9c8647224e9f ("ACPI: thermal: Use library functions to obtain trip=
 point temperature values")
> Signed-off-by: Stephen Horvath <s.horvath@outlook.com.au>
> ---
>  V1 -> V2: Referenced bug tracker in commit, and switched to using
>                 `thermal_tripless_zone_device_register` as per the
>                 suggestion of Rafael J. Wysocki.
>
>  drivers/acpi/thermal.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 302dce0b2b50..10044c56b85e 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -662,14 +662,16 @@ static int acpi_thermal_register_thermal_zone(struc=
t acpi_thermal *tz,
>  {
>         int result;
>
> -       tz->thermal_zone =3D thermal_zone_device_register_with_trips("acp=
itz",
> -                                                                  trip_t=
able,
> -                                                                  trip_c=
ount,
> -                                                                  tz,
> -                                                                  &acpi_=
thermal_zone_ops,
> -                                                                  NULL,
> -                                                                  passiv=
e_delay,
> -                                                                  tz->po=
lling_frequency * 100);
> +       if (trip_count) {
> +               tz->thermal_zone =3D thermal_zone_device_register_with_tr=
ips(
> +                       "acpitz", trip_table, trip_count, tz,
> +                       &acpi_thermal_zone_ops, NULL, passive_delay,
> +                       tz->polling_frequency * 100);
> +       } else {
> +               tz->thermal_zone =3D thermal_tripless_zone_device_registe=
r(
> +                       "acpitz", tz, &acpi_thermal_zone_ops, NULL);
> +       }
> +
>         if (IS_ERR(tz->thermal_zone))
>                 return PTR_ERR(tz->thermal_zone);
>
> @@ -903,8 +905,6 @@ static int acpi_thermal_add(struct acpi_device *devic=
e)
>
>         if (trip =3D=3D trip_table) {
>                 pr_warn(FW_BUG "No valid trip points!\n");
> -               result =3D -ENODEV;
> -               goto free_memory;
>         }
>
>         result =3D acpi_thermal_register_thermal_zone(tz, trip_table,
>
> base-commit: 4cece764965020c22cff7665b18a012006359095
> --

Applied as 6.9-rc material under a modified subject ("ACPI: thermal:
Register thermal zones without valid trip points"), with some
redundant braces removed and with some white space adjusted.

Please verify the result at
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?h=3Dbleeding-edge&id=3D8a4ff5452dd0cdcc35940460bb777d836bece11c

