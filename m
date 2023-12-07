Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B988086FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjLGLqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjLGLqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:46:04 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11E2D53;
        Thu,  7 Dec 2023 03:46:10 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SmCBb6hpnzYsnr;
        Thu,  7 Dec 2023 19:45:27 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 19:46:07 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 0/5] Bugfixes and improvements for hns RoCE
Date:   Thu, 7 Dec 2023 19:42:26 +0800
Message-ID: <20231207114231.2872104-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are several bugfixes and improvements for hns RoCE.

v1 -> v2:
* Change applying target from -rc to -next
* Drop patch #6 in v1

Chengchang Tang (3):
  RDMA/hns: Rename the interrupts
  RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
  RDMA/hns: Fix memory leak in free_mr_init()

Junxian Huang (2):
  RDMA/hns: Response dmac to userspace
  RDMA/hns: Add a max length of gid table

 drivers/infiniband/hw/hns/hns_roce_ah.c    |  7 +++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 22 +++++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  2 +-
 include/uapi/rdma/hns-abi.h                |  5 +++++
 4 files changed, 30 insertions(+), 6 deletions(-)

--
2.30.0

