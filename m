Return-Path: <linux-kernel+bounces-120924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8059688E08F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02686B289F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA86414A62A;
	Wed, 27 Mar 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4eAP0aj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9514A618;
	Wed, 27 Mar 2024 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541597; cv=none; b=aO9NzhtZXi7fsgRmR2SoxVqsArcBU0ZoaaukukjdDj9u42rzFH+fH9pB05tTABj/iPLj1pdG2UdsRNEYAtXEnIHP562jKnmoqsgOJeMKIkGGAgO9LbMIEJzis2kkF52LUM0hcTBhtIqbsfSqHVl7kJkUjx9a+Q6dJOqpEQDDDCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541597; c=relaxed/simple;
	bh=9IOTd/DeSy7nw/KuL83BdyBarcazJuCkb4BvzI1jKhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqwCIUWNQmq50BI3Svm7ObxV6cnLpP5aG6lazUXsK5hsY0njciBZklQH6aaXAXjnHEKgq3yI8laFRC8ZeuJqTEgutukhvt8I3rIOvsbdz1pEcKFyPiQJ56CQoHa6WNyiJorPPVQMmF1sC2hsrJMv+ky72l2KqtcBIe2aMtd0ID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4eAP0aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F4FC433F1;
	Wed, 27 Mar 2024 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541596;
	bh=9IOTd/DeSy7nw/KuL83BdyBarcazJuCkb4BvzI1jKhc=;
	h=From:To:Cc:Subject:Date:From;
	b=h4eAP0ajmpERlZs0bb89cTFszOu+ebbrqRK/FVgfMnhrqqzX07JEOlSRgvpQ3k7pO
	 OZQ645fuCFhkrvOJs1tiGT8l0ip5SpsismhhaoL7NRB/0P8vZCMaBPsiQQX29m+vck
	 61OjRGvgr1ACoC7XyQTV1Ad7NywO3ZYtU1acai8286TOxN9XWYrECTl1abAzt5kkVQ
	 evPkdEn3BshOCM5gZehLcao+tRGfgNwuPuYUFX4nrEm3Byqo/CKCq/HZgO1sLrfsl+
	 95vHEXrhyF1BOg6YTkM9bSKvluc8sF4mEQx0NqQt/Lvg2eNu0NywkqPiCAZaFxfW5h
	 5g7di5nPlmL8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	faetalize@proton.me
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek - ALC236 fix volume mute & mic mute LED on some HP models" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:13:14 -0400
Message-ID: <20240327121315.2830164-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 300ab0dfbf3903f36b4456643d8201438e6553b1 Mon Sep 17 00:00:00 2001
From: Valentine Altair <faetalize@proton.me>
Date: Tue, 12 Mar 2024 14:42:00 +0000
Subject: [PATCH] ALSA: hda/realtek - ALC236 fix volume mute & mic mute LED on
 some HP models

Some HP laptops have received revisions that altered their board IDs
and therefore the current patches/quirks do not apply to them.
Specifically, for my Probook 440 G8, I have a board ID of 8a74.
It is necessary to add a line for that specific model.

Signed-off-by: Valentine Altair <faetalize@proton.me>
Cc: <stable@vger.kernel.org>
Message-ID: <kOqXRBcxkKt6m5kciSDCkGqMORZi_HB3ZVPTX5sD3W1pKxt83Pf-WiQ1V1pgKKI8pYr4oGvsujt3vk2zsCE-DDtnUADFG6NGBlS5N3U4xgA=@proton.me>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4f92b19a58501..b6cd13b1775d9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9870,6 +9870,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a6e, "HP EDNA 360", ALC287_FIXUP_CS35L41_I2C_4),
+	SND_PCI_QUIRK(0x103c, 0x8a74, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x8aa0, "HP ProBook 440 G9 (MB 8A9E)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.43.0





