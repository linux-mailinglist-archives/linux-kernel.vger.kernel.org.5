Return-Path: <linux-kernel+bounces-125715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BE4892B02
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5601F22479
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5089436B01;
	Sat, 30 Mar 2024 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bendiksen.me header.i=@bendiksen.me header.b="Es/zRBOv"
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F832C698;
	Sat, 30 Mar 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711799790; cv=none; b=e/3nBj4gUmFqiNGDcMSQqwBAJUQRpwxC+hNqU2qpotGRLWog0596IfwzD8tC7lhAXwcm8kIWmoRwoTTxFEBKB8Q6NGIvjIno71beU8c0QAFLzKYzXabkjy7LSfRUWgB7f3/NLaV897iafWCT8Ucu1VFktQaQyG+u9hd/CRURc4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711799790; c=relaxed/simple;
	bh=DxYnVnYZrsYQtt9xYwNqAJiZ5sywWI9iheNc4C4klQ4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsJc88d9dQEwXff48UlJa6o7iSstiPMvV9hiWM6CxGfRa0n72MDdb6ibVWZEtZjsQSFOOd1uVm44gm5kodphonuDJH8gCa648VnYB6GV2JOvXiTdYyiSD/iwN00wBQZsEQXbCxZ5pPoSQv7uBXbz+PSfiuvRB7ZlqDbkSV5//7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bendiksen.me; spf=pass smtp.mailfrom=bendiksen.me; dkim=pass (2048-bit key) header.d=bendiksen.me header.i=@bendiksen.me header.b=Es/zRBOv; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bendiksen.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bendiksen.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bendiksen.me;
	s=protonmail; t=1711799777; x=1712058977;
	bh=VFZVe2OuWeMsGVWtzIXudU5I+IjHuYH6TozJ6x2gAO8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Es/zRBOvagohReC5ltdeIDR57lPGD96npjg4HAEipPM3di2lMNtpy5fwFkiSEG41i
	 U0cFCLZhr2wO5QPZckWuO8JDGsMLUCjtPGI5qxOB6SqFMmPJKkNiAB7Y+GYjX7Mel0
	 2n3KBhH9oVuZaRpV9P1oDiz7PyGfyxWGQP9Sf83EjfQdhfICAIoVmp+ca0OwCwWC69
	 5n1ZFDIiltt+6k0ueHToA2YcPJBkjC35RfUpz/VTvXmkmBpGmK0rGqaz0BRGl/h9Oo
	 Rtzixb6yZuP9WNUayOutTVFiyUiGK83ONXm8cupvcHHrZhqPhH2C4lxEBdvsBM1LoV
	 m6jGoS0KUq17w==
Date: Sat, 30 Mar 2024 11:56:09 +0000
To: james.schulman@cirrus.com, david.rhodes@cirrus.com, rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com, sbinding@opensource.cirrus.com, kailang@realtek.com, luke@ljones.dev, shenghao-ding@ti.com, foss@athaariq.my.id, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
From: Christian@bendiksen.me
Cc: Christian Bendiksen <christian@bendiksen.me>
Subject: [PATCH v2] Add sound quirks for Lenovo Legion slim 7 16ARHA7 models.
Message-ID: <20240330115554.27895-1-christian@bendiksen.me>
In-Reply-To: <87r0fsnmky.wl-tiwai@suse.de>
References: <20240329185406.9802-1-christian@bendiksen.me> <87r0fsnmky.wl-tiwai@suse.de>
Feedback-ID: 100541561:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Christian Bendiksen <christian@bendiksen.me>

This fixes the sound not working from internal speakers on
Lenovo Legion Slim 7 16ARHA7 models. The correct subsystem ID
have been added to cs35l41_hda_property.c and patch_realtek.c.

Signed-off-by: Christian Bendiksen <christian@bendiksen.me>
---
 sound/pci/hda/cs35l41_hda_property.c | 4 ++++
 sound/pci/hda/patch_realtek.c        | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_h=
da_property.c
index 72ec872afb8d..d6ea3ab72f75 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -109,6 +109,8 @@ static const struct cs35l41_config cs35l41_config_table=
[] =3D {
 =09{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1=
, 0, 0, 0, 0 },
 =09{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2,=
 0, 0, 0, 0 },
 =09{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1=
, -1, 0, 0, 0 },
+=09{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 0, 0, 0 },
+=09{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 0, 0, 0 },
 =09{ "17AA38A9", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2,=
 -1, 0, 0, 0 },
 =09{ "17AA38AB", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2,=
 -1, 0, 0, 0 },
 =09{ "17AA38B4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 0, 0, 0 },
@@ -497,6 +499,8 @@ static const struct cs35l41_prop_model cs35l41_prop_mod=
el_table[] =3D {
 =09{ "CSC3551", "10431F1F", generic_dsd_config },
 =09{ "CSC3551", "10431F62", generic_dsd_config },
 =09{ "CSC3551", "17AA386F", generic_dsd_config },
+=09{ "CSC3551", "17AA3877", generic_dsd_config },
+=09{ "CSC3551", "17AA3878", generic_dsd_config },
 =09{ "CSC3551", "17AA38A9", generic_dsd_config },
 =09{ "CSC3551", "17AA38AB", generic_dsd_config },
 =09{ "CSC3551", "17AA38B4", generic_dsd_config },
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a17c36a36aa5..0fb2d23b3d35 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10333,6 +10333,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[=
] =3D {
 =09SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9=
_14IAP7_BASS_SPK_PIN),
 =09SND_PCI_QUIRK(0x17aa, 0x386f, "Legion 7i 16IAX7", ALC287_FIXUP_CS35L41_=
I2C_2),
 =09SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_YOGA=
7_14ARB7_I2C),
+=09SND_PCI_QUIRK(0x17aa, 0x3877, "Lenovo Legion 7 Slim 16ARHA7", ALC287_FI=
XUP_CS35L41_I2C_2"),
+=09SND_PCI_QUIRK(0x17aa, 0x3878, "Lenovo Legion 7 Slim 16ARHA7", ALC287_FI=
XUP_CS35L41_I2C_2"),
 =09SND_PCI_QUIRK(0x17aa, 0x387d, "Yoga S780-16 pro Quad AAC", ALC287_FIXUP=
_TAS2781_I2C),
 =09SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC", ALC287_FIXUP_=
TAS2781_I2C),
 =09SND_PCI_QUIRK(0x17aa, 0x3881, "YB9 dual power mode2 YC", ALC287_FIXUP_T=
AS2781_I2C),
--=20
2.44.0



