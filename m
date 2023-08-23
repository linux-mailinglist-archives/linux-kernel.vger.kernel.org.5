Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8F9785176
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjHWH1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjHWH13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:27:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EB7133
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdYDb67yvtwyxCuHPL/6vJbrcx+2QNYxsS9PmdgD3ZIaEL+a4HkUP2+FB1zXyASU2MLIQpF4srA7N7GyITAh4jL9WRzJSsR+p7yZjV2xIpkg24kZNHszCjvtquLehyPGSShH7lMTMuH0XgCT5YmYSgRbig8cfbavcGd8s2BEJPMu/57sA0trG+D1f/81ZkrWDb9Bc0rsIV+HNKhHKRdsuIR2CdyW634EqX3M1Uo6t3epMkAENRdf2riakiERdRwXGZb6yLHox5KrM88mHi0XhTZYUHNb0ZNsdmOLbkDzS0zbbqihpZYtt8Zig6zz1GpEuUO1MgmPAm3miJ3JTjY9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FKv+HHc9unuxWzc1s2Dhz+/pqriWqJ0I+9ZAqiHsoo=;
 b=OzFqVFQAf9IpU6oDGGmY1KcaceoeAiID9t1C7CZCs/qR+3TZG5Hu9nUSw7a3RODEADAa/wjsyKhtmQ7H8948r+2l/HJ1L+8mK/+Rwp3BUMJ1qcQvhX/uzzAA935BkFarHdOamRvnXXz9jO3bGYe0l1Gp2CiaJ36fVUsdB9TGweVog0aawkNKvovOeZro01Zq0sLVP+o4LbllIV438abyRMkIPYTA8sLs4uW6MeqZk+73doUE6lNq1lMk8TDhm8zsA9z3UTD2MCPy8H4vcQsfcxPvkSv98SbvmJ1FMBnJdmHwoeQtbcmmc6QoRizR769klAUWu20t91MhsE9Q3Tvayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FKv+HHc9unuxWzc1s2Dhz+/pqriWqJ0I+9ZAqiHsoo=;
 b=DzZ2GMILhCIZti86eO0PUAokixlnOKC00cGA3EVTcnqYqZl1tnWs7Wd0gKMRs+LckuvfDcP9JeOCpZ8DkD6/naupDTJ6prch0iIXVw6qLAZgxtIac1iZlq1uxa6oHgj6+Sk8Nyi96XsegrDDXguB8BwruEbCEsH3jK5dFzj9spk=
Received: from PA7P264CA0352.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37c::11)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 07:27:22 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10a6:102:37c:cafe::83) by PA7P264CA0352.outlook.office365.com
 (2603:10a6:102:37c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 07:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 07:27:20 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 02:27:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 00:27:14 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 23 Aug 2023 02:27:09 -0500
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
Subject: [PATCH 1/7] ASoC: SOF: amd: remove unused sha dma interrupt code
Date:   Wed, 23 Aug 2023 13:03:33 +0530
Message-ID: <20230823073340.2829821-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 441d9a0f-a53e-4d83-db36-08dba3aa6341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZxsszH7rgfe9BNCic1fi50MyhKpNzOl793VnWzKv9+1t4qan0n+38v5n508xE4rQp16Zm/BGiEreLAIstxRou43LxlAgUhT0jVung9DbPbYM7CCCerRL1I6NZTau9h7rrf+MUqbB1Y2X6VVJIzF62RjWZD70riqw4kH7IIxuDFUSxm+w3ulReipPBaWtRMzNYbzfshFXdcBkWrx+zADeMCLqtn28H5fo/2BSHql0JY8SYodHLb7X4C/0RYyzSOBJ7VH7BsaGZu0vef/uTKWK0jOh7dKRhPcIV67BCgSzytI/FgCWT9/4Lygfnl0iMLLyz4bM1+IjrhCZZWSN1C4UhwcAX+vxtel2fhwkXen0NPTh3pjlzVDZfQ1VEaEvbRKM/pT9ZcS3BFS2Fpx4QUp9dEfQTxQoeGDaFEbnMqbREMnMn5AKoeUuES2j+Zrj2qVr7yVupz0iYBYJpr/0WSqtYubDBVgYttcjqziLfuxVfKmiJB2BGbUAszKZ2nWGwEo84QQLiXCBvJy55APeYP8y5GHKJ8kzgYP3+5D/T0U8DuvE1obQ04gvCBCCR6RlCDjL3SpO6mvjbRBvEJV85QaWLo15Dr93cXxrfUZvMfsmIflRHeBMXg2KvWbQwe7smtbgAiJilb2b4DNfVtTX2wHImKpsUnilmemOuu+rl4Q/3Iem7rXs9Ex2wPJgbviVWllo55DUFUNap3exI9Q/kxSOlgUUhHhaTcFumFA3jksfbVlNCtw6nUSAHrjHojYAz2/AwDwRDC6uiSVaWenlEzO0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(6916009)(70206006)(70586007)(316002)(2616005)(8676002)(8936002)(4326008)(41300700001)(36756003)(40460700003)(1076003)(82740400003)(356005)(81166007)(478600001)(6666004)(40480700001)(83380400001)(2906002)(7416002)(36860700001)(7696005)(47076005)(5660300002)(426003)(86362001)(26005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:27:20.7616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 441d9a0f-a53e-4d83-db36-08dba3aa6341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During initial development time for RN platform, when SHA
dma gets completed, SHA DMA engine used to raise the ACP interrupt.
In ACP interrupt handler, SHA DMA interrupt got handled.
Currently SHA DMA compleition is verified by checking
transfer count using read poll time out logic.
Remove unused SHA dma interrupt handling code.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index b2e00a10a03e..630c2c5fe4c7 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -337,14 +337,7 @@ static irqreturn_t acp_irq_thread(int irq, void *context)
 {
 	struct snd_sof_dev *sdev = context;
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
-	unsigned int val, count = ACP_HW_SEM_RETRY_COUNT;
-
-	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat);
-	if (val & ACP_SHA_STAT) {
-		/* Clear SHA interrupt raised by PSP */
-		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, val);
-		return IRQ_HANDLED;
-	}
+	unsigned int count = ACP_HW_SEM_RETRY_COUNT;
 
 	while (snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->hw_semaphore_offset)) {
 		/* Wait until acquired HW Semaphore lock or timeout */
-- 
2.34.1

