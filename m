Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A350B800919
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378375AbjLAKxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378355AbjLAKw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:52:56 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27EA10E2;
        Fri,  1 Dec 2023 02:53:00 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B1AqFaO5299708, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B1AqFaO5299708
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Dec 2023 18:52:15 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 1 Dec 2023 18:52:15 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Dec 2023 18:52:14 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Fri, 1 Dec 2023 18:52:14 +0800
From:   Tzuyi Chang <tychang@realtek.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stanley Chang <stanley_chang@realtek.com>,
        Tzuyi Chang <tychang@realtek.com>
Subject: [PATCH 0/2] Add PCIe PHY driver support for Realtek DHC SoCs
Date:   Fri, 1 Dec 2023 18:52:05 +0800
Message-ID: <20231201105207.11786-1-tychang@realtek.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add the bindings and the PCIe phy driver for Realtek
DHC(Digital Home Center) RTD SoCs(RTD1319, RTD1619B, RTD1319D and RTD1315E).

Tzuyi Chang (2):
  dt-bindings: phy: realtek: Add Realtek DHC RTD SoC PCIe PHY
  phy: realtek: pcie: Add PCIe PHY support for Realtek DHC RTD SoCs

 .../bindings/phy/realtek,rtd-pcie-phy.yaml    |  61 ++
 drivers/phy/realtek/Kconfig                   |   8 +
 drivers/phy/realtek/Makefile                  |   1 +
 drivers/phy/realtek/phy-rtk-pcie.c            | 738 ++++++++++++++++++
 4 files changed, 808 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/realtek,rtd-pcie-phy.yaml
 create mode 100644 drivers/phy/realtek/phy-rtk-pcie.c

-- 
2.43.0

