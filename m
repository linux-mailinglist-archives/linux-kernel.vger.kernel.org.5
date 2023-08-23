Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93BA78517F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjHWH2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjHWH2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:28:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D7410C6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/8BKcoOJZrAsGbJDVnQWDuPY+DTt2X6ylmm3oXiLvlRWp7RSW48cbYJM8B5YNJaeTpXon1roCflAzLmN65wmuW0YampU1zhSZcvwV8Bhw2rABvCbXBCQraqk7VkBPe+191ptEdf9NoaxwcZkEHuyiod/C0KjfOvwiZnzg/PHgSZ7jG34LHomVQ/H6GLDLsCx1WirI2vS9Hd06fqKPhgSqw3GLd1s3zs4NBehidyU9WytJZ4ekd5fw4ij4T0FCh6g0/v/FnFCbfKwCg9Kgj4c7APOZlx6gJkLuFS8eHxBnvu2TqY5Zkmzn3+xlk4HCyuMN4P9FB948CNtL2tDB1+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bQbgwARwAOZubUMjIiRI22jaHY1XaDo0nFr/CPGcxI=;
 b=BJuG+Y29u74FbsQpY7Nb/GveuDy1kUsSShV4FV7grvS1HaP9IXtFZe4epdWe+w1cfFRCBtutgtvm4xVgagGYT+cSvj2ZjiEMPh/367EjFDkAn3WioYldSUlD1vdaAdehouRQNIjyUmTVKQSAwB34U1FXvQ2e2B5HhLTeBqQiIzIUMPjprsOn1oi+d27E5ORltYGBnAl+GaSVzeTaADlQBckWOvZYvROcx12593jEoNt6IkOv4/e4rM9oC05DZ2Ks12rQa6p71WWZK7CIAQaOKJS82EJB1lJQrzcXOea/4ZqHZ20TkccNlKB3d+byacjy06VF0pjZhDr0f7oNymmhYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bQbgwARwAOZubUMjIiRI22jaHY1XaDo0nFr/CPGcxI=;
 b=3AMOX5jdLJLy4r6RTmIxpA4rpSUFOlsgL4RqIAZ6pre7WjtdbfJs1UYa/VP4uE6pNXfciw0t/x71wkr2CGUBiPy+PB4L5gegrWSFwP/fkgjOUoeeJWaICClCkWre+9fyzMOssyCVRf/bsrVAuwHmWTWNGAuuBeZbEiyTwuHlf1M=
Received: from PA7P264CA0284.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:373::10)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 07:28:24 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10a6:102:373:cafe::28) by PA7P264CA0284.outlook.office365.com
 (2603:10a6:102:373::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 07:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 07:28:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 02:28:22 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 23 Aug 2023 02:28:17 -0500
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
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] ASoC: SOF: amd: clear dsp to host interrupt status
Date:   Wed, 23 Aug 2023 13:03:39 +0530
Message-ID: <20230823073340.2829821-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823073340.2829821-1-Vijendar.Mukunda@amd.com>
References: <20230823073340.2829821-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e6a8b8-bcb3-4303-b964-08dba3aa88aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p0VWhURYsH+cpacWuNBJ/xhpHAx1bL/w/YrH47o2Bzze/6Wlewy9hD39Bl1xaRLVyRQnnYfXwLR7m2IkFxTUPn1Tmq3oVBhCdc9LKXNXExkHTNuWD+xyRo/Bt/4SmIp2UQyeSSlwYjVeovIkNGi6aRNSPHS81aQyzHhcL79Q/yqAqCq8eLJIMbXVZ2E9clM2d24hV3CMDY2o12VRcAm0AmFtHEyBe6dy+fU7CAE0/ofJ6pFrzcef6AF5Y3ZAD6HxFFgkYlBqfSt11SWbBXFuGxeiGekdoA9GWbnqcfENsT0+TLzer79cQnwTm2HvnSHbSZq9qfXnDZXlTuCOAHcre9hlnjNfPFtfPaN8TE2+Ur1g7bii+1CImQe1axxuPqIuA4ftjHvwt7FPdskcTIdJu6o9kqMQ1GtJ7/6E0tJihptX0cqcwPcnXDyS4ht7faD272Jd+/qARB4wHj7ORorPzywRr3bHucFEIx46xRo7LUEp6KwvATzvEM91QXIGuU5fHAnanqnsYWWrm0fmpFPWHwlT7CkG/XZQ8GE74QB4rlNgcnqIYMLWc+aYRxl8vi80VyH6pggqgs8vO6Sc61OZNTOv76MEs+Puh4PARNbqxvp4zg9mT122rTpgi+w6g5zg/T2Ph0N+pUCANPIy+fmvnEtFGcQGkJGRw7exEd9s9br4G5eZu7WvW9hid+qsstV7wYCzYmJYVCAAgmbA2czk545bcdd/GO+iH4JIPvFt63Taf1YNe/qd/7G4x9BreiGcLbBMEvHLZl8WmAPXhiyWKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(6666004)(40480700001)(7696005)(2616005)(1076003)(40460700003)(86362001)(4326008)(5660300002)(2906002)(7416002)(70586007)(70206006)(54906003)(8936002)(8676002)(36756003)(6916009)(41300700001)(316002)(81166007)(478600001)(82740400003)(36860700001)(83380400001)(356005)(426003)(47076005)(336012)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:28:23.5089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e6a8b8-bcb3-4303-b964-08dba3aa88aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSP_SW_INTR_STAT_OFFSET is a common interrupt register which will be
accessed by both ACP firmware and driver. This register contains register
bits corresponds to host to dsp interrupts and vice versa.

when dsp to host interrupt is reported, only clear dsp to host
interrupt bit in DSP_SW_INTR_STAT_OFFSET.

Fixes: 2e7c6652f9b8 ("ASoC: SOF: amd: Fix for handling spurious interrupts from DSP")

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index eceba9b794ab..19a801908b56 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -367,9 +367,9 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 	unsigned int val;
 
 	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET);
-	if (val) {
-		val |= ACP_DSP_TO_HOST_IRQ;
-		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET, val);
+	if (val & ACP_DSP_TO_HOST_IRQ) {
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET,
+				  ACP_DSP_TO_HOST_IRQ);
 		return IRQ_WAKE_THREAD;
 	}
 
-- 
2.34.1

