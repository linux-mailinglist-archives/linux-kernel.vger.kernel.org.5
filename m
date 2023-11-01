Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6B47DDC74
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376573AbjKAFpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 01:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345134AbjKAFps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 01:45:48 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FD2DF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 22:45:44 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3A15ih0A023577;
        Wed, 1 Nov 2023 13:44:43 +0800 (+08)
        (envelope-from pu.li@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SKwnb0BfKz2LjbCt;
        Wed,  1 Nov 2023 13:40:03 +0800 (CST)
Received: from zebjkernups01.spreadtrum.com (10.0.93.153) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 1 Nov 2023 13:44:41 +0800
From:   Pu Li <pu.li@unisoc.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Pu Li <pu.li@unisoc.com>, Zhiyong Liu <zhiyong.liu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] phy: sprd: Add Spreadtrum USB20 HSPHY Driver
Date:   Wed, 1 Nov 2023 13:44:30 +0800
Message-ID: <20231101054432.27509-1-pu.li@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.93.153]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 3A15ih0A023577
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is used to add spreadtrum usb20 high speed phy driver. Patch 1
is dt-binding Documentation supports, and patch 2 is the specific implementation.

Pu Li (2):
  dt-bindings: phy: Add Spreadtrum usb20 hsphy yaml
  phy: sprd: Add Spreadtrum usb20 hsphy driver

 .../bindings/phy/phy-sprd-usb20-hs.yaml       |   70 +
 drivers/phy/Kconfig                           |    1 +
 drivers/phy/Makefile                          |    1 +
 drivers/phy/sprd/Kconfig                      |   14 +
 drivers/phy/sprd/Makefile                     |    6 +
 drivers/phy/sprd/phy-sprd-usb20-hs.c          | 1324 +++++++++++++++++
 drivers/phy/sprd/phy-sprd-usb20-hs.h          |  525 +++++++
 7 files changed, 1941 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-sprd-usb20-hs.yaml
 create mode 100644 drivers/phy/sprd/Kconfig
 create mode 100644 drivers/phy/sprd/Makefile
 create mode 100644 drivers/phy/sprd/phy-sprd-usb20-hs.c
 create mode 100644 drivers/phy/sprd/phy-sprd-usb20-hs.h

-- 
2.17.1

