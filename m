Return-Path: <linux-kernel+bounces-124806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F118891CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599BFB29B47
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7127719668A;
	Fri, 29 Mar 2024 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJKMM7z4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E8194C9E;
	Fri, 29 Mar 2024 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716167; cv=none; b=mFvMrtUE5CZwxnqbFKDbCajcRMiZDeV3NaCuWbtuGGLTDipcr5nusEyb6Kgkkgy5VCA6btEyIx2yy/d/eKn8f9cSP9c4AywMs7COPfi3iH3m16usflqH5R9UHF7DTGfXTouZQxi3VsQl1iqr/SPEN+N1yVjJ4osIuYtd/T4eArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716167; c=relaxed/simple;
	bh=k5sDD4+Vpoaj/hvTPW+o2mryEI3k1nHt3V8TlXWV0rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4sF896cGhM2h6YhTkz6jMRle52I2GeNJBIBGqeqniY8c+8V64cz9YEAguycxrRWWrFYJtdi4/yKpfZavE3nlFLgPaSpnrNRGdJAE+PfEiaHdzoEMKOaV/dg3w6OGuNjpJ4O7ZCmxLL7kslI2znVpeNJRYXQB1xYNE5JJ8Rxbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJKMM7z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2982CC433C7;
	Fri, 29 Mar 2024 12:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716167;
	bh=k5sDD4+Vpoaj/hvTPW+o2mryEI3k1nHt3V8TlXWV0rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJKMM7z4hccotL/CeZAsmO408lZxqnwqqK8KAY+er7CyWLiXiJmEZEGUtx4/XDvx0
	 LyHUATOjjnfm5FF46x7cPmxJsufgDNJEiknR4garYaH+bP1iGtN3QdeT4/t4BzyONQ
	 H4bfa2+YKiYmULweUtAjdgbmt3NX0VIX5mjKJlHsXTFvaHp4tT0qNt0LxpYp+QtAUJ
	 LN1JzBS6yY716vpe1MC32+FqnJzUlE/l+Tbi1efd0jzfMLqEOq72H2u1D47yZvlehm
	 8t1GLGOkjKekkoMFWJVMib3xhBP0y7Ulo6rS/Aw9tGBGRLmghnbC25Z25vUjKsFHaC
	 6MalZICj3RUnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jichi Zhang <i@jichi.ca>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 95/98] ALSA: hda/realtek: Add quirk for Lenovo Yoga 9 14IMH9
Date: Fri, 29 Mar 2024 08:38:06 -0400
Message-ID: <20240329123919.3087149-95-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Jichi Zhang <i@jichi.ca>

[ Upstream commit 9b714a59b719b1ba9382c092f0f7aa4bbe94eba1 ]

The speakers on the Lenovo Yoga 9 14IMH9 are similar to previous generations
such as the 14IAP7, and the bass speakers can be fixed using similar methods
with one caveat: 14IMH9 uses CS35L41 amplifiers which need to be activated
separately.

Signed-off-by: Jichi Zhang <i@jichi.ca>
Message-ID: <20240315081954.45470-3-i@jichi.ca>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a1facdb98d9a0..83a1d5c719be6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7466,6 +7466,7 @@ enum {
 	ALC287_FIXUP_LEGION_16ITHG6,
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK,
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN,
+	ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN,
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
@@ -9589,6 +9590,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK,
 	},
+	[ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_yoga9_14iap7_bass_spk_pin,
+		.chained = true,
+		.chain_id = ALC287_FIXUP_CS35L41_I2C_2,
+	},
 	[ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc295_fixup_dell_inspiron_top_speakers,
@@ -10320,6 +10327,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38c3, "Y980 DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38cb, "Y790 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38cd, "Y790 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38d2, "Lenovo Yoga 9 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x38d7, "Lenovo Yoga 9 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
-- 
2.43.0


