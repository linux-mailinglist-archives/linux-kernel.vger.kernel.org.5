Return-Path: <linux-kernel+bounces-143724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA98A3CAB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83981F221B4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041C13FB31;
	Sat, 13 Apr 2024 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="y2TfVhAY"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA46AB8;
	Sat, 13 Apr 2024 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713008861; cv=none; b=OYJttMyE83efSKsaxac+c1iPDwKkGsxky8zelNdWAUETd8DtQeNME1zE6X7H/UKf3GsFZQgf8wgHRjfVrMCFb3Y8MWPlyFywneyDV5lyFo9tkBf+iMYY+d+3Idy1K6bLW3sQRO1O4eG01J+2hLRfpw/1G2BN9HvWOAvQJ1Aq6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713008861; c=relaxed/simple;
	bh=S5SKxjqBLEazmK9VzoxpMLNUbW254TmsbmfvUiZKfkU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=o4LiVlhPz+ok84X+x53dbfVc8JXOOgr/KQpfOpkg2JH5QWjCwqYzcwcQmCra5OePnFPUTtAwo2AbZwOK2wmbQ5oEySGC3LObuZd8tGlwK9did1+FwYFI9D/59jfYkxm6ufyC7gGCJrtRQft9NRnfkESXKxBv5CZNFMOM93M6n9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=y2TfVhAY; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1713008853; bh=buU/TI1ycm4oXmFV2yW1Moaxa/OBm98bV+Uw5KNRXxo=;
	h=From:To:Cc:Subject:Date;
	b=y2TfVhAY8vuaK1fKT5HoU6TzEB/5gm8yMjnTvohjCakZ/Alx3NDR9mc1tNaXotXAu
	 IRLfBTjTeH9ox6ajJKXF46BbsCOXFw8oeTWC+Erfxtd/hYTx8EsBdlT24UJcLTzGrJ
	 1jvDDBSAY5yFTk+6o3NTOlX7zCIPw8YYdNRw5eLI=
Received: from levi-pc.. ([61.186.29.10])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id A4B1F810; Sat, 13 Apr 2024 19:41:11 +0800
X-QQ-mid: xmsmtpt1713008471t21yb30x3
Message-ID: <tencent_37EB880C5E5BD99D21C16B288115C4545F06@qq.com>
X-QQ-XMAILINFO: Nx5llcX2zp4EfIlu/YnLYTHyOv1Fz6LhBZJqmmpegZxljWmX0TmL0/dPqaPKOS
	 KCFhD788ITjLkg61iwrr8vsW3z9pGQEH0s2IiGeMPKkxDlhcXN9fbH/AWLIx6nP607/KhafMaVZo
	 MHUBo11WDj+0ZvWJ4wxDm/MlkG+qvLzhxwPW8ofPDm+IcpnUlmN8qb+ak7+ujBeAn6kLPSZiHUfc
	 wsZNyZiyg6xjS9/7Xq0tu+WgxdJiRUfLtrgVFjm/eyJ487kQo8W7k+sFmFp9QhGX04j4mJ6rB+n1
	 9gyz365oK+LwYw3WGu/WFn1p39Zg3Hk7CON8d8g/zBrgkEjJIQq1zmcGnqksygIIQd+sS66X/wf2
	 XVV3doIuc/jeX5LfE6dqL/snOih5Ot1K8i2P01hFdGJMbhIrEedp9v6l7wQtAEA9HgOPHJzf85kt
	 160+8eW++m86PNawfVoEw+OVXVVroDOUVjtCzUU2qV9A3EQd3R9FYTbkUhjJX0fRsA2eNgYOlgtb
	 w9dHbvaBFPWn5fu3DPXx0ZLwG/FjshvTxm24MGDSQfU5xmecFTss6wJiTBntOt48pmLr9YP5srHc
	 AzZIU5pY8Xhct0mV9l5j7eHIaYqR4xiOspoLiD7Ng1z9/k7IbxuzWXcPNmH6/kVYvGqNqrsg8KC3
	 v3/feApTsq1UfjS6WavSkhI4dqUmOLgoMRPp+fVWgYOOlCTi55DSL6TF3syyP85oz2c9XICYm9c4
	 V04lVgwR7IfDJwz2MNb/5eXMVGNRS8FQP22PzgM/wUJDrFRhJ9TO5ThCenOQj89e1lEuuZZiz1aH
	 s4S88lU+cU9VUTaYndXFDvXnAlkgMEQUQRSo0T0HyIJDmvq70+TXPZUoZXLW2Dls9V+BZ8NWkpg1
	 RA2x5hjlxN1vBwIjYl5X/1tTGCy71Td+ILXxJtv4oL/JkbWrax89fcuSzH/6emOfU+onPOp5etGz
	 /2nuHsvo2DJzqQZS26Uxf+FOKeZy4ooF/IqJWR6sBGQsvRql+fHzlSLrXpmli0v+uUSHenu/7KGw
	 A8tIPQZmCXiMeGSUTHr8zKPDCXMVUpIxR0NwyGStAVLY44iA38rJ13EnmtrqAmrRwTZVTNW/Epma
	 uwVn+Kv6JlkR789QanGE2pnwfH3B+2ieq32BAV
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: zhanghuayu1233@qq.com
To: perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	zhanghuayu.dev@gmail.com,
	zhanghuayu1233@qq.com
Subject: [PATCH] Fix volumn control of ThinkBook 16P Gen4
Date: Sat, 13 Apr 2024 19:41:22 +0800
X-OQ-MSGID: <20240413114122.24524-1-zhanghuayu1233@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Huayu Zhang <zhanghuayu1233@qq.com>

change HDA & AMP configuration from ALC287_FIXUP_CS35L41_I2C_2 to
ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD for ThinkBook 16P Gen4 models to fix volumn
control issue (cannot fully mute).

Signed-off-by: Huayu Zhang <zhanghuayu1233@qq.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d6940bc4ec39..1aef223307bb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10396,8 +10396,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P AMD VECO dual", ALC287_FIXUP_TAS2781_I2C),
-	SND_PCI_QUIRK(0x17aa, 0x38a9, "Thinkbook 16P", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x38ab, "Thinkbook 16P", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38a9, "Thinkbook 16P", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x38ab, "Thinkbook 16P", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b5, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b6, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.34.1


