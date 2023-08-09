Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C270775F32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjHIMgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjHIMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:35:58 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4121FCA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1Z3CIHAa3k7UhPsOD90x2UolmiIcPNAlsVb8RmhkXeaKFMNKLr1GR0i2z4Nr33JDPawGGabY+Kj/Q6aHB2f0LXCGZ6Clj8PfrIoiEpn+uIcbhn/nHfltKNytrIaGGmxPIeZ6etbOC9aPPN6nq067NVRwmXzRxGE/Gj07OKJsIbT85eigrxrcYcXQ5vayFB1S1wjqgoLIXAUJ9PUxyE4p/934wYyHHN2p0Eg4Jihwj6tluY11L/Wd4YgQuukSzCeAAYx2cJ0Uxb0h1bDvORBBtfRUzIA8Q+WEhG4yKuK0jVJQWdNHGAWWCp47YK/B0KLWOtigrGSUsZh/W8iOO77kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYOv0IXslR/MWQ6rt0Z95832S7yvpspIEhidZ6M1aRo=;
 b=kubMJMvLmjw4ebJKBFBnS87fx8I6a+6HrJDACzXDtYtwwmgy+GLA38my3S4lATa1AiArPtbDpCUTICm9dGuS+HxPs3F8Sl4hmGumpFYw4jzBysPtwYU5fqVRm2WxNQjTX0DAZMmvkW6kIxRSUcu/pZljpMz6e6WW+M8wIvgaQWE0LjZm4FbikZ8pXNOXpXVQYvMSk/Qemzl+A/KbYkZVJBmA2Ed6AO57C2JKTThFzaSjRJ1FneJU1tzqb/pI+6OJZUnDUHlcMuPdhcPzfru83kxTKLzE0LYF0j161OYZxK7mM4fSe9DgT/Xp/Jv7fFd1mJpnM+JLgVM7MHhrAgZurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYOv0IXslR/MWQ6rt0Z95832S7yvpspIEhidZ6M1aRo=;
 b=RBAxCr8v1iaOA6seAqVUJhLuVbca6Lkx6rFAP5z2/7IxiYy79L035HAvWL0jruO8K8wzUaoF2SG72S55YsMbhHTbhrj4TuRCG8lf0A6A7VlWZgSK2lP9vvgc72gu1BPsY4aUeRoPJQA9lVPAA5CBOyBdBQ/LzNNMHtxHAh1rzNg=
Received: from PH0PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:e::10)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 12:35:52 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::8c) by PH0PR07CA0035.outlook.office365.com
 (2603:10b6:510:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 12:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Wed, 9 Aug 2023 12:35:52 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 07:35:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 05:35:51 -0700
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 9 Aug 2023 07:35:35 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <syed.sabakareem@amd.com>, <mastan.katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>
Subject: [PATCH 1/3] ASoC: SOF: amd: Add sof support for vangogh platform
Date:   Wed, 9 Aug 2023 18:05:20 +0530
Message-ID: <20230809123534.287707-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b87ad4-c87c-46f1-588b-08db98d52b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oub6vo1zHFtJaPIRqD0khH1yOo+CRKQZ5f/zjS8Fur0yywZajVb01+aWCDutwsad/H7scpt/uoyEte4VzNqMawj98RmwBaYUM75QPGdhC2OUG8OadEYDdWktUO8pNNGp3jfkGwPi84wSNlQ0NKLLrF5wLPwhbty95rVtsBcGCqgqTM9pphJtSZpRQejWaTPgX8C4DNAM3nEibmqU/OLc7IKraPRDGOCOTAUrCNPegrkXqZh6s0cuqKEFGGtCwDl02nGawJhYUgXRaKxbGeBlrMxrsPmQ99MHKtLbI7AQzjEesYpG21GLJSLQpRxRjuad4x/MG+TPSVnwG6bA6BXG3+nntkYQEeAW8dFyZFPRYf9oNEgf0cm+e4JaazUGZw5ZI3xhsrtb1FrVSXcevHfYlaiILrgk9dxCr/LRxFpwLWnYZh586EKaw8/1YkY1DzgT1JGQNJ/krt6DLI9ffG1rnpV/DlSq/T+Her7yLh8UJ5jjbVVFxpC+kUpOamzOKvRHGhP4VYdaqYm4Alw7zv7U8rw7WGGQOH86uH+pnDgQEyeR0FZIZ4k+vCq9vUpmnNqESS2+q6po8Qs+yLgcxvz0T72SA2NOHr5Fd1/Mc4kAUwm6h6EOC+eohifv9JTGXDXo2n39QKclgLB8eG3SHHCquUOo+ybfGK/JwkEwQOxLPgSa/UaL6CmPiqJIFRMfNOSG1+5hR64yvvL6ldfxsPML+LlaZRUNO4WPMe/mIRQ1pwjXYoUNUVamnfWYn5KdqECxo21cOHDAFLb2ukwny5Luag==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(82310400008)(1800799006)(186006)(46966006)(36840700001)(40470700004)(83380400001)(6666004)(2616005)(81166007)(426003)(54906003)(1076003)(356005)(110136005)(478600001)(82740400003)(26005)(70206006)(4326008)(70586007)(47076005)(7696005)(36860700001)(336012)(7416002)(30864003)(40460700003)(5660300002)(8676002)(2906002)(41300700001)(8936002)(316002)(86362001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 12:35:52.1650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b87ad4-c87c-46f1-588b-08db98d52b21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pci driver and platform driver to enable SOF support
on ACP5x architecture based Vangogh platform.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/sof/amd/Kconfig          |  12 ++-
 sound/soc/sof/amd/Makefile         |   4 +-
 sound/soc/sof/amd/acp-dsp-offset.h |   8 +-
 sound/soc/sof/amd/acp.h            |   9 +-
 sound/soc/sof/amd/pci-vangogh.c    | 105 +++++++++++++++++++
 sound/soc/sof/amd/vangogh.c        | 156 +++++++++++++++++++++++++++++
 6 files changed, 290 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/sof/amd/pci-vangogh.c
 create mode 100644 sound/soc/sof/amd/vangogh.c

diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
index 7dbc8df5cfe6..f2faa08f0c0e 100644
--- a/sound/soc/sof/amd/Kconfig
+++ b/sound/soc/sof/amd/Kconfig
@@ -2,7 +2,7 @@
 # This file is provided under a dual BSD/GPLv2 license. When using or
 # redistributing this file, you may do so under either license.
 #
-# Copyright(c) 2021 Advanced Micro Devices, Inc. All rights reserved.
+# Copyright(c) 2021, 2023 Advanced Micro Devices, Inc. All rights reserved.
 
 config SND_SOC_SOF_AMD_TOPLEVEL
 	tristate "SOF support for AMD audio DSPs"
@@ -34,6 +34,16 @@ config SND_SOC_SOF_AMD_RENOIR
 	help
 	  Select this option for SOF support on AMD Renoir platform
 
+config SND_SOC_SOF_AMD_VANGOGH
+	tristate "SOF support for VANGOGH"
+	depends on SND_SOC_SOF_PCI
+	select SND_SOC_SOF_AMD_COMMON
+	help
+	  Select this option for SOF support
+	  on AMD Vangogh platform.
+	  Say Y if you want to enable SOF on Vangogh.
+	  If unsure select "N".
+
 config SND_SOC_SOF_AMD_REMBRANDT
 	tristate "SOF support for REMBRANDT"
 	depends on SND_SOC_SOF_PCI
diff --git a/sound/soc/sof/amd/Makefile b/sound/soc/sof/amd/Makefile
index ef9f7df4e379..f3b375e67a6f 100644
--- a/sound/soc/sof/amd/Makefile
+++ b/sound/soc/sof/amd/Makefile
@@ -2,13 +2,15 @@
 # This file is provided under a dual BSD/GPLv2 license. When using or
 # redistributing this file, you may do so under either license.
 #
-# Copyright(c) 2021 Advanced Micro Devices, Inc. All rights reserved.
+# Copyright(c) 2021, 2023 Advanced Micro Devices, Inc. All rights reserved.
 
 snd-sof-amd-acp-objs := acp.o acp-loader.o acp-ipc.o acp-pcm.o acp-stream.o acp-trace.o acp-common.o
 snd-sof-amd-acp-$(CONFIG_SND_SOC_SOF_ACP_PROBES) = acp-probes.o
 snd-sof-amd-renoir-objs := pci-rn.o renoir.o
 snd-sof-amd-rembrandt-objs := pci-rmb.o rembrandt.o
+snd-sof-amd-vangogh-objs := pci-vangogh.o vangogh.o
 
 obj-$(CONFIG_SND_SOC_SOF_AMD_COMMON) += snd-sof-amd-acp.o
 obj-$(CONFIG_SND_SOC_SOF_AMD_RENOIR) +=snd-sof-amd-renoir.o
 obj-$(CONFIG_SND_SOC_SOF_AMD_REMBRANDT) +=snd-sof-amd-rembrandt.o
+obj-$(CONFIG_SND_SOC_SOF_AMD_VANGOGH) +=snd-sof-amd-vangogh.o
diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index 920155dee819..19ef2b4c46d6 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -3,7 +3,7 @@
  * This file is provided under a dual BSD/GPLv2 license. When using or
  * redistributing this file, you may do so under either license.
  *
- * Copyright(c) 2021 Advanced Micro Devices, Inc. All rights reserved.
+ * Copyright(c) 2021, 2023 Advanced Micro Devices, Inc. All rights reserved.
  *
  * Author: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
  */
@@ -49,27 +49,33 @@
 #define ACP_CONTROL				0x1004
 
 #define ACP3X_I2S_PIN_CONFIG			0x1400
+#define ACP5X_I2S_PIN_CONFIG			0x1400
 #define ACP6X_I2S_PIN_CONFIG			0x1440
 
 /* Registers offsets from ACP_PGFSM block */
 #define ACP3X_PGFSM_BASE			0x141C
+#define ACP5X_PGFSM_BASE			0x1424
 #define ACP6X_PGFSM_BASE                        0x1024
 #define PGFSM_CONTROL_OFFSET			0x0
 #define PGFSM_STATUS_OFFSET			0x4
 #define ACP3X_CLKMUX_SEL			0x1424
+#define ACP5X_CLKMUX_SEL			0x142C
 #define ACP6X_CLKMUX_SEL			0x102C
 
 /* Registers from ACP_INTR block */
 #define ACP3X_EXT_INTR_STAT			0x1808
+#define ACP5X_EXT_INTR_STAT			0x1808
 #define ACP6X_EXT_INTR_STAT                     0x1A0C
 
 #define ACP3X_DSP_SW_INTR_BASE			0x1814
+#define ACP5X_DSP_SW_INTR_BASE			0x1814
 #define ACP6X_DSP_SW_INTR_BASE                  0x1808
 #define DSP_SW_INTR_CNTL_OFFSET			0x0
 #define DSP_SW_INTR_STAT_OFFSET			0x4
 #define DSP_SW_INTR_TRIG_OFFSET			0x8
 #define ACP_ERROR_STATUS			0x18C4
 #define ACP3X_AXI2DAGB_SEM_0			0x1880
+#define ACP5X_AXI2DAGB_SEM_0			0x1884
 #define ACP6X_AXI2DAGB_SEM_0			0x1874
 
 /* Registers from ACP_SHA block */
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 72fa0af971f0..73c3e1373d42 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -3,7 +3,7 @@
  * This file is provided under a dual BSD/GPLv2 license. When using or
  * redistributing this file, you may do so under either license.
  *
- * Copyright(c) 2021 Advanced Micro Devices, Inc. All rights reserved.
+ * Copyright(c) 2021, 2023 Advanced Micro Devices, Inc. All rights reserved.
  *
  * Author: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
  */
@@ -32,6 +32,7 @@
 
 #define ACP_DSP_INTR_EN_MASK			0x00000001
 #define ACP3X_SRAM_PTE_OFFSET			0x02050000
+#define ACP5X_SRAM_PTE_OFFSET			0x02050000
 #define ACP6X_SRAM_PTE_OFFSET			0x03800000
 #define PAGE_SIZE_4K_ENABLE			0x2
 #define ACP_PAGE_SIZE				0x1000
@@ -56,9 +57,11 @@
 #define ACP_DSP_TO_HOST_IRQ			0x04
 
 #define ACP_RN_PCI_ID				0x01
+#define ACP_VANGOGH_PCI_ID			0x50
 #define ACP_RMB_PCI_ID				0x6F
 
 #define HOST_BRIDGE_CZN				0x1630
+#define HOST_BRIDGE_VGH				0x1645
 #define HOST_BRIDGE_RMB				0x14B5
 #define ACP_SHA_STAT				0x8000
 #define ACP_PSP_TIMEOUT_US			1000000
@@ -163,6 +166,7 @@ struct acp_dsp_stream {
 
 struct sof_amd_acp_desc {
 	unsigned int rev;
+	const char *name;
 	unsigned int host_bridge_id;
 	u32 pgfsm_base;
 	u32 ext_intr_stat;
@@ -253,6 +257,8 @@ extern struct snd_sof_dsp_ops sof_acp_common_ops;
 
 extern struct snd_sof_dsp_ops sof_renoir_ops;
 int sof_renoir_ops_init(struct snd_sof_dev *sdev);
+extern struct snd_sof_dsp_ops sof_vangogh_ops;
+int sof_vangogh_ops_init(struct snd_sof_dev *sdev);
 extern struct snd_sof_dsp_ops sof_rembrandt_ops;
 int sof_rembrandt_ops_init(struct snd_sof_dev *sdev);
 
@@ -282,4 +288,5 @@ static inline const struct sof_amd_acp_desc *get_chip_info(struct snd_sof_pdata
 int acp_probes_register(struct snd_sof_dev *sdev);
 void acp_probes_unregister(struct snd_sof_dev *sdev);
 
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_vangogh_sof_machines[];
 #endif
diff --git a/sound/soc/sof/amd/pci-vangogh.c b/sound/soc/sof/amd/pci-vangogh.c
new file mode 100644
index 000000000000..d8be42fbcb6d
--- /dev/null
+++ b/sound/soc/sof/amd/pci-vangogh.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2023 Advanced Micro Devices, Inc. All rights reserved.
+//
+// Authors: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
+
+/*.
+ * PCI interface for Vangogh ACP device
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <sound/sof.h>
+#include <sound/soc-acpi.h>
+
+#include "../ops.h"
+#include "../sof-pci-dev.h"
+#include "../../amd/mach-config.h"
+#include "acp.h"
+#include "acp-dsp-offset.h"
+
+#define ACP5X_FUTURE_REG_ACLK_0 0x1864
+
+static const struct sof_amd_acp_desc vangogh_chip_info = {
+	.rev		= 5,
+	.name		= "vangogh",
+	.host_bridge_id = HOST_BRIDGE_VGH,
+	.pgfsm_base	= ACP5X_PGFSM_BASE,
+	.ext_intr_stat	= ACP5X_EXT_INTR_STAT,
+	.dsp_intr_base	= ACP5X_DSP_SW_INTR_BASE,
+	.sram_pte_offset = ACP5X_SRAM_PTE_OFFSET,
+	.hw_semaphore_offset = ACP5X_AXI2DAGB_SEM_0,
+	.acp_clkmux_sel = ACP5X_CLKMUX_SEL,
+	.probe_reg_offset = ACP5X_FUTURE_REG_ACLK_0,
+};
+
+static const struct sof_dev_desc vangogh_desc = {
+	.machines		= snd_soc_acpi_amd_vangogh_sof_machines,
+	.resindex_lpe_base	= 0,
+	.resindex_pcicfg_base	= -1,
+	.resindex_imr_base	= -1,
+	.irqindex_host_ipc	= -1,
+	.chip_info		= &vangogh_chip_info,
+	.ipc_supported_mask     = BIT(SOF_IPC),
+	.ipc_default            = SOF_IPC,
+	.default_fw_path	= {
+		[SOF_IPC] = "amd/sof",
+	},
+	.default_tplg_path	= {
+		[SOF_IPC] = "amd/sof-tplg",
+	},
+	.default_fw_filename	= {
+		[SOF_IPC] = "sof-vangogh.ri",
+	},
+	.nocodec_tplg_filename	= "sof-acp.tplg",
+	.ops			= &sof_vangogh_ops,
+	.ops_init		= sof_vangogh_ops_init,
+};
+
+static int acp_pci_vgh_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+{
+	unsigned int flag;
+
+	if (pci->revision != ACP_VANGOGH_PCI_ID)
+		return -ENODEV;
+
+	flag = snd_amd_acp_find_config(pci);
+	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
+		return -ENODEV;
+
+	return sof_pci_probe(pci, pci_id);
+};
+
+static void acp_pci_vgh_remove(struct pci_dev *pci)
+{
+	sof_pci_remove(pci);
+}
+
+/* PCI IDs */
+static const struct pci_device_id vgh_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_PCI_DEV_ID),
+	.driver_data = (unsigned long)&vangogh_desc},
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, vgh_pci_ids);
+
+/* pci_driver definition */
+static struct pci_driver snd_sof_pci_amd_vgh_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = vgh_pci_ids,
+	.probe = acp_pci_vgh_probe,
+	.remove = acp_pci_vgh_remove,
+	.driver = {
+		.pm = &sof_pci_pm,
+	},
+};
+module_pci_driver(snd_sof_pci_amd_vgh_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(SND_SOC_SOF_AMD_COMMON);
+MODULE_IMPORT_NS(SND_SOC_SOF_PCI_DEV);
diff --git a/sound/soc/sof/amd/vangogh.c b/sound/soc/sof/amd/vangogh.c
new file mode 100644
index 000000000000..f3f6bd790788
--- /dev/null
+++ b/sound/soc/sof/amd/vangogh.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2023 Advanced Micro Devices, Inc.
+//
+// Authors: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
+
+/*
+ * Hardware interface for Audio DSP on Vangogh platform
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+
+#include "../ops.h"
+#include "../sof-audio.h"
+#include "acp.h"
+#include "acp-dsp-offset.h"
+
+#define I2S_HS_INSTANCE		0
+#define I2S_BT_INSTANCE		1
+#define I2S_SP_INSTANCE		2
+#define PDM_DMIC_INSTANCE	3
+#define I2S_HS_VIRTUAL_INSTANCE	4
+
+static struct snd_soc_dai_driver vangogh_sof_dai[] = {
+	[I2S_HS_INSTANCE] = {
+		.id = I2S_HS_INSTANCE,
+		.name = "acp-sof-hs",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S HS controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+
+	[I2S_BT_INSTANCE] = {
+		.id = I2S_BT_INSTANCE,
+		.name = "acp-sof-bt",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S BT controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+
+	[I2S_SP_INSTANCE] = {
+		.id = I2S_SP_INSTANCE,
+		.name = "acp-sof-sp",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S SP controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+
+	[PDM_DMIC_INSTANCE] = {
+		.id = PDM_DMIC_INSTANCE,
+		.name = "acp-sof-dmic",
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 4,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+
+	[I2S_HS_VIRTUAL_INSTANCE] = {
+		.id = I2S_HS_VIRTUAL_INSTANCE,
+		.name = "acp-sof-hs-virtual",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+					   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S HS-Virtual controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+};
+
+/* Vangogh ops */
+struct snd_sof_dsp_ops sof_vangogh_ops;
+EXPORT_SYMBOL_NS(sof_vangogh_ops, SND_SOC_SOF_AMD_COMMON);
+
+int sof_vangogh_ops_init(struct snd_sof_dev *sdev)
+{
+	/* common defaults */
+	memcpy(&sof_vangogh_ops, &sof_acp_common_ops, sizeof(struct snd_sof_dsp_ops));
+
+	sof_vangogh_ops.drv = vangogh_sof_dai;
+	sof_vangogh_ops.num_drv = ARRAY_SIZE(vangogh_sof_dai);
+
+	return 0;
+}
+
+MODULE_IMPORT_NS(SND_SOC_SOF_AMD_COMMON);
+MODULE_DESCRIPTION("VANGOGH SOF Driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1

