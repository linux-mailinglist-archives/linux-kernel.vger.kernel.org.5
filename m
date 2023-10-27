Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBEA7D92A9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbjJ0Iwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbjJ0IwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:52:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFF91B4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-694ed847889so1740693b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396741; x=1699001541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59Ey2F1WGl117Zy7e/WDuBfmKzQ/9WE16LCyKckLl/k=;
        b=D427RXdvVCch/HLsV9jsQlmGeXsljMBVuoWrr1bUgzVa5mqz2KQhLjWZ+7SWCJKQyD
         5tRN2VdbJV1sSJlMsr1QwLilLve5klpSlZoj3Rg3xoppQBw2UGegtCYf91+qtZM2B6Zb
         k9nyoHth+LCGwqPV1gONsU29VeJQnAHUjv3qrXyBnkQep++pzjMCXf26iNsjI+z5XUg9
         QOXmL4ko5Ez69U2KzisuGXpEdulLxP6X8JgWRj+06bR/KRSOGg0ZJTA7lvOntAAm9YZd
         dNjnfp1AQmt7n468dwlkA0EM70xGkN2diCfVPv43m/I8hRcBJAWtsMaPWeaoWvh/yefu
         /3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396741; x=1699001541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59Ey2F1WGl117Zy7e/WDuBfmKzQ/9WE16LCyKckLl/k=;
        b=S+sGxELZy78Wv2NrtrFz2iMoMrcW/wyi5tjAPd/ibgPBemcLyZQbYFzbL/PmNxOtse
         roynXKj4tAyxQ5AEGfES5ezOnNIi9sWkP8ynwjvzF4xXeoz3NUP6vyR6tWfpUG9eYsnA
         +od4p1PlFJ1ptPP1T4bXMlvZ7dbvMkv/7vW2naAiJKY68wgKlxUvmxt8ZBinUkkrQSfm
         J/tU8AXlKNZLDSCbGcXlne6xHHscJPvaC7WIOEw9BCvtG6o8k9adFoKEBd0loicOSYpW
         JkiR1sWiGspGcGUQiEIXMJkerf3fl/kWNvOM44IWVMntUC0XH40Of1Ri16HVaqv1oXXo
         1B9A==
X-Gm-Message-State: AOJu0YyuuWPv2leyh/9Z38AyfmZoOojIR27kln7fgK2Q1rY/TftAL5ab
        q1qNekspJoLyFROXRiyjRME=
X-Google-Smtp-Source: AGHT+IFFdz1tHIqvU2F7u74sK7YEsjTm32cifdtb/hF01T+AFomtICdUTYv5m6oVgvDznjvp+iv2GA==
X-Received: by 2002:a05:6a00:2d82:b0:6be:5a6c:d3f7 with SMTP id fb2-20020a056a002d8200b006be5a6cd3f7mr2337968pfb.2.1698396741339;
        Fri, 27 Oct 2023 01:52:21 -0700 (PDT)
Received: from ubuntu.. ([122.174.106.169])
        by smtp.gmail.com with ESMTPSA id h12-20020a63b00c000000b0055c178a8df1sm698825pgf.94.2023.10.27.01.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:52:20 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 02/10] staging: vt6655: Type encoding info dropped from function name "s_vCalculateOFDMRParameter"
Date:   Fri, 27 Oct 2023 14:21:51 +0530
Message-Id: <de4817b8c29a1cf5e50afb553e3e30bc0fc44572.1698396278.git.opensource206@gmail.com>
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

function name "s_vCalculateOFDMRParameter" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index aa1017d7399c..2968be1f8d4e 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -80,7 +80,7 @@ static void vt6655_mac_set_bb_type(void __iomem *iobase, u32 mask)
  *
  * Return Value: none
  */
-static void s_vCalculateOFDMRParameter(unsigned char rate,
+static void calculate_ofdmr_parameter(unsigned char rate,
 				       u8 bb_type,
 				       unsigned char *pbyTxRate,
 				       unsigned char *pbyRsvTime)
@@ -585,58 +585,58 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 	iowrite32(phy.field_write, priv->port_offset + MAC_REG_RSPINF_B_11);
 
 	/* RSPINF_a_6 */
-	s_vCalculateOFDMRParameter(RATE_6M,
+	calculate_ofdmr_parameter(RATE_6M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_6);
 	/* RSPINF_a_9 */
-	s_vCalculateOFDMRParameter(RATE_9M,
+	calculate_ofdmr_parameter(RATE_9M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_9);
 	/* RSPINF_a_12 */
-	s_vCalculateOFDMRParameter(RATE_12M,
+	calculate_ofdmr_parameter(RATE_12M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_12);
 	/* RSPINF_a_18 */
-	s_vCalculateOFDMRParameter(RATE_18M,
+	calculate_ofdmr_parameter(RATE_18M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_18);
 	/* RSPINF_a_24 */
-	s_vCalculateOFDMRParameter(RATE_24M,
+	calculate_ofdmr_parameter(RATE_24M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_24);
 	/* RSPINF_a_36 */
-	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
+	calculate_ofdmr_parameter(CARDwGetOFDMControlRate((void *)priv,
 							   RATE_36M),
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_36);
 	/* RSPINF_a_48 */
-	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
+	calculate_ofdmr_parameter(CARDwGetOFDMControlRate((void *)priv,
 							   RATE_48M),
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_48);
 	/* RSPINF_a_54 */
-	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
+	calculate_ofdmr_parameter(CARDwGetOFDMControlRate((void *)priv,
 							   RATE_54M),
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_54);
 	/* RSPINF_a_72 */
-	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
+	calculate_ofdmr_parameter(CARDwGetOFDMControlRate((void *)priv,
 							   RATE_54M),
 				   bb_type,
 				   &byTxRate,
-- 
2.34.1

