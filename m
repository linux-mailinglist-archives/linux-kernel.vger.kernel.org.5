Return-Path: <linux-kernel+bounces-19549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD270826EA3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9BF1F22E16
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6553E4596A;
	Mon,  8 Jan 2024 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mOlAYhla"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C75644E;
	Mon,  8 Jan 2024 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704717293; bh=0ub3HiEeynpEvWN9T9rYs29daqMSRNhQo+LY89G/pJQ=;
	h=From:To:Cc:Subject:Date;
	b=mOlAYhla6tInPjvp4nllwhMtgn3+55onrvpjt+K5rJ1o3Ot//cvj0O9pYx7fLvBsR
	 2tvspT0ZuEnDEglbrtPgPrgl7z1M1oIiiTF5rFotdSaGdmhitjRlMnefszGd7JWwt+
	 x2u9hbAQAwXBKjIE3RhYcqJnqB8h0vk4xSjChieM=
Received: from levi-pc.. ([61.186.21.12])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 7291AE67; Mon, 08 Jan 2024 20:28:41 +0800
X-QQ-mid: xmsmtpt1704716921tnwswvaia
Message-ID: <tencent_CD95311972BE7A11FC41B4F5718E14E02D0A@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70B4sqURBSAfyGq5AxsWzh71hchYgD9jVJGaFCd7NH7ZvGyCOimW
	 NDCsDxMDjLhnWT4NOG3WvuyMRVDFqMpoIf8vANzgixfGIZGiTiz/RohVDQUmxP4kAObi6h/YX68X
	 y9Sejd7lGxQcGf62Avv5E7Vj1pBWFgmJKI5MXzRomqUD6yqbbyAq39Wkt3scl0Mg0y6xJhEbWGM8
	 reGvalm7IpvsgWdkcJuA6t7uKSrSIN5e2VajQJPEMTGCqPKeEXojHA/L1cU7OLwLxje43zQT3kpV
	 UZGR/EWFrNj3XWz+cU64IU5HLqEVUxyho1kcWOspqGtmXLPQ08kf4OjMWl3LhlyjRLEOJO7T44t9
	 ZqLkPsVdxNJHWL0gjY/SRMvsIVxV5J41pOQ8Kfba7WJJiGJBzHZ3CvhrmVXoOLgmqI5Rm3qsJbx4
	 QXVlp+t8pQkbjvAkbvmNG7iOgUJ1nFVNAGAhHlHeldK9ibuqeln1jpDAsj1EEtfSeI8c+ka4hM/0
	 WXZwVd7B3hdF1zKZnXkB4eOTo7h+4aBnEtw+voeBav3Foy7xLgFwSy6Ii30oxHV8/hygZWS9qAcI
	 AGcMZyjODEOQY8/8OXGM6G7AfDTfiyP9bU29ve+tpDmAP8CXO00dyBpR1bIZSZhOuXkZxbcBzWHH
	 M4tqnc/6SiRmuOC5BQOt3BEX+qHTtKbx7vCwwg2zQQHnnjwMNMFJrwOhnchCFg76s2n+GhEYRFiG
	 TWhO5IvrgwDmJ9oxwOrckPsXymPXFIixYCT7UXsgJs43yl/04DDa5Luh95r3AOpF396rFLwIFTsQ
	 ecKtb3gmbXNiFYei1KKcfvPxgmMcTKwzPt5u6pEiognHy5ezkuxSEnEGpRRxIkOsynN7V1YKf4Lc
	 UmxoszZTiK3mZNqiAMvoLIPIMcUSNlNd0LiAZ17TvovNDOxziVWKGGQQ+u8CMMcvp6O8+MNJFSn6
	 gUK57JqVUEfJAZ0gS+dqmO5Vwbej03WbVGIhDy/Io=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
Date: Mon,  8 Jan 2024 20:28:42 +0800
X-OQ-MSGID: <20240108122842.12642-1-932367230@qq.com>
X-Mailer: git-send-email 2.34.1
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


