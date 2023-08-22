Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70D2783B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjHVHw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjHVHwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:52:23 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCBA19F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:52:20 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37M7pVnN026078;
        Tue, 22 Aug 2023 15:51:31 +0800 (+08)
        (envelope-from Jiansheng.Wu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RVM1K67Znz2QDlXq;
        Tue, 22 Aug 2023 15:49:09 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 22 Aug
 2023 15:51:29 +0800
From:   Jiansheng Wu <jiansheng.wu@unisoc.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yongzhi.chen@unisoc.com>, <xiaoqing.wu@unisoc.com>,
        <jinfeng.lin1@unisoc.com>, <jianshengwu16@gmail.com>
Subject: [PATCH 0/2] Add PMICs support for UMS9621 SoC
Date:   Tue, 22 Aug 2023 15:51:11 +0800
Message-ID: <20230822075113.25506-1-jiansheng.wu@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37M7pVnN026078
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1, bindings: Convert sprd spi bindings to yaml and add UMP962x PMICs.
Patch 2, mfd: Add PMICs support for UMS9621 SoC.

Jiansheng Wu (2):
  dt-bindings: spi: Convert sprd spi bindings to yaml
  mfd: sprd-sc27xx-spi: Add PMICs support for UMS9621 SoC

 .../bindings/mfd/sprd,sc27xx-pmic.txt         |  40 -------
 .../bindings/mfd/sprd,sc27xx-pmic.yaml        |  84 ++++++++++++++
 drivers/mfd/sprd-sc27xx-spi.c                 | 104 +++++++++++++-----
 3 files changed, 161 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.yaml

-- 
2.17.1

