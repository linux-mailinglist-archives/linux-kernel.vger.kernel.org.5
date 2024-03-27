Return-Path: <linux-kernel+bounces-120836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D61ED88DECF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9921F26632
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F0813AA4E;
	Wed, 27 Mar 2024 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV4pWmhv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11813AA3A;
	Wed, 27 Mar 2024 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541339; cv=none; b=F+6SCAqs5WrGAfRUvihRfEYPkOXXlm0qdmqoB+YocZqmHH/SXHvf1YoVQj4oyk4sq6dp50AoQ9wR0dEAY4CpsAvKKt/N+KWq02Sb51jrvYfj2hH1u64gekdrjISkrk0wnBMsvgzWadRzn/vUGUfutKn26CrhMXpK/wb13bM7FMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541339; c=relaxed/simple;
	bh=kDIsLVLx1NflgLdnfRw687WTZ1vXPS23eWSMYH8QCGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZvDS22uYS+PiySgFRj0llZnwQfRgblVDHt0bmeqag36zWxyCpYgr48MC4nI+NXjNjUSdgRZJp6Q//UWYeWmtQ6GRn8PxAvSNvBLvlEYVlChlXUzZRFPNaCxguZoZ7sR4415cmwmyE6tpdLay9lR2owSr3/QTeQK8q454YOZXkD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV4pWmhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909BDC433F1;
	Wed, 27 Mar 2024 12:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541339;
	bh=kDIsLVLx1NflgLdnfRw687WTZ1vXPS23eWSMYH8QCGE=;
	h=From:To:Cc:Subject:Date:From;
	b=hV4pWmhvqedI2KzF8JAh2/cl5Fyu5ymKdT8+UNVvx67lmMPwFJaM8kZTqqdX+JU3O
	 W73IPcx2ZOlyENJhes6ENdpA44X+9v2xgU+y6WzGyHvg8580rNdXelY0FLw6OoL33s
	 4MnxT4gq0iVO/BYxBck284UvTilEsAUyVBJS/GF0axfEC3g7RfOjWa/bPe5Wf9yVfL
	 4sgpa+QI1gAkrFpbajzkdhHVKLHRrW9bz9twG9qKkSsHeS958Ov5F5LUQUZMu+uBtN
	 q7XciOX+tnZRBvQhJO++bZhSMUC5L6RNBacrzaGf20Qi1JHIsb6IfmVcz7DARwaWJD
	 ZHe/43Sy2yPxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	faetalize@proton.me
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek - ALC236 fix volume mute & mic mute LED on some HP models" failed to apply to 6.7-stable tree
Date: Wed, 27 Mar 2024 08:08:57 -0400
Message-ID: <20240327120857.2826646-1-sashal@kernel.org>
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

The patch below does not apply to the 6.7-stable tree.
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





