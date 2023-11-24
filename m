Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46E7F718C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbjKXKdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345460AbjKXKc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:32:57 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725C31717;
        Fri, 24 Nov 2023 02:33:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+sdh8KvLMHd1LBsYdO7e0DdSYgTkga6gXdEoiwQayu9xWr/WppouJZQEpbXQdItM9/ziZCctN0AHC+lxtEOCUZN4PFRDcFQUtKtEcSm93lvutkQo+yTHjj/qKEB0CkMx8nuvwEwdpIQiMKgAvZmv1r22EbczO3pfrQY8YbhxZbWfim0IKf9VFFmXS9H3pK2cm7gNJomwXerzIWAcX2J7Y4HGmopkHBM2EpaKK9iKhg8RpJDjKXgHAeNTGXU0ApFcsjsbpZYfh1dHQpgd0wQL/pEibcCPd5oMDWAs9hCog0aJLzX9K11JRVURoKT7QsQV9afKzCvJcOqgn0q0aXlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aH+2SVcQn/nsVjZ45IvLi1aXjfOjVFR+f+ua3swKd8=;
 b=avvWCSA/Jy380gIoNZZWA2sTNRtJZGiBMSKRf0j4CQaWtkBiEVT557QIbIquhWhVZoZi1hi9z9LY4hWZrl3RHNZ+KDjlva+hFRy1cPVimWp0Db2InOg0er+8ls2vA9krnEVEIuQSt7S9rcqm8Dp9mDpkZaZnmcc6XgOkBEPVZu8DoO9eCpHeEcpyGFLWihHGMiOzte1/lQXcrhPdpRKtw34zETeKpIUIZeP6lgW/kvuj8nuhdQTu7G8gJwB/AjoINF9Efs+B91g0QoljUzgSZkVSuEI1XbitCAjTkmBx4t89AkE6MvykmTvLgkMRxQ3kBXkMGjbWJm8MOloObIQEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aH+2SVcQn/nsVjZ45IvLi1aXjfOjVFR+f+ua3swKd8=;
 b=B7uZvhUxln1N+q4YTG01eiRGtk8iyKwiP1eAcTdyH+JVdKXPdunGlatWK3cE1cktLW9zPrCBlo93qRiM3YiyenRFM0JmV2eoK9R6+QQp33nh5FkVzLJr53JQKvZVK9KY+uhtEplOHbwsKbAZ0Otf0PLmio2DbGR2zGmd2d5Zovg=
Received: from CY5PR15CA0043.namprd15.prod.outlook.com (2603:10b6:930:1b::12)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 10:32:59 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::cd) by CY5PR15CA0043.outlook.office365.com
 (2603:10b6:930:1b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21 via Frontend
 Transport; Fri, 24 Nov 2023 10:32:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.20 via Frontend Transport; Fri, 24 Nov 2023 10:32:59 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 24 Nov
 2023 04:32:53 -0600
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
Subject: [RFC KERNEL PATCH v2 1/3] xen/pci: Add xen_reset_device_state function
Date:   Fri, 24 Nov 2023 18:31:21 +0800
Message-ID: <20231124103123.3263471-2-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: b93f64d7-346c-4ffb-31d8-08dbecd8babb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y25TUEANezV16ofpBWfoq00mLowrkjE9spwmym00POnUVjNmXCCV6FqWLa1qBMau6eNokvjlIgZfnrVYNfvmFEzKv21u5NVx+MUSlXjwjKpXK0Imz72hv0olTZOoUneqtO/kgQukrdJuUgbycDfD+VHnY0A9a4O2rly6vVbXJzw492gl756imh/0Kpw82q3wV9nwTCTH/yfPZfLoR6oz3wRBXOQmVUgsK2THRvIAh1KwSDuXQ2iE77Fn6nSJH5gHQ8jqsC60Zidm+wi6wZpvQK4THT52rCnQW0VAF52wsxRCil3Nj54d6HIgCuMPQ2qF1D4DZRlujoyqh1jwhkYG8HQ2mS2zC56yyoOULMMvZaCAQ9l47IR/hdVql8bSZ5Cd3PdUJVHON1uDxKzXyGdgkPi59GKufOCeAEFHSF/6Cb0dbmsqs6lRzNYjT5BqHFSADUsfMGYT1RYCL13TwsjQkBCUoZ0xQaO6aA2smp78KJfmOkf9kpP2kKCvJd12fWvKyBQJXCl8V/4wJBmT8zkouxCD3/LmaQC62TpS3V0DRGpgEhuQHcTSOtBHpozc2arX0vdCZGbydRKpVJ8OtrjByYVnlDRSNDzNPyRsW9AZ4I+k9Z4Z/avwobAJPmf5dMFheyaaYFiMBXbXr4vOYqbbbydCNdZDrcAHOmFYODhDII4ehwhwKT4imnl9YCDidQU0LIqZadpjCDytLmnhW33dvanadnQR5ucXrBuUkoLyKLJnOrLKpWwbRsdYjqconrfj4K/M0yjmXfnUdLFfki+0ExCqRzcDk8Y4IbVbzZkWlPE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(26005)(16526019)(83380400001)(336012)(426003)(47076005)(82740400003)(86362001)(356005)(81166007)(40480700001)(36860700001)(41300700001)(921008)(2616005)(1076003)(36756003)(7416002)(7696005)(6666004)(2906002)(40460700003)(5660300002)(316002)(54906003)(70206006)(70586007)(110136005)(478600001)(8936002)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 10:32:59.2040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b93f64d7-346c-4ffb-31d8-08dbecd8babb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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

When device on dom0 side has been reset, the vpci on Xen side
won't get notification, so that the cached state in vpci is
all out of date with the real device state.
To solve that problem, this patch add a function to clear all
vpci device state when device is reset on dom0 side.

And call that function in pcistub_init_device. Because when
we use "pci-assignable-add" to assign a passthrough device in
Xen, it will reset passthrough device and the vpci state will
out of date, and then device will fail to restore bar state.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/xen/pci.c                  | 12 ++++++++++++
 drivers/xen/xen-pciback/pci_stub.c |  3 +++
 include/xen/interface/physdev.h    |  2 ++
 include/xen/pci.h                  |  6 ++++++
 4 files changed, 23 insertions(+)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 72d4e3f193af..e9b30bc09139 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -177,6 +177,18 @@ static int xen_remove_device(struct device *dev)
 	return r;
 }
 
+int xen_reset_device_state(const struct pci_dev *dev)
+{
+	struct physdev_pci_device device = {
+		.seg = pci_domain_nr(dev->bus),
+		.bus = dev->bus->number,
+		.devfn = dev->devfn
+	};
+
+	return HYPERVISOR_physdev_op(PHYSDEVOP_pci_device_state_reset, &device);
+}
+EXPORT_SYMBOL_GPL(xen_reset_device_state);
+
 static int xen_pci_notifier(struct notifier_block *nb,
 			    unsigned long action, void *data)
 {
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index e34b623e4b41..5a96b6c66c07 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -421,6 +421,9 @@ static int pcistub_init_device(struct pci_dev *dev)
 	else {
 		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
 		__pci_reset_function_locked(dev);
+		err = xen_reset_device_state(dev);
+		if (err)
+			goto config_release;
 		pci_restore_state(dev);
 	}
 	/* Now disable the device (this also ensures some private device
diff --git a/include/xen/interface/physdev.h b/include/xen/interface/physdev.h
index a237af867873..231526f80f6c 100644
--- a/include/xen/interface/physdev.h
+++ b/include/xen/interface/physdev.h
@@ -263,6 +263,8 @@ struct physdev_pci_device {
     uint8_t devfn;
 };
 
+#define PHYSDEVOP_pci_device_state_reset     32
+
 #define PHYSDEVOP_DBGP_RESET_PREPARE    1
 #define PHYSDEVOP_DBGP_RESET_DONE       2
 
diff --git a/include/xen/pci.h b/include/xen/pci.h
index b8337cf85fd1..b2e2e856efd6 100644
--- a/include/xen/pci.h
+++ b/include/xen/pci.h
@@ -4,10 +4,16 @@
 #define __XEN_PCI_H__
 
 #if defined(CONFIG_XEN_DOM0)
+int xen_reset_device_state(const struct pci_dev *dev);
 int xen_find_device_domain_owner(struct pci_dev *dev);
 int xen_register_device_domain_owner(struct pci_dev *dev, uint16_t domain);
 int xen_unregister_device_domain_owner(struct pci_dev *dev);
 #else
+static inline int xen_reset_device_state(const struct pci_dev *dev)
+{
+	return -1;
+}
+
 static inline int xen_find_device_domain_owner(struct pci_dev *dev)
 {
 	return -1;
-- 
2.34.1

