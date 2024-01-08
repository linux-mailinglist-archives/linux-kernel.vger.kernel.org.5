Return-Path: <linux-kernel+bounces-19551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57805826EA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FA0283521
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F34D41765;
	Mon,  8 Jan 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Lcf1XyRU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11741744;
	Mon,  8 Jan 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704717132; bh=0ub3HiEeynpEvWN9T9rYs29daqMSRNhQo+LY89G/pJQ=;
	h=From:To:Cc:Subject:Date;
	b=Lcf1XyRUwj8JYaOdyYt0yt8lM1SJaU5PVJLxQHlR2LB81R61nbLCghBHO84A3p5C1
	 pHA/xrYqZXDHh8qJI79D+XAn1aJN52ToJUGJnjSnopaSU0+ZO8EGOWK9m6NNCWGVu8
	 G/dtGEy6tjPUN01fU1cq9Mi4xoiXQnjIr+O7yKBs=
Received: from levi-pc.. ([61.186.21.12])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 809A30F8; Mon, 08 Jan 2024 20:32:09 +0800
X-QQ-mid: xmsmtpt1704717129t9llkx3wl
Message-ID: <tencent_36BEBD114FBCA33263C3945743822F888907@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeOOCsKVtKsyIlhIW7b/zjUV6pUrNrYZZI9XK2Oic147fEU5fTgm
	 7kNxktRJnBnvLdamswo0GZFc92xuFBVxB17zsqa7/LhyZ9qzDko3/xwv9TOqP05NhUZkG89fqBv1
	 0NMm9Mgvs+S/kpNQ41b+KH76jMuJnOKt/1K5YM/i2Azf6ojGpANPOCQopx4cLtm5LNrgLSnwDiOS
	 MlKig5T9rWosJrznVdFICrqNcxenmYMs+q/HgzYZQM7lUEDCUIeqM7kQ2Iz2EOQG70fI//1rhVWL
	 hJq82vghNBYXskuFwSKNAsafImf3OHGqZHZj+KvPc9RuOCYoMsCXdrWyYMGhkufZnXyH6F/BvsiV
	 mV4LmTsobuiOOGy9R9uu5QQMfenA2KNCnOjvzRUFVstVrc+7OUzDj+eA0TqeIY4PlusiooukYsSn
	 hjkrNJjSpLE56kVa7io8hPsUGRhaDufbgzGhMq/UZQ/CQjuArd1HH4KVfYuLife0hJL+NozqOSRG
	 MSj5Hw+My+cz+3OlxaSTTX8B0zzpfR+gYyy1KycDZeJxodqI9M+nYlYdcNB4ysyfDwIZqpuTr5Vx
	 cD/d8QYvcF3Ub9GuSHWJMSYhUovo8+bPVT8lNOnuXoVLqtuQgTsX4qQcKunFJ1bcLUTyvVBa1r4k
	 6KHnSHB6nStfRQryQ3m1WlKoG+7DWXXaiRzvUnp9oeJdPoN6egITseJm2FcGt6GyyZRDrGVqloQT
	 nk+hfLpOngRyTh/kz0ixtDhJQy3+3cuNOgKgczOwik+3AHBVmr/QlbDxVWHk5KXyp89LfXpkWr9G
	 mKmitAa2yNjpRZYN1nZTC0gVb/wuY0ohqvVRfN2PP72189oc9hqjzVeiMEenAT5GK9sKu/b65sPl
	 MC0a5k2oQd6SL2Shna3tREMfi6eyF72O88sP1tneINeZ2/XIUnlvVnADw4sOKbcg0stKfYPKwMsX
	 JCcTGsOSSN+eNJH/xEmtC/K5scWMkOnGXvYW0QAoEbgiqV24OQhGuVpMDsC9vlRwzR1viJCs8vuP
	 0LEvhF3JD0YF3FgOHO
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
Date: Mon,  8 Jan 2024 20:32:11 +0800
X-OQ-MSGID: <20240108123211.13059-1-932367230@qq.com>
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


