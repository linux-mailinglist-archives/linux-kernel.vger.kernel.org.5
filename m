Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7EA7D7C71
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbjJZFpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344254AbjJZFoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:44:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F4F1B1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:44:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9bfbc393dfaso12052266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698299072; x=1698903872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pj8Q7YsY/vYkJDue8+dvhserphxMSxUdnrU/yK6lzXQ=;
        b=RwJIFyPUAT79yCaGZgyZNjJQPid0meKF+FvedNn4Bmx0Co/nwQ9g1eWW2WKUD4OGH5
         TwLBUbKhPZiaixahtosTFE+n+rq4vZodmseQwWWKwQmNxNiqQ5EJ68apJ7MutgTxsQ4x
         g8PC6v7qO/Jk6Th1Qh2O1FPvbaZUJOFmlmImdrMga7Nl+YXX8Nj6zdtS8DVeKTOh6Mmm
         JhhKZ6RJh2wNieCJQsZYAEB+ZdPbm4PYKgzBpqyDOC1yTcuYtxcuuANLg4fG9k/nMUN6
         2mmUPRIaf75aoEsDpYEWINOugvzNInRaw44cxw11/6p140Gj6oG/Wlg4ammOsP6p4CSq
         YrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299072; x=1698903872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj8Q7YsY/vYkJDue8+dvhserphxMSxUdnrU/yK6lzXQ=;
        b=nEveb5WcKteuCoA3huMaWHHJI3NrYqCMsVDLtWXXnrsi9DmVH43+vscY5q74rjIo3h
         bxkW3XbLUT7DCfMmHYB0tifzoyiTFFpiaZzALHh60C8ys+bQRCG78Lcd7LrELvFzVDty
         SF6C6RDfsmFHpDppeYNTnHiZtMZaTTNjO7C+n0xnm3OYbMiE7SJRHAnzY60crWhBv52P
         H8z3CZn2BxdYbEy6659LWRp9rDP0lNdUHmH3cAbi4bnbKiNPtgvWt4DJuOkLD+Ag9F9i
         DbprF8IX5wfuSQmA3PSy+RwN4L0fKv421KOeb13bi69etvJ0hzqAYVCm/RM2quA+XdTz
         TL0Q==
X-Gm-Message-State: AOJu0YxgjeXqelYRpkV7MUNLbcshpNNBSjKBxFQjgpWCjTBJK7Km5LKn
        YA1IPwV5Om1enJ1g0o9PLTozSOjFJSU=
X-Google-Smtp-Source: AGHT+IEUTXYnXCN5fDsGVzGmmv4KTEHOhjaAmgsj9i0QbvMs5CJl71PZMyfWOQuPuEV+Aw8f+oyVHQ==
X-Received: by 2002:a17:906:2250:b0:9bd:cab6:a34b with SMTP id 16-20020a170906225000b009bdcab6a34bmr13813147ejr.0.1698299072414;
        Wed, 25 Oct 2023 22:44:32 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id x9-20020a170906b08900b0099ce188be7fsm10953361ejy.3.2023.10.25.22.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:44:32 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:44:30 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] staging: rtl8192e: Remove unused constants starting
 with MAX_RX_QUEUE
Message-ID: <0809e3380ce76354d689edd80b82adada5a18d4e.1698295861.git.philipp.g.hortmann@gmail.com>
References: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused constants.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8190P_def.h    |  2 -
 .../staging/rtl8192e/rtl8192e/r8192E_phyreg.h | 62 +------------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  2 -
 drivers/staging/rtl8192e/rtl819x_Qos.h        |  1 -
 drivers/staging/rtl8192e/rtl819x_TS.h         |  1 -
 drivers/staging/rtl8192e/rtllib.h             |  1 -
 6 files changed, 1 insertion(+), 68 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index c229fd244a48..8c85f1c866d3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -11,8 +11,6 @@
 
 #define		MAX_SILENT_RESET_RX_SLOT_NUM	10
 
-#define RX_MPDU_QUEUE				0
-
 enum rtl819x_loopback {
 	RTL819X_NO_LOOPBACK = 0,
 	RTL819X_MAC_LOOPBACK = 1,
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index 24fb0ca539ea..c48c56869c19 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -248,75 +248,15 @@
 #define bPAEnd				0xf
 #define bTREnd				0x0f000000
 #define bRFEnd				0x000f0000
-/* T2R */
-#define bCCAMask			0x000000f0
-#define bR2RCCAMask			0x00000f00
-#define bHSSI_R2TDelay			0xf8000000
-#define bHSSI_T2RDelay			0xf80000
 /* Channel gain at continue TX. */
-#define bContTxHSSI			0x400
-#define bIGFromCCK			0x200
-#define bAGCAddress			0x3f
-#define bRxHPTx				0x7000
-#define bRxHPT2R			0x38000
-#define bRxHPCCKIni			0xc0000
-#define bAGCTxCode			0xc00000
-#define bAGCRxCode			0x300000
 #define b3WireDataLength		0x800
 #define b3WireAddressLength		0x400
-#define b3WireRFPowerDown		0x1
-/*#define bHWSISelect			0x8 */
-#define b2GPAPEPolarity			0x80000000
-#define bRFSW_TxDefaultAnt		0x3
-#define bRFSW_TxOptionAnt		0x30
-#define bRFSW_RxDefaultAnt		0x300
-#define bRFSW_RxOptionAnt		0x3000
-#define bRFSI_3WireData			0x1
-#define bRFSI_3WireClock		0x2
-#define bRFSI_3WireLoad			0x4
-#define bRFSI_3WireRW			0x8
 /* 3-wire total control */
-#define bRFSI_3Wire			0xf
 #define bRFSI_RFENV			0x10
-#define bRFSI_TRSW			0x20
-#define bRFSI_TRSWB			0x40
-#define bRFSI_ANTSW			0x100
-#define bRFSI_ANTSWB			0x200
-#define bRFSI_PAPE			0x400
-#define bBandSelect			0x1
-#define bHTSIG2_GI			0x80
-#define bHTSIG2_Smoothing		0x01
-#define bHTSIG2_Sounding		0x02
-#define bHTSIG2_Aggreaton		0x08
-#define bHTSIG2_STBC			0x30
-#define bHTSIG2_AdvCoding		0x40
-#define bHTSIG2_NumOfHTLTF		0x300
-#define bHTSIG2_CRC8			0x3fc
-#define bHTSIG1_MCS			0x7f
-#define bHTSIG1_BandWidth		0x80
-#define bHTSIG1_HTLength		0xffff
-#define bLSIG_Rate			0xf
-#define bLSIG_Reserved			0x10
-#define bLSIG_Length			0x1fffe
-#define bLSIG_Parity			0x20
-#define bCCKRxPhase			0x4
 #define bLSSIReadAddress		0x3f000000 /* LSSI "read" address */
 #define bLSSIReadEdge			0x80000000 /* LSSI "read" edge signal */
 #define bLSSIReadBackData		0xfff
-#define bLSSIReadOKFlag			0x1000
-#define bCCKSampleRate			0x8 /* 0: 44 MHz, 1: 88MHz */
-
-#define bRegulator0Standby		0x1
-#define bRegulatorPLLStandby		0x2
-#define bRegulator1Standby		0x4
-#define bPLLPowerUp			0x8
-#define bDPLLPowerUp			0x10
-#define bDA10PowerUp			0x20
-#define bAD7PowerUp			0x200
-#define bDA6PowerUp			0x2000
-#define bXtalPowerUp			0x4000
-#define b40MDClkPowerUP			0x8000
-#define bDA6DebugMode			0x20000
+
 #define bDA6Swing			0x380000
 #define bADClkPhase			0x4000000
 #define b80MClkDelay			0x18000000
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index a6c47388d72c..a4afbf3e934d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -91,8 +91,6 @@
 
 #define MAX_TX_QUEUE				9
 
-#define MAX_RX_QUEUE				1
-
 #define MAX_RX_COUNT				64
 #define MAX_TX_QUEUE_COUNT			9
 
diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index f547de4c1da3..1c00092ea3a5 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -21,7 +21,6 @@ struct octet_string {
 #define AC1_BK	1
 #define AC2_VI	2
 #define AC3_VO	3
-#define AC_MAX	4
 
 enum direction_value {
 	DIR_UP			= 0,
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index ab737428d4a7..fff36315f174 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -10,7 +10,6 @@
 #define TS_ADDBA_DELAY		60
 
 #define TOTAL_TS_NUM		16
-#define TCLAS_NUM		4
 
 enum tr_select {
 	TX_DIR = 0,
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index dc3488d9693f..d2cf3cfaaaba 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -911,7 +911,6 @@ enum {WMM_all_frame, WMM_two_frame, WMM_four_frame, WMM_six_frame};
 	((up) < 6) ? WME_AC_VI : \
 	WME_AC_VO)
 
-#define	ETHER_ADDR_LEN		6	/* length of an Ethernet address */
 #define ETHERNET_HEADER_SIZE    14      /* length of two Ethernet address
 					 * plus ether type
 					 */
-- 
2.42.0

