Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E517D2A92
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjJWGjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJWGjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:39:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ED5D5B
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:39:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c40c3814a8so88350466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698043175; x=1698647975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbuDFZ6Q4bsAALBcS9+CuBZ65o4x+vujhw43QWbD5pU=;
        b=Mk4wmw0dpc51nTxBmfZQ1GUYF7UmcfppZMAAwGEg1D4WmaqzKEX1E8u4PTp9VBWhoP
         yp2nAsjSZ1wZYcAkYLGk1GZpgj2VYrlW42gadSy60+OOGlN9L0lp71ByN+a/MSZurphl
         5IXFETWfYMG0zxyxWd4BfmcdrcWqEVVOvESKJlNo7k1DJlmMyYMs5Xu885SB/lTMr5fC
         VwsoVMaRqThUHW6CXQmPwaGaj3xJwkFTA6pIJl6AeWUJnOdoaBQDXiScbawtgYQ4FB+T
         4eigqsZCyG8U8T9KD87od1HSlmsdo45SeLeb/AZW1w/CBLvTFDMR3KJjbKB26JUvN1ht
         pPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698043175; x=1698647975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbuDFZ6Q4bsAALBcS9+CuBZ65o4x+vujhw43QWbD5pU=;
        b=Vn15Cy6upgirDgVlix+P9LcLMHnVvd7Z2shwSQw9cPyBU0AH+rsAxGOPpf3+O5/iNi
         ZqU4qp4Co6p/M4eoyYhOyy4/+TgUBSGSX6QIyqcuauR3qPvgLJGAx9Ylduejrz8c3kKq
         CEL/jc6Szuz1vPLtZjr8r1int4y6u5oc7unBnsWit0IC35YfnY7bCs0w+8nTDOIhUDQ4
         wwumCm7l0l+0EpodEDc1OOc8JUaUxo81wngEThEf6n3F3mcwB3v80mrGvZ3SE/atsSG4
         j9/SzJwYPASCkNQ3C8px8kjBDEZV67fERZEaEVvUUFLqeSG87ChFJcrRqLfjuDdW8boP
         DHqg==
X-Gm-Message-State: AOJu0Yyi0jWpvttIsRZ+cbpCFXPaRunDvZ5HjlHVmUXwOFMmdgOrIOT8
        9Uzpc0joTveiKa4CYNEFc3TcPQCElKE=
X-Google-Smtp-Source: AGHT+IGQJysNoQEMkO2u3/ZXpnv0wpqq45SJiRHGHiC+CFyg6AAisShWHQu1CgoJ/50kDF84t19phg==
X-Received: by 2002:a17:906:74d9:b0:9c3:9577:5638 with SMTP id z25-20020a17090674d900b009c395775638mr5137379ejl.0.1698043175023;
        Sun, 22 Oct 2023 23:39:35 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id bm11-20020a170906c04b00b009a193a5acffsm6061090ejb.121.2023.10.22.23.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 23:39:34 -0700 (PDT)
Date:   Mon, 23 Oct 2023 08:39:33 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] staging: rtl8192e: Replace BIT0 to BIT9 with BIT(0) to
 BIT(9)
Message-ID: <07e7de26d364d0781e41892d5738e1b6b93faf53.1698042685.git.philipp.g.hortmann@gmail.com>
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

Replace custom macros BIT0 to BIT9 with standard kernel macros BIT(0) to
BIT(9) to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 70 +++++++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c   |  2 +-
 drivers/staging/rtl8192e/rtl819x_Qos.h        | 10 ---
 drivers/staging/rtl8192e/rtllib.h             |  4 +-
 6 files changed, 41 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 09f8c76b7e65..80f44ffe00e6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -43,7 +43,7 @@ enum _RTL8192PCI_HW {
 	PMR			= 0x00c,
 	EPROM_CMD		= 0x00e,
 
-#define EPROM_CMD_9356SEL	BIT4
+#define EPROM_CMD_9356SEL	BIT(4)
 #define EPROM_CMD_OPERATING_MODE_SHIFT 6
 #define EPROM_CMD_NORMAL 0
 #define EPROM_CMD_PROGRAM 2
@@ -67,10 +67,10 @@ enum _RTL8192PCI_HW {
 #define RCR_AMF			BIT20
 #define RCR_ADF			BIT18
 #define RCR_AICV		BIT12
-#define	RCR_AB			BIT3
-#define	RCR_AM			BIT2
-#define	RCR_APM			BIT1
-#define	RCR_AAP			BIT0
+#define	RCR_AB			BIT(3)
+#define	RCR_AM			BIT(2)
+#define	RCR_APM			BIT(1)
+#define	RCR_AAP			BIT(0)
 #define RCR_MXDMA_OFFSET	8
 #define RCR_FIFO_OFFSET		13
 	SLOT_TIME		= 0x049,
@@ -95,11 +95,11 @@ enum _RTL8192PCI_HW {
 #define   TOTAL_CAM_ENTRY				32
 	WCAMI			= 0x0A4,
 	SECR			= 0x0B0,
-#define	SCR_TxUseDK			BIT0
-#define   SCR_RxUseDK			BIT1
-#define   SCR_TxEncEnable		BIT2
-#define   SCR_RxDecEnable		BIT3
-#define   SCR_NoSKMC				BIT5
+#define	SCR_TxUseDK			BIT(0)
+#define   SCR_RxUseDK			BIT(1)
+#define   SCR_TxEncEnable		BIT(2)
+#define   SCR_RxDecEnable		BIT(3)
+#define   SCR_NoSKMC				BIT(5)
 	SWREGULATOR	= 0x0BD,
 	INTA_MASK		= 0x0f4,
 #define IMR_TBDOK			BIT27
@@ -110,19 +110,19 @@ enum _RTL8192PCI_HW {
 #define	IMR_RXFOVW			BIT12
 #define IMR_RDU				BIT11
 #define IMR_RXCMDOK			BIT10
-#define IMR_BDOK			BIT9
-#define IMR_HIGHDOK			BIT8
-#define	IMR_COMDOK			BIT7
-#define IMR_MGNTDOK			BIT6
-#define IMR_HCCADOK			BIT5
-#define	IMR_BKDOK			BIT4
-#define	IMR_BEDOK			BIT3
-#define	IMR_VIDOK			BIT2
-#define	IMR_VODOK			BIT1
-#define	IMR_ROK				BIT0
+#define IMR_BDOK			BIT(9)
+#define IMR_HIGHDOK			BIT(8)
+#define	IMR_COMDOK			BIT(7)
+#define IMR_MGNTDOK			BIT(6)
+#define IMR_HCCADOK			BIT(5)
+#define	IMR_BKDOK			BIT(4)
+#define	IMR_BEDOK			BIT(3)
+#define	IMR_VIDOK			BIT(2)
+#define	IMR_VODOK			BIT(1)
+#define	IMR_ROK				BIT(0)
 	ISR			= 0x0f8,
 	TP_POLL			= 0x0fd,
-#define TP_POLL_CQ		BIT5
+#define TP_POLL_CQ		BIT(5)
 	PSR			= 0x0ff,
 	CPU_GEN			= 0x100,
 #define	CPU_CCK_LOOPBACK	0x00030000
@@ -136,9 +136,9 @@ enum _RTL8192PCI_HW {
 #define CPU_GEN_NO_LOOPBACK_MSK	0xFFF8FFFF
 #define CPU_GEN_NO_LOOPBACK_SET	0x00080000
 	ACM_HW_CTRL		= 0x171,
-#define	ACM_HW_BEQ_EN		BIT1
-#define	ACM_HW_VIQ_EN		BIT2
-#define	ACM_HW_VOQ_EN		BIT3
+#define	ACM_HW_BEQ_EN		BIT(1)
+#define	ACM_HW_VIQ_EN		BIT(2)
+#define	ACM_HW_VOQ_EN		BIT(3)
 	RQPN1			= 0x180,
 	RQPN2			= 0x184,
 	RQPN3			= 0x188,
@@ -159,7 +159,7 @@ enum _RTL8192PCI_HW {
 	WFCRC2		  = 0x2f8,
 
 	BW_OPMODE		= 0x300,
-#define	BW_OPMODE_20MHZ			BIT2
+#define	BW_OPMODE_20MHZ			BIT(2)
 	IC_VERRSION		= 0x301,
 	MSR			= 0x303,
 #define MSR_LINK_MASK		(BIT(1) | BIT(0))
@@ -178,16 +178,16 @@ enum _RTL8192PCI_HW {
 	TSFR			= 0x308,
 	RRSR			= 0x310,
 #define RRSR_SHORT_OFFSET			23
-#define RRSR_1M					BIT0
-#define RRSR_2M					BIT1
-#define RRSR_5_5M				BIT2
-#define RRSR_11M				BIT3
-#define RRSR_6M					BIT4
-#define RRSR_9M					BIT5
-#define RRSR_12M				BIT6
-#define RRSR_18M				BIT7
-#define RRSR_24M				BIT8
-#define RRSR_36M				BIT9
+#define RRSR_1M					BIT(0)
+#define RRSR_2M					BIT(1)
+#define RRSR_5_5M				BIT(2)
+#define RRSR_11M				BIT(3)
+#define RRSR_6M					BIT(4)
+#define RRSR_9M					BIT(5)
+#define RRSR_12M				BIT(6)
+#define RRSR_18M				BIT(7)
+#define RRSR_24M				BIT(8)
+#define RRSR_36M				BIT(9)
 #define RRSR_48M				BIT10
 #define RRSR_54M				BIT11
 #define BRSR_AckShortPmb			BIT23
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index a5e16bf99cd6..4d12d7385041 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -965,7 +965,7 @@ void rtl92e_init_gain(struct net_device *dev, u8 Operation)
 
 void rtl92e_set_rf_off(struct net_device *dev)
 {
-	rtl92e_set_bb_reg(dev, rFPGA0_XA_RFInterfaceOE, BIT4, 0x0);
+	rtl92e_set_bb_reg(dev, rFPGA0_XA_RFInterfaceOE, BIT(4), 0x0);
 	rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4, 0x300, 0x0);
 	rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1, 0x18, 0x0);
 	rtl92e_set_bb_reg(dev, rOFDM0_TRxPathEnable, 0xf, 0x0);
@@ -1016,7 +1016,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 					 0x4, 0x1);
 			priv->hw_rf_off_action = 0;
 			rtl92e_set_bb_reg(dev, rFPGA0_XA_RFInterfaceOE,
-					  BIT4, 0x1);
+					  BIT(4), 0x1);
 			rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter4,
 					  0x300, 0x3);
 			rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 97de404840df..e88963a4b1f1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1247,7 +1247,7 @@ static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
 
 	tmp1byte = rtl92e_readb(dev, GPI);
 
-	rf_power_state_to_set = (tmp1byte & BIT1) ?  rf_on : rf_off;
+	rf_power_state_to_set = (tmp1byte & BIT(1)) ?  rf_on : rf_off;
 
 	if (priv->hw_radio_off && (rf_power_state_to_set == rf_on)) {
 		netdev_info(dev, "gpiochangeRF  - HW Radio ON\n");
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
index 0bc3e013001e..1aa73561581b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
@@ -21,7 +21,7 @@ static void _rtl92e_parse_pci_configuration(struct pci_dev *pdev,
 	pcie_capability_read_word(priv->pdev, PCI_EXP_LNKCTL, &link_ctrl_reg);
 
 	pci_read_config_byte(pdev, 0x98, &tmp);
-	tmp |= BIT4;
+	tmp |= BIT(4);
 	pci_write_config_byte(pdev, 0x98, tmp);
 
 	tmp = 0x17;
diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index 37677366c397..519a3160933b 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -7,16 +7,6 @@
 #ifndef __INC_QOS_TYPE_H
 #define __INC_QOS_TYPE_H
 
-#define BIT0		    0x00000001
-#define BIT1		    0x00000002
-#define BIT2		    0x00000004
-#define BIT3		    0x00000008
-#define BIT4		    0x00000010
-#define BIT5		    0x00000020
-#define BIT6		    0x00000040
-#define BIT7		    0x00000080
-#define BIT8		    0x00000100
-#define BIT9		    0x00000200
 #define BIT10		   0x00000400
 #define BIT11		   0x00000800
 #define BIT12		   0x00001000
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 9d141aad8cd5..7f0aa0779c78 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -91,7 +91,7 @@ static inline void *netdev_priv_rsl(struct net_device *dev)
 #define IE_CISCO_FLAG_POSITION		0x08
 #define SUPPORT_CKIP_MIC			0x08
 #define SUPPORT_CKIP_PK			0x10
-#define	RT_RF_OFF_LEVL_HALT_NIC		BIT3
+#define	RT_RF_OFF_LEVL_HALT_NIC		BIT(3)
 #define	RT_IN_PS_LEVEL(psc, _PS_FLAG)		\
 	((psc->CurPsLevel & _PS_FLAG) ? true : false)
 #define	RT_CLEAR_PS_LEVEL(psc, _PS_FLAG)	\
@@ -341,7 +341,7 @@ enum rt_op_mode {
 /* QOS control */
 #define RTLLIB_QCTL_TID	      0x000F
 
-#define	FC_QOS_BIT					BIT7
+#define	FC_QOS_BIT					BIT(7)
 #define IsDataFrame(pdu)	(((pdu[0] & 0x0C) == 0x08) ? true : false)
 #define	IsLegacyDataFrame(pdu)	(IsDataFrame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
 #define IsQoSDataFrame(pframe)			\
-- 
2.42.0

