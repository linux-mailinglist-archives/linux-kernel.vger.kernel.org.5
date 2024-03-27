Return-Path: <linux-kernel+bounces-121067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE91588E207
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9921C2945AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0CB161327;
	Wed, 27 Mar 2024 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRWuq75G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088F161318;
	Wed, 27 Mar 2024 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541991; cv=none; b=U08/UFDgUn807uZJXPiBspUsF2NX8O3Jsv5eeJ2J68VpNtEkAV7zFhM3TND5pd6unIr0sLav5/5ZrOgXI8mIafevmo8USxJ6dUOclviNn20PQ6q07zCRROFzLoIg5vWFafw55aFMrZbpfKkDsCWfME+GCWlBGAJfTyOD8QiN85M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541991; c=relaxed/simple;
	bh=wuO15VNJqjqwmcm6Na53isU80ZBmhw3AhzwNTpq0ZTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIIJ+0QomvakJiCowCDy/HAfydg4yc7SLr8/Xh4wCfVfruLKRnsFtCMTlw7gItsh/IpQSJU4S0tzW/XLzYwkfgjHxaNTn4rRHQhQ8BmL9lzezemkqydba4vXolhJoQCsdK+kXqGd1lF8jHe8JwxLg8+kYJOYlEsBQSe2uOX4Nx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRWuq75G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3E6C433F1;
	Wed, 27 Mar 2024 12:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541990;
	bh=wuO15VNJqjqwmcm6Na53isU80ZBmhw3AhzwNTpq0ZTk=;
	h=From:To:Cc:Subject:Date:From;
	b=DRWuq75GUuFxyliEI9b4u1V3c2F9n2sJUpNMhfmbSBaG3rPkQF1AUPTVHU2g/v/U9
	 +VIOx2OvXrrd5HdAxijN9cmJbb1U+YafZOZ/sEbyNNeXsQPciBxp8hiwroko7H2Lmw
	 N9sVAxZ309QlluhmzjTy3jYLiS9W+hu/7FPeT9REgLPjAcM1PZGCsPHv4bLf9UCzOG
	 b8nc8D53cW94VMbPml+UEmC6ifQsZkTOWu4l0rybUUWxne7vIbXSO/NEkLYEZ4cgi0
	 2d87RRjozocL1hxJNDhZzqH4qbKIRAu6n05MYd3gGkI8aK+F7ua2HKW5AD07y2QX6H
	 1wAJftA1u7tLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	faetalize@proton.me
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek - ALC236 fix volume mute & mic mute LED on some HP models" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:19:49 -0400
Message-ID: <20240327121949.2835499-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
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





