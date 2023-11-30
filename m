Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C455B7FFB35
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376387AbjK3TX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376407AbjK3TXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:23:32 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6147D48;
        Thu, 30 Nov 2023 11:23:38 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sh5h13JSpz6JB68;
        Fri,  1 Dec 2023 03:23:13 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
        by mail.maildlp.com (Postfix) with ESMTPS id 9A87414058E;
        Fri,  1 Dec 2023 03:23:36 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 19:23:35 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
        <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
        <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
        <jiaqiyan@google.com>, <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
        <dave.hansen@linux.intel.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <pgonda@google.com>, <duenwen@google.com>,
        <mike.malvestuto@intel.com>, <gthelen@google.com>,
        <wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
        <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
        <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v4 11/11] cxl: scrub: sysfs: Add Documentation for CXL memory device scrub control attributes
Date:   Fri, 1 Dec 2023 03:23:13 +0800
Message-ID: <20231130192314.1220-12-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231130192314.1220-1-shiju.jose@huawei.com>
References: <20231130192314.1220-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add sysfs documentation for the CXL memory device scrub control
attributes those are exposed in /sys/class/scrub/ by the scrub
driver. These attributes support user configuring a CXL memory
device scrub.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 .../testing/sysfs-class-cxl-scrub-configure   | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-cxl-scrub-configure

diff --git a/Documentation/ABI/testing/sysfs-class-cxl-scrub-configure b/Documentation/ABI/testing/sysfs-class-cxl-scrub-configure
new file mode 100644
index 000000000000..3f55522134cd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-cxl-scrub-configure
@@ -0,0 +1,79 @@
+See `Documentation/ABI/testing/sysfs-class-scrub-configure` for the
+documentation of common scrub configure directory layout (/sys/class/scrub/),
+including the attributes used for configuring the CXL patrol scrub.
+Following are the attributes used for configuring the CXL ECS.
+
+What:		/sys/class/scrub/scrubX/regionY/ecs_log_entry_type
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The log entry type of how the DDR5 ECS log is
+		reported.
+		00b - per DRAM.
+		01b - per memory media FRU.
+
+What:		/sys/class/scrub/scrubX/regionY/ecs_log_entry_type_per_dram
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Returns true if current log entry type of DDR5 ECS
+		region is per DRAM.
+
+What:		/sys/class/scrub/scrubX/regionY/ecs_log_entry_type_per_memory_media
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Returns true if current log entry type of DDR5 ECS
+		region is per memory media FRU.
+
+What:		/sys/class/scrub/scrubX/regionY/mode
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The mode of how the DDR5 ECS counts the errors.
+		0 - ECS counts rows with errors.
+		1 - ECS counts codewords with errors.
+
+What:		/sys/class/scrub/scrubX/regionY/mode_counts_rows
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Returns true if current mode of DDR5 ECS region
+		is counts rows with errors.
+
+What:		/sys/class/scrub/scrubX/regionY/mode_counts_codewords
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Returns true if current mode of DDR5 ECS region
+		is counts codewords with errors.
+
+What:		/sys/class/scrub/scrubX/regionY/reset_counter
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(WO) DDR5 ECS reset ECC counter.
+		0 - normal, ECC counter running actively.
+		1 - reset ECC counter to the default value.
+
+What:		/sys/class/scrub/scrubX/regionY/threshold
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) DDR5 ECS threshold count per GB of memory cells.
+
+What:		/sys/class/scrub/scrubX/regionY/threshold_available
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Supported list of DDR5 ECS threshold count per GB of
+		memory cells.
-- 
2.34.1

