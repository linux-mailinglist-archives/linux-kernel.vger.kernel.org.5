Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82DD80022C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjLADpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLADpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:45:31 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC58810C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:45:37 -0800 (PST)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ShJq21M2WzvRJ8;
        Fri,  1 Dec 2023 11:45:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000004.china.huawei.com (7.193.23.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 11:45:35 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Jonathan.Cameron@Huawei.com>, <arnd@arndb.de>, <krzk@kernel.org>,
        <sudeep.holla@arm.com>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH v3 0/5] soc: hisilicon: kunpeng_hccs: Support the platform with PCC type3 and interrupt ack
Date:   Fri, 1 Dec 2023 11:45:29 +0800
Message-ID: <20231201034534.7276-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231109054526.27270-1-lihuisong@huawei.com>
References: <20231109054526.27270-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000004.china.huawei.com (7.193.23.18)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose of this series is to support the platform with PCC type3
and interrupt ack. At the same time, this series also fix some clean codes
and modify the incorrect email domain name.

---
 v3:
  - remove inline tag of two wait_cmd_complete function.
  - delete variable 'ret' in hccs_wait_cmd_complete_by_irq()
  - add a new patch which fix incorrect email domain name in document.

 v2:
  - using a version specific structure to replace device version according
    to Jonathan's advice.
  - add a new patch that remove an unused blank line.

Huisong Li (5):
  soc: hisilicon: kunpeng_hccs: Fix some incorrect format strings
  soc: hisilicon: kunpeng_hccs: Add failure log for no _CRS method
  soc: hisilicon: kunpeng_hccs: Remove an unused blank line
  doc: kunpeng_hccs: Fix incorrect email domain name
  soc: hisilicon: kunpeng_hccs: Support the platform with PCC type3 and
    interrupt ack

 .../sysfs-devices-platform-kunpeng_hccs       |   6 +-
 drivers/soc/hisilicon/kunpeng_hccs.c          | 152 ++++++++++++++----
 drivers/soc/hisilicon/kunpeng_hccs.h          |  15 ++
 3 files changed, 137 insertions(+), 36 deletions(-)

-- 
2.33.0

