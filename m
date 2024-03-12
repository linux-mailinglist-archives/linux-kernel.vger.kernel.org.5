Return-Path: <linux-kernel+bounces-100169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92A68792E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CF21F22EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9269879B7A;
	Tue, 12 Mar 2024 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ac1emfkd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lNsVlYH+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6366179B69;
	Tue, 12 Mar 2024 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242552; cv=none; b=QIUt+ujixUQ2mt5hqjR+z6QS0mfBijnFTfFH2G8qKNse3FqFG4mHTaYkVhvf1wtTjUo6fdU/kuxvdLpXZiJEmusolkrSWlJW+8kb7BHT7QZsnTxsbXIOpQT31v0v0nXvxXBapSvGg11YsSPELWl5kIlO1coDlVtJ68EnSRGiSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242552; c=relaxed/simple;
	bh=cywT/QByQFIJdhADZzCtgX79R/D7p67c/GQR1xc82d0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qdpPK2V5+SgpSyT//BHZ8/OJqXwjhdkURKF1ZdgaCvsZ0NK3NNzv2z8jfA+qpmLQMwR0PizS7viejUXd38x7aLA6T1ilQtpOcSAlc0VBy64kerXBcZF97Q62n35lpcntX+3TybuJvLmk23IdtuUrJMjbT16RQglygC/epH1whs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ac1emfkd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lNsVlYH+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710242549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sf8IIBXXR308h4kRJYGu81pgt61c8R8ZXVrdx1HuATA=;
	b=Ac1emfkdlm80k4NNTrCk8ypmAbhqVcLh0Kz1QOcDVFPeDx9wpxESgrFvxYlIX1BzpQUp/p
	em+4Tmjou7GWCWrnQq7k6OpRokEfvU3eKL4sui1heA0izq4y4rY0BLAL6CjQkJorH4XyXu
	ZU9+FKCqgt1YuWe+GwdNjAafSnXf6H2RiO68MdGyK7m1D15TOeMdHRs8+BtL+L4mwjR5gU
	PTZGw0ikFWrZIQUtR9rsfeZa+pS6T9QXluTpUC/4zyQ6szYjeGt+Q9ie6YOH8bXa9XyPrc
	GLPvVp/OsV26opnHbRV2AVepeHgEbK5FX4aJKT5ycRCI5kdF30He28WL4JdqbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710242549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sf8IIBXXR308h4kRJYGu81pgt61c8R8ZXVrdx1HuATA=;
	b=lNsVlYH+t9pbriX1H3dOtFuKudDyN9IUKK3uLJfP6y+9tXbhZxDSsh7XxbMlABleSvEYfi
	+yzmuutONeyQN6AA==
Date: Tue, 12 Mar 2024 12:22:28 +0100
Subject: [PATCH] ALSA: aaci: Delete unused variable in aaci_do_suspend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240312-aaci-unused-v1-1-09be643f67c2@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAPM68GUC/x3MQQqAIBBA0avIrBtQM6SuEi1Ep5qNhWIE4t2Tl
 m/xf4VMiSnDIiokejjzFTvUIMCfLh6EHLpBS23kqDQ65xlLLJkCBmuUVXLWNEnoxZ1o5/e/rVt
 rH4HQ5qNdAAAA
To: Russell King <linux@armlinux.org.uk>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710242548; l=1049;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cywT/QByQFIJdhADZzCtgX79R/D7p67c/GQR1xc82d0=;
 b=Gx2FROu1Olg8QxebPKXGIbZIuHew1YoC26h43RlpBK9Hj4HCacMYmsn4XBAh6+PgVx/d5keqb
 rEIQpH/iYx5DKFGyxE0rb0k+2cGlGMzdAeqGYoConcgYqrUUNP0R94J
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The variable aaci is not used anymore and can be deleted.

Fixes: 792a6c51875c ("[ALSA] Fix PM support")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Note: This only seems to trigger with the series
"ALSA: Clean up with DEFINE_SIMPLE_DEV_PM_OPS()" applied.

(Encountered on next-20240312)

[0] https://lore.kernel.org/all/20240207155140.18238-1-tiwai@suse.de/
---
 sound/arm/aaci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 0817ad21af74..2bfffdd33864 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -740,7 +740,6 @@ static const struct snd_pcm_ops aaci_capture_ops = {
 #ifdef CONFIG_PM
 static int aaci_do_suspend(struct snd_card *card)
 {
-	struct aaci *aaci = card->private_data;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3cold);
 	return 0;
 }

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240312-aaci-unused-d74171092e50

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


