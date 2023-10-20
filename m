Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7A77D072B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346977AbjJTDut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346903AbjJTDuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:50:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBA31B8;
        Thu, 19 Oct 2023 20:50:43 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39K3nQAt93723184, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39K3nQAt93723184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 11:49:26 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 20 Oct 2023 11:49:27 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Oct 2023 11:49:26 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Fri, 20 Oct 2023 11:49:26 +0800
From:   Jyan Chou <jyanchou@realtek.com>
To:     <adrian.hunter@intel.com>, <jh80.chung@samsung.com>,
        <ulf.hansson@linaro.org>
CC:     <riteshh@codeaurora.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <asutoshd@codeaurora.org>, <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <briannorris@chromium.org>, <doug@schmorgal.com>,
        <tonyhuang.sunplus@gmail.com>, <abel.vesa@linaro.org>,
        <william.qiu@starfivetech.com>, <jyanchou@realtek.com>
Subject: [PATCH V2][0/4] Add DesignWare Mobile mmc driver
Date:   Fri, 20 Oct 2023 11:49:17 +0800
Message-ID: <20231020034921.1179-1-jyanchou@realtek.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-KSE-ServerInfo: RTEXMBS05.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
  dt-bindings: mmc: Add dt-bindings for realtek mmc driver

 .../bindings/mmc/realtek-dw-mshc.yaml         |  150 ++
 drivers/mmc/host/Kconfig                      |   22 +
 drivers/mmc/host/Makefile                     |    2 +
 drivers/mmc/host/cqhci-core.c                 |    8 +-
 drivers/mmc/host/cqhci.h                      |    5 +
 drivers/mmc/host/dw_mmc_cqe-rtk.c             |  992 ++++++++++
 drivers/mmc/host/dw_mmc_cqe-rtk.h             |  160 ++
 drivers/mmc/host/dw_mmc_cqe.c                 | 1610 +++++++++++++++++
 drivers/mmc/host/dw_mmc_cqe.h                 |  445 +++++
 9 files changed, 3393 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml
 create mode 100644 drivers/mmc/host/dw_mmc_cqe-rtk.c
 create mode 100644 drivers/mmc/host/dw_mmc_cqe-rtk.h
 create mode 100644 drivers/mmc/host/dw_mmc_cqe.c
 create mode 100644 drivers/mmc/host/dw_mmc_cqe.h

-- 
2.42.0

