Return-Path: <linux-kernel+bounces-9420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C883781C53F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806CB2871C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5337DBE72;
	Fri, 22 Dec 2023 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sH5/Q5pf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8CBE48
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp5mDMGV8p5elSKbdTnM3g3NO7Q7PYiAX5I6IxNdNBHCRQUEzI5WSf4ErUGCJ/mZGnWwtG7jNCzgcM7thtxDJ206fMEFwhen6vQJeE0p7IyaXpPOdz+MUAy/MncYjtFIU632sSiWPAyJR4N+l8Rr31X8fA+V6WfWQzCwcTZrD0qh1yNqcZ65iBfRwT/wWka3f3UC8C+jbzQ3+NGK4ReNekXD7N7ZTPSi4SVthGxMMbUcqJJOs76kW5ora5Y006/dcvwIOR5NsGVryUaHIgRQH8V/xLgFuu3Wpf1C18BVIMnJoXCqjdtPAGR0/AuDZY9Wwq0sfNqT/X5/GqZuyySE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pX3GXZo3e7l8fwlxAsZGREOd5bTzt2Kkm0pkcl1fsUs=;
 b=YNJw0IBfbxN05NFcRHEmo8Sf9QSDc1BAtrtiBo9C+DPhtmzHvGJSRbKnbbVB+GU55VRfG8yRx0LTq2TL6c+wfizCiIZbUb3vjbQ1R7rUoWvehXcHd4GcAjoa9fBdAdhvrBr5WL5ijI35IVt2eVsyqTIAvavkCc38kZ9yp4Q6PZpMT2FO035SQTb+UOoslPDtAYV7HbTXYTIZSbj42GyeFWkaSBABJJSiZDn01QL2Erghdl9XxLdR12SMiAFCjC2Yi9vJw0T3b90fcyqVVqiiREf40MLQNV3Yfxkwvt2JG4sSTZz84nVnvNyEt3NWOtSm69yNl0fb8WG3DAkrvKaYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pX3GXZo3e7l8fwlxAsZGREOd5bTzt2Kkm0pkcl1fsUs=;
 b=sH5/Q5pfbwXHn2sanBB9Jr/Zk2l2oPvaVP/iBMQAzBEzefD/mBWi6ez1sYhUU9WheiOb8MIT+GnavAQwKc6yRFGoFpBfhUIYkgCfLeXRxPMJOCpSP6lPUJTIOWYMlknaHGF0f0vj3s4KkIRCqz9BtFsa9YIc8Afuofn3i2nAXPQ=
Received: from SJ0PR03CA0178.namprd03.prod.outlook.com (2603:10b6:a03:338::33)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.21; Fri, 22 Dec 2023 06:46:53 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::ac) by SJ0PR03CA0178.outlook.office365.com
 (2603:10b6:a03:338::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Fri, 22 Dec 2023 06:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 22 Dec 2023 06:46:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 22 Dec
 2023 00:46:34 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 21 Dec
 2023 22:46:33 -0800
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 22 Dec 2023 00:46:31 -0600
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<Nipun.Gupta@amd.com>
CC: <puneet.gupta@amd.com>, <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
	<git@amd.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH RESEND v2 1/2] cdx: create sysfs bin files for cdx resources
Date: Fri, 22 Dec 2023 12:16:26 +0530
Message-ID: <20231222064627.2828960-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e9e5a5-9c37-4f16-aca5-08dc02b9c84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E/WEEfH987jBx6l6809dVZ7Z9w116gHq9Y53Wvn8CI2witIoDVGjb7NxMLgs04DBRvXTVI3sVmi9dK0VBpN/xk3y2TP0fEY4vBOSudGIrlpZ6Eo7TEvMQueVX6RWauJvBS4wJ07nD6ynBwXSTKs0HoLXRJRQfUvuW25mhdi72VNF/zm4ila4Yn16WTibHHVDzVwUu58ZxQ2/8Fc7KcMU2B3hrewJowuHGQLVmINzzWi6wV3DYwRVedFDAiuen0vQe5G8CkJI+T3vZFCuKX7QCbs/hmwNb5TLpXVveBRw99PaaVkDC9OXqxKGRuDO1DLItl3Mep27fclhCQ84/qFlr/gpJiufQe8Z6i2g09s/iL4ff0lASsLYtdBJNtp6DaJgkPpMxoYgDCX2nzqhXFGnw0ZmpyHzk7+PxAlznP3bAN7pbxhOGdkST5pTaYW9X0uhPpq6LQ56fVFIgYdzl80CZh/4VmxyM76IvcZQOmxNqndUWiClptvzzS7G8gjnK6F0SR/veVsMkppVH6RyhLE0vnvrxq3FnUlup8GdBZrZirRjWzLoWxeIxkGtQpV5hgGegdzS9gHZk3mAuwKW2LC+cMgx0eOwUTKljQh+3ozDgnDTLLjyxYjD58Eldw5nXvnae2GFCeoxE2bB5nOVydhgOq5bQV+IpUkIuA/w9nUO+JRbOzhPE/ey4r7xBp1oTT5NgUgW8IDhwVrxkR1IVCCSV6zf5nhgRfCEZ7yqyJN/dSccOKHhAMcMTD5xZzEeM/ZKGqGH3xBeKZAWF5/55zRJEA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(82310400011)(1800799012)(451199024)(186009)(64100799003)(46966006)(36840700001)(40470700004)(336012)(426003)(6636002)(316002)(1076003)(2906002)(26005)(2616005)(83380400001)(478600001)(54906003)(110136005)(70586007)(70206006)(5660300002)(6666004)(47076005)(40480700001)(8936002)(4326008)(8676002)(44832011)(81166007)(36860700001)(82740400003)(356005)(41300700001)(36756003)(86362001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 06:46:53.1060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e9e5a5-9c37-4f16-aca5-08dc02b9c84a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118

Resource binary file contains the content of the memory regions.
These resources<x> devices can be used to mmap the MMIO regions in
the user-space.

Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Changes in v2:
 - None

 Documentation/ABI/testing/sysfs-bus-cdx |   7 ++
 drivers/cdx/cdx.c                       | 118 +++++++++++++++++++++++-
 include/linux/cdx/cdx_bus.h             |  10 ++
 3 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index 8c067ff99e54..e84277531414 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -98,6 +98,13 @@ Description:
 
 		  # echo 1 > /sys/bus/cdx/devices/.../remove
 
+What:		/sys/bus/cdx/devices/.../resource<N>
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		The resource binary file contains the content of the memory
+		regions. These files can be m'maped from userspace.
+
 What:		/sys/bus/cdx/devices/.../modalias
 Date:		July 2023
 Contact:	nipun.gupta@amd.com
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index c5873980a9d3..4edf64f9e98d 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -78,6 +78,8 @@ static DEFINE_MUTEX(cdx_controller_lock);
 
 static char *compat_node_name = "xlnx,versal-net-cdx";
 
+static void cdx_destroy_res_attr(struct cdx_device *cdx_dev, int num);
+
 /**
  * cdx_dev_reset - Reset a CDX device
  * @dev: CDX device
@@ -146,6 +148,7 @@ static int cdx_unregister_device(struct device *dev,
 		if (cdx_dev->enabled && cdx->ops->bus_disable)
 			cdx->ops->bus_disable(cdx, cdx_dev->bus_num);
 	} else {
+		cdx_destroy_res_attr(cdx_dev, MAX_CDX_DEV_RESOURCES);
 		kfree(cdx_dev->driver_override);
 		cdx_dev->driver_override = NULL;
 	}
@@ -641,11 +644,105 @@ static void cdx_device_release(struct device *dev)
 	kfree(cdx_dev);
 }
 
+static const struct vm_operations_struct cdx_phys_vm_ops = {
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+	.access = generic_access_phys,
+#endif
+};
+
+/**
+ * cdx_mmap_resource - map a CDX resource into user memory space
+ * @fp: File pointer. Not used in this function, but required where
+ *      this API is registered as a callback.
+ * @kobj: kobject for mapping
+ * @attr: struct bin_attribute for the file being mapped
+ * @vma: struct vm_area_struct passed into the mmap
+ *
+ * Use the regular CDX mapping routines to map a CDX resource into userspace.
+ *
+ * Return: true on success, false otherwise.
+ */
+static int cdx_mmap_resource(struct file *fp, struct kobject *kobj,
+			     struct bin_attribute *attr,
+			     struct vm_area_struct *vma)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(kobj_to_dev(kobj));
+	int num = (unsigned long)attr->private;
+	struct resource *res;
+	unsigned long size;
+
+	res = &cdx_dev->res[num];
+	if (iomem_is_exclusive(res->start))
+		return -EINVAL;
+
+	/* Make sure the caller is mapping a valid resource for this device */
+	size = ((cdx_resource_len(cdx_dev, num) - 1) >> PAGE_SHIFT) + 1;
+	if (vma->vm_pgoff + vma_pages(vma) > size)
+		return -EINVAL;
+
+	/*
+	 * Map memory region and vm->vm_pgoff is expected to be an
+	 * offset within that region.
+	 */
+	vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
+	vma->vm_pgoff += (cdx_resource_start(cdx_dev, num) >> PAGE_SHIFT);
+	vma->vm_ops = &cdx_phys_vm_ops;
+	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+				  vma->vm_end - vma->vm_start,
+				  vma->vm_page_prot);
+}
+
+static void cdx_destroy_res_attr(struct cdx_device *cdx_dev, int num)
+{
+	int i;
+
+	/* removing the bin attributes */
+	for (i = 0; i < num; i++) {
+		struct bin_attribute *res_attr;
+
+		res_attr = cdx_dev->res_attr[i];
+		if (res_attr) {
+			sysfs_remove_bin_file(&cdx_dev->dev.kobj, res_attr);
+			kfree(res_attr);
+		}
+	}
+}
+
+#define CDX_RES_ATTR_NAME_LEN	10
+static int cdx_create_res_attr(struct cdx_device *cdx_dev, int num)
+{
+	struct bin_attribute *res_attr;
+	char *res_attr_name;
+	int ret;
+
+	res_attr = kzalloc(sizeof(*res_attr) + CDX_RES_ATTR_NAME_LEN, GFP_ATOMIC);
+	if (!res_attr)
+		return -ENOMEM;
+
+	res_attr_name = (char *)(res_attr + 1);
+
+	sysfs_bin_attr_init(res_attr);
+
+	cdx_dev->res_attr[num] = res_attr;
+	sprintf(res_attr_name, "resource%d", num);
+
+	res_attr->mmap = cdx_mmap_resource;
+	res_attr->attr.name = res_attr_name;
+	res_attr->attr.mode = 0600;
+	res_attr->size = cdx_resource_len(cdx_dev, num);
+	res_attr->private = (void *)(unsigned long)num;
+	ret = sysfs_create_bin_file(&cdx_dev->dev.kobj, res_attr);
+	if (ret)
+		kfree(res_attr);
+
+	return ret;
+}
+
 int cdx_device_add(struct cdx_dev_params *dev_params)
 {
 	struct cdx_controller *cdx = dev_params->cdx;
 	struct cdx_device *cdx_dev;
-	int ret;
+	int ret, i;
 
 	cdx_dev = kzalloc(sizeof(*cdx_dev), GFP_KERNEL);
 	if (!cdx_dev)
@@ -696,7 +793,26 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 		goto fail;
 	}
 
+	/* Create resource<N> attributes */
+	for (i = 0; i < MAX_CDX_DEV_RESOURCES; i++) {
+		if (cdx_resource_flags(cdx_dev, i) & IORESOURCE_MEM) {
+			/* skip empty resources */
+			if (!cdx_resource_len(cdx_dev, i))
+				continue;
+
+			ret = cdx_create_res_attr(cdx_dev, i);
+			if (ret != 0) {
+				dev_err(&cdx_dev->dev,
+					"cdx device resource<%d> file creation failed: %d", i, ret);
+				goto resource_create_fail;
+			}
+		}
+	}
+
 	return 0;
+resource_create_fail:
+	cdx_destroy_res_attr(cdx_dev, i);
+	device_del(&cdx_dev->dev);
 fail:
 	/*
 	 * Do not free cdx_dev here as it would be freed in
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index db39835b93d2..3096c31d5b9f 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -154,6 +154,7 @@ struct cdx_device {
 	u8 bus_num;
 	u8 dev_num;
 	struct resource res[MAX_CDX_DEV_RESOURCES];
+	struct bin_attribute *res_attr[MAX_CDX_DEV_RESOURCES];
 	u8 res_count;
 	u64 dma_mask;
 	u16 flags;
@@ -170,6 +171,15 @@ struct cdx_device {
 #define to_cdx_device(_dev) \
 	container_of(_dev, struct cdx_device, dev)
 
+#define cdx_resource_start(dev, num)	((dev)->res[(num)].start)
+#define cdx_resource_end(dev, num)	((dev)->res[(num)].end)
+#define cdx_resource_flags(dev, num)	((dev)->res[(num)].flags)
+#define cdx_resource_len(dev, num) \
+	((cdx_resource_start((dev), (num)) == 0 &&	\
+	  cdx_resource_end((dev), (num)) ==		\
+	  cdx_resource_start((dev), (num))) ? 0 :	\
+	 (cdx_resource_end((dev), (num)) -		\
+	  cdx_resource_start((dev), (num)) + 1))
 /**
  * struct cdx_driver - CDX device driver
  * @driver: Generic device driver
-- 
2.34.1


