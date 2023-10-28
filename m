Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA507DA4F0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 05:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjJ1DCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 23:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjJ1DCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 23:02:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39410106;
        Fri, 27 Oct 2023 20:02:38 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SHPQN403fz1L9GV;
        Sat, 28 Oct 2023 10:59:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 28 Oct 2023 11:02:35 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/7] There are some bugfix for the HNS3 ethernet driver
Date:   Sat, 28 Oct 2023 10:59:10 +0800
Message-ID: <20231028025917.314305-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)
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

Jian Shen (2):
  net: hns3: fix add VLAN fail issue
  net: hns3: fix incorrect capability bit display for copper port

Jijie Shao (2):
  net: hns3: fix VF reset fail issue
  net: hns3: fix VF wrong speed and duplex issue

Yonglong Liu (3):
  net: hns3: add barrier in vf mailbox reply process
  net: hns3: fix out-of-bounds access may occur when coalesce info is
    read via debugfs
  net: hns3: fix variable may not initialized problem in
    hns3_init_mac_addr()

 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  9 ++++---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  2 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 26 ++++++++++++++-----
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 24 +++++++++++++----
 .../hisilicon/hns3/hns3vf/hclgevf_mbx.c       |  7 +++++
 5 files changed, 53 insertions(+), 15 deletions(-)

-- 
2.30.0

