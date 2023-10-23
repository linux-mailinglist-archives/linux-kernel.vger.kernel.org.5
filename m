Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0267D2A93
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjJWGjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjJWGjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:39:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A28D7D
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:39:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c14313eb1cso78547166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698043184; x=1698647984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLFo6mN1dQpFM3u9PDdaEolPvTWL8Fd9rcZrlk3kJ7c=;
        b=Vu5yuvkzY3x7Lwd7P1w0hPGEDF52ZRcSPTmEVqiN7D2GPUebi0QvdCkKwDrVP9x21Z
         cqMaDu5brThPWlIJkAgpIBIkNoOzCSyLXn1K0rgEfAEAEfk9u6LJwNKezS5sHl1/ZA/Y
         70gfE8fySvZZcOmAYER9eF2LnDM7vYOUnHbTjsZrle5XTAPYd79L/P7t1B08jI1U5Rvj
         VZJQI/8k7mljaq/zHA8hp2/65kDB+l0CchtTv1+HK6eWw1uzoEMW5x9tOP+cmdKIBYEO
         otGgrpyatqyUr2zZa4WlGsU/6gHIicine/i0qtbaESQJtJnuvsIZrUWOkfsPEGXAuwr3
         xkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698043184; x=1698647984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLFo6mN1dQpFM3u9PDdaEolPvTWL8Fd9rcZrlk3kJ7c=;
        b=b67vN0e2JEeUUWtH2K7ELhM1qibw7eiLYN4wE9dR1pgdtjUW055/BQreIfvhQM7tZM
         DLjEXXOJ+w9EleGbRos5i3jJQj48OELx3zEHDm1xOa0xco6V3GJsFtGA71edYxX0JZoh
         peWfs+E1lMvOMAwtxZ/EVuWpsmCwazD+kYHu+xgjMcqqHDiGF0Ur8IIL2rwsd8BmuuJu
         Jfv+Fv6IxbD/P5ErPffHGIlLFE+Vc8CZcGcAsGs5DT/8CgsHiwcLNYdEv6RV45h25Tnt
         HvRi9GbRK8YWgDf/8ttQ9gN6VW+9Vxe2qODFisGfCyVMzo5c/4EGJR9klzqO/2Z0S9S0
         9M+A==
X-Gm-Message-State: AOJu0YwJkOx7QCAaumM1hBhz9XwV7PlsgXa6CF3N6h5um1LVRsdjumEw
        sCf/clisecMaAmkQvtJ8yug=
X-Google-Smtp-Source: AGHT+IHCwhcP9Y/oXdcdOq/TKc2HmWfozMB/+qFnQlIuonoREuH8aT1eRtLCr3Y3Hbiymgh3rkVYwA==
X-Received: by 2002:a17:906:7394:b0:9b2:bf2d:6b65 with SMTP id f20-20020a170906739400b009b2bf2d6b65mr5838149ejl.4.1698043183605;
        Sun, 22 Oct 2023 23:39:43 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id ss17-20020a170907039100b0099cb349d570sm6131450ejb.185.2023.10.22.23.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 23:39:43 -0700 (PDT)
Date:   Mon, 23 Oct 2023 08:39:41 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] staging: rtl8192e: Replace BIT10 to BIT31 with BIT(10)
 to BIT(31)
Message-ID: <294ff1d0b92a474a9ae0d48a54a9f99f14008053.1698042685.git.philipp.g.hortmann@gmail.com>
References: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom macros BIT10 to BIT31 with standard kernel macros BIT(10) to
BIT(31) to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 34 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   |  8 ++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 20 +++++------
 drivers/staging/rtl8192e/rtl819x_Qos.h        | 23 -------------
 drivers/staging/rtl8192e/rtllib.h             |  8 ++---
 5 files changed, 35 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 80f44ffe00e6..1b444529b59c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -61,12 +61,12 @@ enum _RTL8192PCI_HW {
 #define		CR_TE					0x04
 	SIFS		= 0x03E,
 	RCR			= 0x044,
-#define RCR_ONLYERLPKT		BIT31
-#define RCR_CBSSID		BIT23
-#define	RCR_ADD3		BIT21
-#define RCR_AMF			BIT20
-#define RCR_ADF			BIT18
-#define RCR_AICV		BIT12
+#define RCR_ONLYERLPKT		BIT(31)
+#define RCR_CBSSID		BIT(23)
+#define	RCR_ADD3		BIT(21)
+#define RCR_AMF			BIT(20)
+#define RCR_ADF			BIT(18)
+#define RCR_AICV		BIT(12)
 #define	RCR_AB			BIT(3)
 #define	RCR_AM			BIT(2)
 #define	RCR_APM			BIT(1)
@@ -102,14 +102,14 @@ enum _RTL8192PCI_HW {
 #define   SCR_NoSKMC				BIT(5)
 	SWREGULATOR	= 0x0BD,
 	INTA_MASK		= 0x0f4,
-#define IMR_TBDOK			BIT27
-#define IMR_TBDER			BIT26
-#define IMR_TXFOVW			BIT15
-#define IMR_TIMEOUT0			BIT14
-#define IMR_BcnInt			BIT13
-#define	IMR_RXFOVW			BIT12
-#define IMR_RDU				BIT11
-#define IMR_RXCMDOK			BIT10
+#define IMR_TBDOK			BIT(27)
+#define IMR_TBDER			BIT(26)
+#define IMR_TXFOVW			BIT(15)
+#define IMR_TIMEOUT0			BIT(14)
+#define IMR_BcnInt			BIT(13)
+#define	IMR_RXFOVW			BIT(12)
+#define IMR_RDU				BIT(11)
+#define IMR_RXCMDOK			BIT(10)
 #define IMR_BDOK			BIT(9)
 #define IMR_HIGHDOK			BIT(8)
 #define	IMR_COMDOK			BIT(7)
@@ -188,9 +188,9 @@ enum _RTL8192PCI_HW {
 #define RRSR_18M				BIT(7)
 #define RRSR_24M				BIT(8)
 #define RRSR_36M				BIT(9)
-#define RRSR_48M				BIT10
-#define RRSR_54M				BIT11
-#define BRSR_AckShortPmb			BIT23
+#define RRSR_48M				BIT(10)
+#define RRSR_54M				BIT(11)
+#define BRSR_AckShortPmb			BIT(23)
 	UFWP			= 0x318,
 	RATR0			= 0x320,
 #define	RATR_1M			0x00000001
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index 76ec4ed967c4..69298c7c129a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -17,7 +17,7 @@ void rtl92e_cam_reset(struct net_device *dev)
 {
 	u32 ulcommand = 0;
 
-	ulcommand |= BIT31 | BIT30;
+	ulcommand |= BIT(31) | BIT(30);
 	rtl92e_writel(dev, RWCAM, ulcommand);
 }
 
@@ -89,13 +89,13 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 	}
 
 	if (DefaultKey)
-		usConfig |= BIT15 | (KeyType << 2);
+		usConfig |= BIT(15) | (KeyType << 2);
 	else
-		usConfig |= BIT15 | (KeyType << 2) | KeyIndex;
+		usConfig |= BIT(15) | (KeyType << 2) | KeyIndex;
 
 	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
 		TargetCommand  = i + CAM_CONTENT_COUNT * EntryNo;
-		TargetCommand |= BIT31 | BIT16;
+		TargetCommand |= BIT(31) | BIT(16);
 
 		if (i == 0) {
 			TargetContent = (u32)(*(MacAddr + 0)) << 16 |
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index e88963a4b1f1..330dafd62656 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -292,25 +292,25 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 				     ht_info->bCurShortGI20MHz);
 
 		pra->upper_rssi_threshold_ratr =
-				(pra->upper_rssi_threshold_ratr & (~BIT31)) |
-				((bshort_gi_enabled) ? BIT31 : 0);
+				(pra->upper_rssi_threshold_ratr & (~BIT(31))) |
+				((bshort_gi_enabled) ? BIT(31) : 0);
 
 		pra->middle_rssi_threshold_ratr =
-				(pra->middle_rssi_threshold_ratr & (~BIT31)) |
-				((bshort_gi_enabled) ? BIT31 : 0);
+				(pra->middle_rssi_threshold_ratr & (~BIT(31))) |
+				((bshort_gi_enabled) ? BIT(31) : 0);
 
 		if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) {
 			pra->low_rssi_threshold_ratr =
-				(pra->low_rssi_threshold_ratr_40M & (~BIT31)) |
-				((bshort_gi_enabled) ? BIT31 : 0);
+				(pra->low_rssi_threshold_ratr_40M & (~BIT(31))) |
+				((bshort_gi_enabled) ? BIT(31) : 0);
 		} else {
 			pra->low_rssi_threshold_ratr =
-				(pra->low_rssi_threshold_ratr_20M & (~BIT31)) |
-				((bshort_gi_enabled) ? BIT31 : 0);
+				(pra->low_rssi_threshold_ratr_20M & (~BIT(31))) |
+				((bshort_gi_enabled) ? BIT(31) : 0);
 		}
 		pra->ping_rssi_ratr =
-				(pra->ping_rssi_ratr & (~BIT31)) |
-				((bshort_gi_enabled) ? BIT31 : 0);
+				(pra->ping_rssi_ratr & (~BIT(31))) |
+				((bshort_gi_enabled) ? BIT(31) : 0);
 
 		if (pra->ratr_state == DM_RATR_STA_HIGH) {
 			high_rssi_thresh_for_ra = pra->high2low_rssi_thresh_for_ra;
diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index 519a3160933b..a43a5142e96f 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -7,29 +7,6 @@
 #ifndef __INC_QOS_TYPE_H
 #define __INC_QOS_TYPE_H
 
-#define BIT10		   0x00000400
-#define BIT11		   0x00000800
-#define BIT12		   0x00001000
-#define BIT13		   0x00002000
-#define BIT14		   0x00004000
-#define BIT15		   0x00008000
-#define BIT16		   0x00010000
-#define BIT17		   0x00020000
-#define BIT18		   0x00040000
-#define BIT19		   0x00080000
-#define BIT20		   0x00100000
-#define BIT21		   0x00200000
-#define BIT22		   0x00400000
-#define BIT23		   0x00800000
-#define BIT24		   0x01000000
-#define BIT25		   0x02000000
-#define BIT26		   0x04000000
-#define BIT27		   0x08000000
-#define BIT28		   0x10000000
-#define BIT29		   0x20000000
-#define BIT30		   0x40000000
-#define BIT31		   0x80000000
-
 union qos_tsinfo {
 	u8		charData[3];
 	struct {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7f0aa0779c78..dc3488d9693f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1085,10 +1085,10 @@ struct rt_pwr_save_ctrl {
 
 #define RT_RF_CHANGE_SOURCE u32
 
-#define RF_CHANGE_BY_SW BIT31
-#define RF_CHANGE_BY_HW BIT30
-#define RF_CHANGE_BY_PS BIT29
-#define RF_CHANGE_BY_IPS BIT28
+#define RF_CHANGE_BY_SW BIT(31)
+#define RF_CHANGE_BY_HW BIT(30)
+#define RF_CHANGE_BY_PS BIT(29)
+#define RF_CHANGE_BY_IPS BIT(28)
 #define RF_CHANGE_BY_INIT	0
 
 enum country_code_type {
-- 
2.42.0

