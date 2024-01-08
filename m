Return-Path: <linux-kernel+bounces-19582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E461D826F20
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B821C227AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2687941212;
	Mon,  8 Jan 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="E3ZBZNRd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E541745;
	Mon,  8 Jan 2024 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704718944; bh=0ub3HiEeynpEvWN9T9rYs29daqMSRNhQo+LY89G/pJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E3ZBZNRdYmjh3Ih60sq6dzqptRKo6MnhtYf8yZmoket4Z15yS6hva6PMU5O5H3Br0
	 Y7DJZ1fWjJTRQc8UGVh/Q/nWxpM3PsQ7e2f/e4HjQDswTAYFlNyWJoPOzPNtSrqsQk
	 2NzTJHqB/TH/ZbflaOA1XyUfzXMD3IfjtGcsq+V4=
Received: from levi-pc.. ([61.186.21.12])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id D5405488; Mon, 08 Jan 2024 20:53:20 +0800
X-QQ-mid: xmsmtpt1704718402t7bah2boi
Message-ID: <tencent_7D17862FAF1D04B210747D392317785A6508@qq.com>
X-QQ-XMAILINFO: N26DAMVpW7UE8bEsG1DL1OQYT7OG4saY288xbYPEwBD89ZTWXtlQhFRinzLe4R
	 oxEVR37D8UfJMiesvq3v3YB4fz79I8slxfUXVOntX6GCRMhyFjLiVsCeKCNtuMIlT8kZrbo0R/+d
	 ACUy5wIcRlgfW+C+0TzcBUzoP7ufroOwxlu0EivkDwqGFXtBJY+hYi1/k/JqVkLDL0WTMJ/zTs1m
	 nw40gsSPccOHFe1UTSOedvzun1/jC1+4cZY5Y531VO2g13Il7EJ4YizHbVA5soWKWzurqWb+LOh3
	 usjjZzSYPKoB8GOBkZ9rvEG3kYRS0l8nxbTb38kieY+ucgX0+ywE0mKOzXebRG+2/tg5KSxNUzyX
	 D7Ijh8LhtxxiACM7jFGpmhER9kYnRtgDX7W+IaBeKrH2swYUnchM2XO/6YP8JSqrtsJHRbVCquZb
	 ZE7WwUO2kvytdlSmSX0tcP93pC2OP4BRQwPAhhFiXud8tjtlAj64Is3FA6Jj1MG5/5O2TsuxDed/
	 yHZROdUEGa+7W8xBLsSbWMdRfmpOvRPugN/+0Q+YnjYyRYFGdND43SqarAMJ2tF5CxuAKMoKW1aZ
	 m3jMYjgZU+zHob4wR2vOaM5t1lSaXoPfg0s/INTEUa4ty8fVI3kHtxtaQBKKO1Ue4gmXpJy9tqH8
	 rCrKzutVmRsE8uzolFt/ptfJH4CdMu3yWSpcoGG7U9AahlB0ZW/jZuqWM41jXxLgmtS/3anTxtaX
	 frZGvikKwXv86uKOBh+zXHECqLg41G3ob4iCBAY9WOcZl2n9h3NhtpUyPikoTuA7If5R28U74JiV
	 mqlIy3TZL8+/0lzm4Owsw5tujPK8S0LGw4yP2OQO19+xFkCf9Prt1fF9PDW4aVsESUSIhJuFomVV
	 BKOBqi68+z8EamdVXYBkg74lcKyX03v8Wtu03gapP0b8/HjDR36kRqeZhEoprDnzQ3fhQra5Z5ye
	 ZRUp5obLRwMqrvwvZMGAVGgMAc0/rdsQqWNrrXq5bpEkEdesZYelMGPn84POT+EaZeveIL1iNfz8
	 nsUZisrsuLAbqFrqJr
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Huayu Zhang <932367230@qq.com>
To: tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	zhanghuayu.dev@gmail.com
Subject: [PATCH] add DSD for ThinkBook 16p G4 IRH with Subsystem Id of : 0x17aa38a9
Date: Mon,  8 Jan 2024 20:51:37 +0800
X-OQ-MSGID: <20240108125137.15081-2-932367230@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108125137.15081-1-932367230@qq.com>
References: <20240108125137.15081-1-932367230@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Huayu Zhang <zhanghuayu.dev@gmail.com>

---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 35277ce890a4..b1844224123f 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -93,6 +93,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "17AA38A9", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
@@ -427,6 +428,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
+	{ "CSC3551", "17AA38A9", generic_dsd_config },
 	{ "CSC3551", "17AA38B4", generic_dsd_config },
 	{ "CSC3551", "17AA38B5", generic_dsd_config },
 	{ "CSC3551", "17AA38B6", generic_dsd_config },
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1dcfba27e075..3eae1a5d9bcd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10256,6 +10256,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P AMD VECO dual", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38a9, "ThinkBook 16p G4 IRH", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b5, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b6, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.34.1


