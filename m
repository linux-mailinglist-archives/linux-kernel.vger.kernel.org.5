Return-Path: <linux-kernel+bounces-31749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8141383335D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E1E2839CE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B90C8C4;
	Sat, 20 Jan 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kUTgD7yL"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA11D507
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705743747; cv=none; b=rCe65xUwjY8DU0t9FW3jc+UVC4DzYU1GQ6quBWn9OI9SqPU4G0ymEM/SZPJ0X1ongg9hlaV8VLjXwV9GFcQjqtRYJ9H4A5m5givTxEUk3nbA0GfmuxgcXwR2yzFu0c/IHE50US0iE0cA4UWUGQivHo9uDRXysXhQe4UvyqXNQyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705743747; c=relaxed/simple;
	bh=1+N3YmtcT/VrFLO1mZria8sCoBSPBU080hcNWd3hcB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b58VqIdGK4cxMQDUBIaW0JJ746e8+VCFZx6V2XnQzxROTq5U/nRRRFV1QV/uz+ue41L7V7GBM2OD/9kQdZec45NV6JJU0Mq6j7ujUoz5U6LcQUbvHLSXADLkCgLgu7F2bPwFbRdfaZcBGPTv92bQ3E9dHvyRt9ckEaOHnptgU+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kUTgD7yL; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id R7rirLBJA6LbeR7rjrquA5; Sat, 20 Jan 2024 10:42:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705743735;
	bh=jqkuByAneJ1tG1xwrZ5rETs0q0pFU+XkKF5W5mqRRsk=;
	h=From:To:Cc:Subject:Date;
	b=kUTgD7yLyeXMn4n1wcBXLPiynU/tLOC2Nv9PXTX52BE35qxpILX+MwppzmzvxZDW+
	 WZf7sAn5wNb7FHfuKvYgyEvZDAQ8lMyqX/qlRl1wu98svDV626XGe61Zk4Aajn3PKK
	 7y+3mDMw5nlqJ2xqs+YQI+Y3Ei/Rm72tbnnni0Cjy5IbHm2kt5PRGEYDWPpnVii5EZ
	 T/H93MbpVy+lWZrC7OSzJYFkxtzPbOIwg3ZyrEtSo/awvqmP1cb+saNd8QRLbrD6H5
	 +xOImqeUeLjEPHnW1Lq30gZ/7WSSPRYeyU+W613E6EpgJZv/ljs5b0UxMDQZVUe9e9
	 THA+q/8Zs8YwQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Jan 2024 10:42:15 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-sound@vger.kernel.org
Subject: [PATCH] ALSA: synth: Save a few bytes of memory when registering a 'snd_emux'
Date: Sat, 20 Jan 2024 10:42:12 +0100
Message-ID: <9e7b94c852a25ed4be5382e5e48a7dd77e8d4d1a.1705743706.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_emux_register() calls pass a string literal as the 'name' parameter.

So kstrdup_const() can be used instead of kfree() to avoid a memory
allocation in such cases.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/sound/emux_synth.h | 2 +-
 sound/synth/emux/emux.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/emux_synth.h b/include/sound/emux_synth.h
index 1cc530434b97..3f7f365ed248 100644
--- a/include/sound/emux_synth.h
+++ b/include/sound/emux_synth.h
@@ -103,7 +103,7 @@ struct snd_emux {
 	int ports[SNDRV_EMUX_MAX_PORTS];	/* The ports for this device */
 	struct snd_emux_port *portptrs[SNDRV_EMUX_MAX_PORTS];
 	int used;	/* use counter */
-	char *name;	/* name of the device (internal) */
+	const char *name;	/* name of the device (internal) */
 	struct snd_rawmidi **vmidi;
 	struct timer_list tlist;	/* for pending note-offs */
 	int timer_active;
diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index 0006c3ddb51d..a82af9374852 100644
--- a/sound/synth/emux/emux.c
+++ b/sound/synth/emux/emux.c
@@ -85,7 +85,7 @@ int snd_emux_register(struct snd_emux *emu, struct snd_card *card, int index, ch
 		return -EINVAL;
 
 	emu->card = card;
-	emu->name = kstrdup(name, GFP_KERNEL);
+	emu->name = kstrdup_const(name, GFP_KERNEL);
 	emu->voices = kcalloc(emu->max_voices, sizeof(struct snd_emux_voice),
 			      GFP_KERNEL);
 	if (emu->name == NULL || emu->voices == NULL)
@@ -140,7 +140,7 @@ int snd_emux_free(struct snd_emux *emu)
 	snd_emux_delete_hwdep(emu);
 	snd_sf_free(emu->sflist);
 	kfree(emu->voices);
-	kfree(emu->name);
+	kfree_const(emu->name);
 	kfree(emu);
 	return 0;
 }
-- 
2.43.0


