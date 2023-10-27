Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168B47D8F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbjJ0HQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345406AbjJ0HQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:16:26 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E25BD5F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:16:17 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 39R7EkGw002735;
        Fri, 27 Oct 2023 15:14:46 +0800 (+08)
        (envelope-from linhua.xu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SGv201Kygz2L6nms;
        Fri, 27 Oct 2023 15:10:16 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 27 Oct
 2023 15:14:45 +0800
From:   Linhua Xu <Linhua.xu@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lh xu <xulh0829@gmail.com>, Linhua Xu <Linhua.Xu@unisoc.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: [PATCH V3 0/6] pinctrl: sprd: Modification of UNIOC Platform pinctrl Driver
Date:   Fri, 27 Oct 2023 15:14:20 +0800
Message-ID: <20231027071426.17724-1-Linhua.xu@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL: SHSQR01.spreadtrum.com 39R7EkGw002735
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linhua Xu <Linhua.Xu@unisoc.com>

Recently, some bugs have been discovered during use, and patch1 and patch2
are bug fixes. Also, this patchset add new features: patch3 is for
compatibility with more platforms, patch4 Increase the range of register values,
patch5 add pinctrl support for UMS512, patch6 add pinctrl support for UMS9621.

change in V3
-Add platform structure
-Add the mask definition
-Modify register definition format
-Improve code readability
-Add fixes tag

Linhua Xu (6):
  pinctrl: sprd: Modify pull-up parameters
  pinctrl: sprd: Fix the incorrect mask and shift definition
  pinctrl: sprd: Move common and misc offset parameters to private data
  pinctrl: sprd: Increase the range of register values
  pinctrl: sprd: Add pinctrl support for UMS512
  pinctrl: sprd: Add pinctrl support for UMS9621

 drivers/pinctrl/sprd/Kconfig                |   22 +
 drivers/pinctrl/sprd/Makefile               |    2 +
 drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c  |   12 +-
 drivers/pinctrl/sprd/pinctrl-sprd-ums512.c  |  881 +++++++++++++++
 drivers/pinctrl/sprd/pinctrl-sprd-ums9621.c | 1120 +++++++++++++++++++
 drivers/pinctrl/sprd/pinctrl-sprd.c         |   35 +-
 drivers/pinctrl/sprd/pinctrl-sprd.h         |   49 +-
 7 files changed, 2087 insertions(+), 34 deletions(-)
 create mode 100644 drivers/pinctrl/sprd/pinctrl-sprd-ums512.c
 create mode 100644 drivers/pinctrl/sprd/pinctrl-sprd-ums9621.c

-- 
2.17.1

