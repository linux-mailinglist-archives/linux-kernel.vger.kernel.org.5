Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96978517C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjHWH21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjHWH2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:28:25 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B04C10CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNXmRszbUvx2+sUG7sofwgUiqgM+CEhYNyHY7r7hW07X3zZg12HXd4gvx98p+vkiDpY1A64RAZANIaZTtt1KYJtxezaix9Gd3YsODXFlbuJFj4DzIZJBUu6OCcj8w/PlpI1roaFUKuHv2L1s75sp1gJGdyZv/5fsQlIUA638g8536k+j/WZJzQi8168phClTFyuW4HP50qjKqsOpIejh8P5izZoNMk819lQbHk/Vh+9v64SMLwJYz8goB54n1QpZbT4wDyOOPpk8216sYNMo3i0gewfi67T51RO80Gd0DOvVFX2KfN0JtLciadipb0RiUm1s3LubyEEtfjZBLjaXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfhHANGNPPspIXdIIs16CG2zLlQRPodl7ByWUlDKty8=;
 b=GXA+aKkH0pXTV+qec7aeBEfeJYsYHURg4qLw/OGMbBq6ftSPF18Te4E8EYbKkkI8GNkXimdWuezjbsZDNHJuQaIG/Sd2z+UBHGn3NN4rvgEsreLMUE+daZd++wS5TzEWZ7cNNqSMvz8BWYpMjs9kWdsmzWA79+xShQcFVHsaoZHO1yvbnUrVT6OYXRCkuhDUIRe8OLUc0DZThzoRMcP+rv199P/ubTR9e31z3LCDdX6HD9nLdq/EYzIl1hiQZRXVLSc8NOezhZdZQv0xce0yRknVtrBUonVU5uGE3jHGKJtwTHZXwBlO7LK8WSsM6phgjY7sXMRozoVw3PMJSSV0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfhHANGNPPspIXdIIs16CG2zLlQRPodl7ByWUlDKty8=;
 b=F0T/bSZHqv1KShfOqymWbf8ZrREktZeyH+lwKNJceIZZvrMNVjT8FeR+nkmxf9thszV7jQM13G1XUCTHg71Sy+4QqVhk1xqD3+VblnYsfs6tLk0dyTxVwhwqULQfMXZr5if+WrSC4GNRY6bzu+p6pCPgxI8Abz0HPGN8X+NZ7KM=
Received: from SA9PR13CA0053.namprd13.prod.outlook.com (2603:10b6:806:22::28)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 07:28:10 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::4f) by SA9PR13CA0053.outlook.office365.com
 (2603:10b6:806:22::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Wed, 23 Aug 2023 07:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 07:28:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 02:28:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 02:28:09 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 23 Aug 2023 02:28:04 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] ASoC: SOF: amd: add conditional check for acp_clkmux_sel register
Date:   Wed, 23 Aug 2023 13:03:37 +0530
Message-ID: <20230823073340.2829821-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823073340.2829821-1-Vijendar.Mukunda@amd.com>
References: <20230823073340.2829821-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|BL1PR12MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: fce03d00-6516-4174-7b97-08dba3aa80c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPi5MaVnyHykhoj45nnsifEGmxaSH5s0LAzcIXHzHqTQh1lhx6f4jH8FmX1DIgMzEsJIW9yAsG1OxVbaa7S10VIBP8GFlPgVk+sxU9+ai9vvNk7jSR1Pf+C4BSVuyrsqUx45uYTMjTpBJslGnPjsqyQSEVN3KFw0GrOW6rVkFf/SB4W1oSsYqtI6zhBiukQdHv5i5N0NzwPr3RYFSNBKJvlmsSC/8qpfI4QX7OkuHnbg0Pj6K2FmI8NL4HUu60X3r4CwNaAnfjyhd1YqX43S1nKfSdDIrEB/YLeI7Nhq/VE9ek1JiKn4IY2Vmm71eq7vbkHXLaWR+H0VYFRRhGn8ctbKNNMhYhuRuqnstfrGUy30FwRulCzKB50tDIcDrup0ZXaXmgDDhHohsdnAsjo5Uuqf/9GE1yRu1zmpuLWRbx4tf+yHKHaQ5QvI4hOxendvBpK3NefVKUPOyGt8lCnO4VfEOY0fX+ocLGumuUMjJYt14oWPGD2stTHQxxmEdlqWsJbxKQd5BHPJdTN9dk74zt/Y/uRIuW9xh3b/k/YNbV81guZXR+Y3aoljYiIC3Gdm6LsP3gtoako7P0y0c85RygAR0SFEWKTTKWWmTdjsbfykqhVhvM4hkkJuHi1ldhBA0ZuKICglBOejwPIH+V/GA5TCdqvuFDElFvrHmK4SIyFAVY59Sqdqo6djPyaHWduqxu3UKTks9OYBJ4I55cCT5vX36kG1I35NNZBWgY1ix4PEsksgG2Msk8iLVbEflNjq72dPFqvbd+1bSzgrejvZ8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(478600001)(6666004)(1076003)(7696005)(426003)(2616005)(41300700001)(2906002)(70586007)(4744005)(70206006)(336012)(26005)(7416002)(8936002)(4326008)(316002)(54906003)(6916009)(8676002)(5660300002)(36756003)(86362001)(47076005)(36860700001)(83380400001)(81166007)(82740400003)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:28:10.2494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce03d00-6516-4174-7b97-08dba3aa80c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few AMD platforms require ACP ACLK as clock source.
Add conditional check for clock mux selection register for
switching between internal clock and ACP ACLK.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 61faae74d637..eceba9b794ab 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -423,7 +423,9 @@ static int acp_reset(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		dev_err(sdev->dev, "timeout in releasing reset\n");
 
-	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_clkmux_sel, ACP_CLOCK_ACLK);
+	if (desc->acp_clkmux_sel)
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_clkmux_sel, ACP_CLOCK_ACLK);
+
 	if (desc->ext_intr_enb)
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_enb, 0x01);
 
-- 
2.34.1

