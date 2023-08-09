Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED77751B4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjHIDx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjHIDxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:53:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA9B173A;
        Tue,  8 Aug 2023 20:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaO1DePBjZJD9av5h/Z8dclDVwDlDPbd3GEHpejmtqsaQE47seDoMZdrYGdfUxk+tBpGkv+emYM5GPmLJ3TEMhq39nPST2ht8KcgTTTOqLP6mwR1I2cT2Za3tjtn8cae9mGk1TzgE/EopRNOhiqhXFGuo3hw7NpKQ21lXF2Elhki+WMDBgVB7q9T89ThWsu8tPcpnA2Zanw79CQbzNEahkUZz5XN18MThGSEMoQWDMqBCRjVz4LjOqaJvVxdzLNcR3o88umNCdWporHct4FdTJe9jwXJlg4hwMDWtE5hICr+Ns2IxS0zYICChbJUoYoel9PcVnGQtnkpxw+TJsWU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvgKNFD9R1NjZcog9Pyj14peLPe3mzOPjFPRmVMvtAE=;
 b=ID5unPNP2Se/M84QBPNJcdCIxnOy8XAZWV/eCbj5voj1w9hhZHRJF2diT2oXcnj+unlwWCrH/xRB82vIZ6plP2qNWfbpcL+lyYJzmHq4CLhFA6jIIR5F+3xBMQqF1crFR8SV6ABj4aXyrn4Q4iEPtWYdRnt2SJdA75oPdHG82uRC8JHIujUaapIcyWfXgB1JG+IrGqj1bSdqDvpaGtHI8G5J5YRj/X1RwsPvj2jRkhi65yOY7TRmjLKz72zXY5xY12UhBvIYPUf2KLpCLtGJvYMZ3pr28mktB0z53/DKVu4nRtihldlByTtaYAQPTHqe4nzU927brSbiXMXVYec7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvgKNFD9R1NjZcog9Pyj14peLPe3mzOPjFPRmVMvtAE=;
 b=D8obXZu/uhAB/hwCYyRvw38QMFdN3Byh2KZ+sMAW/xNXAHrpZro0G2T2o5O5X5kmljEV5dAmVPWS0xYxJLSRMC9o7gt0fz5SROtRDw0NpY9qTIS6ojs8//sqr7Qil1Km5YQvNf7AUxyrNgCaWn3DTEMAPXuZIV1ny2NavnsxbP8=
Received: from SA1P222CA0149.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::26)
 by DS0PR12MB9400.namprd12.prod.outlook.com (2603:10b6:8:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 03:53:15 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:3c2:cafe::84) by SA1P222CA0149.outlook.office365.com
 (2603:10b6:806:3c2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 03:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 03:53:14 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 22:53:13 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <bp@alien8.de>, <x86@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        <yazen.ghannam@amd.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v2 2/3] hwmon: (k10temp) Add thermal support for AMD Family 1Ah-based models
Date:   Tue, 8 Aug 2023 22:52:43 -0500
Message-ID: <20230809035244.2722455-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809035244.2722455-1-avadhut.naik@amd.com>
References: <20230809035244.2722455-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DS0PR12MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: f6606ba6-68fc-4980-6f88-08db988c28c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRHOhA/wjysoe8vySzCoMMS560ebA7KBdUb3+OK2ANKkcPNHUCHkDoEmiY1uqgeB+RA17yH+D73QgJqvX+JAZf5iYO6OjRBNtvBFt4DVN/f5rR+eZRDgNdnHmDH25oiYrifddY+VbHweLeu7OFlzJZSY9CCQu8xkzpaf2jVPi0mQ8eEwyIwNQZfirGbWrM3SpkNrwxU2wuid1+GIOGEpszzyMlODqGn8onXInw11u/JNOO2vJ0aFJe9tynaqnwIGQOTH5qLDk+eZ0pzOol1FbUgbTpexcTRO2sOhCTn+XNyNgZnhGoJpoxR2VJFih1S3pdMeIOeiIkGWobodSopdWac5ObU10NQN0259yA7NKhYdgPj7cpmjpHY+rJ+2Ehu8iK457bYmYBY6uLehkJFfT6nNIrZ9CxF1+xNkCQerUY28idjtgcokegunOAydy3nPw6tDZHhYFK0GCyx9gCC8lveTp/F/2hXdj6pe+C/RkJnDsBLPwAHXLHVEdCLhfad3GN1AFsmaRbfw4PLsiSU9asIXmMSAeYtfweQIM5cDrmEVnCFc8fufV1HWE9Wjw5ZiHcQqsRO/46Kgqlvnd0Nnllr783EA5Wj8JR5Qf6KcCkd/ccQG2lzC6ZqqsEFg7CL5wHVMcve8s0UoQ0FYep5cLPYjVCDq2qxbBEg2cDxnm8qFdf6IcpDQOlzz8uZWjHoQkdxRC/2zOyZfK8Jhwtv5T6fyb4HPjgbLFq5MAWpSw1YpTnqliXsS/TgPR9qZ9mb7vbmckHy73qj5GsaKXTztRhamFw0uSk9ilqsCWMmi6Ak=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(186006)(1800799006)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(40460700003)(110136005)(36860700001)(54906003)(82740400003)(356005)(26005)(1076003)(6666004)(7696005)(2616005)(47076005)(426003)(83380400001)(16526019)(478600001)(336012)(81166007)(36756003)(2906002)(8936002)(5660300002)(44832011)(8676002)(70206006)(70586007)(41300700001)(316002)(86362001)(4326008)(40480700001)(170073001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 03:53:14.9278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6606ba6-68fc-4980-6f88-08db988c28c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9400
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avadhut Naik <Avadhut.Naik@amd.com>

Add thermal info support for AMD Family 1Ah-based models. Support is
provided on a per-socket granularity.

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index a267b11731a8..bae0becfa24b 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -65,7 +65,7 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET	0xd8200c64
 #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET	0xd8200ca4
 
-/* Common for Zen CPU families (Family 17h and 18h and 19h) */
+/* Common for Zen CPU families (Family 17h and 18h and 19h and 1Ah) */
 #define ZEN_REPORTED_TEMP_CTRL_BASE		0x00059800
 
 #define ZEN_CCD_TEMP(offset, x)			(ZEN_REPORTED_TEMP_CTRL_BASE + \
@@ -475,6 +475,10 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			k10temp_get_ccd_support(pdev, data, 12);
 			break;
 		}
+	} else if (boot_cpu_data.x86 == 0x1a) {
+		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
+		data->read_tempreg = read_tempreg_nb_zen;
+		data->is_zen = true;
 	} else {
 		data->read_htcreg = read_htcreg_pci;
 		data->read_tempreg = read_tempreg_pci;
@@ -521,6 +525,8 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
-- 
2.34.1

