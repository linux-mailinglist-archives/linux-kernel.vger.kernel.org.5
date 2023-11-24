Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4530C7F718D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbjKXKd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345595AbjKXKdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:33:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900FA10EC;
        Fri, 24 Nov 2023 02:33:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKAxpiYbBpjb0NMpmXcUsFWlgX0ZKfgvTMvn6wL998PfOsItsUYp4OU/8rEKgyBNAVQLIgVJ6TzJJxT+dJrMY9GnQJb6Jy1I+PHrw0c5kIBOwH77UPOkfcmcesN0aydoIRGaKXfSKP5tZeFPCm7rDaVDInww99qXgiQPn0jNrlrM0nPZ4HIgiQmdEogkaotd2gSfeCz3/ImZcxpfoVihTbTKUGwl+TpT8E6EUVcq66gB0YuVMcGYEAsOvP6vpx/K7DwlI0K21SbaoSdMhfiJOfIDLe2EyPKelB/JnK/zb+WAMogG2SDyC99lAtE5TqLVkdCCoj1A5V2Nbh2e8GY1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfANHFWcou1FeEN+wZbXol2ku2zP/OewOlGHwHnCwuw=;
 b=hE3RPWUXgDqv7ZyJWjpkXhO8iwJ6Auuhifoc8J7dTpjMb4VDxaHAMkfsxh0Avl5i3oNTu60LeT2OltpCANC2kYWiJ9hdODw2TkjliRwW72NJLlWFwyau810blzbiQGSyVVPAeaSbGyiuyc7EdPdBp3KsQQl37lWgv/kcwesJH7+k1jyy14H14l3+X/rC/w0hhEkvG3LOS2sFnaJH5+y4VxTWdcwhsf+MiMYtuiuinmhXVCq46nh9O0qXFjh9D2cW1CWoEPSxf9vgUsglhjcQtKBtX8XDCIUdHnwj/0o+XhEW0i4gutbTXwNR42eTQEWF7xPRJz+JIjxpNYZV6K4S5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfANHFWcou1FeEN+wZbXol2ku2zP/OewOlGHwHnCwuw=;
 b=JRwAzIrleJpxCNrADTyIsfYRH5mp2WI0lNSvz/+OsuKxwXGLmvp95RePHv7P8+X3w5mVj9HpOUm4vaSwVdr1PnTMJUd7A7AUtCDeZ8LlO7IuIdmHvSAPzGtRsYFjYLFvSk+GCdGqhl3h9+y8eSDKCnAsrBfvPEtYjO5Z6NLKvaM=
Received: from CY8PR10CA0022.namprd10.prod.outlook.com (2603:10b6:930:4f::23)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 10:33:05 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::ad) by CY8PR10CA0022.outlook.office365.com
 (2603:10b6:930:4f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21 via Frontend
 Transport; Fri, 24 Nov 2023 10:33:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 24 Nov 2023 10:33:04 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 24 Nov
 2023 04:32:59 -0600
From:   Jiqian Chen <Jiqian.Chen@amd.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     Stefano Stabellini <stefano.stabellini@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        "Julia Zhang" <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>,
        Jiqian Chen <Jiqian.Chen@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough device in PVH dom0
Date:   Fri, 24 Nov 2023 18:31:22 +0800
Message-ID: <20231124103123.3263471-3-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|BL1PR12MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2d2249-14f0-4ab2-43a2-08dbecd8be21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbOO3cPBX404OwUvQTq+zwaugFWDj/7ufDz1LIQJQkBOpEbJC0ctMgL5dOI7VEDnSwnoh9WlzvE5F/fibO6EGOeHVo+9mNJ91aeA63O6Q0uhmDqoNHV6fajHqfafx+0oZ+h6wLvjvK8HZLsIVuSlvEQWFsua5WWYFIX7m8XmTcLQiC+LNsiVFM63/PFU9dz7/dezHcQE9GVV1udengbgI5Px9sUSrD8Lt/qVOo0BOpW2t2wd+3Rxc7E7yQ7fQDUmBgYtsNuk0A/yCNqxIsfd2Mr4Z9VlUUjpC8GomY5kR+wTPPWsTQeOsp/w45fFS1lBJh6DiLBKq3RIqn68eSY371FTops2eL+9OUjP+29FzPNTFNGtOUETNUztCoyRF1a4aQXmZigGg3V1aOZEQG1EoY2XScfKpfknDGF5C2rfVfwy1C0f50yn17jZdntdofJVUEzwO4P366xb/PJAcq7KgQSJ+eE6NeTfJUSm9IxjvNZgHZzt15c6xIW4jiP6UcT+MCpiiifvqHdZIuAIdQMGkHXH3u8DzJaQM6UJQ2MHgXJcQzR33JfmDPpFVj78ml/tAN17rm5TpA9aeV22mKa0/NHv+tZF0+Zk2cjry8E9exT4pK0FcZu8y4gT6bRZl2N5Iiy+jtaGjtL7creQ6bmHwbGFHXf0wIwizC41kC202+Fct2qh5bGw+1HFVMUDcNkY+v0iRkHJGCIcFeshN4GAiIPnQ6o+P34RrmYzSgTz7KyzzCgYsg6mD9hE7aTz10cE+SQ+I9igFlW+jljEkaj1WHVMIhEAmGtqcp74RgIxNE0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(40470700004)(46966006)(36840700001)(478600001)(40460700003)(81166007)(8936002)(4326008)(8676002)(110136005)(70586007)(316002)(54906003)(70206006)(356005)(36756003)(16526019)(26005)(1076003)(2906002)(336012)(426003)(36860700001)(921008)(47076005)(40480700001)(2616005)(83380400001)(86362001)(41300700001)(5660300002)(7416002)(6666004)(82740400003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 10:33:04.8592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2d2249-14f0-4ab2-43a2-08dbecd8be21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to solve two problems we encountered when we try to
passthrough a device to hvm domU base on Xen PVH dom0.

First, hvm guest will alloc a pirq and irq for a passthrough device
by using gsi, before that, the gsi must first has a mapping in dom0,
see Xen code pci_add_dm_done->xc_domain_irq_permission, it will call
into Xen and check whether dom0 has the mapping. See
XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH
dom0 and it return irq is 0, and then return -EPERM.
This is because the passthrough device doesn't do PHYSDEVOP_map_pirq
when thay are enabled.

Second, in PVH dom0, the gsi of a passthrough device doesn't get
registered, but gsi must be configured for it to be able to be
mapped into a domU.

After searching codes, we can find map_pirq and register_gsi will be
done in function vioapic_write_redirent->vioapic_hwdom_map_gsi when
the gsi(aka ioapic's pin) is unmasked in PVH dom0. So the problems
can be conclude to that the gsi of a passthrough device doesn't be
unmasked.

To solve the unmaske problem, this patch call the unmask_irq when we
assign a device to be passthrough. So that the gsi can get registered
and mapped in PVH dom0.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/xen/xen-pciback/pci_stub.c | 7 +++++++
 include/linux/irq.h                | 1 +
 kernel/irq/chip.c                  | 1 +
 kernel/irq/internals.h             | 1 -
 kernel/irq/irqdesc.c               | 2 +-
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 5a96b6c66c07..b83d02bcc76c 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -357,6 +357,7 @@ static int pcistub_match(struct pci_dev *dev)
 static int pcistub_init_device(struct pci_dev *dev)
 {
 	struct xen_pcibk_dev_data *dev_data;
+	struct irq_desc *desc = NULL;
 	int err = 0;
 
 	dev_dbg(&dev->dev, "initializing...\n");
@@ -399,6 +400,12 @@ static int pcistub_init_device(struct pci_dev *dev)
 	if (err)
 		goto config_release;
 
+	if (xen_initial_domain() && xen_pvh_domain()) {
+		if (dev->irq <= 0 || !(desc = irq_to_desc(dev->irq)))
+			goto config_release;
+		unmask_irq(desc);
+	}
+
 	if (dev->msix_cap) {
 		struct physdev_pci_device ppdev = {
 			.seg = pci_domain_nr(dev->bus),
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 90081afa10ce..44650ca178d9 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -659,6 +659,7 @@ extern void handle_percpu_irq(struct irq_desc *desc);
 extern void handle_percpu_devid_irq(struct irq_desc *desc);
 extern void handle_bad_irq(struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
+extern void unmask_irq(struct irq_desc *desc);
 
 extern void handle_fasteoi_nmi(struct irq_desc *desc);
 extern void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index dc94e0bf2c94..fd67b40b678d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -439,6 +439,7 @@ void unmask_irq(struct irq_desc *desc)
 		irq_state_clr_masked(desc);
 	}
 }
+EXPORT_SYMBOL_GPL(unmask_irq);
 
 void unmask_threaded_irq(struct irq_desc *desc)
 {
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index bcc7f21db9ee..d08e3e7b2819 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -95,7 +95,6 @@ extern void irq_disable(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
 extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
 extern void mask_irq(struct irq_desc *desc);
-extern void unmask_irq(struct irq_desc *desc);
 extern void unmask_threaded_irq(struct irq_desc *desc);
 
 #ifdef CONFIG_SPARSE_IRQ
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 27ca1c866f29..5977efed31b5 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -380,7 +380,7 @@ struct irq_desc *irq_to_desc(unsigned int irq)
 {
 	return mtree_load(&sparse_irqs, irq);
 }
-#ifdef CONFIG_KVM_BOOK3S_64_HV_MODULE
+#if defined CONFIG_KVM_BOOK3S_64_HV_MODULE || defined CONFIG_XEN_PVH
 EXPORT_SYMBOL_GPL(irq_to_desc);
 #endif
 
-- 
2.34.1

