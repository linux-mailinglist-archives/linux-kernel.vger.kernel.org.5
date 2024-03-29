Return-Path: <linux-kernel+bounces-125294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A2D89239D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2ED3286DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422D848CCD;
	Fri, 29 Mar 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bendiksen.me header.i=@bendiksen.me header.b="g3oQXPAi"
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C021DA5E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738469; cv=none; b=lnYoKGSaYmX0CtQNIaL00wZT4T2U2mVNhbUhQgQb1EpHqw26XwSSUQdh1CK2uo45IYjEaUFv7BuRr/TjHTNJUQXAsXZpyyRgABXACvsmD1u6jkFby1mFkxIAZWkEuKIA8j79fD8l5l9CC6SvP1GK5rtR83oFJRrTTpDSzLi+jB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738469; c=relaxed/simple;
	bh=nyFd1gVD6IOaOkZxv+ijhnFzzD+61fz5CSxFthsNV08=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=c6pK6LxAun7W5rEXhvlJmUEYQEz954y4yDzGl5vzJBxh6RU4xbHyLw5GCqAiqhR+uXKktVx1VBZ5SiqnAmvcSLFUuKF1KAN37Z0DXWQJMFYCJqPEey4VH/DkklU1S7C6tDjqruovzQuebt+vkbACI7kZWzkTOhwSFy9dKTXcjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bendiksen.me; spf=pass smtp.mailfrom=bendiksen.me; dkim=pass (2048-bit key) header.d=bendiksen.me header.i=@bendiksen.me header.b=g3oQXPAi; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bendiksen.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bendiksen.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bendiksen.me;
	s=protonmail; t=1711738459; x=1711997659;
	bh=PbTlUZvfyW5EEgU8CtWt38HrMcQmW9XR3nwwcixiO80=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=g3oQXPAiCbXjswnX844LZUf4oeXU9jlHBfne70b0iKbXNkHOnm9woeDFRjisSLfQR
	 RMAkPxLujCTyAbDZ8xGQyuIR44FNS3fb7V8CYnPSJK06F6HbYlMs95e066DkB58pOB
	 jOYBwFwOoy5i/kVQcgRXQ/OuF92X8G2ZvtJPF9SoR05RnrkYacfsRXlvVkDIvF4tRp
	 NebpEGV67yxan0KVxiD/TFK6QUlcW40Y4fs9b77C1OOwHkiUgmfUxmJDU+Nvt1LecF
	 Hmze1cpO4Y9j3ZMS3yyHynVUH0n9LW8J5a7Xg71TCXkGug9RaphqBwM9EZFyi+BmKv
	 8jSL/MbDMW7MQ==
Date: Fri, 29 Mar 2024 18:54:14 +0000
To: james.schulman@cirrus.com, david.rhodes@cirrus.com, rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com, sbinding@opensource.cirrus.com, kailang@realtek.com, luke@ljones.dev, shenghao-ding@ti.com, foss@athaariq.my.id, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
From: Christian@bendiksen.me
Cc: Christian Bendiksen <christian@bendiksen.me>
Subject: [PATCH] Add sound quirks for Lenovo Legion slim 7 16ARHA7 models.
Message-ID: <20240329185406.9802-1-christian@bendiksen.me>
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
index 72ec872afb8d..959864994eca 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -115,6 +115,8 @@ static const struct cs35l41_config cs35l41_config_table=
[] =3D {
 =09{ "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 0, 0, 0 },
 =09{ "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 0, 0, 0 },
 =09{ "17AA38B7", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 0, 0, 0 },
+=09{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 0, 0, 0 },
+=09{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 0, 0, 0 },
 =09{}
 };
=20
@@ -503,6 +505,8 @@ static const struct cs35l41_prop_model cs35l41_prop_mod=
el_table[] =3D {
 =09{ "CSC3551", "17AA38B5", generic_dsd_config },
 =09{ "CSC3551", "17AA38B6", generic_dsd_config },
 =09{ "CSC3551", "17AA38B7", generic_dsd_config },
+=09{ "CSC3551", "17AA3877", generic_dsd_config },
+=09{ "CSC3551", "17AA3878", generic_dsd_config },
 =09{}
 };
=20
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a17c36a36aa5..540868d6c602 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10347,6 +10347,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[=
] =3D {
 =09SND_PCI_QUIRK(0x17aa, 0x38b5, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35=
L41_I2C_2),
 =09SND_PCI_QUIRK(0x17aa, 0x38b6, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35=
L41_I2C_2),
 =09SND_PCI_QUIRK(0x17aa, 0x38b7, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35=
L41_I2C_2),
+=09SND_PCI_QUIRK(0x17aa, 0x3877, "Legion Slim 7 16ARHA7", ALC287_FIXUP_CS3=
5L41_I2C_2),
+=09SND_PCI_QUIRK(0x17aa, 0x3878, "Legion Slim 7 16ARHA7", ALC287_FIXUP_CS3=
5L41_I2C_2),
 =09SND_PCI_QUIRK(0x17aa, 0x38ba, "Yoga S780-14.5 Air AMD quad YC", ALC287_=
FIXUP_TAS2781_I2C),
 =09SND_PCI_QUIRK(0x17aa, 0x38bb, "Yoga S780-14.5 Air AMD quad AAC", ALC287=
_FIXUP_TAS2781_I2C),
 =09SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual", ALC287_FIX=
UP_TAS2781_I2C),
--=20
2.44.0



