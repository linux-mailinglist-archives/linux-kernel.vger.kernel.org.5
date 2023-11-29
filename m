Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10F47FCD9B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376827AbjK2Dth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjK2Dtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:49:35 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935B4100;
        Tue, 28 Nov 2023 19:49:39 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AT3nGJx92515549, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AT3nGJx92515549
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 11:49:17 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Wed, 29 Nov 2023 11:49:16 +0800
Received: from localhost (172.22.81.102) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Wed, 29 Nov
 2023 11:49:16 +0800
From:   Ricky Wu <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <frank.li@vivo.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-mmc@vger.kernel.org>
CC:     <ricky_wu@realtek.com>
Subject: [PATCH v6 0/3] Support new card reader rts5264
Date:   Wed, 29 Nov 2023 11:48:53 +0800
Message-ID: <20231129034856.2001223-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.22.81.102]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary
=======
This series adds to support New card reader rts5264
patch#1 
Going to have new files to define rts5264 funtions, 
and rts5264 register definition
patch#2 
Add rts5264 to rtsx_pcr driver
patch#3   
This new reader rts5264 can support sd express card
so need add the id to ths sd_init flow of rtsx_sdmmc  

Patch structure
===============
v5->v6:
add more description for individual patches  

v4->v5:
add summary for this series

v3->v4:
split new definition part up from same patch 

v2->v3:
split misc part and mmc part

v1->v2:
remove ic version check for rts5264

Ricky Wu(3):
 misc: rtsx: add to support new card reader rts5264 new
 definition and function
 misc: rtsx: add to support new card reader rts5264
 mmc: rtsx: add rts5264 to support sd express card

 drivers/misc/cardreader/Makefile   |   2 +-
 drivers/misc/cardreader/rts5264.c  | 886 +++++++++++++++++++++++++++++
 drivers/misc/cardreader/rts5264.h  | 278 +++++++++
 drivers/misc/cardreader/rtsx_pcr.c |  30 +-
 drivers/misc/cardreader/rtsx_pcr.h |   1 +
 drivers/mmc/host/rtsx_pci_sdmmc.c  |  17 +-
 include/linux/rtsx_pci.h           |   8 +
 7 files changed, 1215 insertions(+), 7 deletions(-)
 create mode 100644 drivers/misc/cardreader/rts5264.c
 create mode 100644 drivers/misc/cardreader/rts5264.h


-- 
2.25.1
