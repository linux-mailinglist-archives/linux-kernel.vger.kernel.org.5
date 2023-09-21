Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F597A98BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjIURwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjIURv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:51:29 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18893580A6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:19:08 -0700 (PDT)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.spreadtrum.com with ESMTP id 38L92CuP067165
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:02:12 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 38L90WHA060983;
        Thu, 21 Sep 2023 17:00:32 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Rrq5z5VLxz2SZykd;
        Thu, 21 Sep 2023 16:57:11 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 21 Sep
 2023 17:00:30 +0800
From:   Wenhua Lin <Wenhua.Lin@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: [PATCH V2 0/4] gpio: sprd: Modification of UNISOC Platform EIC Driver
Date:   Thu, 21 Sep 2023 17:00:23 +0800
Message-ID: <20230921090027.11136-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 38L90WHA060983
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, some bugs have been discovered during use, and patch1
and patch2 are bug fixes. Also, this patchset add optimization:
patch3 optimization the calculation method of eic number,
and patch4 Support 8 banks EIC controller.

Change in V2:
-Using thread send 4 patches 

-The dbnc of the title is changed to debounce in PATCH 1/4.
-Add Fixes tag in PATCH 1/4.

-Change commit message and title in PATCH 2/4.

-Change commit message in PATCH 3/4.
-Remove modifications to SPRD_EIC_MAX_BANK macro in PATCH 3/4.
-Remove modifications to fallthrough in PATCH 3/4.
-Add Fixes tag in PATCH 3/4.

-PATCH 3/4 macro modify split into a separate patch in PATCH 4/4.
-Change related comments in PATCH 4/4.

Wenhua Lin (4):
  gpio: sprd: In the sleep state, the eic debounce clk must be forced
    open
  gpio: sprd: Clear interrupt after set the interrupt type
  gpio: sprd: Modify the calculation method of eic number
  gpio: sprd: Support 8 banks EIC controller

 drivers/gpio/gpio-eic-sprd.c | 63 ++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 25 deletions(-)

-- 
2.17.1

