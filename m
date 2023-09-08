Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D851D7981A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbjIHFwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbjIHFwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:52:51 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE4B19BA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 22:52:47 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3885q0fb009890;
        Fri, 8 Sep 2023 13:52:00 +0800 (+08)
        (envelope-from linhua.xu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RhlXx5j1rz2Rb6KB;
        Fri,  8 Sep 2023 13:49:05 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 8 Sep
 2023 13:51:58 +0800
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
Subject: [PATCH V2 0/6] pinctrl: sprd: Modification of UNIOC Platform pinctrl Driver
Date:   Fri, 8 Sep 2023 13:51:40 +0800
Message-ID: <20230908055146.18347-1-Linhua.xu@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL: SHSQR01.spreadtrum.com 3885q0fb009890
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linhua Xu <Linhua.Xu@unisoc.com>

Recently, some bugs have been discovered during use, and patch2 and patch3
are bug fixes. Also, this patchset add new features: patch1 is for
compatibility with more platforms, patch4 add pinctrl support for UMS512,
patch5 Increase the range of register values, patch6 add pinctrl support
for UMS9621.

change in V2
-Add comment for common_pin_offset and misc_pin_offset
-Remove cast commits
-Modify the mask definition into GENMASK form
-Delete the three-speed configuration that modifies the original parameters
-Add 1.8K resistor configuration
-Delete depends on OF
-Modify the format of sprd_pinctrl_of_match
-Drop trailing comma in the terminator entry
-Add bits.h header file
-Add kernel.h header file

Linhua Xu (6):
  pinctrl: sprd: Modify the probe function parameters
  pinctrl: sprd: Fix the incorrect mask and shift definition
  pinctrl: sprd: Modify pull-up parameters
  pinctrl: sprd: Add pinctrl support for UMS512
  pinctrl: sprd: Increase the range of register values
  pinctrl: sprd: Add pinctrl support for UMS9621

 drivers/pinctrl/sprd/Kconfig                |   22 +
 drivers/pinctrl/sprd/Makefile               |    2 +
 drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c  |    7 +-
 drivers/pinctrl/sprd/pinctrl-sprd-ums512.c  |  878 +++++++++++++++
 drivers/pinctrl/sprd/pinctrl-sprd-ums9621.c | 1117 +++++++++++++++++++
 drivers/pinctrl/sprd/pinctrl-sprd.c         |   49 +-
 drivers/pinctrl/sprd/pinctrl-sprd.h         |   33 +-
 7 files changed, 2071 insertions(+), 37 deletions(-)
 create mode 100644 drivers/pinctrl/sprd/pinctrl-sprd-ums512.c
 create mode 100644 drivers/pinctrl/sprd/pinctrl-sprd-ums9621.c

-- 
2.17.1

