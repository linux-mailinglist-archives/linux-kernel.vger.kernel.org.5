Return-Path: <linux-kernel+bounces-32592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C72835DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FE91F2328A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231939843;
	Mon, 22 Jan 2024 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FqAtyt4T"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7F364D5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914384; cv=none; b=jhYDFcepdVCLFdGuxt4zzMhZ49R9QnAOvrn6m6YZW1YhxhBn56SbwedQaTJha2KTv3c5qFphPAHDsPDSpZnHVRsHt3YwQqwiiViB1jlKlqxR9n7nFhivIHaBdbbF0LtXcBwQhN29X1rFkMA6og7fPXCPKJc9x6ZzdIi/3Cb8DQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914384; c=relaxed/simple;
	bh=Ohy0ZGwqVFZ2Ynmb7PAYjwQ1AwA+GNIglKipPv38KOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZHmBx/xWlrU14k4YSdIh8B4Do7go3jQuRvgomFK9Zsq6vjHK6iY1GmFixgp1M3bdPqOztnBQ/+Yb9OL8BQiWkHh1HiSoBJHyTmeaS+f0F5dTSiVqGeg/nXfbq9LAq4BvNhsLdEj4z0kqQl3/RR3sh132ClEBrDEIY2spwP45Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FqAtyt4T; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7ce3c7566e0so383966241.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705914381; x=1706519181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gp5tgkDSgj11h88t3e/z7UEfT/WURUMZNCx4eihIQpI=;
        b=FqAtyt4T5z2R4h3yKIT8Q8g+SIEah/KSfX4E3GL29mSUBgH7KlL3jDyU/FMDBUNVJG
         Q+p99BTjC2Wz2G4XJCQvUJZSwR7K2PflT3SFRaDhQNR3iZr2QcTJYQJI9u59vX6YPm+m
         OL00+6Qd0w6VwS3LwcsbHKHjX0kW1eMSDAb1OQfGNN8QRBg0xT/UaszAO7PZ04AIzLRW
         8A/2Fss21nwRpIOnVtjHV2iXkatseMBi0LkXsnAu38DgeomRb6LcIN57Zi0yugjw9gWh
         t2v8BjcdQWAyitzXnBiLzZEvHIO6zBz443+QWhIcfX9+C1nB2Hj+ssj255k0VkPVLR0Z
         UYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705914381; x=1706519181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gp5tgkDSgj11h88t3e/z7UEfT/WURUMZNCx4eihIQpI=;
        b=LalcZbSt4DX3e1PtUFTx8w4ss1/mKh/YVgrHax0sxpqKkvS2OQY3jxd+AASEIbeikD
         8NsEwN/oLEwt5/yc8BeT6/PHu/5Wfnx8ACCGzVs9n5wKMuvLembozimivW+cV0tRgXUs
         5QvOOC/vCJE4V5H/oJO6PguyNN0Ylx3QtmAXnVP61c6C0DpyVkAswRPilrQ38/7sMb7e
         f2QTADLNRqU30o2iaVlP+9qI4shcSeb05WqxqOElz81nMxRSqRw9vNYF+xblrP+bkQYL
         fo1lTEOTJ6RpIIJsl84zWjB9ACfvdc6jYcXaoGDIWBNFdz1Lvxw8VEJTuTkphYFxj8I4
         nfhg==
X-Gm-Message-State: AOJu0YxXltm06aHuTNv4dvBJZtdB4URUTkV5qOYLtSX1sg05PEdWcA3N
	A3SrzAymwL6FGRHcJjSBHHVB+wLrHn2ue15Orv2a4yd29A7hEO3CYa7DaqzrP6Oy666pOtlvDZB
	xrsCttpF482BlJb0x65doce9kQEwBIx4RlrIl9Q==
X-Google-Smtp-Source: AGHT+IFfrOIr9bAUFkITg4Xb0WVWPc4vGtm9WQHIVP2Np7ndI6gmd4BUBnYr0dkPWJxnfhMP9tfiz9rZimSYJWdhN5M=
X-Received: by 2002:a05:6102:419e:b0:469:b52c:cdac with SMTP id
 cd30-20020a056102419e00b00469b52ccdacmr398531vsb.5.1705914381000; Mon, 22 Jan
 2024 01:06:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117142942.5924-1-mario.limonciello@amd.com>
In-Reply-To: <20240117142942.5924-1-mario.limonciello@amd.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jan 2024 10:06:10 +0100
Message-ID: <CAMRc=MeUr6UYdWUudsF+6RvoCXsYxBDtw+2k2oJANvpNsBHPAg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-acpi@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, stable@vger.kernel.org, 
	George Melikov <mail@gmelikov.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 3:29=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Spurious wakeups are reported on the GPD G1619-04 which
> can be absolved by programming the GPIO to ignore wakeups.
>
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: George Melikov <mail@gmelikov.ru>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3073
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 88066826d8e5..cd3e9657cc36 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1651,6 +1651,20 @@ static const struct dmi_system_id gpiolib_acpi_qui=
rks[] __initconst =3D {
>                         .ignore_interrupt =3D "INT33FC:00@3",
>                 },
>         },
> +       {
> +               /*
> +                * Spurious wakeups from TP_ATTN# pin
> +                * Found in BIOS 0.35
> +                * https://gitlab.freedesktop.org/drm/amd/-/issues/3073
> +                */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "G1619-04"),
> +               },
> +               .driver_data =3D &(struct acpi_gpiolib_dmi_quirk) {
> +                       .ignore_wake =3D "PNP0C50:00@8",
> +               },
> +       },
>         {} /* Terminating entry */
>  };
>
> --
> 2.34.1
>

Queued for fixes, thanks!

Bart

