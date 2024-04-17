Return-Path: <linux-kernel+bounces-148139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 676498A7E33
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881741C203B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B487E588;
	Wed, 17 Apr 2024 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZxOw0F9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62A7EF0F;
	Wed, 17 Apr 2024 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342379; cv=none; b=b9OkV2jMohO3G6ecg6kLZcCIDfd8cWzwkbj19H6HIQ2hFjm0sua08uG4ZYi/4wgjMGUxpZr2Z0oPIHQVLFq+AnqTvv4B4KiLbqUX9dfnfIOli+JbZdXm87ujve1vK8p+dHv0NbLYeBJyogiRnpGu3DMfRShsVJ/j7BIq+pItD2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342379; c=relaxed/simple;
	bh=F+55rTidfxMpJlnh4dRbVr8SWqmLzp+FoCh+4rte+4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5poyGc5xmeqccQKnylYw2hzHkKeUMMdCBdjV2mgmdn9jZ08cQxLkEiyy0b2akgp1pN2tVo0iqYPLEO2NKBWXoOHEDd1RiEoc4MJHfXCwq4VGRPLuYeBa12xs/kf9HnpfOqxAHHe8SSBt38hUnwLe4aN86cEeDZGGbpguN60WOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZxOw0F9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E178C072AA;
	Wed, 17 Apr 2024 08:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342379;
	bh=F+55rTidfxMpJlnh4dRbVr8SWqmLzp+FoCh+4rte+4E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pZxOw0F9Z/UFOywwzsgCv2AEQiz/JG9YLjRQmhM2alTpRc3YXd7ftLKfI7OHuT6gZ
	 EHPnxk9IGbWgikeweSDid3WByETfTE2YPSXybLIKNml1cyS7VA3qcVXDJgja3faRwb
	 ghLTgL5BmnXgVRXv2WRCrAzwYNg63GQCDj9sssTlruLT9vhpdrIPntL2VEQydZkBWC
	 joycDJMpKhpPzOQFR8R/3YDXJCIa8yi3NmhFbX++mMGDuyvVgLDoULQoBzI4/31tyg
	 5ksOOZt2EtrcGAKAsK0wyLNm6Curx6E2rjMSJz8A4eTa1rW45GfWArgx/T2CQkpwK1
	 rrq0RLUIu7o7A==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5acdbfa7a45so266477eaf.2;
        Wed, 17 Apr 2024 01:26:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtSqHISx7MkPhIN6EHE8v3AgFbrk+BiFVf4o5RB8FRmG90yHWBwEN6cQ8GiO32nIDGm0oIrgXIdEshfyw84YS9YOjcrNUh6F3f1Q==
X-Gm-Message-State: AOJu0YzpNRZMw7i+CZwTt8qDJ+9Tf+6Fr7KLuMbrtYswZN8deODwriYw
	PVnwsMjYRoW4mcL0/ML6GMTeE1b3sFTuWo1nJcSUwkm6FnSVXlySEwwrrYtm73aY+AqLxML7ZgU
	5+i+3+WDDygAgiMKiB6xpVf94Zh4=
X-Google-Smtp-Source: AGHT+IGEahwDm1uzbNdSdWAFcMKikrGld/DOz6HotTHQBOOVZweQDP0Y8baQQ5DQVQ5kuPPheaN7cdrl3zv+9GA4odM=
X-Received: by 2002:a05:6820:4008:b0:5aa:6b2e:36f0 with SMTP id
 fh8-20020a056820400800b005aa6b2e36f0mr18086148oob.0.1713342378562; Wed, 17
 Apr 2024 01:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416211941.9369-1-tony.luck@intel.com> <20240416212201.9433-1-tony.luck@intel.com>
In-Reply-To: <20240416212201.9433-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Apr 2024 10:26:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0givBRP9Dj0pEJpB==TpeCyq_pE__2Jt3YvWUbcvWWweA@mail.gmail.com>
Message-ID: <CAJZ5v0givBRP9Dj0pEJpB==TpeCyq_pE__2Jt3YvWUbcvWWweA@mail.gmail.com>
Subject: Re: [PATCH v3 41/74] x86/cpu/vfm: Update drivers/acpi/x86/utils.c
To: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Raag Jadav <raag.jadav@intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Marius Hoch <mail@mariushoch.de>, 
	Michal Wilczynski <michal.wilczynski@intel.com>, linux-acpi@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:22=E2=80=AFPM Tony Luck <tony.luck@intel.com> wr=
ote:
>
> New CPU #defines encode vendor and family as well as model.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/x86/utils.c | 42 ++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 90c3d2eab9e9..2d8203f7bd98 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -45,37 +45,37 @@ struct override_status_id {
>         unsigned long long status;
>  };
>
> -#define ENTRY(status, hid, uid, path, cpu_model, dmi...) {             \
> +#define ENTRY(status, hid, uid, path, cpu_vfm, dmi...) {               \
>         { { hid, }, {} },                                               \
> -       { X86_MATCH_INTEL_FAM6_MODEL(cpu_model, NULL), {} },            \
> +       { X86_MATCH_VFM(cpu_vfm, NULL), {} },                           \
>         { { .matches =3D dmi }, {} },                                    =
 \
>         uid,                                                            \
>         path,                                                           \
>         status,                                                         \
>  }
>
> -#define PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
> -       ENTRY(ACPI_STA_DEFAULT, hid, uid, NULL, cpu_model, dmi)
> +#define PRESENT_ENTRY_HID(hid, uid, cpu_vfm, dmi...) \
> +       ENTRY(ACPI_STA_DEFAULT, hid, uid, NULL, cpu_vfm, dmi)
>
> -#define NOT_PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
> -       ENTRY(0, hid, uid, NULL, cpu_model, dmi)
> +#define NOT_PRESENT_ENTRY_HID(hid, uid, cpu_vfm, dmi...) \
> +       ENTRY(0, hid, uid, NULL, cpu_vfm, dmi)
>
> -#define PRESENT_ENTRY_PATH(path, cpu_model, dmi...) \
> -       ENTRY(ACPI_STA_DEFAULT, "", NULL, path, cpu_model, dmi)
> +#define PRESENT_ENTRY_PATH(path, cpu_vfm, dmi...) \
> +       ENTRY(ACPI_STA_DEFAULT, "", NULL, path, cpu_vfm, dmi)
>
> -#define NOT_PRESENT_ENTRY_PATH(path, cpu_model, dmi...) \
> -       ENTRY(0, "", NULL, path, cpu_model, dmi)
> +#define NOT_PRESENT_ENTRY_PATH(path, cpu_vfm, dmi...) \
> +       ENTRY(0, "", NULL, path, cpu_vfm, dmi)
>
>  static const struct override_status_id override_status_ids[] =3D {
>         /*
>          * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
>          * but Linux uses a separate PWM driver, harmless if not used.
>          */
> -       PRESENT_ENTRY_HID("80860F09", "1", ATOM_SILVERMONT, {}),
> -       PRESENT_ENTRY_HID("80862288", "1", ATOM_AIRMONT, {}),
> +       PRESENT_ENTRY_HID("80860F09", "1", INTEL_ATOM_SILVERMONT, {}),
> +       PRESENT_ENTRY_HID("80862288", "1", INTEL_ATOM_AIRMONT, {}),
>
>         /* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control =
*/
> -       PRESENT_ENTRY_HID("80862289", "2", ATOM_AIRMONT, {
> +       PRESENT_ENTRY_HID("80862289", "2", INTEL_ATOM_AIRMONT, {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
>               }),
> @@ -84,18 +84,18 @@ static const struct override_status_id override_statu=
s_ids[] =3D {
>          * The INT0002 device is necessary to clear wakeup interrupt sour=
ces
>          * on Cherry Trail devices, without it we get nobody cared IRQ ms=
gs.
>          */
> -       PRESENT_ENTRY_HID("INT0002", "1", ATOM_AIRMONT, {}),
> +       PRESENT_ENTRY_HID("INT0002", "1", INTEL_ATOM_AIRMONT, {}),
>         /*
>          * On the Dell Venue 11 Pro 7130 and 7139, the DSDT hides
>          * the touchscreen ACPI device until a certain time
>          * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
>          * *and* _STA has been called at least 3 times since.
>          */
> -       PRESENT_ENTRY_HID("SYNA7500", "1", HASWELL_L, {
> +       PRESENT_ENTRY_HID("SYNA7500", "1", INTEL_HASWELL_L, {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
>               }),
> -       PRESENT_ENTRY_HID("SYNA7500", "1", HASWELL_L, {
> +       PRESENT_ENTRY_HID("SYNA7500", "1", INTEL_HASWELL_L, {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
>               }),
> @@ -112,19 +112,19 @@ static const struct override_status_id override_sta=
tus_ids[] =3D {
>          * was copy-pasted from the GPD win, so it has a disabled KIOX000=
A
>          * node which we should not enable, thus we also check the BIOS d=
ate.
>          */
> -       PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
> +       PRESENT_ENTRY_HID("KIOX000A", "1", INTEL_ATOM_AIRMONT, {
>                 DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>                 DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
>                 DMI_MATCH(DMI_BIOS_DATE, "02/21/2017")
>               }),
> -       PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
> +       PRESENT_ENTRY_HID("KIOX000A", "1", INTEL_ATOM_AIRMONT, {
>                 DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>                 DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
>                 DMI_MATCH(DMI_BIOS_DATE, "03/20/2017")
>               }),
> -       PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
> +       PRESENT_ENTRY_HID("KIOX000A", "1", INTEL_ATOM_AIRMONT, {
>                 DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>                 DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
> @@ -137,7 +137,7 @@ static const struct override_status_id override_statu=
s_ids[] =3D {
>          * method sets a GPIO causing the PCI wifi card to turn off.
>          * See above remark about uniqueness of the DMI match.
>          */
> -       NOT_PRESENT_ENTRY_PATH("\\_SB_.PCI0.SDHB.BRC1", ATOM_AIRMONT, {
> +       NOT_PRESENT_ENTRY_PATH("\\_SB_.PCI0.SDHB.BRC1", INTEL_ATOM_AIRMON=
T, {
>                 DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>                 DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
>                 DMI_EXACT_MATCH(DMI_BOARD_SERIAL, "Default string"),
> @@ -149,7 +149,7 @@ static const struct override_status_id override_statu=
s_ids[] =3D {
>          * as both ACCL0001 and MAGN0001. As we can only ever register an
>          * i2c client for one of them, ignore MAGN0001.
>          */
> -       NOT_PRESENT_ENTRY_HID("MAGN0001", "1", ATOM_SILVERMONT, {
> +       NOT_PRESENT_ENTRY_HID("MAGN0001", "1", INTEL_ATOM_SILVERMONT, {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>                 DMI_MATCH(DMI_PRODUCT_FAMILY, "YOGATablet2"),
>               }),
> --
> 2.44.0
>

