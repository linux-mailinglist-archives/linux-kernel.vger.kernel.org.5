Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20AC7C918B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjJMXsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjJMXrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:47:52 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A4DD8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:47:45 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3af609c5736so1553417b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697240864; x=1697845664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NEEGOi4GCb6HcvidYXCklsWgHDxlGjLGl/WS/rvT1I=;
        b=Ws3/3Vv8GtIf1wb7U5c1zT7rh11liVKnJusmo9D5OxCd18OrXg98g7gUhYZtexFeZT
         E0zODo8hAP8pcdT9dQPGwExIFUJ1i1fsphZjqllwyp61P899t3u5iB0YpR1KQy4eaDCC
         w+UF0SYHUrzBo9u0igHIR0IhS7ipu+CxC+56hcOtcI9lLHvUTpXKJUCjbdXr3MdppxJr
         +faW5XnwGXPqsOxgHI3+Bw9UxvsrgBxET+oPAxl3phRs3cpoLWzDZrgLCIyc38Vc2PNk
         ZBV03gMpngeNeHllUxO4LKVq2f7IdofrhGNHQt+Yv+e6gXTSebzaX6QyFWUd25EMp3aq
         t9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697240864; x=1697845664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NEEGOi4GCb6HcvidYXCklsWgHDxlGjLGl/WS/rvT1I=;
        b=p6VZg6g/pz9I3dIpnq4ytZbSiMOTO1vcfWZvFugoYHImWrGngceF8tlnxwX8QWBn2Y
         Z2lElpShHUSgHohmwBr2B0TVrv+ivHVTMk3CcFPW5xw7trRnXNaARYVhlMcqh39/vOMa
         O4R0oQsdfzxczsJZ1LkRE1OVAS/5D7smZ+wKS11jjP+cjIZxlsFLYfmvlmR54/ig8twi
         pxTs1hCOOHsPoAfboF6OlNzkcZUt4/DQDv/hUw7grDXTm/t+Uy3awZZwVd40i7KRvrQW
         ZTYLfPP7r1Mjrd4Dk+MoialjNskLlncEJ4j7mwGXPz2kpSZwYLoCLmLQd1nDiAEIbfl+
         orNw==
X-Gm-Message-State: AOJu0YyWkVoj+A8h7phCQIWPrynO/ezEYua80i/0MW+KoEBAR04Bq1sH
        dmVOrZ7Uz8Kdi2vyjSxS4jM=
X-Google-Smtp-Source: AGHT+IHrHiJWmg3QWD2PJGpqvM2+FPAs8bOz7KqSlFbKx6/Y2SF6yaaMxRAahAqEW0VtCX9TeqR04g==
X-Received: by 2002:a05:6808:128a:b0:3a6:febf:fb with SMTP id a10-20020a056808128a00b003a6febf00fbmr34131697oiw.22.1697240864158;
        Fri, 13 Oct 2023 16:47:44 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id y3-20020a62b503000000b0068fd653321esm14043032pfe.58.2023.10.13.16.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:47:43 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH 4/4] staging: vme_user: Add spaces around '<<' operator
Date:   Fri, 13 Oct 2023 16:47:16 -0700
Message-ID: <f84f353dedc28f99e42d2419b379ace41d0cb218.1697240381.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697240381.git.soumya.negi97@gmail.com>
References: <cover.1697240381.git.soumya.negi97@gmail.com>
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

Add spaces around all instances of << in the header vme_tsi148.h to
conform with Linux coding style. Issue found by checkpatch.pl

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/vme_user/vme_tsi148.h | 548 +++++++++++++-------------
 1 file changed, 274 insertions(+), 274 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
index 33c19fb60483..4dd224d0b86e 100644
--- a/drivers/staging/vme_user/vme_tsi148.h
+++ b/drivers/staging/vme_user/vme_tsi148.h
@@ -543,7 +543,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 #define TSI148_PCFS_STAT_RCVMA         BIT(13)	/* Received Master Abort */
 #define TSI148_PCFS_STAT_RCVTA         BIT(12)	/* Received Target Abort */
 #define TSI148_PCFS_STAT_SIGTA         BIT(11)	/* Signalled Target Abort */
-#define TSI148_PCFS_STAT_SELTIM        (3<<9)	/* DELSEL Timing */
+#define TSI148_PCFS_STAT_SELTIM        (3 << 9)	/* DELSEL Timing */
 #define TSI148_PCFS_STAT_DPAR          BIT(8)	/* Data Parity Err Reported */
 #define TSI148_PCFS_STAT_FAST          BIT(7)	/* Fast back-to-back Cap */
 #define TSI148_PCFS_STAT_P66M          BIT(5)	/* 66 MHz Capable */
@@ -552,49 +552,49 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  Revision ID/Class Code Registers   (CRG +$008)
  */
-#define TSI148_PCFS_CLAS_M             (0xFF<<24)	/* Class ID */
-#define TSI148_PCFS_SUBCLAS_M          (0xFF<<16)	/* Sub-Class ID */
-#define TSI148_PCFS_PROGIF_M           (0xFF<<8)	/* Sub-Class ID */
-#define TSI148_PCFS_REVID_M            (0xFF<<0)	/* Rev ID */
+#define TSI148_PCFS_CLAS_M             (0xFF << 24)	/* Class ID */
+#define TSI148_PCFS_SUBCLAS_M          (0xFF << 16)	/* Sub-Class ID */
+#define TSI148_PCFS_PROGIF_M           (0xFF << 8)	/* Sub-Class ID */
+#define TSI148_PCFS_REVID_M            (0xFF << 0)	/* Rev ID */
 
 /*
  * Cache Line Size/ Master Latency Timer/ Header Type Registers (CRG + $00C)
  */
-#define TSI148_PCFS_HEAD_M             (0xFF<<16)	/* Master Lat Timer */
-#define TSI148_PCFS_MLAT_M             (0xFF<<8)	/* Master Lat Timer */
-#define TSI148_PCFS_CLSZ_M             (0xFF<<0)	/* Cache Line Size */
+#define TSI148_PCFS_HEAD_M             (0xFF << 16)	/* Master Lat Timer */
+#define TSI148_PCFS_MLAT_M             (0xFF << 8)	/* Master Lat Timer */
+#define TSI148_PCFS_CLSZ_M             (0xFF << 0)	/* Cache Line Size */
 
 /*
  *  Memory Base Address Lower Reg (CRG + $010)
  */
-#define TSI148_PCFS_MBARL_BASEL_M      (0xFFFFF<<12) /* Base Addr Lower Mask */
+#define TSI148_PCFS_MBARL_BASEL_M      (0xFFFFF << 12) /* Base Addr Lower Mask */
 #define TSI148_PCFS_MBARL_PRE          BIT(3)	/* Prefetch */
-#define TSI148_PCFS_MBARL_MTYPE_M      (3<<1)	/* Memory Type Mask */
+#define TSI148_PCFS_MBARL_MTYPE_M      (3 << 1)	/* Memory Type Mask */
 #define TSI148_PCFS_MBARL_IOMEM        BIT(0)	/* I/O Space Indicator */
 
 /*
  *  Message Signaled Interrupt Capabilities Register (CRG + $040)
  */
 #define TSI148_PCFS_MSICAP_64BAC       BIT(7)	/* 64-bit Address Capable */
-#define TSI148_PCFS_MSICAP_MME_M       (7<<4)	/* Multiple Msg Enable Mask */
-#define TSI148_PCFS_MSICAP_MMC_M       (7<<1)	/* Multiple Msg Capable Mask */
+#define TSI148_PCFS_MSICAP_MME_M       (7 << 4)	/* Multiple Msg Enable Mask */
+#define TSI148_PCFS_MSICAP_MMC_M       (7 << 1)	/* Multiple Msg Capable Mask */
 #define TSI148_PCFS_MSICAP_MSIEN       BIT(0)	/* Msg signaled INT Enable */
 
 /*
  *  Message Address Lower Register (CRG +$044)
  */
-#define TSI148_PCFS_MSIAL_M            (0x3FFFFFFF<<2)	/* Mask */
+#define TSI148_PCFS_MSIAL_M            (0x3FFFFFFF << 2)	/* Mask */
 
 /*
  *  Message Data Register (CRG + 4C)
  */
-#define TSI148_PCFS_MSIMD_M            (0xFFFF<<0)	/* Mask */
+#define TSI148_PCFS_MSIMD_M            (0xFFFF << 0)	/* Mask */
 
 /*
  *  PCI-X Capabilities Register (CRG + $050)
  */
-#define TSI148_PCFS_PCIXCAP_MOST_M     (7<<4)	/* Max outstanding Split Tran */
-#define TSI148_PCFS_PCIXCAP_MMRBC_M    (3<<2)	/* Max Mem Read byte cnt */
+#define TSI148_PCFS_PCIXCAP_MOST_M     (7 << 4)	/* Max outstanding Split Tran */
+#define TSI148_PCFS_PCIXCAP_MMRBC_M    (3 << 2)	/* Max Mem Read byte cnt */
 #define TSI148_PCFS_PCIXCAP_ERO        BIT(1)	/* Enable Relaxed Ordering */
 #define TSI148_PCFS_PCIXCAP_DPERE      BIT(0)	/* Data Parity Recover Enable */
 
@@ -602,17 +602,17 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
  *  PCI-X Status Register (CRG +$054)
  */
 #define TSI148_PCFS_PCIXSTAT_RSCEM     BIT(29)	/* Received Split Comp Error */
-#define TSI148_PCFS_PCIXSTAT_DMCRS_M   (7<<26)	/* max Cumulative Read Size */
-#define TSI148_PCFS_PCIXSTAT_DMOST_M   (7<<23)	/* max outstanding Split Trans */
-#define TSI148_PCFS_PCIXSTAT_DMMRC_M   (3<<21)	/* max mem read byte count */
+#define TSI148_PCFS_PCIXSTAT_DMCRS_M   (7 << 26)	/* max Cumulative Read Size */
+#define TSI148_PCFS_PCIXSTAT_DMOST_M   (7 << 23)	/* max outstanding Split Trans */
+#define TSI148_PCFS_PCIXSTAT_DMMRC_M   (3 << 21)	/* max mem read byte count */
 #define TSI148_PCFS_PCIXSTAT_DC        BIT(20)	/* Device Complexity */
 #define TSI148_PCFS_PCIXSTAT_USC       BIT(19)	/* Unexpected Split comp */
 #define TSI148_PCFS_PCIXSTAT_SCD       BIT(18)	/* Split completion discard */
 #define TSI148_PCFS_PCIXSTAT_133C      BIT(17)	/* 133MHz capable */
 #define TSI148_PCFS_PCIXSTAT_64D       BIT(16)	/* 64 bit device */
-#define TSI148_PCFS_PCIXSTAT_BN_M      (0xFF<<8)	/* Bus number */
-#define TSI148_PCFS_PCIXSTAT_DN_M      (0x1F<<3)	/* Device number */
-#define TSI148_PCFS_PCIXSTAT_FN_M      (7<<0)	/* Function Number */
+#define TSI148_PCFS_PCIXSTAT_BN_M      (0xFF << 8)	/* Bus number */
+#define TSI148_PCFS_PCIXSTAT_DN_M      (0x1F << 3)	/* Device number */
+#define TSI148_PCFS_PCIXSTAT_FN_M      (7 << 0)	/* Function Number */
 
 /*
  *  LCSR Registers
@@ -621,22 +621,22 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  Outbound Translation Starting Address Lower
  */
-#define TSI148_LCSR_OTSAL_M            (0xFFFF<<16)	/* Mask */
+#define TSI148_LCSR_OTSAL_M            (0xFFFF << 16)	/* Mask */
 
 /*
  *  Outbound Translation Ending Address Lower
  */
-#define TSI148_LCSR_OTEAL_M            (0xFFFF<<16)	/* Mask */
+#define TSI148_LCSR_OTEAL_M            (0xFFFF << 16)	/* Mask */
 
 /*
  *  Outbound Translation Offset Lower
  */
-#define TSI148_LCSR_OTOFFL_M           (0xFFFF<<16)	/* Mask */
+#define TSI148_LCSR_OTOFFL_M           (0xFFFF << 16)	/* Mask */
 
 /*
  *  Outbound Translation 2eSST Broadcast Select
  */
-#define TSI148_LCSR_OTBS_M             (0xFFFFF<<0)	/* Mask */
+#define TSI148_LCSR_OTBS_M             (0xFFFFF << 0)	/* Mask */
 
 /*
  *  Outbound Translation Attribute
@@ -644,42 +644,42 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 #define TSI148_LCSR_OTAT_EN            BIT(31)	/* Window Enable */
 #define TSI148_LCSR_OTAT_MRPFD         BIT(18)	/* Prefetch Disable */
 
-#define TSI148_LCSR_OTAT_PFS_M         (3<<16)	/* Prefetch Size Mask */
-#define TSI148_LCSR_OTAT_PFS_2         (0<<16)	/* 2 Cache Lines P Size */
+#define TSI148_LCSR_OTAT_PFS_M         (3 << 16)	/* Prefetch Size Mask */
+#define TSI148_LCSR_OTAT_PFS_2         (0 << 16)	/* 2 Cache Lines P Size */
 #define TSI148_LCSR_OTAT_PFS_4         BIT(16)	/* 4 Cache Lines P Size */
-#define TSI148_LCSR_OTAT_PFS_8         (2<<16)	/* 8 Cache Lines P Size */
-#define TSI148_LCSR_OTAT_PFS_16        (3<<16)	/* 16 Cache Lines P Size */
+#define TSI148_LCSR_OTAT_PFS_8         (2 << 16)	/* 8 Cache Lines P Size */
+#define TSI148_LCSR_OTAT_PFS_16        (3 << 16)	/* 16 Cache Lines P Size */
 
-#define TSI148_LCSR_OTAT_2eSSTM_M      (7<<11)	/* 2eSST Xfer Rate Mask */
-#define TSI148_LCSR_OTAT_2eSSTM_160    (0<<11)	/* 160MB/s 2eSST Xfer Rate */
+#define TSI148_LCSR_OTAT_2eSSTM_M      (7 << 11)	/* 2eSST Xfer Rate Mask */
+#define TSI148_LCSR_OTAT_2eSSTM_160    (0 << 11)	/* 160MB/s 2eSST Xfer Rate */
 #define TSI148_LCSR_OTAT_2eSSTM_267    BIT(11)	/* 267MB/s 2eSST Xfer Rate */
-#define TSI148_LCSR_OTAT_2eSSTM_320    (2<<11)	/* 320MB/s 2eSST Xfer Rate */
+#define TSI148_LCSR_OTAT_2eSSTM_320    (2 << 11)	/* 320MB/s 2eSST Xfer Rate */
 
-#define TSI148_LCSR_OTAT_TM_M          (7<<8)	/* Xfer Protocol Mask */
-#define TSI148_LCSR_OTAT_TM_SCT        (0<<8)	/* SCT Xfer Protocol */
+#define TSI148_LCSR_OTAT_TM_M          (7 << 8)	/* Xfer Protocol Mask */
+#define TSI148_LCSR_OTAT_TM_SCT        (0 << 8)	/* SCT Xfer Protocol */
 #define TSI148_LCSR_OTAT_TM_BLT        BIT(8)	/* BLT Xfer Protocol */
-#define TSI148_LCSR_OTAT_TM_MBLT       (2<<8)	/* MBLT Xfer Protocol */
-#define TSI148_LCSR_OTAT_TM_2eVME      (3<<8)	/* 2eVME Xfer Protocol */
-#define TSI148_LCSR_OTAT_TM_2eSST      (4<<8)	/* 2eSST Xfer Protocol */
-#define TSI148_LCSR_OTAT_TM_2eSSTB     (5<<8)	/* 2eSST Bcast Xfer Protocol */
+#define TSI148_LCSR_OTAT_TM_MBLT       (2 << 8)	/* MBLT Xfer Protocol */
+#define TSI148_LCSR_OTAT_TM_2eVME      (3 << 8)	/* 2eVME Xfer Protocol */
+#define TSI148_LCSR_OTAT_TM_2eSST      (4 << 8)	/* 2eSST Xfer Protocol */
+#define TSI148_LCSR_OTAT_TM_2eSSTB     (5 << 8)	/* 2eSST Bcast Xfer Protocol */
 
-#define TSI148_LCSR_OTAT_DBW_M         (3<<6)	/* Max Data Width */
-#define TSI148_LCSR_OTAT_DBW_16        (0<<6)	/* 16-bit Data Width */
+#define TSI148_LCSR_OTAT_DBW_M         (3 << 6)	/* Max Data Width */
+#define TSI148_LCSR_OTAT_DBW_16        (0 << 6)	/* 16-bit Data Width */
 #define TSI148_LCSR_OTAT_DBW_32        BIT(6)	/* 32-bit Data Width */
 
 #define TSI148_LCSR_OTAT_SUP           BIT(5)	/* Supervisory Access */
 #define TSI148_LCSR_OTAT_PGM           BIT(4)	/* Program Access */
 
-#define TSI148_LCSR_OTAT_AMODE_M       (0xf<<0)	/* Address Mode Mask */
-#define TSI148_LCSR_OTAT_AMODE_A16     (0<<0)	/* A16 Address Space */
+#define TSI148_LCSR_OTAT_AMODE_M       (0xf << 0)	/* Address Mode Mask */
+#define TSI148_LCSR_OTAT_AMODE_A16     (0 << 0)	/* A16 Address Space */
 #define TSI148_LCSR_OTAT_AMODE_A24     BIT(0)	/* A24 Address Space */
-#define TSI148_LCSR_OTAT_AMODE_A32     (2<<0)	/* A32 Address Space */
-#define TSI148_LCSR_OTAT_AMODE_A64     (4<<0)	/* A32 Address Space */
-#define TSI148_LCSR_OTAT_AMODE_CRCSR   (5<<0)	/* CR/CSR Address Space */
-#define TSI148_LCSR_OTAT_AMODE_USER1   (8<<0)	/* User1 Address Space */
-#define TSI148_LCSR_OTAT_AMODE_USER2   (9<<0)	/* User2 Address Space */
-#define TSI148_LCSR_OTAT_AMODE_USER3   (10<<0)	/* User3 Address Space */
-#define TSI148_LCSR_OTAT_AMODE_USER4   (11<<0)	/* User4 Address Space */
+#define TSI148_LCSR_OTAT_AMODE_A32     (2 << 0)	/* A32 Address Space */
+#define TSI148_LCSR_OTAT_AMODE_A64     (4 << 0)	/* A32 Address Space */
+#define TSI148_LCSR_OTAT_AMODE_CRCSR   (5 << 0)	/* CR/CSR Address Space */
+#define TSI148_LCSR_OTAT_AMODE_USER1   (8 << 0)	/* User1 Address Space */
+#define TSI148_LCSR_OTAT_AMODE_USER2   (9 << 0)	/* User2 Address Space */
+#define TSI148_LCSR_OTAT_AMODE_USER3   (10 << 0)	/* User3 Address Space */
+#define TSI148_LCSR_OTAT_AMODE_USER4   (11 << 0)	/* User4 Address Space */
 
 /*
  *  VME Master Control Register  CRG+$234
@@ -691,46 +691,46 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 
 #define TSI148_LCSR_VMCTRL_RMWEN       BIT(20)	/* RMW Enable */
 
-#define TSI148_LCSR_VMCTRL_ATO_M       (7<<16)	/* Master Access Time-out Mask
+#define TSI148_LCSR_VMCTRL_ATO_M       (7 << 16)	/* Master Access Time-out Mask
 						 */
-#define TSI148_LCSR_VMCTRL_ATO_32      (0<<16)	/* 32 us */
+#define TSI148_LCSR_VMCTRL_ATO_32      (0 << 16)	/* 32 us */
 #define TSI148_LCSR_VMCTRL_ATO_128     BIT(16)	/* 128 us */
-#define TSI148_LCSR_VMCTRL_ATO_512     (2<<16)	/* 512 us */
-#define TSI148_LCSR_VMCTRL_ATO_2M      (3<<16)	/* 2 ms */
-#define TSI148_LCSR_VMCTRL_ATO_8M      (4<<16)	/* 8 ms */
-#define TSI148_LCSR_VMCTRL_ATO_32M     (5<<16)	/* 32 ms */
-#define TSI148_LCSR_VMCTRL_ATO_128M    (6<<16)	/* 128 ms */
-#define TSI148_LCSR_VMCTRL_ATO_DIS     (7<<16)	/* Disabled */
-
-#define TSI148_LCSR_VMCTRL_VTOFF_M     (7<<12)	/* VMEbus Master Time off */
-#define TSI148_LCSR_VMCTRL_VTOFF_0     (0<<12)	/* 0us */
+#define TSI148_LCSR_VMCTRL_ATO_512     (2 << 16)	/* 512 us */
+#define TSI148_LCSR_VMCTRL_ATO_2M      (3 << 16)	/* 2 ms */
+#define TSI148_LCSR_VMCTRL_ATO_8M      (4 << 16)	/* 8 ms */
+#define TSI148_LCSR_VMCTRL_ATO_32M     (5 << 16)	/* 32 ms */
+#define TSI148_LCSR_VMCTRL_ATO_128M    (6 << 16)	/* 128 ms */
+#define TSI148_LCSR_VMCTRL_ATO_DIS     (7 << 16)	/* Disabled */
+
+#define TSI148_LCSR_VMCTRL_VTOFF_M     (7 << 12)	/* VMEbus Master Time off */
+#define TSI148_LCSR_VMCTRL_VTOFF_0     (0 << 12)	/* 0us */
 #define TSI148_LCSR_VMCTRL_VTOFF_1     BIT(12)	/* 1us */
-#define TSI148_LCSR_VMCTRL_VTOFF_2     (2<<12)	/* 2us */
-#define TSI148_LCSR_VMCTRL_VTOFF_4     (3<<12)	/* 4us */
-#define TSI148_LCSR_VMCTRL_VTOFF_8     (4<<12)	/* 8us */
-#define TSI148_LCSR_VMCTRL_VTOFF_16    (5<<12)	/* 16us */
-#define TSI148_LCSR_VMCTRL_VTOFF_32    (6<<12)	/* 32us */
-#define TSI148_LCSR_VMCTRL_VTOFF_64    (7<<12)	/* 64us */
-
-#define TSI148_LCSR_VMCTRL_VTON_M      (7<<8)	/* VMEbus Master Time On */
-#define TSI148_LCSR_VMCTRL_VTON_4      (0<<8)	/* 8us */
+#define TSI148_LCSR_VMCTRL_VTOFF_2     (2 << 12)	/* 2us */
+#define TSI148_LCSR_VMCTRL_VTOFF_4     (3 << 12)	/* 4us */
+#define TSI148_LCSR_VMCTRL_VTOFF_8     (4 << 12)	/* 8us */
+#define TSI148_LCSR_VMCTRL_VTOFF_16    (5 << 12)	/* 16us */
+#define TSI148_LCSR_VMCTRL_VTOFF_32    (6 << 12)	/* 32us */
+#define TSI148_LCSR_VMCTRL_VTOFF_64    (7 << 12)	/* 64us */
+
+#define TSI148_LCSR_VMCTRL_VTON_M      (7 << 8)	/* VMEbus Master Time On */
+#define TSI148_LCSR_VMCTRL_VTON_4      (0 << 8)	/* 8us */
 #define TSI148_LCSR_VMCTRL_VTON_8      BIT(8)	/* 8us */
-#define TSI148_LCSR_VMCTRL_VTON_16     (2<<8)	/* 16us */
-#define TSI148_LCSR_VMCTRL_VTON_32     (3<<8)	/* 32us */
-#define TSI148_LCSR_VMCTRL_VTON_64     (4<<8)	/* 64us */
-#define TSI148_LCSR_VMCTRL_VTON_128    (5<<8)	/* 128us */
-#define TSI148_LCSR_VMCTRL_VTON_256    (6<<8)	/* 256us */
-#define TSI148_LCSR_VMCTRL_VTON_512    (7<<8)	/* 512us */
-
-#define TSI148_LCSR_VMCTRL_VREL_M      (3<<3)	/* VMEbus Master Rel Mode Mask
+#define TSI148_LCSR_VMCTRL_VTON_16     (2 << 8)	/* 16us */
+#define TSI148_LCSR_VMCTRL_VTON_32     (3 << 8)	/* 32us */
+#define TSI148_LCSR_VMCTRL_VTON_64     (4 << 8)	/* 64us */
+#define TSI148_LCSR_VMCTRL_VTON_128    (5 << 8)	/* 128us */
+#define TSI148_LCSR_VMCTRL_VTON_256    (6 << 8)	/* 256us */
+#define TSI148_LCSR_VMCTRL_VTON_512    (7 << 8)	/* 512us */
+
+#define TSI148_LCSR_VMCTRL_VREL_M      (3 << 3)	/* VMEbus Master Rel Mode Mask
 						 */
-#define TSI148_LCSR_VMCTRL_VREL_T_D    (0<<3)	/* Time on or Done */
+#define TSI148_LCSR_VMCTRL_VREL_T_D    (0 << 3)	/* Time on or Done */
 #define TSI148_LCSR_VMCTRL_VREL_T_R_D  BIT(3)	/* Time on and REQ or Done */
-#define TSI148_LCSR_VMCTRL_VREL_T_B_D  (2<<3)	/* Time on and BCLR or Done */
-#define TSI148_LCSR_VMCTRL_VREL_T_D_R  (3<<3)	/* Time on or Done and REQ */
+#define TSI148_LCSR_VMCTRL_VREL_T_B_D  (2 << 3)	/* Time on and BCLR or Done */
+#define TSI148_LCSR_VMCTRL_VREL_T_D_R  (3 << 3)	/* Time on or Done and REQ */
 
 #define TSI148_LCSR_VMCTRL_VFAIR       BIT(2)	/* VMEbus Master Fair Mode */
-#define TSI148_LCSR_VMCTRL_VREQL_M     (3<<0)	/* VMEbus Master Req Level Mask
+#define TSI148_LCSR_VMCTRL_VREQL_M     (3 << 0)	/* VMEbus Master Req Level Mask
 						 */
 
 /*
@@ -738,20 +738,20 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
  */
 #define TSI148_LCSR_VCTRL_LRE          BIT(31)	/* Late Retry Enable */
 
-#define TSI148_LCSR_VCTRL_DLT_M        (0xF<<24)	/* Deadlock Timer */
-#define TSI148_LCSR_VCTRL_DLT_OFF      (0<<24)	/* Deadlock Timer Off */
+#define TSI148_LCSR_VCTRL_DLT_M        (0xF << 24)	/* Deadlock Timer */
+#define TSI148_LCSR_VCTRL_DLT_OFF      (0 << 24)	/* Deadlock Timer Off */
 #define TSI148_LCSR_VCTRL_DLT_16       BIT(24)	/* 16 VCLKS */
-#define TSI148_LCSR_VCTRL_DLT_32       (2<<24)	/* 32 VCLKS */
-#define TSI148_LCSR_VCTRL_DLT_64       (3<<24)	/* 64 VCLKS */
-#define TSI148_LCSR_VCTRL_DLT_128      (4<<24)	/* 128 VCLKS */
-#define TSI148_LCSR_VCTRL_DLT_256      (5<<24)	/* 256 VCLKS */
-#define TSI148_LCSR_VCTRL_DLT_512      (6<<24)	/* 512 VCLKS */
-#define TSI148_LCSR_VCTRL_DLT_1024     (7<<24)	/* 1024 VCLKS */
-#define TSI148_LCSR_VCTRL_DLT_2048     (8<<24)	/* 2048 VCLKS */
-#define TSI148_LCSR_VCTRL_DLT_4096     (9<<24)	/* 4096 VCLKS */
-#define TSI148_LCSR_VCTRL_DLT_8192     (0xA<<24)	/* 8192 VCLKS */
-#define TSI148_LCSR_VCTRL_DLT_16384    (0xB<<24)	/* 16384 VCLKS */
-#define TSI148_LCSR_VCTRL_DLT_32768    (0xC<<24)	/* 32768 VCLKS */
+#define TSI148_LCSR_VCTRL_DLT_32       (2 << 24)	/* 32 VCLKS */
+#define TSI148_LCSR_VCTRL_DLT_64       (3 << 24)	/* 64 VCLKS */
+#define TSI148_LCSR_VCTRL_DLT_128      (4 << 24)	/* 128 VCLKS */
+#define TSI148_LCSR_VCTRL_DLT_256      (5 << 24)	/* 256 VCLKS */
+#define TSI148_LCSR_VCTRL_DLT_512      (6 << 24)	/* 512 VCLKS */
+#define TSI148_LCSR_VCTRL_DLT_1024     (7 << 24)	/* 1024 VCLKS */
+#define TSI148_LCSR_VCTRL_DLT_2048     (8 << 24)	/* 2048 VCLKS */
+#define TSI148_LCSR_VCTRL_DLT_4096     (9 << 24)	/* 4096 VCLKS */
+#define TSI148_LCSR_VCTRL_DLT_8192     (0xA << 24)	/* 8192 VCLKS */
+#define TSI148_LCSR_VCTRL_DLT_16384    (0xB << 24)	/* 16384 VCLKS */
+#define TSI148_LCSR_VCTRL_DLT_32768    (0xC << 24)	/* 32768 VCLKS */
 
 #define TSI148_LCSR_VCTRL_NERBB        BIT(20)	/* No Early Release of Bus Busy
 						 */
@@ -760,20 +760,20 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 #define TSI148_LCSR_VCTRL_LRESET       BIT(16)	/* Local Reset */
 
 #define TSI148_LCSR_VCTRL_SFAILAI      BIT(15)	/* SYSFAIL Auto Slot ID */
-#define TSI148_LCSR_VCTRL_BID_M        (0x1F<<8)	/* Broadcast ID Mask */
+#define TSI148_LCSR_VCTRL_BID_M        (0x1F << 8)	/* Broadcast ID Mask */
 
 #define TSI148_LCSR_VCTRL_ATOEN        BIT(7)	/* Arbiter Time-out Enable */
 #define TSI148_LCSR_VCTRL_ROBIN        BIT(6)	/* VMEbus Round Robin */
 
-#define TSI148_LCSR_VCTRL_GTO_M        (7<<0)	/* VMEbus Global Time-out Mask*/
-#define TSI148_LCSR_VCTRL_GTO_8	      (0<<0)	/* 8 us */
+#define TSI148_LCSR_VCTRL_GTO_M        (7 << 0)	/* VMEbus Global Time-out Mask*/
+#define TSI148_LCSR_VCTRL_GTO_8	      (0 << 0)	/* 8 us */
 #define TSI148_LCSR_VCTRL_GTO_16	      BIT(0)	/* 16 us */
-#define TSI148_LCSR_VCTRL_GTO_32	      (2<<0)	/* 32 us */
-#define TSI148_LCSR_VCTRL_GTO_64	      (3<<0)	/* 64 us */
-#define TSI148_LCSR_VCTRL_GTO_128      (4<<0)	/* 128 us */
-#define TSI148_LCSR_VCTRL_GTO_256      (5<<0)	/* 256 us */
-#define TSI148_LCSR_VCTRL_GTO_512      (6<<0)	/* 512 us */
-#define TSI148_LCSR_VCTRL_GTO_DIS      (7<<0)	/* Disabled */
+#define TSI148_LCSR_VCTRL_GTO_32	      (2 << 0)	/* 32 us */
+#define TSI148_LCSR_VCTRL_GTO_64	      (3 << 0)	/* 64 us */
+#define TSI148_LCSR_VCTRL_GTO_128      (4 << 0)	/* 128 us */
+#define TSI148_LCSR_VCTRL_GTO_256      (5 << 0)	/* 256 us */
+#define TSI148_LCSR_VCTRL_GTO_512      (6 << 0)	/* 512 us */
+#define TSI148_LCSR_VCTRL_GTO_DIS      (7 << 0)	/* Disabled */
 
 /*
  *  VMEbus Status Register  CRG + $23C
@@ -786,7 +786,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 #define TSI148_LCSR_VSTAT_ACFAILS      BIT(9)	/* AC fail status */
 #define TSI148_LCSR_VSTAT_SCONS        BIT(8)	/* System Cont Status */
 #define TSI148_LCSR_VSTAT_GAP          BIT(5)	/* Geographic Addr Parity */
-#define TSI148_LCSR_VSTAT_GA_M         (0x1F<<0)  /* Geographic Addr Mask */
+#define TSI148_LCSR_VSTAT_GA_M         (0x1F << 0)  /* Geographic Addr Mask */
 
 /*
  *  PCI Configuration Status Register CRG+$240
@@ -813,8 +813,8 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 #define TSI148_LCSR_VEAT_IACK          BIT(16)	/* IACK_ signal state */
 #define TSI148_LCSR_VEAT_DS1           BIT(15)	/* DS1_ signal state */
 #define TSI148_LCSR_VEAT_DS0           BIT(14)	/* DS0_ signal state */
-#define TSI148_LCSR_VEAT_AM_M          (0x3F<<8)	/* Address Mode Mask */
-#define TSI148_LCSR_VEAT_XAM_M         (0xFF<<0)	/* Master AMode Mask */
+#define TSI148_LCSR_VEAT_AM_M          (0x3F << 8)	/* Address Mode Mask */
+#define TSI148_LCSR_VEAT_XAM_M         (0xFF << 0)	/* Master AMode Mask */
 
 /*
  * VMEbus PCI Error Diagnostics PCI/X Attributes Register  CRG + $280
@@ -824,23 +824,23 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  Inbound Translation Starting Address Lower
  */
-#define TSI148_LCSR_ITSAL6432_M        (0xFFFF<<16)	/* Mask */
-#define TSI148_LCSR_ITSAL24_M          (0x00FFF<<12)	/* Mask */
-#define TSI148_LCSR_ITSAL16_M          (0x0000FFF<<4)	/* Mask */
+#define TSI148_LCSR_ITSAL6432_M        (0xFFFF << 16)	/* Mask */
+#define TSI148_LCSR_ITSAL24_M          (0x00FFF << 12)	/* Mask */
+#define TSI148_LCSR_ITSAL16_M          (0x0000FFF << 4)	/* Mask */
 
 /*
  *  Inbound Translation Ending Address Lower
  */
-#define TSI148_LCSR_ITEAL6432_M        (0xFFFF<<16)	/* Mask */
-#define TSI148_LCSR_ITEAL24_M          (0x00FFF<<12)	/* Mask */
-#define TSI148_LCSR_ITEAL16_M          (0x0000FFF<<4)	/* Mask */
+#define TSI148_LCSR_ITEAL6432_M        (0xFFFF << 16)	/* Mask */
+#define TSI148_LCSR_ITEAL24_M          (0x00FFF << 12)	/* Mask */
+#define TSI148_LCSR_ITEAL16_M          (0x0000FFF << 4)	/* Mask */
 
 /*
  *  Inbound Translation Offset Lower
  */
-#define TSI148_LCSR_ITOFFL6432_M       (0xFFFF<<16)	/* Mask */
-#define TSI148_LCSR_ITOFFL24_M         (0xFFFFF<<12)	/* Mask */
-#define TSI148_LCSR_ITOFFL16_M         (0xFFFFFFF<<4)	/* Mask */
+#define TSI148_LCSR_ITOFFL6432_M       (0xFFFF << 16)	/* Mask */
+#define TSI148_LCSR_ITOFFL24_M         (0xFFFFF << 12)	/* Mask */
+#define TSI148_LCSR_ITOFFL16_M         (0xFFFFFFF << 4)	/* Mask */
 
 /*
  *  Inbound Translation Attribute
@@ -848,16 +848,16 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 #define TSI148_LCSR_ITAT_EN            BIT(31)	/* Window Enable */
 #define TSI148_LCSR_ITAT_TH            BIT(18)	/* Prefetch Threshold */
 
-#define TSI148_LCSR_ITAT_VFS_M         (3<<16)	/* Virtual FIFO Size Mask */
-#define TSI148_LCSR_ITAT_VFS_64        (0<<16)	/* 64 bytes Virtual FIFO Size */
+#define TSI148_LCSR_ITAT_VFS_M         (3 << 16)	/* Virtual FIFO Size Mask */
+#define TSI148_LCSR_ITAT_VFS_64        (0 << 16)	/* 64 bytes Virtual FIFO Size */
 #define TSI148_LCSR_ITAT_VFS_128       BIT(16)	/* 128 bytes Virtual FIFO Sz */
-#define TSI148_LCSR_ITAT_VFS_256       (2<<16)	/* 256 bytes Virtual FIFO Sz */
-#define TSI148_LCSR_ITAT_VFS_512       (3<<16)	/* 512 bytes Virtual FIFO Sz */
+#define TSI148_LCSR_ITAT_VFS_256       (2 << 16)	/* 256 bytes Virtual FIFO Sz */
+#define TSI148_LCSR_ITAT_VFS_512       (3 << 16)	/* 512 bytes Virtual FIFO Sz */
 
-#define TSI148_LCSR_ITAT_2eSSTM_M      (7<<12)	/* 2eSST Xfer Rate Mask */
-#define TSI148_LCSR_ITAT_2eSSTM_160    (0<<12)	/* 160MB/s 2eSST Xfer Rate */
+#define TSI148_LCSR_ITAT_2eSSTM_M      (7 << 12)	/* 2eSST Xfer Rate Mask */
+#define TSI148_LCSR_ITAT_2eSSTM_160    (0 << 12)	/* 160MB/s 2eSST Xfer Rate */
 #define TSI148_LCSR_ITAT_2eSSTM_267    BIT(12)	/* 267MB/s 2eSST Xfer Rate */
-#define TSI148_LCSR_ITAT_2eSSTM_320    (2<<12)	/* 320MB/s 2eSST Xfer Rate */
+#define TSI148_LCSR_ITAT_2eSSTM_320    (2 << 12)	/* 320MB/s 2eSST Xfer Rate */
 
 #define TSI148_LCSR_ITAT_2eSSTB        BIT(11)	/* 2eSST Bcast Xfer Protocol */
 #define TSI148_LCSR_ITAT_2eSST         BIT(10)	/* 2eSST Xfer Protocol */
@@ -865,11 +865,11 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 #define TSI148_LCSR_ITAT_MBLT          BIT(8)	/* MBLT Xfer Protocol */
 #define TSI148_LCSR_ITAT_BLT           BIT(7)	/* BLT Xfer Protocol */
 
-#define TSI148_LCSR_ITAT_AS_M          (7<<4)	/* Address Space Mask */
-#define TSI148_LCSR_ITAT_AS_A16        (0<<4)	/* A16 Address Space */
+#define TSI148_LCSR_ITAT_AS_M          (7 << 4)	/* Address Space Mask */
+#define TSI148_LCSR_ITAT_AS_A16        (0 << 4)	/* A16 Address Space */
 #define TSI148_LCSR_ITAT_AS_A24        BIT(4)	/* A24 Address Space */
-#define TSI148_LCSR_ITAT_AS_A32        (2<<4)	/* A32 Address Space */
-#define TSI148_LCSR_ITAT_AS_A64        (4<<4)	/* A64 Address Space */
+#define TSI148_LCSR_ITAT_AS_A32        (2 << 4)	/* A32 Address Space */
+#define TSI148_LCSR_ITAT_AS_A64        (4 << 4)	/* A64 Address Space */
 
 #define TSI148_LCSR_ITAT_SUPR          BIT(3)	/* Supervisor Access */
 #define TSI148_LCSR_ITAT_NPRIV         BIT(2)	/* Non-Priv (User) Access */
@@ -879,18 +879,18 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  GCSR Base Address Lower Address  CRG +$404
  */
-#define TSI148_LCSR_GBAL_M             (0x7FFFFFF<<5)	/* Mask */
+#define TSI148_LCSR_GBAL_M             (0x7FFFFFF << 5)	/* Mask */
 
 /*
  *  GCSR Attribute Register CRG + $408
  */
 #define TSI148_LCSR_GCSRAT_EN          BIT(7)	/* Enable access to GCSR */
 
-#define TSI148_LCSR_GCSRAT_AS_M        (7<<4)	/* Address Space Mask */
-#define TSI148_LCSR_GCSRAT_AS_A16       (0<<4)	/* Address Space 16 */
+#define TSI148_LCSR_GCSRAT_AS_M        (7 << 4)	/* Address Space Mask */
+#define TSI148_LCSR_GCSRAT_AS_A16       (0 << 4)	/* Address Space 16 */
 #define TSI148_LCSR_GCSRAT_AS_A24       BIT(4)	/* Address Space 24 */
-#define TSI148_LCSR_GCSRAT_AS_A32       (2<<4)	/* Address Space 32 */
-#define TSI148_LCSR_GCSRAT_AS_A64       (4<<4)	/* Address Space 64 */
+#define TSI148_LCSR_GCSRAT_AS_A32       (2 << 4)	/* Address Space 32 */
+#define TSI148_LCSR_GCSRAT_AS_A64       (4 << 4)	/* Address Space 64 */
 
 #define TSI148_LCSR_GCSRAT_SUPR        BIT(3)	/* Sup set -GCSR decoder */
 #define TSI148_LCSR_GCSRAT_NPRIV       BIT(2)	/* Non-Privliged set - CGSR */
@@ -900,18 +900,18 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  CRG Base Address Lower Address  CRG + $410
  */
-#define TSI148_LCSR_CBAL_M             (0xFFFFF<<12)
+#define TSI148_LCSR_CBAL_M             (0xFFFFF << 12)
 
 /*
  *  CRG Attribute Register  CRG + $414
  */
 #define TSI148_LCSR_CRGAT_EN           BIT(7)	/* Enable PRG Access */
 
-#define TSI148_LCSR_CRGAT_AS_M         (7<<4)	/* Address Space */
-#define TSI148_LCSR_CRGAT_AS_A16       (0<<4)	/* Address Space 16 */
+#define TSI148_LCSR_CRGAT_AS_M         (7 << 4)	/* Address Space */
+#define TSI148_LCSR_CRGAT_AS_A16       (0 << 4)	/* Address Space 16 */
 #define TSI148_LCSR_CRGAT_AS_A24       BIT(4)	/* Address Space 24 */
-#define TSI148_LCSR_CRGAT_AS_A32       (2<<4)	/* Address Space 32 */
-#define TSI148_LCSR_CRGAT_AS_A64       (4<<4)	/* Address Space 64 */
+#define TSI148_LCSR_CRGAT_AS_A32       (2 << 4)	/* Address Space 32 */
+#define TSI148_LCSR_CRGAT_AS_A64       (4 << 4)	/* Address Space 64 */
 
 #define TSI148_LCSR_CRGAT_SUPR         BIT(3)	/* Supervisor Access */
 #define TSI148_LCSR_CRGAT_NPRIV        BIT(2)	/* Non-Privliged(User) Access */
@@ -921,7 +921,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  CR/CSR Offset Lower Register  CRG + $41C
  */
-#define TSI148_LCSR_CROL_M             (0x1FFF<<19)	/* Mask */
+#define TSI148_LCSR_CROL_M             (0x1FFF << 19)	/* Mask */
 
 /*
  *  CR/CSR Attribute register  CRG + $420
@@ -931,18 +931,18 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  Location Monitor base address lower register  CRG + $428
  */
-#define TSI148_LCSR_LMBAL_M            (0x7FFFFFF<<5)	/* Mask */
+#define TSI148_LCSR_LMBAL_M            (0x7FFFFFF << 5)	/* Mask */
 
 /*
  *  Location Monitor Attribute Register  CRG + $42C
  */
 #define TSI148_LCSR_LMAT_EN            BIT(7)	/* Enable Location Monitor */
 
-#define TSI148_LCSR_LMAT_AS_M          (7<<4)	/* Address Space MASK  */
-#define TSI148_LCSR_LMAT_AS_A16        (0<<4)	/* A16 */
+#define TSI148_LCSR_LMAT_AS_M          (7 << 4)	/* Address Space MASK  */
+#define TSI148_LCSR_LMAT_AS_A16        (0 << 4)	/* A16 */
 #define TSI148_LCSR_LMAT_AS_A24        BIT(4)	/* A24 */
-#define TSI148_LCSR_LMAT_AS_A32        (2<<4)	/* A32 */
-#define TSI148_LCSR_LMAT_AS_A64        (4<<4)	/* A64 */
+#define TSI148_LCSR_LMAT_AS_A32        (2 << 4)	/* A32 */
+#define TSI148_LCSR_LMAT_AS_A64        (4 << 4)	/* A64 */
 
 #define TSI148_LCSR_LMAT_SUPR          BIT(3)	/* Supervisor Access */
 #define TSI148_LCSR_LMAT_NPRIV         BIT(2)	/* Non-Priv (User) Access */
@@ -952,58 +952,58 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  Broadcast Pulse Generator Timer Register  CRG + $438
  */
-#define TSI148_LCSR_BPGTR_BPGT_M       (0xFFFF<<0)	/* Mask */
+#define TSI148_LCSR_BPGTR_BPGT_M       (0xFFFF << 0)	/* Mask */
 
 /*
  *  Broadcast Programmable Clock Timer Register  CRG + $43C
  */
-#define TSI148_LCSR_BPCTR_BPCT_M       (0xFFFFFF<<0)	/* Mask */
+#define TSI148_LCSR_BPCTR_BPCT_M       (0xFFFFFF << 0)	/* Mask */
 
 /*
  *  VMEbus Interrupt Control Register           CRG + $43C
  */
-#define TSI148_LCSR_VICR_CNTS_M        (3<<22)	/* Cntr Source MASK */
+#define TSI148_LCSR_VICR_CNTS_M        (3 << 22)	/* Cntr Source MASK */
 #define TSI148_LCSR_VICR_CNTS_DIS      BIT(22)	/* Cntr Disable */
-#define TSI148_LCSR_VICR_CNTS_IRQ1     (2<<22)	/* IRQ1 to Cntr */
-#define TSI148_LCSR_VICR_CNTS_IRQ2     (3<<22)	/* IRQ2 to Cntr */
+#define TSI148_LCSR_VICR_CNTS_IRQ1     (2 << 22)	/* IRQ1 to Cntr */
+#define TSI148_LCSR_VICR_CNTS_IRQ2     (3 << 22)	/* IRQ2 to Cntr */
 
-#define TSI148_LCSR_VICR_EDGIS_M       (3<<20)	/* Edge interrupt MASK */
+#define TSI148_LCSR_VICR_EDGIS_M       (3 << 20)	/* Edge interrupt MASK */
 #define TSI148_LCSR_VICR_EDGIS_DIS     BIT(20)	/* Edge interrupt Disable */
-#define TSI148_LCSR_VICR_EDGIS_IRQ1    (2<<20)	/* IRQ1 to Edge */
-#define TSI148_LCSR_VICR_EDGIS_IRQ2    (3<<20)	/* IRQ2 to Edge */
+#define TSI148_LCSR_VICR_EDGIS_IRQ1    (2 << 20)	/* IRQ1 to Edge */
+#define TSI148_LCSR_VICR_EDGIS_IRQ2    (3 << 20)	/* IRQ2 to Edge */
 
-#define TSI148_LCSR_VICR_IRQIF_M       (3<<18)	/* IRQ1* Function MASK */
+#define TSI148_LCSR_VICR_IRQIF_M       (3 << 18)	/* IRQ1* Function MASK */
 #define TSI148_LCSR_VICR_IRQIF_NORM    BIT(18)	/* Normal */
-#define TSI148_LCSR_VICR_IRQIF_PULSE   (2<<18)	/* Pulse Generator */
-#define TSI148_LCSR_VICR_IRQIF_PROG    (3<<18)	/* Programmable Clock */
-#define TSI148_LCSR_VICR_IRQIF_1U      (4<<18)	/* 1us Clock */
+#define TSI148_LCSR_VICR_IRQIF_PULSE   (2 << 18)	/* Pulse Generator */
+#define TSI148_LCSR_VICR_IRQIF_PROG    (3 << 18)	/* Programmable Clock */
+#define TSI148_LCSR_VICR_IRQIF_1U      (4 << 18)	/* 1us Clock */
 
-#define TSI148_LCSR_VICR_IRQ2F_M       (3<<16)	/* IRQ2* Function MASK */
+#define TSI148_LCSR_VICR_IRQ2F_M       (3 << 16)	/* IRQ2* Function MASK */
 #define TSI148_LCSR_VICR_IRQ2F_NORM    BIT(16)	/* Normal */
-#define TSI148_LCSR_VICR_IRQ2F_PULSE   (2<<16)	/* Pulse Generator */
-#define TSI148_LCSR_VICR_IRQ2F_PROG    (3<<16)	/* Programmable Clock */
-#define TSI148_LCSR_VICR_IRQ2F_1U      (4<<16)	/* 1us Clock */
+#define TSI148_LCSR_VICR_IRQ2F_PULSE   (2 << 16)	/* Pulse Generator */
+#define TSI148_LCSR_VICR_IRQ2F_PROG    (3 << 16)	/* Programmable Clock */
+#define TSI148_LCSR_VICR_IRQ2F_1U      (4 << 16)	/* 1us Clock */
 
 #define TSI148_LCSR_VICR_BIP           BIT(15)	/* Broadcast Interrupt Pulse */
 
 #define TSI148_LCSR_VICR_IRQC          BIT(12)	/* VMEbus IRQ Clear */
 #define TSI148_LCSR_VICR_IRQS          BIT(11)	/* VMEbus IRQ Status */
 
-#define TSI148_LCSR_VICR_IRQL_M        (7<<8)	/* VMEbus SW IRQ Level Mask */
+#define TSI148_LCSR_VICR_IRQL_M        (7 << 8)	/* VMEbus SW IRQ Level Mask */
 #define TSI148_LCSR_VICR_IRQL_1        BIT(8)	/* VMEbus SW IRQ Level 1 */
-#define TSI148_LCSR_VICR_IRQL_2        (2<<8)	/* VMEbus SW IRQ Level 2 */
-#define TSI148_LCSR_VICR_IRQL_3        (3<<8)	/* VMEbus SW IRQ Level 3 */
-#define TSI148_LCSR_VICR_IRQL_4        (4<<8)	/* VMEbus SW IRQ Level 4 */
-#define TSI148_LCSR_VICR_IRQL_5        (5<<8)	/* VMEbus SW IRQ Level 5 */
-#define TSI148_LCSR_VICR_IRQL_6        (6<<8)	/* VMEbus SW IRQ Level 6 */
-#define TSI148_LCSR_VICR_IRQL_7        (7<<8)	/* VMEbus SW IRQ Level 7 */
+#define TSI148_LCSR_VICR_IRQL_2        (2 << 8)	/* VMEbus SW IRQ Level 2 */
+#define TSI148_LCSR_VICR_IRQL_3        (3 << 8)	/* VMEbus SW IRQ Level 3 */
+#define TSI148_LCSR_VICR_IRQL_4        (4 << 8)	/* VMEbus SW IRQ Level 4 */
+#define TSI148_LCSR_VICR_IRQL_5        (5 << 8)	/* VMEbus SW IRQ Level 5 */
+#define TSI148_LCSR_VICR_IRQL_6        (6 << 8)	/* VMEbus SW IRQ Level 6 */
+#define TSI148_LCSR_VICR_IRQL_7        (7 << 8)	/* VMEbus SW IRQ Level 7 */
 
 static const int TSI148_LCSR_VICR_IRQL[8] = { 0, TSI148_LCSR_VICR_IRQL_1,
 			TSI148_LCSR_VICR_IRQL_2, TSI148_LCSR_VICR_IRQL_3,
 			TSI148_LCSR_VICR_IRQL_4, TSI148_LCSR_VICR_IRQL_5,
 			TSI148_LCSR_VICR_IRQL_6, TSI148_LCSR_VICR_IRQL_7 };
 
-#define TSI148_LCSR_VICR_STID_M        (0xFF<<0)	/* Status/ID Mask */
+#define TSI148_LCSR_VICR_STID_M        (0xFF << 0)	/* Status/ID Mask */
 
 /*
  *  Interrupt Enable Register   CRG + $440
@@ -1155,33 +1155,33 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 /*
  *  Interrupt Map Register 1 CRG + $458
  */
-#define TSI148_LCSR_INTM1_DMA1M_M      (3<<18)	/* DMA 1 */
-#define TSI148_LCSR_INTM1_DMA0M_M      (3<<16)	/* DMA 0 */
-#define TSI148_LCSR_INTM1_LM3M_M       (3<<14)	/* Location Monitor 3 */
-#define TSI148_LCSR_INTM1_LM2M_M       (3<<12)	/* Location Monitor 2 */
-#define TSI148_LCSR_INTM1_LM1M_M       (3<<10)	/* Location Monitor 1 */
-#define TSI148_LCSR_INTM1_LM0M_M       (3<<8)	/* Location Monitor 0 */
-#define TSI148_LCSR_INTM1_MB3M_M       (3<<6)	/* Mail Box 3 */
-#define TSI148_LCSR_INTM1_MB2M_M       (3<<4)	/* Mail Box 2 */
-#define TSI148_LCSR_INTM1_MB1M_M       (3<<2)	/* Mail Box 1 */
-#define TSI148_LCSR_INTM1_MB0M_M       (3<<0)	/* Mail Box 0 */
+#define TSI148_LCSR_INTM1_DMA1M_M      (3 << 18)	/* DMA 1 */
+#define TSI148_LCSR_INTM1_DMA0M_M      (3 << 16)	/* DMA 0 */
+#define TSI148_LCSR_INTM1_LM3M_M       (3 << 14)	/* Location Monitor 3 */
+#define TSI148_LCSR_INTM1_LM2M_M       (3 << 12)	/* Location Monitor 2 */
+#define TSI148_LCSR_INTM1_LM1M_M       (3 << 10)	/* Location Monitor 1 */
+#define TSI148_LCSR_INTM1_LM0M_M       (3 << 8)	/* Location Monitor 0 */
+#define TSI148_LCSR_INTM1_MB3M_M       (3 << 6)	/* Mail Box 3 */
+#define TSI148_LCSR_INTM1_MB2M_M       (3 << 4)	/* Mail Box 2 */
+#define TSI148_LCSR_INTM1_MB1M_M       (3 << 2)	/* Mail Box 1 */
+#define TSI148_LCSR_INTM1_MB0M_M       (3 << 0)	/* Mail Box 0 */
 
 /*
  *  Interrupt Map Register 2 CRG + $45C
  */
-#define TSI148_LCSR_INTM2_PERRM_M      (3<<26)	/* PCI Bus Error */
-#define TSI148_LCSR_INTM2_VERRM_M      (3<<24)	/* VMEbus Error */
-#define TSI148_LCSR_INTM2_VIEM_M       (3<<22)	/* VMEbus IRQ Edge */
-#define TSI148_LCSR_INTM2_IACKM_M      (3<<20)	/* IACK */
-#define TSI148_LCSR_INTM2_SYSFLM_M     (3<<18)	/* System Fail */
-#define TSI148_LCSR_INTM2_ACFLM_M      (3<<16)	/* AC Fail */
-#define TSI148_LCSR_INTM2_IRQ7M_M      (3<<14)	/* IRQ7 */
-#define TSI148_LCSR_INTM2_IRQ6M_M      (3<<12)	/* IRQ6 */
-#define TSI148_LCSR_INTM2_IRQ5M_M      (3<<10)	/* IRQ5 */
-#define TSI148_LCSR_INTM2_IRQ4M_M      (3<<8)	/* IRQ4 */
-#define TSI148_LCSR_INTM2_IRQ3M_M      (3<<6)	/* IRQ3 */
-#define TSI148_LCSR_INTM2_IRQ2M_M      (3<<4)	/* IRQ2 */
-#define TSI148_LCSR_INTM2_IRQ1M_M      (3<<2)	/* IRQ1 */
+#define TSI148_LCSR_INTM2_PERRM_M      (3 << 26)	/* PCI Bus Error */
+#define TSI148_LCSR_INTM2_VERRM_M      (3 << 24)	/* VMEbus Error */
+#define TSI148_LCSR_INTM2_VIEM_M       (3 << 22)	/* VMEbus IRQ Edge */
+#define TSI148_LCSR_INTM2_IACKM_M      (3 << 20)	/* IACK */
+#define TSI148_LCSR_INTM2_SYSFLM_M     (3 << 18)	/* System Fail */
+#define TSI148_LCSR_INTM2_ACFLM_M      (3 << 16)	/* AC Fail */
+#define TSI148_LCSR_INTM2_IRQ7M_M      (3 << 14)	/* IRQ7 */
+#define TSI148_LCSR_INTM2_IRQ6M_M      (3 << 12)	/* IRQ6 */
+#define TSI148_LCSR_INTM2_IRQ5M_M      (3 << 10)	/* IRQ5 */
+#define TSI148_LCSR_INTM2_IRQ4M_M      (3 << 8)	/* IRQ4 */
+#define TSI148_LCSR_INTM2_IRQ3M_M      (3 << 6)	/* IRQ3 */
+#define TSI148_LCSR_INTM2_IRQ2M_M      (3 << 4)	/* IRQ2 */
+#define TSI148_LCSR_INTM2_IRQ1M_M      (3 << 2)	/* IRQ1 */
 
 /*
  *  DMA Control (0-1) Registers CRG + $500
@@ -1192,45 +1192,45 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 
 #define TSI148_LCSR_DCTL_MOD           BIT(23)	/* Mode */
 
-#define TSI148_LCSR_DCTL_VBKS_M        (7<<12)	/* VMEbus block Size MASK */
-#define TSI148_LCSR_DCTL_VBKS_32       (0<<12)	/* VMEbus block Size 32 */
+#define TSI148_LCSR_DCTL_VBKS_M        (7 << 12)	/* VMEbus block Size MASK */
+#define TSI148_LCSR_DCTL_VBKS_32       (0 << 12)	/* VMEbus block Size 32 */
 #define TSI148_LCSR_DCTL_VBKS_64       BIT(12)	/* VMEbus block Size 64 */
-#define TSI148_LCSR_DCTL_VBKS_128      (2<<12)	/* VMEbus block Size 128 */
-#define TSI148_LCSR_DCTL_VBKS_256      (3<<12)	/* VMEbus block Size 256 */
-#define TSI148_LCSR_DCTL_VBKS_512      (4<<12)	/* VMEbus block Size 512 */
-#define TSI148_LCSR_DCTL_VBKS_1024     (5<<12)	/* VMEbus block Size 1024 */
-#define TSI148_LCSR_DCTL_VBKS_2048     (6<<12)	/* VMEbus block Size 2048 */
-#define TSI148_LCSR_DCTL_VBKS_4096     (7<<12)	/* VMEbus block Size 4096 */
-
-#define TSI148_LCSR_DCTL_VBOT_M        (7<<8)	/* VMEbus back-off MASK */
-#define TSI148_LCSR_DCTL_VBOT_0        (0<<8)	/* VMEbus back-off  0us */
+#define TSI148_LCSR_DCTL_VBKS_128      (2 << 12)	/* VMEbus block Size 128 */
+#define TSI148_LCSR_DCTL_VBKS_256      (3 << 12)	/* VMEbus block Size 256 */
+#define TSI148_LCSR_DCTL_VBKS_512      (4 << 12)	/* VMEbus block Size 512 */
+#define TSI148_LCSR_DCTL_VBKS_1024     (5 << 12)	/* VMEbus block Size 1024 */
+#define TSI148_LCSR_DCTL_VBKS_2048     (6 << 12)	/* VMEbus block Size 2048 */
+#define TSI148_LCSR_DCTL_VBKS_4096     (7 << 12)	/* VMEbus block Size 4096 */
+
+#define TSI148_LCSR_DCTL_VBOT_M        (7 << 8)	/* VMEbus back-off MASK */
+#define TSI148_LCSR_DCTL_VBOT_0        (0 << 8)	/* VMEbus back-off  0us */
 #define TSI148_LCSR_DCTL_VBOT_1        BIT(8)	/* VMEbus back-off 1us */
-#define TSI148_LCSR_DCTL_VBOT_2        (2<<8)	/* VMEbus back-off 2us */
-#define TSI148_LCSR_DCTL_VBOT_4        (3<<8)	/* VMEbus back-off 4us */
-#define TSI148_LCSR_DCTL_VBOT_8        (4<<8)	/* VMEbus back-off 8us */
-#define TSI148_LCSR_DCTL_VBOT_16       (5<<8)	/* VMEbus back-off 16us */
-#define TSI148_LCSR_DCTL_VBOT_32       (6<<8)	/* VMEbus back-off 32us */
-#define TSI148_LCSR_DCTL_VBOT_64       (7<<8)	/* VMEbus back-off 64us */
-
-#define TSI148_LCSR_DCTL_PBKS_M        (7<<4)	/* PCI block size MASK */
-#define TSI148_LCSR_DCTL_PBKS_32       (0<<4)	/* PCI block size 32 bytes */
+#define TSI148_LCSR_DCTL_VBOT_2        (2 << 8)	/* VMEbus back-off 2us */
+#define TSI148_LCSR_DCTL_VBOT_4        (3 << 8)	/* VMEbus back-off 4us */
+#define TSI148_LCSR_DCTL_VBOT_8        (4 << 8)	/* VMEbus back-off 8us */
+#define TSI148_LCSR_DCTL_VBOT_16       (5 << 8)	/* VMEbus back-off 16us */
+#define TSI148_LCSR_DCTL_VBOT_32       (6 << 8)	/* VMEbus back-off 32us */
+#define TSI148_LCSR_DCTL_VBOT_64       (7 << 8)	/* VMEbus back-off 64us */
+
+#define TSI148_LCSR_DCTL_PBKS_M        (7 << 4)	/* PCI block size MASK */
+#define TSI148_LCSR_DCTL_PBKS_32       (0 << 4)	/* PCI block size 32 bytes */
 #define TSI148_LCSR_DCTL_PBKS_64       BIT(4)	/* PCI block size 64 bytes */
-#define TSI148_LCSR_DCTL_PBKS_128      (2<<4)	/* PCI block size 128 bytes */
-#define TSI148_LCSR_DCTL_PBKS_256      (3<<4)	/* PCI block size 256 bytes */
-#define TSI148_LCSR_DCTL_PBKS_512      (4<<4)	/* PCI block size 512 bytes */
-#define TSI148_LCSR_DCTL_PBKS_1024     (5<<4)	/* PCI block size 1024 bytes */
-#define TSI148_LCSR_DCTL_PBKS_2048     (6<<4)	/* PCI block size 2048 bytes */
-#define TSI148_LCSR_DCTL_PBKS_4096     (7<<4)	/* PCI block size 4096 bytes */
-
-#define TSI148_LCSR_DCTL_PBOT_M        (7<<0)	/* PCI back off MASK */
-#define TSI148_LCSR_DCTL_PBOT_0        (0<<0)	/* PCI back off 0us */
+#define TSI148_LCSR_DCTL_PBKS_128      (2 << 4)	/* PCI block size 128 bytes */
+#define TSI148_LCSR_DCTL_PBKS_256      (3 << 4)	/* PCI block size 256 bytes */
+#define TSI148_LCSR_DCTL_PBKS_512      (4 << 4)	/* PCI block size 512 bytes */
+#define TSI148_LCSR_DCTL_PBKS_1024     (5 << 4)	/* PCI block size 1024 bytes */
+#define TSI148_LCSR_DCTL_PBKS_2048     (6 << 4)	/* PCI block size 2048 bytes */
+#define TSI148_LCSR_DCTL_PBKS_4096     (7 << 4)	/* PCI block size 4096 bytes */
+
+#define TSI148_LCSR_DCTL_PBOT_M        (7 << 0)	/* PCI back off MASK */
+#define TSI148_LCSR_DCTL_PBOT_0        (0 << 0)	/* PCI back off 0us */
 #define TSI148_LCSR_DCTL_PBOT_1        BIT(0)	/* PCI back off 1us */
-#define TSI148_LCSR_DCTL_PBOT_2        (2<<0)	/* PCI back off 2us */
-#define TSI148_LCSR_DCTL_PBOT_4        (3<<0)	/* PCI back off 3us */
-#define TSI148_LCSR_DCTL_PBOT_8        (4<<0)	/* PCI back off 4us */
-#define TSI148_LCSR_DCTL_PBOT_16       (5<<0)	/* PCI back off 8us */
-#define TSI148_LCSR_DCTL_PBOT_32       (6<<0)	/* PCI back off 16us */
-#define TSI148_LCSR_DCTL_PBOT_64       (7<<0)	/* PCI back off 32us */
+#define TSI148_LCSR_DCTL_PBOT_2        (2 << 0)	/* PCI back off 2us */
+#define TSI148_LCSR_DCTL_PBOT_4        (3 << 0)	/* PCI back off 3us */
+#define TSI148_LCSR_DCTL_PBOT_8        (4 << 0)	/* PCI back off 4us */
+#define TSI148_LCSR_DCTL_PBOT_16       (5 << 0)	/* PCI back off 8us */
+#define TSI148_LCSR_DCTL_PBOT_32       (6 << 0)	/* PCI back off 16us */
+#define TSI148_LCSR_DCTL_PBOT_64       (7 << 0)	/* PCI back off 32us */
 
 /*
  *  DMA Status Registers (0-1)  CRG + $504
@@ -1247,97 +1247,97 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 /*
  *  DMA Current Link Address Lower (0-1)
  */
-#define TSI148_LCSR_DCLAL_M            (0x3FFFFFF<<6)	/* Mask */
+#define TSI148_LCSR_DCLAL_M            (0x3FFFFFF << 6)	/* Mask */
 
 /*
  *  DMA Source Attribute (0-1) Reg
  */
-#define TSI148_LCSR_DSAT_TYP_M         (3<<28)	/* Source Bus Type */
-#define TSI148_LCSR_DSAT_TYP_PCI       (0<<28)	/* PCI Bus */
+#define TSI148_LCSR_DSAT_TYP_M         (3 << 28)	/* Source Bus Type */
+#define TSI148_LCSR_DSAT_TYP_PCI       (0 << 28)	/* PCI Bus */
 #define TSI148_LCSR_DSAT_TYP_VME       BIT(28)	/* VMEbus */
-#define TSI148_LCSR_DSAT_TYP_PAT       (2<<28)	/* Data Pattern */
+#define TSI148_LCSR_DSAT_TYP_PAT       (2 << 28)	/* Data Pattern */
 
 #define TSI148_LCSR_DSAT_PSZ           BIT(25)	/* Pattern Size */
 #define TSI148_LCSR_DSAT_NIN           BIT(24)	/* No Increment */
 
-#define TSI148_LCSR_DSAT_2eSSTM_M      (3<<11)	/* 2eSST Trans Rate Mask */
-#define TSI148_LCSR_DSAT_2eSSTM_160    (0<<11)	/* 160 MB/s */
+#define TSI148_LCSR_DSAT_2eSSTM_M      (3 << 11)	/* 2eSST Trans Rate Mask */
+#define TSI148_LCSR_DSAT_2eSSTM_160    (0 << 11)	/* 160 MB/s */
 #define TSI148_LCSR_DSAT_2eSSTM_267    BIT(11)	/* 267 MB/s */
-#define TSI148_LCSR_DSAT_2eSSTM_320    (2<<11)	/* 320 MB/s */
+#define TSI148_LCSR_DSAT_2eSSTM_320    (2 << 11)	/* 320 MB/s */
 
-#define TSI148_LCSR_DSAT_TM_M          (7<<8)	/* Bus Transfer Protocol Mask */
-#define TSI148_LCSR_DSAT_TM_SCT        (0<<8)	/* SCT */
+#define TSI148_LCSR_DSAT_TM_M          (7 << 8)	/* Bus Transfer Protocol Mask */
+#define TSI148_LCSR_DSAT_TM_SCT        (0 << 8)	/* SCT */
 #define TSI148_LCSR_DSAT_TM_BLT        BIT(8)	/* BLT */
-#define TSI148_LCSR_DSAT_TM_MBLT       (2<<8)	/* MBLT */
-#define TSI148_LCSR_DSAT_TM_2eVME      (3<<8)	/* 2eVME */
-#define TSI148_LCSR_DSAT_TM_2eSST      (4<<8)	/* 2eSST */
-#define TSI148_LCSR_DSAT_TM_2eSSTB     (5<<8)	/* 2eSST Broadcast */
+#define TSI148_LCSR_DSAT_TM_MBLT       (2 << 8)	/* MBLT */
+#define TSI148_LCSR_DSAT_TM_2eVME      (3 << 8)	/* 2eVME */
+#define TSI148_LCSR_DSAT_TM_2eSST      (4 << 8)	/* 2eSST */
+#define TSI148_LCSR_DSAT_TM_2eSSTB     (5 << 8)	/* 2eSST Broadcast */
 
-#define TSI148_LCSR_DSAT_DBW_M         (3<<6)	/* Max Data Width MASK */
-#define TSI148_LCSR_DSAT_DBW_16        (0<<6)	/* 16 Bits */
+#define TSI148_LCSR_DSAT_DBW_M         (3 << 6)	/* Max Data Width MASK */
+#define TSI148_LCSR_DSAT_DBW_16        (0 << 6)	/* 16 Bits */
 #define TSI148_LCSR_DSAT_DBW_32        BIT(6)	/* 32 Bits */
 
 #define TSI148_LCSR_DSAT_SUP           BIT(5)	/* Supervisory Mode */
 #define TSI148_LCSR_DSAT_PGM           BIT(4)	/* Program Mode */
 
-#define TSI148_LCSR_DSAT_AMODE_M       (0xf<<0)	/* Address Space Mask */
-#define TSI148_LCSR_DSAT_AMODE_A16     (0<<0)	/* A16 */
+#define TSI148_LCSR_DSAT_AMODE_M       (0xf << 0)	/* Address Space Mask */
+#define TSI148_LCSR_DSAT_AMODE_A16     (0 << 0)	/* A16 */
 #define TSI148_LCSR_DSAT_AMODE_A24     BIT(0)	/* A24 */
-#define TSI148_LCSR_DSAT_AMODE_A32     (2<<0)	/* A32 */
-#define TSI148_LCSR_DSAT_AMODE_A64     (4<<0)	/* A64 */
-#define TSI148_LCSR_DSAT_AMODE_CRCSR   (5<<0)	/* CR/CSR */
-#define TSI148_LCSR_DSAT_AMODE_USER1   (8<<0)	/* User1 */
-#define TSI148_LCSR_DSAT_AMODE_USER2   (9<<0)	/* User2 */
-#define TSI148_LCSR_DSAT_AMODE_USER3   (0xa<<0)	/* User3 */
-#define TSI148_LCSR_DSAT_AMODE_USER4   (0xb<<0)	/* User4 */
+#define TSI148_LCSR_DSAT_AMODE_A32     (2 << 0)	/* A32 */
+#define TSI148_LCSR_DSAT_AMODE_A64     (4 << 0)	/* A64 */
+#define TSI148_LCSR_DSAT_AMODE_CRCSR   (5 << 0)	/* CR/CSR */
+#define TSI148_LCSR_DSAT_AMODE_USER1   (8 << 0)	/* User1 */
+#define TSI148_LCSR_DSAT_AMODE_USER2   (9 << 0)	/* User2 */
+#define TSI148_LCSR_DSAT_AMODE_USER3   (0xa << 0)	/* User3 */
+#define TSI148_LCSR_DSAT_AMODE_USER4   (0xb << 0)	/* User4 */
 
 /*
  *  DMA Destination Attribute Registers (0-1)
  */
-#define TSI148_LCSR_DDAT_TYP_PCI       (0<<28)	/* Destination PCI Bus  */
+#define TSI148_LCSR_DDAT_TYP_PCI       (0 << 28)	/* Destination PCI Bus  */
 #define TSI148_LCSR_DDAT_TYP_VME       BIT(28)	/* Destination VMEbus */
 
-#define TSI148_LCSR_DDAT_2eSSTM_M      (3<<11)	/* 2eSST Transfer Rate Mask */
-#define TSI148_LCSR_DDAT_2eSSTM_160    (0<<11)	/* 160 MB/s */
+#define TSI148_LCSR_DDAT_2eSSTM_M      (3 << 11)	/* 2eSST Transfer Rate Mask */
+#define TSI148_LCSR_DDAT_2eSSTM_160    (0 << 11)	/* 160 MB/s */
 #define TSI148_LCSR_DDAT_2eSSTM_267    BIT(11)	/* 267 MB/s */
-#define TSI148_LCSR_DDAT_2eSSTM_320    (2<<11)	/* 320 MB/s */
+#define TSI148_LCSR_DDAT_2eSSTM_320    (2 << 11)	/* 320 MB/s */
 
-#define TSI148_LCSR_DDAT_TM_M          (7<<8)	/* Bus Transfer Protocol Mask */
-#define TSI148_LCSR_DDAT_TM_SCT        (0<<8)	/* SCT */
+#define TSI148_LCSR_DDAT_TM_M          (7 << 8)	/* Bus Transfer Protocol Mask */
+#define TSI148_LCSR_DDAT_TM_SCT        (0 << 8)	/* SCT */
 #define TSI148_LCSR_DDAT_TM_BLT        BIT(8)	/* BLT */
-#define TSI148_LCSR_DDAT_TM_MBLT       (2<<8)	/* MBLT */
-#define TSI148_LCSR_DDAT_TM_2eVME      (3<<8)	/* 2eVME */
-#define TSI148_LCSR_DDAT_TM_2eSST      (4<<8)	/* 2eSST */
-#define TSI148_LCSR_DDAT_TM_2eSSTB     (5<<8)	/* 2eSST Broadcast */
+#define TSI148_LCSR_DDAT_TM_MBLT       (2 << 8)	/* MBLT */
+#define TSI148_LCSR_DDAT_TM_2eVME      (3 << 8)	/* 2eVME */
+#define TSI148_LCSR_DDAT_TM_2eSST      (4 << 8)	/* 2eSST */
+#define TSI148_LCSR_DDAT_TM_2eSSTB     (5 << 8)	/* 2eSST Broadcast */
 
-#define TSI148_LCSR_DDAT_DBW_M         (3<<6)	/* Max Data Width MASK */
-#define TSI148_LCSR_DDAT_DBW_16        (0<<6)	/* 16 Bits */
+#define TSI148_LCSR_DDAT_DBW_M         (3 << 6)	/* Max Data Width MASK */
+#define TSI148_LCSR_DDAT_DBW_16        (0 << 6)	/* 16 Bits */
 #define TSI148_LCSR_DDAT_DBW_32        BIT(6)	/* 32 Bits */
 
 #define TSI148_LCSR_DDAT_SUP           BIT(5)	/* Supervisory/User Access */
 #define TSI148_LCSR_DDAT_PGM           BIT(4)	/* Program/Data Access */
 
-#define TSI148_LCSR_DDAT_AMODE_M       (0xf<<0)	/* Address Space Mask */
-#define TSI148_LCSR_DDAT_AMODE_A16      (0<<0)	/* A16 */
+#define TSI148_LCSR_DDAT_AMODE_M       (0xf << 0)	/* Address Space Mask */
+#define TSI148_LCSR_DDAT_AMODE_A16      (0 << 0)	/* A16 */
 #define TSI148_LCSR_DDAT_AMODE_A24      BIT(0)	/* A24 */
-#define TSI148_LCSR_DDAT_AMODE_A32      (2<<0)	/* A32 */
-#define TSI148_LCSR_DDAT_AMODE_A64      (4<<0)	/* A64 */
-#define TSI148_LCSR_DDAT_AMODE_CRCSR   (5<<0)	/* CRC/SR */
-#define TSI148_LCSR_DDAT_AMODE_USER1   (8<<0)	/* User1 */
-#define TSI148_LCSR_DDAT_AMODE_USER2   (9<<0)	/* User2 */
-#define TSI148_LCSR_DDAT_AMODE_USER3   (0xa<<0)	/* User3 */
-#define TSI148_LCSR_DDAT_AMODE_USER4   (0xb<<0)	/* User4 */
+#define TSI148_LCSR_DDAT_AMODE_A32      (2 << 0)	/* A32 */
+#define TSI148_LCSR_DDAT_AMODE_A64      (4 << 0)	/* A64 */
+#define TSI148_LCSR_DDAT_AMODE_CRCSR   (5 << 0)	/* CRC/SR */
+#define TSI148_LCSR_DDAT_AMODE_USER1   (8 << 0)	/* User1 */
+#define TSI148_LCSR_DDAT_AMODE_USER2   (9 << 0)	/* User2 */
+#define TSI148_LCSR_DDAT_AMODE_USER3   (0xa << 0)	/* User3 */
+#define TSI148_LCSR_DDAT_AMODE_USER4   (0xb << 0)	/* User4 */
 
 /*
  *  DMA Next Link Address Lower
  */
-#define TSI148_LCSR_DNLAL_DNLAL_M      (0x3FFFFFF<<6)	/* Address Mask */
+#define TSI148_LCSR_DNLAL_DNLAL_M      (0x3FFFFFF << 6)	/* Address Mask */
 #define TSI148_LCSR_DNLAL_LLA          BIT(0)  /* Last Link Address Indicator */
 
 /*
  *  DMA 2eSST Broadcast Select
  */
-#define TSI148_LCSR_DBS_M              (0x1FFFFF<<0)	/* Mask */
+#define TSI148_LCSR_DBS_M              (0x1FFFFF << 0)	/* Mask */
 
 /*
  *  GCSR Register Group
@@ -1362,7 +1362,7 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 #define TSI148_GCSR_GCTRL_MBI0S        BIT(0)	/* Mail box 0 Int Status */
 
 #define TSI148_GCSR_GAP                BIT(5)	/* Geographic Addr Parity */
-#define TSI148_GCSR_GA_M               (0x1F<<0)  /* Geographic Address Mask */
+#define TSI148_GCSR_GA_M               (0x1F << 0)  /* Geographic Address Mask */
 
 /*
  *  CR/CSR Register Group
@@ -1389,6 +1389,6 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 /*
  *  CR/CSR Base Address Register CRG + FFC
  */
-#define TSI148_CRCSR_CBAR_M            (0x1F<<3)	/* Mask */
+#define TSI148_CRCSR_CBAR_M            (0x1F << 3)	/* Mask */
 
 #endif				/* TSI148_H */
-- 
2.42.0

