Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFDC7CD3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbjJRFxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJRFxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:53:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2F2C4;
        Tue, 17 Oct 2023 22:53:42 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39I5rTbP51104474, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39I5rTbP51104474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 13:53:29 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 18 Oct 2023 13:53:29 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 18 Oct 2023 13:53:29 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 18 Oct 2023 13:53:29 +0800
From:   Jyan Chou <jyanchou@realtek.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <jh80.chung@samsung.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <benchuanggli@gmail.com>, <jyanchou@realtek.com>
Subject: [PATCH V2][0/4] Add DesignWare Mobile mmc driver
Date:   Wed, 18 Oct 2023 13:53:20 +0800
Message-ID: <20231018055326.18256-1-jyanchou@realtek.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We added Synopsys DesignWare mmc cmdq driver and also added
Realtek mmc driver to make good use of it.

Jyan Chou (4):
  mmc: solve DMA boundary limitation of CQHCI driver
  mmc: Add Synopsys DesignWare mmc cmdq host driver
  mmc: Add dw mobile mmc cmdq rtk driver
  mmc: Add dt-bindings for realtek mmc driver

 .../bindings/mmc/realtek-dw-mshc.yaml         |  119 ++
 drivers/mmc/host/Kconfig                      |   22 +
 drivers/mmc/host/Makefile                     |    2 +
 drivers/mmc/host/cqhci-core.c                 |    8 +-
 drivers/mmc/host/cqhci.h                      |    2 +
 drivers/mmc/host/dw_mmc_cqe-rtk.c             |  998 ++++++++++
 drivers/mmc/host/dw_mmc_cqe-rtk.h             |  159 ++
 drivers/mmc/host/dw_mmc_cqe.c                 | 1619 +++++++++++++++++
 drivers/mmc/host/dw_mmc_cqe.h                 |  444 +++++
 9 files changed, 3372 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml
 create mode 100644 drivers/mmc/host/dw_mmc_cqe-rtk.c
 create mode 100644 drivers/mmc/host/dw_mmc_cqe-rtk.h
 create mode 100644 drivers/mmc/host/dw_mmc_cqe.c
 create mode 100644 drivers/mmc/host/dw_mmc_cqe.h

-- 
2.42.0

