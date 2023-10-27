Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49AC7D92AB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbjJ0Iwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345644AbjJ0Iw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:52:29 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2E71B9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:26 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-581e92f615fso1019767eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396745; x=1699001545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hvuzSc5vilro8Nl+ASMbdyW2rK3NnJIlPBZvpWvELE=;
        b=bzRe1gIaHrx/UCUoAHL74Gdz/mK+ZxpYlxaJoAAxmCk9n8JfihrBZHDzOgFA8Om1Cc
         CgbhXxvF+yrbO+cmjH41ObnwtDr1YYfOzsNan5TYx6f52qlBr/E+B8/XgwiCNo9hdV2L
         jDyS5CZDOxqjqGYAijznmlEStbbp+SjtvoRejnO4yezGRF16vVmh0ub67cPbAsOywjbc
         qX9l8EshcgxmqsVol+mrIVUzLWbw3I7fAzDVPQHXgKHeQI85+k4DMJMUEweoioksKnmm
         oWC5wnbp9blHmCSTcC57JCltxQ9I3/pZ/ymKXgLDK725BtwZarqA5geaVvtu0+X32+IN
         +dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396745; x=1699001545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hvuzSc5vilro8Nl+ASMbdyW2rK3NnJIlPBZvpWvELE=;
        b=fgjYECHYqvZ6QEcurmilTethhuWINiR9XQPFzMqmjJyo2hfOYmRuGJ6mVarby3yRJM
         sO/ZszemXKniChIhOGQZOCSzLsk3vtRVwPDhxJwKVIf8VbKDkRRSzy4r2YwUdAkGr10v
         Khy+3SUHAaRjujDkiZHAQj3QsjOB/L8djVVY28K9rDbpWLEEWEvEEqOwAu704Q5LbBoD
         JDUyXmJQIOdtOL0aDk8wsbViad7UrnoUShjtuZPU9Xvh0rrrEHC30p+Lw7zx02oXukOD
         w+JK/YzC3NVkR0gD7imCF3kKenr2z8oVLjICfZ06ZMyH8/xkJiUNMhikV4HyORehsMmw
         QA6A==
X-Gm-Message-State: AOJu0Yw4WyTNnI8KqiAAUeVpFVRmbET/NLd7t7/TYGXS0ZFVqxr8dYgv
        gYWHvF65GjIBLfTDJCY4VEE=
X-Google-Smtp-Source: AGHT+IGf6zPdvcvYt954KqsgKkQXumjS1Tias1/G35Qzq9nEIdmjDKsb/zeSeCAoLOlnppXDiKw+ag==
X-Received: by 2002:a05:6358:1a82:b0:168:cfc5:82c with SMTP id gm2-20020a0563581a8200b00168cfc5082cmr1907627rwb.13.1698396745346;
        Fri, 27 Oct 2023 01:52:25 -0700 (PDT)
Received: from ubuntu.. ([122.174.106.169])
        by smtp.gmail.com with ESMTPSA id h12-20020a63b00c000000b0055c178a8df1sm698825pgf.94.2023.10.27.01.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:52:24 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 04/10] staging: vt6655: Type encoding info dropped from variable name "pbyRsvTime"
Date:   Fri, 27 Oct 2023 14:21:53 +0530
Message-Id: <137b6c433e2d11b6ce99043f1fedf208789e380c.1698396278.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698396278.git.opensource206@gmail.com>
References: <cover.1698396278.git.opensource206@gmail.com>
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

variable name "pbyRsvTime" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c | 36 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 4ee9b48de2c2..5fdfc4dc70cc 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -76,83 +76,83 @@ static void vt6655_mac_set_bb_type(void __iomem *iobase, u32 mask)
  *      byPktType       - Tx Packet type
  *  Out:
  *      tx_rate         - pointer to RSPINF TxRate field
- *      pbyRsvTime      - pointer to RSPINF RsvTime field
+ *      rsv_time        - pointer to RSPINF RsvTime field
  *
  * Return Value: none
  */
 static void calculate_ofdmr_parameter(unsigned char rate,
 				       u8 bb_type,
 				       unsigned char *tx_rate,
-				       unsigned char *pbyRsvTime)
+				       unsigned char *rsv_time)
 {
 	switch (rate) {
 	case RATE_6M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
 			*tx_rate = 0x9B;
-			*pbyRsvTime = 44;
+			*rsv_time = 44;
 		} else {
 			*tx_rate = 0x8B;
-			*pbyRsvTime = 50;
+			*rsv_time = 50;
 		}
 		break;
 
 	case RATE_9M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
 			*tx_rate = 0x9F;
-			*pbyRsvTime = 36;
+			*rsv_time = 36;
 		} else {
 			*tx_rate = 0x8F;
-			*pbyRsvTime = 42;
+			*rsv_time = 42;
 		}
 		break;
 
 	case RATE_12M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
 			*tx_rate = 0x9A;
-			*pbyRsvTime = 32;
+			*rsv_time = 32;
 		} else {
 			*tx_rate = 0x8A;
-			*pbyRsvTime = 38;
+			*rsv_time = 38;
 		}
 		break;
 
 	case RATE_18M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
 			*tx_rate = 0x9E;
-			*pbyRsvTime = 28;
+			*rsv_time = 28;
 		} else {
 			*tx_rate = 0x8E;
-			*pbyRsvTime = 34;
+			*rsv_time = 34;
 		}
 		break;
 
 	case RATE_36M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
 			*tx_rate = 0x9D;
-			*pbyRsvTime = 24;
+			*rsv_time = 24;
 		} else {
 			*tx_rate = 0x8D;
-			*pbyRsvTime = 30;
+			*rsv_time = 30;
 		}
 		break;
 
 	case RATE_48M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
 			*tx_rate = 0x98;
-			*pbyRsvTime = 24;
+			*rsv_time = 24;
 		} else {
 			*tx_rate = 0x88;
-			*pbyRsvTime = 30;
+			*rsv_time = 30;
 		}
 		break;
 
 	case RATE_54M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
 			*tx_rate = 0x9C;
-			*pbyRsvTime = 24;
+			*rsv_time = 24;
 		} else {
 			*tx_rate = 0x8C;
-			*pbyRsvTime = 30;
+			*rsv_time = 30;
 		}
 		break;
 
@@ -160,10 +160,10 @@ static void calculate_ofdmr_parameter(unsigned char rate,
 	default:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
 			*tx_rate = 0x99;
-			*pbyRsvTime = 28;
+			*rsv_time = 28;
 		} else {
 			*tx_rate = 0x89;
-			*pbyRsvTime = 34;
+			*rsv_time = 34;
 		}
 		break;
 	}
-- 
2.34.1

