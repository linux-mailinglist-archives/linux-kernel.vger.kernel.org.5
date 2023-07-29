Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEF0767D21
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjG2I3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG2I3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:29:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AB9448A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:29:15 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RCczZ2VHfzLnvQ;
        Sat, 29 Jul 2023 16:26:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 16:29:11 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <xuwei5@hisilicon.com>, <arnd@arndb.de>, <krzk@kernel.org>,
        <sudeep.holla@arm.com>, <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <wanghuiqiang@huawei.com>,
        <tanxiaofei@huawei.com>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH v5 0/2] soc: hisilicon: Support HCCS driver on Kunpeng SoC
Date:   Sat, 29 Jul 2023 16:26:30 +0800
Message-ID: <20230729082632.43224-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230424073020.4039-1-lihuisong@huawei.com>
References: <20230424073020.4039-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add HCCS driver to query the health status and port information
of HCCS on Kunpeng SoC as well as document all sysfs entries provided by
this driver.

---
 v5:
 - fix document format to eliminate warning of making htmldocs.

 v4:
 - remove useless header and reorder linux header.
 - use __ATTR_RO to replace __ATTR for port attributes.
 - add MODULE_DEVICE_TABLE to autoload the driver.
 - update the date to "November 2023".
 - fix some comments about HCCS description.

 v3:
  - replace "using_status" with "enable" attribute.
  - fix some comments in codes.

 v2:
  - Document all sysfs entries provided by driver.
  - drop 'pcc_type' and 'intr_mode' in struct hccs_dev.
  - using _CRS with PCC GAS to get channel ID instead of _DSD.
  - replace readw_relaxed_poll_timeout with readw_poll_timeout.
  - use sysfs_emit() instead of sprintf().
  - drop ACPI_PTR in hccs_driver.
  - drop useless log during the probe phase.

Huisong Li (2):
  soc: hisilicon: Support HCCS driver on Kunpeng SoC
  doc: soc: hisilicon: Add Kunpeng HCCS driver documentation

 .../sysfs-devices-platform-kunpeng_hccs       |   81 ++
 MAINTAINERS                                   |    7 +
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/hisilicon/Kconfig                 |   20 +
 drivers/soc/hisilicon/Makefile                |    2 +
 drivers/soc/hisilicon/kunpeng_hccs.c          | 1282 +++++++++++++++++
 drivers/soc/hisilicon/kunpeng_hccs.h          |  196 +++
 8 files changed, 1590 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
 create mode 100644 drivers/soc/hisilicon/Kconfig
 create mode 100644 drivers/soc/hisilicon/Makefile
 create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.c
 create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.h

-- 
2.33.0

