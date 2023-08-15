Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5194477C787
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjHOGMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjHOGLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:11:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32341BD7;
        Mon, 14 Aug 2023 23:11:50 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQ18k0tQ2z1GDRF;
        Tue, 15 Aug 2023 14:10:30 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 14:11:48 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/4] refactor registers information for ethtool -d
Date:   Tue, 15 Aug 2023 14:06:37 +0800
Message-ID: <20230815060641.3551665-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refactor registers information for ethtool -d

Jijie Shao (4):
  net: hns3: move dump regs function to a separate file
  net: hns3: Support tlv in regs data for HNS3 PF driver
  net: hns3: Support tlv in regs data for HNS3 VF driver
  net: hns3: fix wrong rpu tln reg issue

 drivers/net/ethernet/hisilicon/hns3/Makefile  |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   1 +
 .../hisilicon/hns3/hns3pf/hclge_cmd.h         |   4 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |   1 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 560 +--------------
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   2 -
 .../hisilicon/hns3/hns3pf/hclge_regs.c        | 668 ++++++++++++++++++
 .../hisilicon/hns3/hns3pf/hclge_regs.h        |  17 +
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 121 +---
 .../hisilicon/hns3/hns3vf/hclgevf_main.h      |   1 +
 .../hisilicon/hns3/hns3vf/hclgevf_regs.c      | 164 +++++
 .../hisilicon/hns3/hns3vf/hclgevf_regs.h      |  13 +
 12 files changed, 875 insertions(+), 681 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.h

-- 
2.30.0

