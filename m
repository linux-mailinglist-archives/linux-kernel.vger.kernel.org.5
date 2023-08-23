Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE5E78517D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjHWH2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjHWH23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:28:29 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EB8E61
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA2smwK11/Vs93hoxATe1sjgNZ0YVA7ZSUnlTJ62/QtasUPCgrx4YdSfPUdGIeUMdl/8rrtWjP5s1xpsOqVgG1cBBszoNYst/BCuKjt00/DTql6KwKIU+WtGIDGoLJSCCpU27aFXOcdXc6fjE7QlCtAw3d/K6jOTDhOXg8TnBkheUhJDR2TRiKGoyKP5a3oGxs10pkwsBVNP1yREljaJS48ZtuMNdJD4RXSRn6aT/V5l5bLrrmz7Wn2NAkYFTAgxvAMF+unILoqGJou3cCG+SoNaNbSQf2+RPwk7xt09yyOJGCivXwhueLzASiEN9kdDAq0oOwAqSrbTRlQZ7Amfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AxnaeiVsjeSG/SJQXag9V66LgeDgU+x6C+xXjf6C0M=;
 b=jJeDms86JNYxAp4N9h0gRHeef6R6DoXEVaf3jQC57HdJbFX3UUEKIOYIWqolAc3E6OpWoZiONYU3xsF/fgk30yAmQj4tv1E6nHGtE4IVcDaELzmvtpNN5am8NlD2+zNYiy+n7t+VQtVeM51mgLgzf5OY6or/pja4f5c2IJSsNuJ5QzesthG8spLldZ2mOYT6Nrb8dPZrLhYhWVS6/ThNL1ENUjqI6RiYR7iopToUxfRlTiGbOlZ+gQlosGW6P5dftSMNkLLd16HI7rgq9yFybw/OfeKe/4O2Y+U8Y8Tvrt4rn7AXLm9KzPppBvTuG91WtA3xUc9T1rlSeLP0Czhp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AxnaeiVsjeSG/SJQXag9V66LgeDgU+x6C+xXjf6C0M=;
 b=sFKPJou+MMMaW0ZJQzwMdm/KmhPDtHxbXlxJbW73JwymhdbZm2k/M2CVvnFv928H+Dz5R2NRcncMcKqM/9xrC4d75LM84OKzRJbT+bJ2gCzpuPeXFe3+khjjuGkdx+sCbWCJVqKG9yiR4JHO7diyl+MKHvaLbMZzrbnaD6SaQcA=
Received: from SA0PR11CA0078.namprd11.prod.outlook.com (2603:10b6:806:d2::23)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 07:28:11 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::8c) by SA0PR11CA0078.outlook.office365.com
 (2603:10b6:806:d2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 07:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 07:28:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 02:28:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 02:27:38 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 23 Aug 2023 02:27:32 -0500
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
Subject: [PATCH 4/7] ASoC: SOF: amd: remove redundant clock mux selection register write
Date:   Wed, 23 Aug 2023 13:03:36 +0530
Message-ID: <20230823073340.2829821-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823073340.2829821-1-Vijendar.Mukunda@amd.com>
References: <20230823073340.2829821-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c62fc0-9eff-4787-dc24-08dba3aa8169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fClwth/XmS6oubLakPvtrSekMguVzftK8cORRspus9ROAZand8QTP3xOqWLAaVhw3UHRCh6eD5+aX39/vsu014KkHbwPR6t9bygk78EfquQSlc5C6sSowBLXvpVFHoRjBx4qgUT+iOygD8YPwphMskjf5xEbXlFB6Bx5n1ZW7Fer6vkApFeOTgcS4t4QKTV3OnYKlIkbtFM8MEtu0vAmwyP2zj6vgM6zHAhW/DtWtPyuHU5jOqeWxN4lA8yDnJqxsGGgpYxUGvc3fh3qRvBaPo6KQDMMXNpHJKb2AuVoWQSInm95RuTad5SUtpQyfA6OXzY4Kup2JSAi/VEGfc9nG6exze+9MeVeaGGX+ppLCvkfDM93ThuxAMLZcuCmNo5rMVU6AP4B/Mm532XKg3nJE17LxtOLjoBPeawmJ4R3xsA9tU7p0JazYRRDAEns+zwt2wu+djMoL9GA5XG98eIkEWwYGVNuTT4AZ9VWGbpd0FYleBz9gvYFwJLYpylEYRDvQCXMQ98/NpJAEQqd7Jb8oOHw5LrULu55EcKQigcfGnBlMkD7gjKjMulMJRpxJAVWqzpnqArZWB7SPGn+OrXAx5GxQnCHlUixiyueAgmWnT59MY1qyBA4QjST/H44+CdlIRIPGkAx0wSzS4qSo4vJu1YOKfANzbhREtF5rWuaErp2bNK1uZxnbiQ5EtVJmPDreebnRje9udJBlfUB+rhyQeyvVOG82xjxposjiyqnDfGANhj+DIK/3rSaaSbjTBEuSfikjismJV39vKLGrxbBSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(70586007)(316002)(70206006)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(81166007)(82740400003)(478600001)(40480700001)(83380400001)(7416002)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:28:11.3554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c62fc0-9eff-4787-dc24-08dba3aa8169
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP clock mux selection register is already programmed during acp init
sequence.
Remove the redundant register write.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index ebc985e2aaad..61faae74d637 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -464,7 +464,6 @@ EXPORT_SYMBOL_NS(amd_sof_acp_suspend, SND_SOC_SOF_AMD_COMMON);
 
 int amd_sof_acp_resume(struct snd_sof_dev *sdev)
 {
-	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	int ret;
 
 	ret = acp_init(sdev);
@@ -472,12 +471,7 @@ int amd_sof_acp_resume(struct snd_sof_dev *sdev)
 		dev_err(sdev->dev, "ACP Init failed\n");
 		return ret;
 	}
-
-	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_clkmux_sel, ACP_CLOCK_ACLK);
-
-	ret = acp_memory_init(sdev);
-
-	return ret;
+	return acp_memory_init(sdev);
 }
 EXPORT_SYMBOL_NS(amd_sof_acp_resume, SND_SOC_SOF_AMD_COMMON);
 
-- 
2.34.1

