Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ED576FF36
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjHDLIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjHDLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:08:16 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EE7187
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:08:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9cb0bb04bso6474341fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 04:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691147293; x=1691752093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hfx9po4X2/nHcqp+uRJNh79vQllteYIAEl+4cz19+wo=;
        b=Y9v7LWfJuu1KFZqRR7L/JeSm0qr+0EnizOFk3RMoGM98ftwdz16Cjpn+F4ULdiDRur
         xTgSQf4glPExnarUK3ZmhHaCFXJpXfImFPGUHDU4vqWZ3T8EzdbtMBfq5NxSYT0U/pKj
         SMgs/zEEaPoNZISp8e+Wrlvw/eOwMLOiYgoZN5vcvDuQSUGiyJvRU4Brvj87Z6qIj1y1
         UyA5oTF3iI057XiaC0SKF0kMmx7u0EWu73VWSHNhN1oUr/AaGnu7oJ5YKJd2qGDYfBIP
         JY3TUmGr3tCKXVJ8jNUN5JWJf5o4hHK4xbZd8PBHtLwuzcWkknX2uQyZA5sBky0Ncuzs
         7jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691147293; x=1691752093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfx9po4X2/nHcqp+uRJNh79vQllteYIAEl+4cz19+wo=;
        b=ZwJxSmVvnIXM0iU07DynixYQp7JZZoADWgzcZ+DwCrcPCPnCLiI1b1wGKEr6i7ermV
         6dmQdqTAxBHwEXsFbLYmv0fwZHywyTsKwg7pDuPSaw4DozYmE0XR8LNWcqbH/FfcU5fo
         Jvq9iRODSHYkMktkqKkBSSvUbtNPARVLhkhQaKvj0rs1MOyVLhcwGvlju3DOsobxgEIy
         2EGp7Xlu264bCYes+SSJ9jwFIljD657ebgSx0c/13g0X8TQkGrOYpEOAGviyyEd0CwT9
         B/+8fMWMhWPhc/QZ2nWq0sKnkathPlgPKaDopiCx9ri41hHmfIR0F3b/Iyw+ykeNWRU/
         5EkQ==
X-Gm-Message-State: ABy/qLZDx0wlDZ/e07P0iPFywvdTaVHR0WY1b6PazFWPMeIScyq320Xv
        qg+j7vQ0uAYAr10ui8PKJ/S7QlIVo0Lq2bvG
X-Google-Smtp-Source: APBJJlG6BvJQhivkEuMwuZNLTqLU7d94VTvMiviNYgJs6jIw35Nbsz+MCrc3BEEtpcaS/JLy/GxOBQ==
X-Received: by 2002:a05:651c:332:b0:2b7:3a7e:9e89 with SMTP id b18-20020a05651c033200b002b73a7e9e89mr9741571ljp.2.1691147292700;
        Fri, 04 Aug 2023 04:08:12 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([178.160.196.94])
        by smtp.gmail.com with ESMTPSA id bn10-20020a170906c0ca00b00992b0745548sm1149478ejb.152.2023.08.04.04.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:08:12 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ALSA: pcmtest: Move buffer iterator initialization to prepare callback
Date:   Fri,  4 Aug 2023 15:07:39 +0400
Message-Id: <20230804110740.9867-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trigger callback is not the best place for buffer iterator
initialization, so move it out to the prepare callback, where it
have to be.

Minor enhancement: remove blank line.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Split changes in the patch into two different patches

 sound/drivers/pcmtest.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index 08e14b5eb772..dc7c9c758537 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -92,7 +92,6 @@ MODULE_PARM_DESC(inject_trigger_err, "Inject EINVAL error in the 'trigger' callb
 module_param(inject_open_err, bool, 0600);
 MODULE_PARM_DESC(inject_open_err, "Inject EBUSY error in the 'open' callback");
 
-
 struct pcmtst {
 	struct snd_pcm *pcm;
 	struct snd_card *card;
@@ -405,25 +404,9 @@ static int snd_pcmtst_pcm_close(struct snd_pcm_substream *substream)
 
 static int snd_pcmtst_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pcmtst_buf_iter *v_iter = runtime->private_data;
-
 	if (inject_trigger_err)
 		return -EINVAL;
 
-	v_iter->sample_bytes = runtime->sample_bits / 8;
-	v_iter->period_bytes = frames_to_bytes(runtime, runtime->period_size);
-	if (runtime->access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED ||
-	    runtime->access == SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED) {
-		v_iter->chan_block = runtime->dma_bytes / runtime->channels;
-		v_iter->interleaved = false;
-	} else {
-		v_iter->interleaved = true;
-	}
-	// We want to record RATE * ch_cnt samples per sec, it is rate * sample_bytes * ch_cnt bytes
-	v_iter->s_rw_ch = runtime->rate / TIMER_PER_SEC;
-	v_iter->b_rw = v_iter->s_rw_ch * v_iter->sample_bytes * runtime->channels;
-
 	return 0;
 }
 
@@ -454,8 +437,24 @@ static void pcmtst_pdev_release(struct device *dev)
 
 static int snd_pcmtst_pcm_prepare(struct snd_pcm_substream *substream)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct pcmtst_buf_iter *v_iter = runtime->private_data;
+
 	if (inject_prepare_err)
 		return -EINVAL;
+
+	v_iter->sample_bytes = samples_to_bytes(runtime, 1);
+	v_iter->period_bytes = snd_pcm_lib_period_bytes(substream);
+	v_iter->interleaved = true;
+	if (runtime->access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED ||
+	    runtime->access == SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED) {
+		v_iter->chan_block = snd_pcm_lib_buffer_bytes(substream) / runtime->channels;
+		v_iter->interleaved = false;
+	}
+	// We want to record RATE * ch_cnt samples per sec, it is rate * sample_bytes * ch_cnt bytes
+	v_iter->s_rw_ch = runtime->rate / TIMER_PER_SEC;
+	v_iter->b_rw = v_iter->s_rw_ch * v_iter->sample_bytes * runtime->channels;
+
 	return 0;
 }
 
-- 
2.34.1

