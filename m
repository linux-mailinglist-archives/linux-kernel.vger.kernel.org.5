Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA697D4C87
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjJXJei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjJXJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:33:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E083B10F6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:32:56 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SF6Gf2ySWzrTwf;
        Tue, 24 Oct 2023 17:30:02 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 24 Oct 2023 17:32:53 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <jonathan.cameron@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH 0/2] Minor fix and cleanup for hisi_pcie_pmu
Date:   Tue, 24 Oct 2023 17:29:52 +0800
Message-ID: <20231024092954.42297-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

This patchset includes 2 minor updates for the hisi_pcie_pmu:
- fix issue that we may touch others events in some case
- modify the event->cpu only on the success pmu::event_init()

Yicong Yang (2):
  drivers/perf: hisi_pcie: Check the type first in pmu::event_init()
  drivers/perf: hisi_pcie: Initialize event->cpu only on success

 drivers/perf/hisilicon/hisi_pcie_pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.24.0

