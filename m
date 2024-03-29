Return-Path: <linux-kernel+bounces-124881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C7891D67
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97469285ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F7210195;
	Fri, 29 Mar 2024 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6f5LlPp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B321018B;
	Fri, 29 Mar 2024 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716338; cv=none; b=Kze6y92X1ArFYf+RzMH9CKCWyWk5mP31UrZKOI0vl1C2F0pHNpaImcO2E6yXDcF+CX1dM98XvulAUQBiA80DN0ZZa6Odz+fYu60aeZxmKIBoNR9MslyxXzgBsoOWcx0wHjgWdNbduW/4Rqbwla+GUm1tco2EZvD5TWUMcEO3fDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716338; c=relaxed/simple;
	bh=uUVuCECJ1je2kBjnYaZfQuWSmZvTYMmlHYJT+NaIRz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JijYAdhQMUGFZhEqt2Twkwl24/k5+D1X/EczCWVyAnPffKcbADXTVDPzeKlpQsNIEhpUL3YGd33Ev1/PxNzAdolgJUarppqpriqrPg01Es+pCmMMBNVE23uMRSh4F1Fn8AjYDbooU/k+octFmRfCnppol9bdTH7rLlELjfY1ukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6f5LlPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975BFC433F1;
	Fri, 29 Mar 2024 12:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716338;
	bh=uUVuCECJ1je2kBjnYaZfQuWSmZvTYMmlHYJT+NaIRz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M6f5LlPp9zvz5V54ddFBymjYN2TanA1ckgYUXnSNCLggQGySGHI1roFt9AkbxkXf0
	 E2C7QMBtdfFiyiIPprBi74BR7k88XGfJlfjc7Hb0ICWXF21aSGDtK76HN0yesXf/fy
	 wM5NuYnXBNigxL0j3YxZceTVatEAq5xJYGyA2APgevA6T1y87jx8+5A4pYv0R78RJ+
	 zO8XnUvFrZT8y/93fU34kfNxx5QuBpON5fouBkHktRHWfjqae/cWMn06WvnPRqw78N
	 rlrjyHvUIOooy5tInH7Kch4WVPWkXaqcjW38r8akc6gNayVVws8nNZ5xQSVgf+EzLW
	 BH3tTRtXPz4Iw==
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
Subject: [PATCH AUTOSEL 6.6 72/75] ALSA: hda/realtek: Add quirk for Lenovo Yoga 9 14IMH9
Date: Fri, 29 Mar 2024 08:42:53 -0400
Message-ID: <20240329124330.3089520-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 88d006ac9568c..001fa1ca53abb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7372,6 +7372,7 @@ enum {
 	ALC287_FIXUP_LEGION_16ITHG6,
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK,
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN,
+	ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN,
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
@@ -9490,6 +9491,12 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -10190,6 +10197,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
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


