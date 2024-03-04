Return-Path: <linux-kernel+bounces-90670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E918702FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF51B1F21CBF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A923F9D8;
	Mon,  4 Mar 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XqJjbyhz"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493771EB2C;
	Mon,  4 Mar 2024 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559653; cv=none; b=MEV7sbW6Q4kpqtT9fE9Eay2gOkBnEdpqduT2TNzA3oI3d86TkieZIdA+YMTSGUcZp6IcZ/TVOpQC95spOwsRDVEoAW/H0NbkKSeySsnK+GYiOlQ8wPOolDSzfVo7ZLGZNFAVjNd/z0yYuD4BWSePithEO5fbnsZs6qyPxm0r7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559653; c=relaxed/simple;
	bh=HEWHA2PR2Vwm0nx5ZwKKi8D+dn4R9GYVVAfVOpirOdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ewod9qB84v8b3OasMIwsWRflM2lZ3EEi0PelDmZMK9j99qtH+TvINHD7T7WUh+wYt0JG40CeA1hlNHn4I8z/TSDEwNBx5/bV0AfIpksbftMcDKSJXEnauc7FPka1TKkiiABb/HaUiM0eiiFhAEH/gMHoJsZJd3zzehwTUFT+at0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XqJjbyhz; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from andch-XPS-15-9520.. (1-163-114-48.dynamic-ip.hinet.net [1.163.114.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 49D333FDED;
	Mon,  4 Mar 2024 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709559648;
	bh=tVLPpKCRmOM3oFaDePTJQsjQEmkz+D3QGfPGx8yx7lU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=XqJjbyhzobDu/SqCj/j1eAUeLfhRTceHvctRjIfQcSvG3Nf9qohi5SKZuexOaPHD3
	 4ORyFrXG+R4Z5nxPjO/ksKsovwt2KHKnmO+F2Bq7EQoIcdtDYsMumcILt3UkBg54jy
	 NMsYdzdyGZoLo5svgOSuRNQKlxgn6xcEMw0J5iBLrI8YNguWkR+c1rUVvNCTnlnLY7
	 qysjWzO/AO0r3+tyk/jHClwvLCQV4FPwDRY9jmTmKGt/+YaIvJGJknVeXVCCaQoCGz
	 XRXbjserrYrJSUDoBxKWEmZSeEfM4fAMdMqgrBdF0oihEo3L3vgeQMsgUSeMbs9HsT
	 9GgLTSZhBTuTw==
From: Andy Chi <andy.chi@canonical.com>
To: 
Cc: andy.chi@canonical.com,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Matthew Anderson <ruinairas1992@gmail.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook
Date: Mon,  4 Mar 2024 21:40:32 +0800
Message-Id: <20240304134033.773348-1-andy.chi@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HP EliteBook using ALC236 codec which using 0x02 to
control mute LED and 0x01 to control micmute LED.
Therefore, add a quirk to make it works.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d71520858b5f..232f759e169f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9880,6 +9880,10 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c8a, "HP EliteBook 630", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c8c, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c90, "HP EliteBook 640", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c97, "HP ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8ca1, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.34.1


