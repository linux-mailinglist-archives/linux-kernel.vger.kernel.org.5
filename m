Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BB680BEF1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjLKCMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKCMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:12:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46609F2;
        Sun, 10 Dec 2023 18:12:39 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SpQHh2tXlzsRs5;
        Mon, 11 Dec 2023 10:12:32 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
        by mail.maildlp.com (Postfix) with ESMTPS id 2C96C1800B8;
        Mon, 11 Dec 2023 10:12:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:12:36 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/6] There are some features for the HNS3 ethernet driver
Date:   Mon, 11 Dec 2023 10:08:10 +0800
Message-ID: <20231211020816.69434-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some features for the HNS3 ethernet driver

Hao Lan (3):
  net: hns3: add command queue trace for hns3
  net: hns3: Add support for some CMIS transceiver modules
  net: sfp: Synchronize some CMIS transceiver modules from ethtool

Jian Shen (1):
  net: hns3: add support for page_pool_get_stats

Jijie Shao (1):
  net: hns3: support dump pfc frame statistics in tx timeout log

Peiyang Wang (1):
  net: hns3: dump more reg info based on ras mod

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   6 +
 .../hns3/hns3_common/hclge_comm_cmd.c         |  19 +
 .../hns3/hns3_common/hclge_comm_cmd.h         |  16 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  11 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |   1 +
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  46 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.h    |   2 +
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |   6 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.h     |   3 +
 .../hisilicon/hns3/hns3pf/hclge_err.c         | 434 +++++++++++++++++-
 .../hisilicon/hns3/hns3pf/hclge_err.h         |  36 ++
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  47 ++
 .../hisilicon/hns3/hns3pf/hclge_trace.h       |  94 ++++
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  40 ++
 .../hisilicon/hns3/hns3vf/hclgevf_trace.h     |  50 ++
 include/linux/sfp.h                           |  12 +
 16 files changed, 811 insertions(+), 12 deletions(-)

-- 
2.30.0

