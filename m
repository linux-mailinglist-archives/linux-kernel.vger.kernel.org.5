Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1110F7FFB34
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376360AbjK3TXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376414AbjK3TXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:23:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7166310FF;
        Thu, 30 Nov 2023 11:23:37 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sh5b43lgRz67lQZ;
        Fri,  1 Dec 2023 03:18:56 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
        by mail.maildlp.com (Postfix) with ESMTPS id A29DB1402CD;
        Fri,  1 Dec 2023 03:23:35 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 19:23:34 +0000
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
Subject: [PATCH v4 10/11] memory: scrub: sysfs: Add Documentation for set of common scrub attributes
Date:   Fri, 1 Dec 2023 03:23:12 +0800
Message-ID: <20231130192314.1220-11-shiju.jose@huawei.com>
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

Add sysfs documentation for the set of common scrub attributes those are
exposed in /sys/class/scrub/ by the scrub configure driver and support
user to configuring attributes of a scrub device.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 .../ABI/testing/sysfs-class-scrub-configure   | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure

diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/Documentation/ABI/testing/sysfs-class-scrub-configure
new file mode 100644
index 000000000000..5e965b3ad088
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
@@ -0,0 +1,82 @@
+What:		/sys/class/scrub/
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The scrub/ class subdirectory belongs to the
+		scrubber subsystem.
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
+		Scrub region is a physical address range for which scrub may be
+		separately controlled. Regions may overlap in which case the
+		scrubbing rate of the overlapped memory will be at least that
+		expected due to each overlapping region.
+
+What:		/sys/class/scrub/scrubX/regionY/addr_base
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The base of the address range of the memory region
+		to be scrubbed.
+		On reading, returns the base of the memory region for
+		the actual address range(The platform calculates
+		the nearest patrol scrub boundary address from where
+		it can start scrub).
+
+What:		/sys/class/scrub/scrubX/regionY/addr_size
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The size of the address range to be scrubbed.
+		On reading, returns the size of the memory region for
+		the actual address range.
+
+What:		/sys/class/scrub/scrubX/regionY/enable
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(WO) Start/Stop scrub the memory region.
+		1 - enable the memory scrub.
+		0 - disable the memory scrub..
+
+What:		/sys/class/scrub/scrubX/regionY/speed_available
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Supported range for the scrub speed(scrub rate)
+		by the scrubber for a memory region.
+		The unit of the scrub rate vary depends on the scrub.
+
+What:		/sys/class/scrub/scrubX/regionY/speed
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The scrub speed(scrub rate) on the memory region specified
+		and it must be with in the supported range by the scrub.
+		The unit of the scrub rate vary depends on the scrub.
-- 
2.34.1

