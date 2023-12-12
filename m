Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6B480F1C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377104AbjLLQCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377081AbjLLQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:02:08 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C35B4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:02:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMjSB+L+2kF39oUPpRwMn7W6/jsvecGRqGh6wELiUsPscEYSOmT8qCaYnzHl2OXxF8lbHVDyoqiePuPShGdW1rboXXuUrTkWUqo6GeJhL8E7H+hwomcroYENJ5t2iEeSsmCLK2VbX+UmEuTH2pLn9u5mVmO/tow/DSXeC3/Slp5yTCqamtltzI9k28GIBqGLef20klhRl/FhKH9b36E12zU20XNCjciLfHb2/OHZGV7lu3JYfU3OPCXbSSDO6JUztv2EmrZGH9MR3Emwn3nFmKAOR6X3C/HBKpCQGK+k5+0HNPsvYJdVGRr+N0WDnWnRZc5t3Az/LkvrAokZ1wMz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cUejR/Qm0+2o+nSpuo39RgV/FP9KIqGrUvNqw4vhYs=;
 b=a/H65hjC988BLaxtYxwPmUTjLHbXGTdd/nOMUHSz0CsfZcdRJHTyfGQA+PTmSONW4IYWGoJd2Jff/LNlNmHC1RwjzlPZ0k2aG2HDmV9+Kn3kS7s/4ocJLDeyUn4vwfM7EUmX3cpGRiWElxy4P1wUdzV9Zq0jeTxbVkQUxW2ABoB5mV8mfoiqdzb438E8pgg4zNrsu3vK3B+FHISyhWxZZgn7hMlXKQ83mYcZcf6vFZnMarHxmefKtAz92/GMSiuPMroiwZBaWZBCgiKsPayh2Bcfd4I+y+kXZ5jnuzG4wqxOJDynkgWwIKz9OrhBvz15cQoPvIOni1lWRkF0yoXaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cUejR/Qm0+2o+nSpuo39RgV/FP9KIqGrUvNqw4vhYs=;
 b=BEusraJChieOiuaJZXmbvY84IFGhmk8R1jT+rYZgQhJbDZhjmFXIXRIOtw/QC53lunJ4xiw/b/RK6Yjocmx9DqGiHyiflTAr6AN2X5P5w0hwqm/CbBaWC3GZhTJMYqKtIhpt6D3CDbjOvvyZmCblgE+VELK+bneVzUYGYltiPHY=
Received: from BL0PR02CA0106.namprd02.prod.outlook.com (2603:10b6:208:51::47)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 16:02:07 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::38) by BL0PR02CA0106.outlook.office365.com
 (2603:10b6:208:51::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 16:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 16:02:07 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 10:02:05 -0600
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <joro@8bytes.org>, <jgg@nvidia.com>
CC:     <yi.l.liu@intel.com>, <kevin.tian@intel.com>,
        <nicolinc@nvidia.com>, <eric.auger@redhat.com>,
        <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
        <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
        <pandoh@google.com>, <loganodell@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [RFC PATCH 3/6] iommu/amd: Introduce Guest-ID struct amd_iommu_vminfo
Date:   Tue, 12 Dec 2023 10:01:36 -0600
Message-ID: <20231212160139.174229-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: e1541d59-45b8-40a6-8f22-08dbfb2bb0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hvjr6FCa9F4gN9M+5eJ1wGvQbb6Gc+pD9oSaLxH8TWOryheMoaCgFXUWzlckelbykC8sHOs7gVBckvkw97zwomEqNgYE6fsWpAfkJYCRrRf0H40Vrw5dIA6RRAFUu6atmLI5cMpYe9DYuErDBFGHUULawZE1IY+GWtV1hRMXDZflqPhBCNHnaWlwADnp72ZV0FvxXTWbe+4yN8XgQwCACkpRdjkmzrC4X85X0j9SnD0TL8xsaGbquHte6MiOmRltlhXY5xSpraJt2ApolCC9M/dd2GlUxeaow5quPFQK9Ojdw+ZolRjX9Td3OMyE6RjNuDYHlwoG6T1oFX8MpjtWUw7d1MSvBL166fG0j4EIiOwuJroXw30OkjEX8sW/+ebwd05gn/afKLOE+5npysNPhuu4EWjkQt8DHtY0TQ/8LUNyno3s9RQwP9BWC+hWrwkEV6WzAKRNogpDVvB7W+wz2rgHarAX8IBsCFpMFVZi5/jhe3oTxS5323qtezrm/Sk7REqD0lvDn1z9At8Byej+VXMADmUROEpdEz69aTtWilBBTKfZ4uS73BQ9L+UOG7bVz6JiA0R9Lk8xoBBZLhFtnJj6uw3n7MfE5Ft70zaGh/XwbvtC8RLSYGOdPmqSsMkz0Qbt/AQIkU53oQHz7bFv4UcNxhq0xOAooQdKtoHc26F8F/azG85JO/o77AP5hCdAS1aq3luJJrgLaPENsi60arQr9k+prnJgNhhXbMyV9SipKTuuroAV+EltqL6HFpzNFWZsRBUb9BnHfgo+5gulVhnR4Q1o3GgUZj4y2UVce3g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(16526019)(1076003)(47076005)(6666004)(7696005)(336012)(478600001)(26005)(2616005)(36860700001)(83380400001)(41300700001)(7416002)(5660300002)(54906003)(2906002)(426003)(44832011)(70206006)(8676002)(316002)(8936002)(4326008)(81166007)(110136005)(70586007)(86362001)(356005)(82740400003)(36756003)(40480700001)(40460700003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:02:07.1801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1541d59-45b8-40a6-8f22-08dbfb2bb0d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD HW-vIOMMU feature requires IOMMU driver to specify a unique 16-bit
Guest ID (GID) for each VM. This ID is used to index into various
data structures for configuring the hardware.

Introduce amd_iommu_vminfo_hash hashtable to store per-vm configuration,
which uses 16-bit GID as a hash key along with helper functions.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  6 +++
 drivers/iommu/amd/amd_iommu_types.h |  6 +++
 drivers/iommu/amd/iommu.c           | 66 +++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 4118129f4a24..7783a933ad14 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -182,4 +182,10 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 
 extern bool amd_iommu_snp_en;
+
+/* AMD IOMMU GID */
+int amd_iommu_vminfo_alloc(struct amd_iommu *iommu, struct amd_iommu_vminfo *vminfo);
+void amd_iommu_vminfo_free(struct amd_iommu *iommu, struct amd_iommu_vminfo *vminfo);
+struct amd_iommu_vminfo *amd_iommu_get_vminfo(int gid);
+
 #endif
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 956fd4658a4a..a00731673c50 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -16,6 +16,7 @@
 #include <linux/pci.h>
 #include <linux/irqreturn.h>
 #include <linux/io-pgtable.h>
+#include <linux/hashtable.h>
 
 /*
  * Maximum number of IOMMUs supported
@@ -1053,6 +1054,11 @@ struct amd_irte_ops {
 	void (*clear_allocated)(struct irq_remap_table *, int);
 };
 
+struct amd_iommu_vminfo {
+	u16 gid;
+	struct hlist_node hnode;
+};
+
 #ifdef CONFIG_IRQ_REMAP
 extern struct amd_irte_ops irte_32_ops;
 extern struct amd_irte_ops irte_128_ops;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c41932e9f16a..d18b23ac6357 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -23,6 +23,7 @@
 #include <linux/amd-iommu.h>
 #include <linux/notifier.h>
 #include <linux/export.h>
+#include <linux/idr.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/irqdomain.h>
@@ -66,6 +67,16 @@ LIST_HEAD(acpihid_map);
 const struct iommu_ops amd_iommu_ops;
 static const struct iommu_dirty_ops amd_dirty_ops;
 
+/* VMInfo Hashtable */
+#define AMD_IOMMU_VMINFO_HASH_BITS	16
+DEFINE_HASHTABLE(amd_iommu_vminfo_hash, AMD_IOMMU_VMINFO_HASH_BITS);
+DEFINE_SPINLOCK(amd_iommu_vminfo_hash_lock);
+
+/* Global VMID */
+#define AMD_IOMMU_VMID_INVALID (-1U)
+static DEFINE_IDA(amd_iommu_global_vmid_ida);
+static u32 amd_iommu_latest_gid;
+
 int amd_iommu_max_glx_val = -1;
 
 /*
@@ -101,6 +112,61 @@ static inline bool domain_id_is_per_dev(struct protection_domain *pdom)
 	return (pdom && pdom->pd_mode != PD_MODE_V1);
 }
 
+int get_vmid(void)
+{
+	int ret;
+
+	ret = ida_alloc_range(&amd_iommu_global_vmid_ida, 1, 0xFFFF, GFP_KERNEL);
+	return ret < 0 ? AMD_IOMMU_VMID_INVALID : ret;
+}
+
+int amd_iommu_vminfo_alloc(struct amd_iommu *iommu, struct amd_iommu_vminfo *vminfo)
+{
+	u32 gid;
+	unsigned long flags;
+
+	spin_lock_irqsave(&amd_iommu_vminfo_hash_lock, flags);
+	gid = amd_iommu_latest_gid = get_vmid();
+	if (gid == AMD_IOMMU_VMID_INVALID)
+		return -EINVAL;
+
+	pr_debug("%s: gid=%u\n", __func__, gid);
+	vminfo->gid = gid;
+	hash_add(amd_iommu_vminfo_hash, &vminfo->hnode, vminfo->gid);
+	spin_unlock_irqrestore(&amd_iommu_vminfo_hash_lock, flags);
+	return 0;
+}
+
+void amd_iommu_vminfo_free(struct amd_iommu *iommu,
+			    struct amd_iommu_vminfo *vminfo)
+{
+	unsigned long flags;
+
+	pr_debug("%s: gid=%u\n", __func__, vminfo->gid);
+	spin_lock_irqsave(&amd_iommu_vminfo_hash_lock, flags);
+	hash_del(&vminfo->hnode);
+	ida_free(&amd_iommu_global_vmid_ida, vminfo->gid);
+	spin_unlock_irqrestore(&amd_iommu_vminfo_hash_lock, flags);
+}
+
+struct amd_iommu_vminfo *amd_iommu_get_vminfo(int gid)
+{
+	unsigned long flags;
+	struct amd_iommu_vminfo *tmp, *ptr = NULL;
+
+	spin_lock_irqsave(&amd_iommu_vminfo_hash_lock, flags);
+	hash_for_each_possible(amd_iommu_vminfo_hash, tmp, hnode, gid) {
+		if (tmp->gid == gid) {
+			ptr = tmp;
+			break;
+		}
+	}
+	if (!ptr)
+		pr_debug("%s : gid=%u not found\n", __func__, gid);
+	spin_unlock_irqrestore(&amd_iommu_vminfo_hash_lock, flags);
+	return ptr;
+}
+
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
-- 
2.34.1

