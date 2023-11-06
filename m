Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4A97E1B5A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjKFHiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjKFHiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:38:19 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F023AD57;
        Sun,  5 Nov 2023 23:38:14 -0800 (PST)
Received: from kwepemm000005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SP34T4qvtzMmTc;
        Mon,  6 Nov 2023 15:33:45 +0800 (CST)
Received: from huawei.com (10.50.165.33) by kwepemm000005.china.huawei.com
 (7.193.23.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 6 Nov
 2023 15:26:34 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <bcreeley@amd.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <liulongfang@huawei.com>
Subject: [PATCH v19 2/3] Documentation: add debugfs description for vfio
Date:   Mon, 6 Nov 2023 15:22:24 +0800
Message-ID: <20231106072225.28577-3-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20231106072225.28577-1-liulongfang@huawei.com>
References: <20231106072225.28577-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000005.china.huawei.com (7.193.23.27)
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

Add an debugfs document description file to help users understand
how to use the accelerator live migration driver's debugfs.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Reviewed-by: Cedric Le Goater <clg@redhat.com>
---
 Documentation/ABI/testing/debugfs-vfio | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-vfio

diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/testing/debugfs-vfio
new file mode 100644
index 000000000000..210eca135979
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-vfio
@@ -0,0 +1,25 @@
+What:		/sys/kernel/debug/vfio
+Date:		Nov 2023
+KernelVersion:	6.7
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	This debugfs file directory is used for debugging
+		of vfio devices, it's a common directory for all vfio devices.
+		Vfio core will create a device subdirectory under this
+		directory.
+
+What:		/sys/kernel/debug/vfio/<device>/migration
+Date:		Nov 2023
+KernelVersion:	6.7
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	This debugfs file directory is used for debugging
+		of vfio devices that support live migration.
+		The debugfs of each vfio device that supports live migration
+		could be created under this directory.
+
+What:		/sys/kernel/debug/vfio/<device>/migration/state
+Date:		Nov 2023
+KernelVersion:	6.7
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Read the live migration status of the vfio device.
+		The contents of the state file reflects the migration state
+		relative to those defined in the vfio_device_mig_state enum
-- 
2.24.0

