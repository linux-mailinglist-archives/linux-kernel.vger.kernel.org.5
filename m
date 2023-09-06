Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2B5793624
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjIFHYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjIFHX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:23:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC60E41;
        Wed,  6 Sep 2023 00:23:55 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RgYhD2VlCzTlP8;
        Wed,  6 Sep 2023 15:21:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 15:23:52 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/7] There are some bugfix for the HNS3 ethernet driver
Date:   Wed, 6 Sep 2023 15:20:11 +0800
Message-ID: <20230906072018.3020671-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some bugfix for the HNS3 ethernet driver

Hao Chen (2):
  net: hns3: fix byte order conversion issue in hclge_dbg_fd_tcam_read()
  net: hns3: fix debugfs concurrency issue between kfree buffer and read

Jian Shen (1):
  net: hns3: fix tx timeout issue

Jie Wang (1):
  net: hns3: remove GSO partial feature bit

Jijie Shao (2):
  net: hns3: Support query tx timeout threshold by debugfs
  net: hns3: fix invalid mutex between tc qdisc and dcb ets command
    issue

Yisen Zhuang (1):
  net: hns3: fix the port information display when sfp is absent

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  1 +
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 11 +++++++---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 19 +++++++++++-------
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  4 +++-
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         | 20 +++++--------------
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 14 ++++++-------
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  5 +++--
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  2 --
 8 files changed, 39 insertions(+), 37 deletions(-)

-- 
2.30.0

