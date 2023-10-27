Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40507D92AA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345511AbjJ0Iwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345601AbjJ0Iw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:52:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D848CD4A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so1810712b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396743; x=1699001543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+UmcifUD+EOeaauItVXeb4cJhVMVx5fQNibExuj5hw=;
        b=TUOaceXNSDarNBV5PzZAvb07yVNiOT4VoQHt6cXShvwaZ31gXnsP76Mc05VLLxNprJ
         doRc8Myb6HPXmj3J+NiuInkIif+IP2FQi6hy359SQji2hzTWiod2eQjHAmlnxqQANLLv
         lDIzus80r6j0rX5ZMBdRVgfvOu4cdyhOyzmOjHdpxFiiOWoPzZwcm0zo+bTnFxfjrmXr
         BdyZUnkJxWjq0QVbnytGS2pPksfh48RwaXYU13M7/s99GrhvJtwV9ZUrTYbScw2HIgSv
         Sa96106B3Rcg3SC3cBhS7hK05x8k9WXsufZ64lqzS2A+X4q3sIeeLAHP5v0PrFFvHY8U
         PsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396743; x=1699001543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+UmcifUD+EOeaauItVXeb4cJhVMVx5fQNibExuj5hw=;
        b=T8HYTxe4JLUJ1OHJsGek4CbDrvmKmtkPhwOP48l+jhcmT+zv2RS34vN55j8XDlATkk
         VF80cRxzY5lrlY8PBkRr09DWt4Wettt13mcw3qD6smjpsjG26LLnMA28aPte7vWHLtOG
         LIZ0ItejO1dKWu6IuDUXP+k7MZYXt1sebnxFWur8e//G4uIM/dT1saqShDLFYl+DEjOW
         GvSeqrSnoOlxyV1RfENU9fl+GqhSSz0Dx3MEmQvY2hjBo5B68vuExkCoQQuJNGgVq+Xh
         xwpsJWjNhjibKqvGLcRfiM1OnTz3P420Uv/fjicnnFTk7YwKQZKajH1vI0U2Qbtl0Yhh
         EIcw==
X-Gm-Message-State: AOJu0Yz+a/6UsO8iGEKWaR405jLqzmqd2ZyQPlWFYFBklyGyEikeshAL
        FJ3kmUZP8sFcEKcNb7SvNAU=
X-Google-Smtp-Source: AGHT+IHKSMAkF7Pnsgz+EZNOdMuZuvgKbEfnL8usPRl2qxpvh5sqXTqT/gMvwUTwyVWatDl9cfV6pA==
X-Received: by 2002:a05:6a21:4988:b0:15e:9c50:73ee with SMTP id ax8-20020a056a21498800b0015e9c5073eemr2409644pzc.53.1698396743302;
        Fri, 27 Oct 2023 01:52:23 -0700 (PDT)
Received: from ubuntu.. ([122.174.106.169])
        by smtp.gmail.com with ESMTPSA id h12-20020a63b00c000000b0055c178a8df1sm698825pgf.94.2023.10.27.01.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:52:22 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 03/10] staging: vt6655: Type encoding info dropped from variable name "pbyTxRate"
Date:   Fri, 27 Oct 2023 14:21:52 +0530
Message-Id: <409a80898ccbb398c31f222dc29cea4725a0cfb3.1698396278.git.opensource206@gmail.com>
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

variable name "pbyTxRate" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c | 36 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 2968be1f8d4e..4ee9b48de2c2 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -75,83 +75,83 @@ static void vt6655_mac_set_bb_type(void __iomem *iobase, u32 mask)
  *      wRate           - Tx Rate
  *      byPktType       - Tx Packet type
  *  Out:
- *      pbyTxRate       - pointer to RSPINF TxRate field
+ *      tx_rate         - pointer to RSPINF TxRate field
  *      pbyRsvTime      - pointer to RSPINF RsvTime field
  *
  * Return Value: none
  */
 static void calculate_ofdmr_parameter(unsigned char rate,
 				       u8 bb_type,
-				       unsigned char *pbyTxRate,
+				       unsigned char *tx_rate,
 				       unsigned char *pbyRsvTime)
 {
 	switch (rate) {
 	case RATE_6M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
-			*pbyTxRate = 0x9B;
+			*tx_rate = 0x9B;
 			*pbyRsvTime = 44;
 		} else {
-			*pbyTxRate = 0x8B;
+			*tx_rate = 0x8B;
 			*pbyRsvTime = 50;
 		}
 		break;
 
 	case RATE_9M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
-			*pbyTxRate = 0x9F;
+			*tx_rate = 0x9F;
 			*pbyRsvTime = 36;
 		} else {
-			*pbyTxRate = 0x8F;
+			*tx_rate = 0x8F;
 			*pbyRsvTime = 42;
 		}
 		break;
 
 	case RATE_12M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
-			*pbyTxRate = 0x9A;
+			*tx_rate = 0x9A;
 			*pbyRsvTime = 32;
 		} else {
-			*pbyTxRate = 0x8A;
+			*tx_rate = 0x8A;
 			*pbyRsvTime = 38;
 		}
 		break;
 
 	case RATE_18M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
-			*pbyTxRate = 0x9E;
+			*tx_rate = 0x9E;
 			*pbyRsvTime = 28;
 		} else {
-			*pbyTxRate = 0x8E;
+			*tx_rate = 0x8E;
 			*pbyRsvTime = 34;
 		}
 		break;
 
 	case RATE_36M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
-			*pbyTxRate = 0x9D;
+			*tx_rate = 0x9D;
 			*pbyRsvTime = 24;
 		} else {
-			*pbyTxRate = 0x8D;
+			*tx_rate = 0x8D;
 			*pbyRsvTime = 30;
 		}
 		break;
 
 	case RATE_48M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
-			*pbyTxRate = 0x98;
+			*tx_rate = 0x98;
 			*pbyRsvTime = 24;
 		} else {
-			*pbyTxRate = 0x88;
+			*tx_rate = 0x88;
 			*pbyRsvTime = 30;
 		}
 		break;
 
 	case RATE_54M:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
-			*pbyTxRate = 0x9C;
+			*tx_rate = 0x9C;
 			*pbyRsvTime = 24;
 		} else {
-			*pbyTxRate = 0x8C;
+			*tx_rate = 0x8C;
 			*pbyRsvTime = 30;
 		}
 		break;
@@ -159,10 +159,10 @@ static void calculate_ofdmr_parameter(unsigned char rate,
 	case RATE_24M:
 	default:
 		if (bb_type == BB_TYPE_11A) { /* 5GHZ */
-			*pbyTxRate = 0x99;
+			*tx_rate = 0x99;
 			*pbyRsvTime = 28;
 		} else {
-			*pbyTxRate = 0x89;
+			*tx_rate = 0x89;
 			*pbyRsvTime = 34;
 		}
 		break;
-- 
2.34.1

