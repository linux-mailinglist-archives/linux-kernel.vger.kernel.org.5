Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5567A24C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbjIOR3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbjIOR3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:29:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750162120;
        Fri, 15 Sep 2023 10:29:06 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnLkc2nYbz6K6LG;
        Sat, 16 Sep 2023 01:28:24 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 18:29:04 +0100
From:   <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <dave.hansen@linux.intel.com>, <david@redhat.com>,
        <jiaqiyan@google.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <pgonda@google.com>, <rientjes@google.com>, <duenwen@google.com>,
        <Vilas.Sridharan@amd.com>, <mike.malvestuto@intel.com>,
        <gthelen@google.com>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
        <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries for set of scrub attributes
Date:   Sat, 16 Sep 2023 01:28:11 +0800
Message-ID: <20230915172818.761-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230915172818.761-1-shiju.jose@huawei.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add sysfs documentation entries for the set of attributes those are
exposed in /sys/class/scrub/ by the scrub driver. These attributes
support configuring parameters of a scrub device.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 .../ABI/testing/sysfs-class-scrub-configure   | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure

diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/Documentation/ABI/testing/sysfs-class-scrub-configure
new file mode 100644
index 000000000000..347e2167dc62
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
@@ -0,0 +1,82 @@
+What:		/sys/class/scrub/
+Date:		September 2023
+KernelVersion:	6.7
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The scrub/ class subdirectory belongs to the
+		scrubber subsystem.
+
+What:		/sys/class/scrub/scrubX/
+Date:		September 2023
+KernelVersion:	6.7
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The /sys/class/scrub/scrub{0,1,2,3,...} directories
+		correspond to each scrub device.
+
+What:		/sys/class/scrub/scrubX/name
+Date:		September 2023
+KernelVersion:	6.7
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) name of the memory scrub device
+
+What:		/sys/class/scrub/scrubX/regionY/
+Date:		September 2023
+KernelVersion:	6.7
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
+Date:		September 2023
+KernelVersion:	6.7
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The base of the address range of the memory region
+		to be patrol scrubbed.
+		On reading, returns the base of the memory region for
+		the actual address range(The platform calculates
+		the nearest patrol scrub boundary address from where
+		it can start scrubbing).
+
+What:		/sys/class/scrub/scrubX/regionY/addr_size
+Date:		September 2023
+KernelVersion:	6.7
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The size of the address range to be patrol scrubbed.
+		On reading, returns the size of the memory region for
+		the actual address range.
+
+What:		/sys/class/scrub/scrubX/regionY/enable
+Date:		September 2023
+KernelVersion:	6.7
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(WO) Start/Stop scrubbing the memory region.
+		1 - enable the memory scrubbing.
+		0 - disable the memory scrubbing..
+
+What:		/sys/class/scrub/scrubX/regionY/speed_available
+Date:		September 2023
+KernelVersion:	6.7
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Supported range for the partol speed(scrub rate)
+		by the scrubber for a memory region.
+		The unit of the scrub rate vary depends on the scrubber.
+
+What:		/sys/class/scrub/scrubX/regionY/speed
+Date:		September 2023
+KernelVersion:	6.7
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The partol speed(scrub rate) on the memory region specified and
+		it must be with in the supported range by the scrubber.
+		The unit of the scrub rate vary depends on the scrubber.
-- 
2.34.1

