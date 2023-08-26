Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E442078930B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjHZBYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjHZBYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:24:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6A4E77
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 18:24:11 -0700 (PDT)
Received: from kwepemm600016.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RXfCd19bnzJrmy;
        Sat, 26 Aug 2023 09:21:01 +0800 (CST)
Received: from linux-hNCriV.Euler.HZ (10.175.124.27) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 26 Aug 2023 09:24:08 +0800
From:   Jiang Dongxu <jiangdongxu1@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     jiangdongxu <jiangdongxu1@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <longpeng2@huawei.com>,
        <eric.fangyi@huawei.com>
Subject: [PATCH 0/2] vdpa: Add logging operatins
Date:   Sat, 26 Aug 2023 09:23:30 +0800
Message-ID: <cover.1693012755.git.jiangdongxu1@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jiangdongxu <jiangdongxu1@huawei.com>

Currently, the vdpa device supports suspend and resume operations.
To support vdpa device live migration, we need to support logging
operations and device state save/load opertions.

These series introduces some new operations for vdpa devices.
They allow vdpa to enable logging while vm start live migration.

And I will submit another patches about saving and loading
vdpa device state later.

jiangdongxu (2):
  vdpa: add log operations
  vhost-vdpa: add uAPI for logging

 drivers/vhost/vdpa.c       | 49 ++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h       | 14 +++++++++++
 include/uapi/linux/vhost.h |  4 ++++
 3 files changed, 67 insertions(+)

-- 
2.27.0

