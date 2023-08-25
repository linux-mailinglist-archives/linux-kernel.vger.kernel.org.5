Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F336D787E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbjHYDgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbjHYDfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:35:48 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29FDE54
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 20:35:45 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37P3YfPT054644;
        Fri, 25 Aug 2023 11:34:41 +0800 (+08)
        (envelope-from linhua.xu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RX59V1gp6z2QTWfr;
        Fri, 25 Aug 2023 11:32:14 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 25 Aug
 2023 11:34:40 +0800
From:   Linhua Xu <Linhua.xu@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lh xu <xulh0829@gmail.com>, Linhua Xu <Linhua.Xu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: [PATCH 0/6] pinctrl: sprd: Modification of UNIOC Platform pinctrl Driver
Date:   Fri, 25 Aug 2023 11:18:20 +0800
Message-ID: <20230825031826.31599-1-Linhua.xu@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL: SHSQR01.spreadtrum.com 37P3YfPT054644
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
for UMS9230.

Linhua Xu (6):
  pinctrl: sprd: Modify the probe function parameters
  pinctrl: sprd: Fix the incorrect mask and shift definition
  pinctrl: sprd: Modify pull-up parameters
  pinctrl: sprd: Add pinctrl support for UMS512
  pinctrl: sprd: Increase the range of register values
  pinctrl: sprd: Add pinctrl support for UMS9621

 drivers/pinctrl/sprd/Kconfig                |   24 +
 drivers/pinctrl/sprd/Makefile               |    2 +
 drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c  |    7 +-
 drivers/pinctrl/sprd/pinctrl-sprd-ums512.c  |  880 +++++++++++++++
 drivers/pinctrl/sprd/pinctrl-sprd-ums9621.c | 1119 +++++++++++++++++++
 drivers/pinctrl/sprd/pinctrl-sprd.c         |   65 +-
 drivers/pinctrl/sprd/pinctrl-sprd.h         |   15 +-
 7 files changed, 2074 insertions(+), 38 deletions(-)
 create mode 100644 drivers/pinctrl/sprd/pinctrl-sprd-ums512.c
 create mode 100644 drivers/pinctrl/sprd/pinctrl-sprd-ums9621.c

-- 
2.17.1

