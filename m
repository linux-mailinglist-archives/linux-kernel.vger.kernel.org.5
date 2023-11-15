Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4876C7EB064
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjKNM51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjKNM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:57:14 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A307A19E;
        Tue, 14 Nov 2023 04:57:09 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SV5rW3Jxqz6K9LJ;
        Tue, 14 Nov 2023 20:55:55 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 12:57:07 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <Vilas.Sridharan@amd.com>,
        <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
        <rientjes@google.com>, <jiaqiyan@google.com>,
        <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
        <dave.hansen@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <"pgonda@pgonda"@google.com>, <duenwen@google.com>,
        <mike.malvestuto@intel.com>, <gthelen@google.com>,
        <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
        <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 6/6] cxl: scrub: sysfs: Add Documentation for CXL memory device scrub control attributes
Date:   Tue, 14 Nov 2023 20:56:47 +0800
Message-ID: <20231114125648.1146-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231114125648.1146-1-shiju.jose@huawei.com>
References: <20231114125648.1146-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
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

From: Shiju Jose <shiju.jose@huawei.com>

Add sysfs documentation entries for the CXL memory device scrub
control attributes those are exposed in /sys/class/scrub/ by the
scrub driver. These attributes support configuring a CXL memory
device scrub.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 .../testing/sysfs-class-cxl-scrub-configure   | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-cxl-scrub-configure

diff --git a/Documentation/ABI/testing/sysfs-class-cxl-scrub-configure b/Documentation/ABI/testing/sysfs-class-cxl-scrub-configure
new file mode 100644
index 000000000000..9dd0c18451aa
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-cxl-scrub-configure
@@ -0,0 +1,135 @@
+What:		/sys/class/scrub/
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The scrub/ class subdirectory belongs to the scrub
+		subsystem.
+
+What:		/sys/class/scrub/scrubX/
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The /sys/class/scrub/scrub{0,1,2,3,...} directories
+		correspond to each scrub device.
+
+What:		/sys/class/scrub/scrubX/name
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) name of the memory scrub device
+
+What:		/sys/class/scrub/scrubX/regionY/
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The /sys/class/scrub/scrubX/region{0,1,2,3,...}
+		directories correspond to each scrub region under a scrub device.
+		Scrub region is a physical address range or for example
+		memory media FRU of DDR5 ECS feature for which scrub may be
+		separately controlled.
+
+What:		/sys/class/scrub/scrubX/regionY/enable
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(WO) Start/Stop CXL memory patrol scrub.
+		1 - enable the CXL memory patrol scrub.
+		0 - disable the CXL memory patrol scrub.
+
+What:		/sys/class/scrub/scrubX/regionY/speed
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The scrub cycle to set for the CXL memory
+		patrol scrub and it must be within the supported
+		range. The unit of the scrub cycle is hour.
+
+What:		/sys/class/scrub/scrubX/regionY/speed_available
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Supported range of the scrub cycle by the
+		CXL memory patrol scrub.
+		The unit of the scrub cycle is hour.
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

