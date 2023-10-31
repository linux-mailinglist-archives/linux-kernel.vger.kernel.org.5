Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8627DC5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjJaFfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJaFfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:35:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00051BD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc3bb4c307so14149735ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698730503; x=1699335303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I92nHjRtfgt/kVv9q05XvKDSG1e3bVqP1qntsFLqJw=;
        b=AEMW1RF7ujLdL3w53lfEMAQwwLERtpdvNcbEBxeWxIXBg/htugS7RPsSL1/nh7aAmh
         hOkpaBrwe8gV2xRKUOghJG3mGvMv6wOrviMil+f8tBnUMT/O0ep/RtHfc3rhKZ40VbCv
         UnnwIT21Tr6MgCT/vMc8CHHYvP0uDJh6mv06jK38jQgdGs30BpJtEg6Ks8Y9Kdk7xW5E
         JwUeGu90guz8QVqw6nGJZRcE11+tQ498RKZWVomAbQ0S4mmRHKMBqqo7geKvaG9cjZf7
         S1ITaKCn0mVf1b2AayTlDYdVTG/uL9PK/TE3KFqFHLhhgywWj7RU/oOCA+W5OaT/Jboo
         L8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698730503; x=1699335303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4I92nHjRtfgt/kVv9q05XvKDSG1e3bVqP1qntsFLqJw=;
        b=X57VOZ5IGjmMUMK4Wv02d+uapb6+LBAuLxYmNFaRonpV2vSQrTPAk5CFVYSjLSv6I5
         5GwfZDjOYEnhvmvL+hUpetAv0NpbCy1gv7jwbDGn0F+T4ODHt7G6eEVl7ruG7BiSgGBR
         GQVvzmcXiddPcgJZnugaYQdXFbRqY9VYQ3pW3Zm9YyFdhj/OI4slw4ENKHNqfJB2Mfie
         6vAb+7Z0D1ktqOH0zmdbe0WFmdAXwZE5ucztFnfTWjGq2wCsITGpkO9xT+j4vv1Vq8rX
         RBsLAYAxueUlPWpkKYme76hZZkWLp3uY+9rzHUk8fYhJA5Vsu9tIaC9ozyuFNX5NXMjk
         jjjA==
X-Gm-Message-State: AOJu0Yw9o9SF3LL7lUYOp172BGzGq4Tiw9bxQlpAOA2pnk/s5SF9XjM6
        LT7B8RMS5ArekAtwU2IOtSo=
X-Google-Smtp-Source: AGHT+IE0uMuwUFUKjYPaamC4PZGj44kXcL3wPEzEgIUwEptd/c5m5AV5W5Ave3zevUcZK6yjdvNJDw==
X-Received: by 2002:a17:903:442:b0:1ca:8541:e1fe with SMTP id iw2-20020a170903044200b001ca8541e1femr9221519plb.62.1698730502840;
        Mon, 30 Oct 2023 22:35:02 -0700 (PDT)
Received: from ubuntu.. ([122.182.231.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001c0a414695bsm422211pld.43.2023.10.30.22.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:35:02 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 11/11] staging: vt6655: Type encoding info dropped from variable name "apTailTD"
Date:   Tue, 31 Oct 2023 11:04:34 +0530
Message-Id: <482553f089fe86dc7ebecd96c9397cfaa9c7bdf9.1698730318.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698730318.git.opensource206@gmail.com>
References: <cover.1698730318.git.opensource206@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable name "apTailTD" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c        | 4 ++--
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index d20afbc1072f..36183f2a64c1 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -388,10 +388,10 @@ void card_safe_reset_tx(struct vnt_private *priv)
 	struct vnt_tx_desc *curr_td;
 
 	/* initialize TD index */
-	priv->apTailTD[0] = &priv->apTD0Rings[0];
+	priv->tail_td[0] = &priv->apTD0Rings[0];
 	priv->apCurrTD[0] = &priv->apTD0Rings[0];
 
-	priv->apTailTD[1] = &priv->apTD1Rings[0];
+	priv->tail_td[1] = &priv->apTD1Rings[0];
 	priv->apCurrTD[1] = &priv->apTD1Rings[0];
 
 	for (uu = 0; uu < TYPE_MAXTD; uu++)
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index fadbfccf42de..0212240ba23f 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -133,7 +133,7 @@ struct vnt_private {
 	volatile int                iTDUsed[TYPE_MAXTD];
 
 	struct vnt_tx_desc *apCurrTD[TYPE_MAXTD];
-	struct vnt_tx_desc *apTailTD[TYPE_MAXTD];
+	struct vnt_tx_desc *tail_td[TYPE_MAXTD];
 
 	struct vnt_tx_desc *apTD0Rings;
 	struct vnt_tx_desc *apTD1Rings;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index a1f3dc25ad0e..b0b262de6480 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -737,7 +737,7 @@ static int device_init_td0_ring(struct vnt_private *priv)
 
 	if (i > 0)
 		priv->apTD0Rings[i - 1].next_desc = cpu_to_le32(priv->td0_pool_dma);
-	priv->apTailTD[0] = priv->apCurrTD[0] = &priv->apTD0Rings[0];
+	priv->tail_td[0] = priv->apCurrTD[0] = &priv->apTD0Rings[0];
 
 	return 0;
 
@@ -777,7 +777,7 @@ static int device_init_td1_ring(struct vnt_private *priv)
 
 	if (i > 0)
 		priv->apTD1Rings[i - 1].next_desc = cpu_to_le32(priv->td1_pool_dma);
-	priv->apTailTD[1] = priv->apCurrTD[1] = &priv->apTD1Rings[0];
+	priv->tail_td[1] = priv->apCurrTD[1] = &priv->apTD1Rings[0];
 
 	return 0;
 
@@ -969,7 +969,7 @@ static int device_tx_srv(struct vnt_private *priv, unsigned int idx)
 	unsigned char byTsr0;
 	unsigned char byTsr1;
 
-	for (desc = priv->apTailTD[idx]; priv->iTDUsed[idx] > 0; desc = desc->next) {
+	for (desc = priv->tail_td[idx]; priv->iTDUsed[idx] > 0; desc = desc->next) {
 		if (desc->td0.owner == OWNED_BY_NIC)
 			break;
 		if (works++ > 15)
@@ -1007,7 +1007,7 @@ static int device_tx_srv(struct vnt_private *priv, unsigned int idx)
 		}
 	}
 
-	priv->apTailTD[idx] = desc;
+	priv->tail_td[idx] = desc;
 
 	return works;
 }
-- 
2.34.1

