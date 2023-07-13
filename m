Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D507752200
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjGMM5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjGMM5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:57:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78687173B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTAbBrrXPqRr1mXgucOU5lC+YIojymYlfyaTtJL7xypSQJQozDwY5BIy1rPol0r/aMcpceJcB2FgedOB69iK+pkgPK0N5SDhIjTx32vIZy+G9KFamWjPTJAMSorKwIpqa/Y5wYBGiGyOLj32CFHPi8eq2UCyYXTKb2Uqkxh1xt4jrtlp4WoVQh86BzTPKim6SY68aYqPBnv+/Ri5CakH56dVGwWLPT29Mdd1kDzqYxc1SA95jCFszXirkN9ipbUPXmaJXbmw4z0Oh8xuOb6LNNXS11yYYJJawuG9FQDCk7jPaRBr9S5wFfTaGSM00HJUPhMIKaeR57qL3xajiLz1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cA+q6vEZZMd4FyxrLe+MzC/9+458G/yI6cBlw28Zfo=;
 b=LVzAOcBECVMXnjU6dcDuy+97zRo1+uM4UyYaSQ6SvBhLpjaoGrgfjX3haUjZ2IqmG0Of2aHd1TjlnZO2xAVnuOUuLf5KIW19efdNrtOLsc/c7s1JygZmqPXB88i/b0P39pEx8ADgMwrznG0IrXlU3gbSyIMHxwyB2GCY/XSHJLlQ3kkpuslYwohMDQn1fGEQ+FMUb/3eKuDTwMfQU0R9BYpJwoNJTsD9+Q9I2u/cAbfqGCHCclT/L00SG4pwQBA2I9tv6BWkaJYGk7HuNrKyjQYzQWMQsOY+Jf5s85LNmmXwtHYP0LBfnMfGLbeMn1hdpDmwnDzM9CPflwpJiGAsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=amd.corp-partner.google.com; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=amd.corp-partner.google.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cA+q6vEZZMd4FyxrLe+MzC/9+458G/yI6cBlw28Zfo=;
 b=MVgKnmGmn1xl8J1Fbe6rA7mprr9yIxbulYkEAKJHJblX4hIK7ed+1v8Ze1tSMVWhPKUFjieb1W8ePWodAkYL5WsLATYZC+gQqerh9tWZPAQ5CZ6IZ7fouWBXH+9wv2Lf15bq/2MBWD4On33p0B8gNrLI4F3n4g6+iQ/5fhpr+3WFOr1xEBP3SOgA5anGGYC7nUKWIom4WSw1JWZ5oIysEbg9lqA4ji40Ql5i/1uquR/+Ta3JyCpP7Kc4H+Xhx5CYEjM88ruw6A/8YQo8z3RPs0ZChSPj22faw6cjKXS0DP7B17iYTkGytxbWS/0OfV0lwF94qTvDLVCk/EoOmF1hgw==
Received: from SJ0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:33a::10)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 12:57:29 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::6f) by SJ0PR03CA0005.outlook.office365.com
 (2603:10b6:a03:33a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Thu, 13 Jul 2023 12:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.corp-partner.google.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=amd.corp-partner.google.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.corp-partner.google.com discourages use of 165.204.84.17 as permitted
 sender)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 12:57:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 07:57:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 07:57:23 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Thu, 13 Jul 2023 07:57:02 -0500
From:   V sujith kumar Reddy 
        <vsujithkumar.reddy@amd.corp-partner.google.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <ssabakar@amd.com>, <akondave@amd.com>,
        <mastan.katragadda@amd.com>,
        "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "Mastan Katragadda" <Mastan.Katragadda@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>
Subject: [PATCH 1/3] ASoC: SOF: amd: Add Probe functionality support for amd platforms.
Date:   Thu, 13 Jul 2023 18:27:07 +0530
Message-ID: <20230713125709.418851-2-vsujithkumar.reddy@amd.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713125709.418851-1-vsujithkumar.reddy@amd.corp-partner.google.com>
References: <20230713125709.418851-1-vsujithkumar.reddy@amd.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT005:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e622fb-0bab-464f-4274-08db83a0b6b8
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XERzmxOe0AXYBMz5h3d9zwGvZJ5dt+d7sNLhhkJQLMLBZVLIaevCLdAVF2L5D0hg4rcuzjZtDw0ioEUv7AnRi4X5aicbJPYRs5rZoPRmvguHJjuojaoh+1Mo8me3X665b+T6ORnTvvym4RjaNJx4SHySMWRV4dbpwHGjuEkrreYH/s/1dBLzgqwwN8QpwEOJA5Kzu/nwU++llJP2hC5kRpqeyteelwJTMPGZNq/KA/zpoG4YdV7zW1V3fdM3GqNIWwmKaMUr4mndGjmymB0stvmeqDHnjSIer0IUo7Ddp1/++hyHuIZscqvavT9lvgzDmZgDgntC6e/uJ1MPpBNqL8ffXYrkkiOgp5iNZQbs2HCDt3UTHw1y5oLn4O+1Im00dxqtLl+ermhLJaiwAFF3Dx5S9uGhJ/qMzYbHvJgCTk+jSanHD3wqegeHCbBLmrJGN5r6cYEu4uEPRuKFmOTEjepNrpdIdj8E1qSVjKfa7mHdpf1Q7snf37RlC82LfGFrrVxJcToL22uL1Qe7rdQOXStKkfE4suePfKyinDg5c65h3durZgID4IQ5Jgw7d475WdVNqYKtWT8BKRiYpPdoqbofafh3NEReRlmMSfq295aPkRSjx1yNFTbkNS/reP4XeVNHGS3BKwCa16k1+dzZdDQA+iElBArJnjqVVlK8jZ6U2xBkm0oi7cVH7Hst1BfgWc3udD9GTJjF/UY8+K2nvvQrUHyByRcJ7RMRD99JSyoSOfMc2e6nHSDIcjzn5vpu
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(40470700004)(46966006)(7416002)(4326008)(70586007)(70206006)(41300700001)(316002)(2906002)(498600001)(76482006)(5660300002)(8936002)(8676002)(54906003)(110136005)(40460700003)(26005)(1076003)(40480700001)(336012)(83380400001)(35950700001)(47076005)(2616005)(81166007)(356005)(82740400003)(82310400005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:57:28.5029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e622fb-0bab-464f-4274-08db83a0b6b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>

This patch consist of probe client device registration,stream tag
and dma channel configuration for SOF firmware.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/Kconfig      |   8 ++
 sound/soc/sof/amd/Makefile     |   1 +
 sound/soc/sof/amd/acp-common.c |   4 +
 sound/soc/sof/amd/acp-ipc.c    |  26 ++++++
 sound/soc/sof/amd/acp-probes.c | 147 +++++++++++++++++++++++++++++++++
 sound/soc/sof/amd/acp.h        |   9 ++
 6 files changed, 195 insertions(+)
 create mode 100644 sound/soc/sof/amd/acp-probes.c

diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
index 1cb92d6030e3..7dbc8df5cfe6 100644
--- a/sound/soc/sof/amd/Kconfig
+++ b/sound/soc/sof/amd/Kconfig
@@ -21,6 +21,7 @@ config SND_SOC_SOF_AMD_COMMON
 	select SND_SOC_SOF_PCI_DEV
 	select SND_AMD_ACP_CONFIG
 	select SND_SOC_SOF_XTENSA
+	select SND_SOC_SOF_ACP_PROBES
 	select SND_SOC_ACPI if ACPI
 	help
 	  This option is not user-selectable but automatically handled by
@@ -42,4 +43,11 @@ config SND_SOC_SOF_AMD_REMBRANDT
 	  Say Y if you want to enable SOF on Rembrandt.
 	  If unsure select "N".
 
+config SND_SOC_SOF_ACP_PROBES
+	tristate
+	select SND_SOC_SOF_DEBUG_PROBES
+	help
+	  This option is not user-selectable but automatically handled by
+	  'select' statements at a higher level
+
 endif
diff --git a/sound/soc/sof/amd/Makefile b/sound/soc/sof/amd/Makefile
index 5626d13b3e69..ef9f7df4e379 100644
--- a/sound/soc/sof/amd/Makefile
+++ b/sound/soc/sof/amd/Makefile
@@ -5,6 +5,7 @@
 # Copyright(c) 2021 Advanced Micro Devices, Inc. All rights reserved.
 
 snd-sof-amd-acp-objs := acp.o acp-loader.o acp-ipc.o acp-pcm.o acp-stream.o acp-trace.o acp-common.o
+snd-sof-amd-acp-$(CONFIG_SND_SOC_SOF_ACP_PROBES) = acp-probes.o
 snd-sof-amd-renoir-objs := pci-rn.o renoir.o
 snd-sof-amd-rembrandt-objs := pci-rmb.o rembrandt.o
 
diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
index df36b411a12e..3a0c7688dcfe 100644
--- a/sound/soc/sof/amd/acp-common.c
+++ b/sound/soc/sof/amd/acp-common.c
@@ -196,6 +196,10 @@ struct snd_sof_dsp_ops sof_acp_common_ops = {
 	.dbg_dump		= amd_sof_dump,
 	.debugfs_add_region_item = snd_sof_debugfs_add_region_item_iomem,
 	.dsp_arch_ops = &sof_xtensa_arch_ops,
+
+	/* probe client device registation */
+	.register_ipc_clients = acp_probes_register,
+	.unregister_ipc_clients = acp_probes_unregister,
 };
 EXPORT_SYMBOL_NS(sof_acp_common_ops, SND_SOC_SOF_AMD_COMMON);
 
diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index 8a0fc635a997..81a2c096a185 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -155,6 +155,8 @@ static void acp_dsp_ipc_get_reply(struct snd_sof_dev *sdev)
 irqreturn_t acp_sof_ipc_irq_thread(int irq, void *context)
 {
 	struct snd_sof_dev *sdev = context;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
 	unsigned int dsp_msg_write = sdev->debug_box.offset +
 				     offsetof(struct scratch_ipc_conf, sof_dsp_msg_write);
 	unsigned int dsp_ack_write = sdev->debug_box.offset +
@@ -200,6 +202,30 @@ irqreturn_t acp_sof_ipc_irq_thread(int irq, void *context)
 		return IRQ_HANDLED;
 	}
 
+	if (desc->probe_reg_offset) {
+		u32 val;
+		u32 posn;
+
+		/* Probe register consists of two parts
+		 * (0-30) bit has cumulative position value
+		 * 31 bit is a synchronization flag between DSP and CPU
+		 * for the position update
+		 */
+		val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->probe_reg_offset);
+		if (val & PROBE_STATUS_BIT) {
+			posn = val & ~PROBE_STATUS_BIT;
+			if (adata->probe_stream) {
+				/* Probe related posn value is of 31 bits limited to 2GB
+				 * once wrapped DSP won't send posn interrupt.
+				 */
+				adata->probe_stream->cstream_posn = posn;
+				snd_compr_fragment_elapsed(adata->probe_stream->cstream);
+				snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->probe_reg_offset, posn);
+				ipc_irq = true;
+			}
+		}
+	}
+
 	if (!ipc_irq)
 		dev_dbg_ratelimited(sdev->dev, "nothing to do in IPC IRQ thread\n");
 
diff --git a/sound/soc/sof/amd/acp-probes.c b/sound/soc/sof/amd/acp-probes.c
new file mode 100644
index 000000000000..778cf1a8b610
--- /dev/null
+++ b/sound/soc/sof/amd/acp-probes.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2023 Advanced Micro Devices, Inc.
+//
+// Authors: V Sujith Kumar Reddy <Vsujithkumar.Reddy@amd.com>
+
+/*
+ * Probe interface for generic AMD audio ACP DSP block
+ */
+
+#include <linux/module.h>
+#include <sound/soc.h>
+#include "../sof-priv.h"
+#include "../sof-client-probes.h"
+#include "../sof-client.h"
+#include "../ops.h"
+#include "acp.h"
+#include "acp-dsp-offset.h"
+
+static int acp_probes_compr_startup(struct sof_client_dev *cdev,
+				    struct snd_compr_stream *cstream,
+				    struct snd_soc_dai *dai, u32 *stream_id)
+{
+	struct snd_sof_dev *sdev = sof_client_dev_to_sof_dev(cdev);
+	struct acp_dsp_stream *stream;
+	struct acp_dev_data *adata;
+
+	adata = sdev->pdata->hw_pdata;
+	stream = acp_dsp_stream_get(sdev, 0);
+	if (!stream)
+		return -ENODEV;
+
+	stream->cstream = cstream;
+	cstream->runtime->private_data = stream;
+
+	adata->probe_stream = stream;
+	*stream_id = stream->stream_tag;
+
+	return 0;
+}
+
+static int acp_probes_compr_shutdown(struct sof_client_dev *cdev,
+				     struct snd_compr_stream *cstream,
+				     struct snd_soc_dai *dai)
+{
+	struct snd_sof_dev *sdev = sof_client_dev_to_sof_dev(cdev);
+	struct acp_dsp_stream *stream = cstream->runtime->private_data;
+	struct acp_dev_data *adata;
+	int ret;
+
+	ret = acp_dsp_stream_put(sdev, stream);
+	if (ret < 0) {
+		dev_err(sdev->dev, "Failed to release probe compress stream\n");
+		return ret;
+	}
+
+	adata = sdev->pdata->hw_pdata;
+	stream->cstream = NULL;
+	cstream->runtime->private_data = NULL;
+	adata->probe_stream = NULL;
+
+	return 0;
+}
+
+static int acp_probes_compr_set_params(struct sof_client_dev *cdev,
+				       struct snd_compr_stream *cstream,
+				       struct snd_compr_params *params,
+				       struct snd_soc_dai *dai)
+{
+	struct snd_sof_dev *sdev = sof_client_dev_to_sof_dev(cdev);
+	struct acp_dsp_stream *stream = cstream->runtime->private_data;
+	unsigned int buf_offset, index;
+	u32 size;
+	int ret;
+
+	stream->dmab = cstream->runtime->dma_buffer_p;
+	stream->num_pages = PFN_UP(cstream->runtime->dma_bytes);
+	size = cstream->runtime->buffer_size;
+
+	ret = acp_dsp_stream_config(sdev, stream);
+	if (ret < 0) {
+		acp_dsp_stream_put(sdev, stream);
+		return ret;
+	}
+
+	/* write buffer size of stream in scratch memory */
+
+	buf_offset = sdev->debug_box.offset +
+		     offsetof(struct scratch_reg_conf, buf_size);
+	index = stream->stream_tag - 1;
+	buf_offset = buf_offset + index * 4;
+
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + buf_offset, size);
+
+	return 0;
+}
+
+static int acp_probes_compr_trigger(struct sof_client_dev *cdev,
+				    struct snd_compr_stream *cstream,
+				    int cmd, struct snd_soc_dai *dai)
+{
+	/* Nothing to do here, as it is a mandatory callback just defined */
+	return 0;
+}
+
+static int acp_probes_compr_pointer(struct sof_client_dev *cdev,
+				    struct snd_compr_stream *cstream,
+				    struct snd_compr_tstamp *tstamp,
+				    struct snd_soc_dai *dai)
+{
+	struct acp_dsp_stream *stream = cstream->runtime->private_data;
+	struct snd_soc_pcm_stream *pstream;
+
+	pstream = &dai->driver->capture;
+	tstamp->copied_total = stream->cstream_posn;
+	tstamp->sampling_rate = snd_pcm_rate_bit_to_rate(pstream->rates);
+
+	return 0;
+}
+
+/* SOF client implementation */
+static const struct sof_probes_host_ops acp_probes_ops = {
+	.startup = acp_probes_compr_startup,
+	.shutdown = acp_probes_compr_shutdown,
+	.set_params = acp_probes_compr_set_params,
+	.trigger = acp_probes_compr_trigger,
+	.pointer = acp_probes_compr_pointer,
+};
+
+int acp_probes_register(struct snd_sof_dev *sdev)
+{
+	return sof_client_dev_register(sdev, "acp-probes", 0, &acp_probes_ops,
+				       sizeof(acp_probes_ops));
+}
+EXPORT_SYMBOL_NS(acp_probes_register, SND_SOC_SOF_AMD_COMMON);
+
+void acp_probes_unregister(struct snd_sof_dev *sdev)
+{
+	sof_client_dev_unregister(sdev, "acp-probes", 0);
+}
+EXPORT_SYMBOL_NS(acp_probes_unregister, SND_SOC_SOF_AMD_COMMON);
+
+MODULE_IMPORT_NS(SND_SOC_SOF_CLIENT);
+
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index c3659dbc3745..72fa0af971f0 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -77,6 +77,7 @@
 #define AMD_STACK_DUMP_SIZE			32
 
 #define SRAM1_SIZE				0x13A000
+#define PROBE_STATUS_BIT			BIT(31)
 
 enum clock_source {
 	ACP_CLOCK_96M = 0,
@@ -156,6 +157,8 @@ struct acp_dsp_stream {
 	int active;
 	unsigned int reg_offset;
 	size_t posn_offset;
+	struct snd_compr_stream *cstream;
+	u64 cstream_posn;
 };
 
 struct sof_amd_acp_desc {
@@ -168,6 +171,7 @@ struct sof_amd_acp_desc {
 	u32 hw_semaphore_offset;
 	u32 acp_clkmux_sel;
 	u32 fusion_dsp_offset;
+	u32 probe_reg_offset;
 };
 
 /* Common device data struct for ACP devices */
@@ -186,6 +190,7 @@ struct acp_dev_data {
 	struct acp_dsp_stream stream_buf[ACP_MAX_STREAM];
 	struct acp_dsp_stream *dtrace_stream;
 	struct pci_dev *smn_dev;
+	struct acp_dsp_stream *probe_stream;
 };
 
 void memcpy_to_scratch(struct snd_sof_dev *sdev, u32 offset, unsigned int *src, size_t bytes);
@@ -273,4 +278,8 @@ static inline const struct sof_amd_acp_desc *get_chip_info(struct snd_sof_pdata
 
 	return desc->chip_info;
 }
+
+int acp_probes_register(struct snd_sof_dev *sdev);
+void acp_probes_unregister(struct snd_sof_dev *sdev);
+
 #endif
-- 
2.25.1

