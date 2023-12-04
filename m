Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454D080313F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbjLDLFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbjLDLFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:05:01 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B8A109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:05:07 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SkLKg05tjzShhd;
        Mon,  4 Dec 2023 19:00:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 19:04:27 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <will@kernel.org>, <jonathan.cameron@huawei.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <prime.zeng@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH] drivers/perf: hisi: Fix some event id for HiSilicon UC pmu
Date:   Mon, 4 Dec 2023 19:04:25 +0800
Message-ID: <20231204110425.20354-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500002.china.huawei.com (7.185.36.158)
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

Some event id of HiSilicon uncore UC PMU driver is incorrect, fix them.

Fixes: 312eca95e28d ("drivers/perf: hisi: Add support for HiSilicon UC PMU driver")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_uc_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
index 63da05e5831c..636fb79647c8 100644
--- a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
@@ -383,8 +383,8 @@ static struct attribute *hisi_uc_pmu_events_attr[] = {
 	HISI_PMU_EVENT_ATTR(cpu_rd,		0x10),
 	HISI_PMU_EVENT_ATTR(cpu_rd64,		0x17),
 	HISI_PMU_EVENT_ATTR(cpu_rs64,		0x19),
-	HISI_PMU_EVENT_ATTR(cpu_mru,		0x1a),
-	HISI_PMU_EVENT_ATTR(cycles,		0x9c),
+	HISI_PMU_EVENT_ATTR(cpu_mru,		0x1c),
+	HISI_PMU_EVENT_ATTR(cycles,		0x95),
 	HISI_PMU_EVENT_ATTR(spipe_hit,		0xb3),
 	HISI_PMU_EVENT_ATTR(hpipe_hit,		0xdb),
 	HISI_PMU_EVENT_ATTR(cring_rxdat_cnt,	0xfa),
-- 
2.33.0

