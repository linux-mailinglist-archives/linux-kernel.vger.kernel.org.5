Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76FD7FF087
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345665AbjK3Nps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345640AbjK3Npr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:45:47 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24202131
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:45:53 -0800 (PST)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Sgy564HQgzMnX3;
        Thu, 30 Nov 2023 21:40:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000004.china.huawei.com (7.193.23.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 21:45:50 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Jonathan.Cameron@Huawei.com>, <arnd@arndb.de>, <krzk@kernel.org>,
        <sudeep.holla@arm.com>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH v2 0/4] soc: hisilicon: kunpeng_hccs: Support the platform with PCC type3 and interrupt ack
Date:   Thu, 30 Nov 2023 21:45:46 +0800
Message-ID: <20231130134550.33398-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231109054526.27270-1-lihuisong@huawei.com>
References: <20231109054526.27270-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000004.china.huawei.com (7.193.23.18)
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

The main purpose of this series is to support the platform with PCC type3
and interrupt ack. At the same time, this series also fix some incorrect
format strings, add failure log for no _CRS method and remove an unused
blank line.

---
 v2:
  - using a version specific structure to replace device version according
    to Jonathan's advice.
  - add a new patch that remove an unused blank line.

Huisong Li (4):
  soc: hisilicon: kunpeng_hccs: Fix some incorrect format strings
  soc: hisilicon: kunpeng_hccs: Add failure log for no _CRS method
  soc: hisilicon: kunpeng_hccs: remove an unused blank line
  soc: hisilicon: kunpeng_hccs: Support the platform with PCC type3 and
    interrupt ack

 drivers/soc/hisilicon/kunpeng_hccs.c | 153 +++++++++++++++++++++------
 drivers/soc/hisilicon/kunpeng_hccs.h |  15 +++
 2 files changed, 135 insertions(+), 33 deletions(-)

-- 
2.33.0

