Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A427D2916
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjJWDar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjJWDaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:30:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADC910C8;
        Sun, 22 Oct 2023 20:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698031811; x=1729567811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TzAs4WqG+fJiSTBAokWdOF+N9p7/TQYUdpoHehE7fZ8=;
  b=XD3gMSF+6qfwW3ICwuGTPAi3HBXvqbbhD/fBIihhu1me1AfVH0cpkRkd
   qQwtxf9GDrTuqt3sdD+XJ8UGwNJyxr+wep6XZSGrLA9YMxIZNDKMxviHb
   udH+lMqhhwzSL1dA996J8rTV/raKPGAoOSY78khmGbQg5s9+KXGWulXD2
   uODdYxiTxg1cVuBmjz7LZWhA3dNTjnb8W1sEorVHbASNnZgvP/8aswept
   AM9mJZL+fIaVa/q204GzfwDNlxUMkae5nrmYRYP5vE7Im0XXmSz/YdyJ7
   lMaQOOaDXvrPisjqpzH9LHgxpsWXqAaEr2DR5lIOrxWW5LC52X7ueuiYy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="5380104"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5380104"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 20:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="881617666"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="881617666"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 22 Oct 2023 20:30:08 -0700
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     gregkh@linuxfoundation.org
Cc:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yilun.xu@intel.com
Subject: [RESEND PATCH 0/2] FPGA Remaining fix patches for 6.6-final
Date:   Mon, 23 Oct 2023 11:28:55 +0800
Message-Id: <20231023032857.902699-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg:

We have settled the issue of some patches in FPGA pull request for
6.6-final.
https://lore.kernel.org/all/2023101924-hunk-conjuror-2d35@gregkh/

There are 2 more patches which seem OK but not get pulled in this pull
request.
https://lore.kernel.org/all/2023101730-budding-spree-1471@gregkh/

Could you help review and merge?

Jinjie Ruan (1):
  fpga: Fix memory leak for fpga_region_test_class_find()

Russ Weight (1):
  fpga: m10bmc-sec: Change contact for secure update driver

 .../testing/sysfs-driver-intel-m10-bmc-sec-update  | 14 +++++++-------
 MAINTAINERS                                        |  2 +-
 drivers/fpga/tests/fpga-region-test.c              |  2 ++
 3 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.25.1

