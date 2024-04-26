Return-Path: <linux-kernel+bounces-160289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FD38B3B78
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6811F22448
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A114D149C7F;
	Fri, 26 Apr 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cXFXEgzj"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A127A14885A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145399; cv=none; b=AfTu0OcNHdyCkmtEX+xQkNjOMzP4jshYuAlnCgfW0XLXl2WShSu6j4mSpg84GNyXrxDPMcj1Ek9tE41v19pezpwpHdYQZMVQB0aiLNZMH54jPT4cFr6gdGj2IZgmLuhgedUC71AiHVIINP98fuDTNCh8+iV8RvZm3aWepcQ/yNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145399; c=relaxed/simple;
	bh=hMVnOvoSMf+JRMF8t9uSLpRgdcu8Yz7Hi23L/8tCSL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9tlaRUS7hT8f9I/S755mFmgS67qAD6hqHRuih3wnriGM8q4tL7itj9zNj1HGcTvA4ZfMtdjBbDa6GLg+IrSTyEYQd0yhvPbzxuvtWp4e4LHsX5lJF9op3g9XOsu88p/7UfeBCNvoMy7cAs4dvWRMAK7tvSm3BqesiwxWKncOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cXFXEgzj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so17945255e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714145396; x=1714750196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdxkC9xy0JdUlM4HJdidG8uU38VPySKk64XDlad2PLg=;
        b=cXFXEgzj/K2X3kBAXJ99vCqEiATNy1CRXgS9Yyix2JRFxGPd2nGGcvkdsSFDzG9pWM
         smmT6+jcRv19l+S3r4IxvaxvofvUegiYcf2PZDfDYAsq+i8Z0MHy3Cl1v0j4ULWFrk7p
         ddilr2oi6BM4OmJauunUmUnANum8Jg/0dDZrNMZrwRaKrAGfOiJ2o/cztA3ezz61cR5i
         /KNvXDIxxxLiDDKKb2ksGdAMeqmqhjnrcI5y6chRJ+cGX+QwS4gwwVZCkeoT3EH6qx4r
         kNbH16OtzdIp34D053GpOMvJrNidqqN8wK+2Q9EDPqglf+no9BUzI0Bwr9DPWFGdL4+J
         mRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145396; x=1714750196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdxkC9xy0JdUlM4HJdidG8uU38VPySKk64XDlad2PLg=;
        b=Bw/MaQQG6d41D9IbPWizFsalLKGKa/+kvE4ikLBNERKCDana8XLs+jWgwQX3xRmUnV
         2vVO+9HEeAL8tpRnP6zj6WMV5k+BlzdvLDn6ANbMlT6z52xcq3/OndaoRwltHrUqG7N5
         +4EAuwM3ly2ZMZHrhF/tI5rRN6o7MDHPUp0Si9WkfR3LSivoergFY0DAhjABA4aJuX3B
         Ppv/zXp54eDcCBKc+snj6+uCV99kY5yQOpVOESXYCI9reCJPSAY7+kYIw09MKf/PrwSC
         xhn+35RXp2AEFzEI3XaMDod84UZAgJBra8G78HpiBKIIA/F9qujgIwdeDgXYFPTIdlyK
         oc0w==
X-Forwarded-Encrypted: i=1; AJvYcCVbNAn8P3xz4vaKX+ptys/NUV/IeovWxeIh/kQUfjwOpFiafkn9RDuJjD+YrIH1pqI45tt5hSRLLQgHOCManE7y+WirFPmW2MXrabNN
X-Gm-Message-State: AOJu0YzXCWW7MS3e+gfVleqLYxyo4DE0/pUrsGulTyvgdKts3SagfCB+
	pIaiPMTs5vjooUCywo8PkTKA7LLOIvq+YWVGGdwyQLFg8Lpn6XvpWSU7ZsIOkkw=
X-Google-Smtp-Source: AGHT+IHPpBP3QSa57mdn7C6mGnSnPPrJ1b15kSZTPSoFNzWhfVV6qwoJcqsNBhnR4twzoAilz89DKA==
X-Received: by 2002:a05:600c:4ecf:b0:416:bc18:2a00 with SMTP id g15-20020a05600c4ecf00b00416bc182a00mr2136057wmq.38.1714145395834;
        Fri, 26 Apr 2024 08:29:55 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1926:f73e:8b99:1c0a])
        by smtp.googlemail.com with ESMTPSA id i13-20020a05600c354d00b00419fba938d8sm22628687wmq.27.2024.04.26.08.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:29:55 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 1/4] ASoC: meson: axg-fifo: use threaded irq to check periods
Date: Fri, 26 Apr 2024 17:29:38 +0200
Message-ID: <20240426152946.3078805-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426152946.3078805-1-jbrunet@baylibre.com>
References: <20240426152946.3078805-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

With the AXG audio subsystem, there is a possible random channel shift on
TDM capture, when the slot number per lane is more than 2, and there is
more than one lane used.

The problem has been there since the introduction of the axg audio support
but such scenario is pretty uncommon. This is why there is no loud
complains about the problem.

Solving the problem require to make the links non-atomic and use the
trigger() callback to start FEs and BEs in the appropriate order.

This was tried in the past and reverted because it caused the block irq to
sleep while atomic. However, instead of reverting, the solution is to call
snd_pcm_period_elapsed() in a non atomic context.

Use the bottom half of a threaded IRQ to do so.

Fixes: 6dc4fa179fb8 ("ASoC: meson: add axg fifo base driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index bebee0ca8e38..ecb3eb7a9723 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -204,18 +204,26 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
 	unsigned int status;
 
 	regmap_read(fifo->map, FIFO_STATUS1, &status);
-
 	status = FIELD_GET(STATUS1_INT_STS, status);
+	axg_fifo_ack_irq(fifo, status);
+
+	/* Use the thread to call period elapsed on nonatomic links */
 	if (status & FIFO_INT_COUNT_REPEAT)
-		snd_pcm_period_elapsed(ss);
-	else
-		dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
-			status);
+		return IRQ_WAKE_THREAD;
 
-	/* Ack irqs */
-	axg_fifo_ack_irq(fifo, status);
+	dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
+		status);
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t axg_fifo_pcm_irq_block_thread(int irq, void *dev_id)
+{
+	struct snd_pcm_substream *ss = dev_id;
+
+	snd_pcm_period_elapsed(ss);
 
-	return IRQ_RETVAL(status);
+	return IRQ_HANDLED;
 }
 
 int axg_fifo_pcm_open(struct snd_soc_component *component,
@@ -243,8 +251,9 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
 	if (ret)
 		return ret;
 
-	ret = request_irq(fifo->irq, axg_fifo_pcm_irq_block, 0,
-			  dev_name(dev), ss);
+	ret = request_threaded_irq(fifo->irq, axg_fifo_pcm_irq_block,
+				   axg_fifo_pcm_irq_block_thread,
+				   IRQF_ONESHOT, dev_name(dev), ss);
 	if (ret)
 		return ret;
 
-- 
2.43.0


