Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD757C98D0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjJOL2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 07:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjJOL2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 07:28:03 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005C2E8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:28:01 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a86b6391e9so3136987b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697369281; x=1697974081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2EkuzijiPdrajc83Obp0fb3GnIq7fHlM8WZQAKhxfc=;
        b=VrLm1C3LmBoNtjp0I2abO6qLrDPd3pvvKsxf3pakEbeTe9H8OGVrHGaD/A0taQw4J8
         Tb6pj7ruvpe95EkWqVtOezC1jUm7g34GZHm8eqno3NBg+VMeu4o8tYNcHpj8OPMKnRio
         jHPGtw9QsHPGyYCBrU5oJm3MbKBi1wM5NkxNSAbkVHbKKCFQoZwXQUcutxKHTn/7Z/eK
         NDf/4NIoHRWU762U4LgAXugZkMgcj4TswI04Fb8yExreIPxe37yPvRnKGj8eQi8V23Hi
         YywXAwszj6E3WwrSBQIrFCc0RMpIlKkhKpfNhLHUN0hMBj2Hf6bkn5MxlWB/wg8R4Hy6
         xITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697369281; x=1697974081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2EkuzijiPdrajc83Obp0fb3GnIq7fHlM8WZQAKhxfc=;
        b=OdFit1CaQsLpbxfdIe3eY+UJDMd+qXu5ecau4x5PLOnlm+E1zAREYiBLZyk5qw5tsq
         a0fxKCGwfO7mRqWKWQcId0GGnNbuc1mtxzj071RRVEDe0W4TBEXdpGrdegfyKjHo5GJQ
         dJ8ATIwpWHlNk2rc6E9hNVIgfpWC7tP+ko1AjyE2wDqfGQhb5Ca6juJdka06V/leMbM4
         286kUKy5e9o6f4LTGPTuv6eDqmO5EI+VrpqhT59hYqcc005AsURx0nlezXoaMpkj42xO
         0SxyaG9qVcDHM9wShSP7I7TcBiZH9xAqABmBuc7mV5Dt2io5NcXF7FFU7pJTnBISutGl
         nQ0A==
X-Gm-Message-State: AOJu0YzSCNr4oT9mNJwmL/ZwVK8VV+pkT9XB4PaOL1LQLLCt7QbRuq2Y
        GsvLlavuk3C1h7A+/49tX9JPih4XovFrsyU1
X-Google-Smtp-Source: AGHT+IFjbSk7DfrtlIN7XI9cu5JvpJTBXuagNb9bed7eLp/azq9pCfQxN5smueJLnuCHZ0psboVk5Q==
X-Received: by 2002:a05:690c:f14:b0:5a7:fb11:90f8 with SMTP id dc20-20020a05690c0f1400b005a7fb1190f8mr12045502ywb.16.1697369281047;
        Sun, 15 Oct 2023 04:28:01 -0700 (PDT)
Received: from gilbert-PC ([105.112.18.68])
        by smtp.gmail.com with ESMTPSA id j145-20020a819297000000b00579e5c4982fsm1330279ywg.36.2023.10.15.04.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 04:28:00 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 3/6] staging: rtl8192u: Align descendant arguments
Date:   Sun, 15 Oct 2023 12:24:49 +0100
Message-Id: <0230e0abfb31d6000c2d1294bc118b45896e9149.1697367161.git.gilbertadikankwu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697367161.git.gilbertadikankwu@gmail.com>
References: <cover.1697367161.git.gilbertadikankwu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align descendant arguments to the open parenthesis as per the "Linux
Kernel coding style" in Documentation/process/coding-style.rst

Mute the following checkpatch error:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 0a60ef20107c..2985c4f05bc8 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2236,7 +2236,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 			*((u16 *)(&priv->EEPROMTxPowerLevelCCK_V1[1])) = tmpValue;
 			if (bLoad_From_EEPOM)
 				tmpValue = eprom_read(dev,
-					EEPROM_TX_PW_INDEX_OFDM_24G_V1 >> 1);
+						      EEPROM_TX_PW_INDEX_OFDM_24G_V1 >> 1);
 			else
 				tmpValue = 0x1010;
 			*((u16 *)(&priv->EEPROMTxPowerLevelOFDM24G[0])) = tmpValue;
@@ -2536,16 +2536,16 @@ static bool rtl8192_adapter_start(struct net_device *dev)
 
 	/* Initialize Number of Reserved Pages in Firmware Queue */
 	write_nic_dword(dev, RQPN1,
-		NUM_OF_PAGE_IN_FW_QUEUE_BK << RSVD_FW_QUEUE_PAGE_BK_SHIFT |
-		NUM_OF_PAGE_IN_FW_QUEUE_BE << RSVD_FW_QUEUE_PAGE_BE_SHIFT |
-		NUM_OF_PAGE_IN_FW_QUEUE_VI << RSVD_FW_QUEUE_PAGE_VI_SHIFT |
-		NUM_OF_PAGE_IN_FW_QUEUE_VO << RSVD_FW_QUEUE_PAGE_VO_SHIFT);
+			NUM_OF_PAGE_IN_FW_QUEUE_BK << RSVD_FW_QUEUE_PAGE_BK_SHIFT |
+			NUM_OF_PAGE_IN_FW_QUEUE_BE << RSVD_FW_QUEUE_PAGE_BE_SHIFT |
+			NUM_OF_PAGE_IN_FW_QUEUE_VI << RSVD_FW_QUEUE_PAGE_VI_SHIFT |
+			NUM_OF_PAGE_IN_FW_QUEUE_VO << RSVD_FW_QUEUE_PAGE_VO_SHIFT);
 	write_nic_dword(dev, RQPN2,
-		NUM_OF_PAGE_IN_FW_QUEUE_MGNT << RSVD_FW_QUEUE_PAGE_MGNT_SHIFT |
-		NUM_OF_PAGE_IN_FW_QUEUE_CMD << RSVD_FW_QUEUE_PAGE_CMD_SHIFT);
+			NUM_OF_PAGE_IN_FW_QUEUE_MGNT << RSVD_FW_QUEUE_PAGE_MGNT_SHIFT |
+			NUM_OF_PAGE_IN_FW_QUEUE_CMD << RSVD_FW_QUEUE_PAGE_CMD_SHIFT);
 	write_nic_dword(dev, RQPN3,
-		APPLIED_RESERVED_QUEUE_IN_FW |
-		NUM_OF_PAGE_IN_FW_QUEUE_BCN << RSVD_FW_QUEUE_PAGE_BCN_SHIFT);
+			APPLIED_RESERVED_QUEUE_IN_FW |
+			NUM_OF_PAGE_IN_FW_QUEUE_BCN << RSVD_FW_QUEUE_PAGE_BCN_SHIFT);
 	write_nic_dword(dev, RATR0 + 4 * 7, (RATE_ALL_OFDM_AG | RATE_ALL_CCK));
 
 	/* Set AckTimeout */
@@ -3019,7 +3019,7 @@ static void rtl819x_ifsilentreset(struct net_device *dev)
 }
 
 static void rtl819x_update_rxcounts(struct r8192_priv *priv, u32 *TotalRxBcnNum,
-			     u32 *TotalRxDataNum)
+				    u32 *TotalRxDataNum)
 {
 	u16			SlotIndex;
 	u16			i;
-- 
2.34.1

