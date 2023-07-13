Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B029F751AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjGMICZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjGMIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:01:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E8226A2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:00:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fbf9e4c0d5so103566e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689235208; x=1691827208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQWUSEoOR5t3MEXAfVU6qpzWsgyy+Mooxn06h3Z1zKo=;
        b=AbdHpSx4W0NU1QBnqdMfK5CRrsrCnCDXoNeNtfRok8O6iX1amyWXGG5Mk/QKRKTAwC
         9KW+bTz5eZFBTyuq4Y0wxP7KBdIO836HbQ73gkAb493zR4IwTrjk0tsXs3/IELE/H7wm
         VxkVNCGVeEIaAUwf0aZpMLOCq7J2zB+Pp84scSphSsXA1XTWl2vYk+4Oy++5BFR1ilkD
         wYDeskynXwOoE17nfa7gMUCT46k8f3zhiWQHJFTEOW9elUY+8yzuowcG3/TY8SJAaaje
         3Irjw2wlQ7B04AwJXPzb7gUGC1jcJbNNAMu+TbJt+VGfwjl1cseVeke5MlxYgx6EqwLv
         FTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689235208; x=1691827208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQWUSEoOR5t3MEXAfVU6qpzWsgyy+Mooxn06h3Z1zKo=;
        b=V1aBRktJzxs4i3S1JlCoLbemhCaYvvnw65WWjYRM8zXfcUJoIy1/vr0O5dyOCA2pak
         mDoFfVVkIdDPNZmKRxRkBD57a2D2d3T3ir/XciBpZN0iiLHh7h5AuxHk2Y7x0oR8WR+D
         wSU7UMNq+0XMlANwFQE0H0A4whKfCNDcSXUfAQNNxSBIpi4gaNi2e91ZWV4LO9744IxK
         MN4ZiDGYHZEAYx7aMumg5PfHIENFm+wKVTY+x6pyoRWD62eguvft9ROl4qSniP9FrrJg
         2d8eD0nTmM+6r0MofD7gBiipJ1Vris+6jQKUbqOPyikG8ykjox7j4tVJO4p74I+f1FSP
         oE9w==
X-Gm-Message-State: ABy/qLaugGpj6jkTjOWFQ5HTOrHXiP8LGETfYzS2gLussgoRzu9nQkhD
        S4lCdda5MRB0gH4ewtXDuzQ=
X-Google-Smtp-Source: APBJJlHt2Zs4KS1Le0F4m4coeU4CvQdR1DZX2Yu483HL8m6d0Nk0AYwmmEWZ6I3sZYF5Hpm0aqVZoA==
X-Received: by 2002:ac2:4833:0:b0:4fb:8eac:8571 with SMTP id 19-20020ac24833000000b004fb8eac8571mr491482lft.0.1689235208117;
        Thu, 13 Jul 2023 01:00:08 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([178.160.196.94])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25288000000b004fb8c0f247fsm1011385lfm.129.2023.07.13.01.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 01:00:07 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ALSA: pcmtest: minor optimizations
Date:   Thu, 13 Jul 2023 11:59:53 +0400
Message-Id: <20230713075953.13692-2-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713075953.13692-1-ivan.orlov0322@gmail.com>
References: <20230713075953.13692-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decrease the buffer filling overhead with conditional remainder
calculation in the 'inc_buf_pos' inline function.

Fix the driver to use already defined variables where it is possible
in 'check_buf_block_ni' and 'fill_block_pattern_n' functions.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Split changes in the patch into two different patches

 sound/drivers/pcmtest.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index e74c523e49eb..08e14b5eb772 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -144,7 +144,8 @@ static inline void inc_buf_pos(struct pcmtst_buf_iter *v_iter, size_t by, size_t
 {
 	v_iter->total_bytes += by;
 	v_iter->buf_pos += by;
-	v_iter->buf_pos %= bytes;
+	if (v_iter->buf_pos >= bytes)
+		v_iter->buf_pos %= bytes;
 }
 
 /*
@@ -200,10 +201,10 @@ static void check_buf_block_ni(struct pcmtst_buf_iter *v_iter, struct snd_pcm_ru
 	u8 current_byte;
 
 	for (i = 0; i < v_iter->b_rw; i++) {
-		current_byte = runtime->dma_area[buf_pos_n(v_iter, channels, i % channels)];
+		ch_num = i % channels;
+		current_byte = runtime->dma_area[buf_pos_n(v_iter, channels, ch_num)];
 		if (!current_byte)
 			break;
-		ch_num = i % channels;
 		if (current_byte != patt_bufs[ch_num].buf[(v_iter->total_bytes / channels)
 							  % patt_bufs[ch_num].len]) {
 			v_iter->is_buf_corrupted = true;
@@ -243,7 +244,7 @@ static void fill_block_pattern_n(struct pcmtst_buf_iter *v_iter, struct snd_pcm_
 
 	for (i = 0; i < v_iter->b_rw; i++) {
 		ch_num = i % channels;
-		runtime->dma_area[buf_pos_n(v_iter, channels, i % channels)] =
+		runtime->dma_area[buf_pos_n(v_iter, channels, ch_num)] =
 			patt_bufs[ch_num].buf[(v_iter->total_bytes / channels)
 					      % patt_bufs[ch_num].len];
 		inc_buf_pos(v_iter, 1, runtime->dma_bytes);
-- 
2.34.1

