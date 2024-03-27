Return-Path: <linux-kernel+bounces-120993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC41888E14E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D01D1F277E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46AB156F50;
	Wed, 27 Mar 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro7Ed/5+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10745156F2D;
	Wed, 27 Mar 2024 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541790; cv=none; b=WEyZzmNxJfzSXZ8OV00erW9DSusfutvrP+h5aHiYCr+jbhqrQiilZ7nJQLjCueDgzBK2R/29nZZxbuSixqHGaI9nQlbLlwYQ919RLLXYdT07KrNPIMOy/9a40iHzVPbXHnH9WJs2k9Rmtu/JFGKXa04LVprZsNT9CFpOj8gU89o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541790; c=relaxed/simple;
	bh=TSwAlfxkLHgRmT/0S2t2Bo/+FY2EgBInY0RLKm1ChlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edBgnLFlSb2GWYUz1hSjiu3OnThez2bydvAQev6ffXNtnROUIhQsCl1iXWn8uc3O++xrQagcR1Sl8n5SqMV0WgUrFER1BJ2NzDVVEgWQCz+83aQkdhK49FDzW9CK7UoTovrTM2k/it8teIAQH7ah2knzNGCZ/LkD6ShMkZQKI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ro7Ed/5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2C0C43390;
	Wed, 27 Mar 2024 12:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541789;
	bh=TSwAlfxkLHgRmT/0S2t2Bo/+FY2EgBInY0RLKm1ChlM=;
	h=From:To:Cc:Subject:Date:From;
	b=Ro7Ed/5+relyMRjCahK38dMVU5ASixH6zyIkbu0zyzIyfbA6cFnn92lzWsQcenbHx
	 Y5qFYH93ohT5itOjMGrUXNqS4IvWTkyhuHBQAZ+JU8UAtc9Oa+GM0H5tXvpKgGNhbj
	 OHCtqsxJNRvWVw5R5HTKJfGjxrgt1E9mnlr68NTU2d78fX98UllYGHTDGJLcWEM1sS
	 PvVOQodYRLY20KbnNsRVc6WDy/3I69g1WISmkVcEwQrPpBgodUMCqDcxhAFhUMAbas
	 md4kL8jBNBn8Sh79u2rt4DD3jt9xKzbkcPQmf2VAlbqI4ZdlTNey5hRWP/3oczEbtt
	 jLRi0XAQPcc0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	faetalize@proton.me
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek - ALC236 fix volume mute & mic mute LED on some HP models" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:16:27 -0400
Message-ID: <20240327121627.2832730-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
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





