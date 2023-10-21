Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8E87D1DA2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjJUOwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjJUOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:52:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F26810DA
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjiemmcMUPyeIj19YcezlNSWJA9c2P6Fh9m8WNFiWos15c0ogKnCOghLmV+f1tKeWOol1yoqFiGDPm1+1FnMHmalYrkRRb9dFYWuFwpmE/oDcATSDxwHnid176MvUO/pJ0UenTG/3aMdMmPWSnU+emb0K1xx4nOug+04kg2EWFTcs0CONoHJQqyMYjHrd3nrBX5krWarCfAoF6um1BJMP667XAlVWcLkj3yb5fLqF1pEmioP3+cVX2f5HAlobXHtRGKFzq4IjbtSncMvABXd4efedN1S1bgYump9gwtw1SaeLKGKm2h2QncPIUko17qdDQT0U5xuFGwKJPeQ1P7JpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2AYoYlU6AD/2FrJzoVU3wZWBvcWdpwuZ7A9GInqjww=;
 b=FzaJHuVCJ7mUKhtQCW7QwDCH4AKFR1vpgTZnBda6+O0J8ifuwp+smKkU4g7DWldJsNVRaxe4slJUFx+Hh9Azj8JcxtUYR1hJ6zUruiVYFEYoAKXjafzHBMwbGA7rl0Sbu34N72fbLvKBEyMi5QneQluLzceit9sx8fCr93d7Xo1b9I9ONc5saEcN3TK8lfPITT2T68TnizoQRV5rdvfvVSdLA9NXWRMmS7axI1xEPtnIn9eHeQ9CGREMMx1F18dFWLh8a1aBcjqtWAv2WQcFG43vVDAtQcGqgO6NvuuRivPu/8cnp/mVkhVGDctoy5Vk1ew+HuJT/Dj/HH2bWqYUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2AYoYlU6AD/2FrJzoVU3wZWBvcWdpwuZ7A9GInqjww=;
 b=z2fW08knYhgId5dEoGy9gYRFO9BxpepwyztHfLvrJ6k9IKdS+VXOLE+2GSqP1+/wMq45GUupTb9PvUuxhgHF9MN29GUwm/gvmjEyrFfpDkdFwnAfi/KVArGqdEhXkn3mhbEyixvT6url/ShTcWtYveVe8vfdJKBVZj1CZWK+ioY=
Received: from CH0PR03CA0422.namprd03.prod.outlook.com (2603:10b6:610:10e::19)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Sat, 21 Oct
 2023 14:52:40 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::e0) by CH0PR03CA0422.outlook.office365.com
 (2603:10b6:610:10e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29 via Frontend
 Transport; Sat, 21 Oct 2023 14:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Sat, 21 Oct 2023 14:52:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 21 Oct
 2023 09:52:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 21 Oct
 2023 09:52:38 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sat, 21 Oct 2023 09:52:33 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <venkataprasad.potturu@amd.com>, <arungopal.kondaveeti@amd.com>,
        <mastan.katragadda@amd.com>, <juan.martinez@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marian Postevca <posteuca@mutex.one>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/13] ASoC: amd: acp: add machine driver support for pdm use case
Date:   Sat, 21 Oct 2023 20:20:50 +0530
Message-ID: <20231021145110.478744-9-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|BN9PR12MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 812cfc1a-5f49-470a-4615-08dbd2455f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Bc/3QdrB8g1X9Eo6NadbpYmFb/pMdS5qwvYanKDh510uxp83NBQNCggFfSm83P9DXvwt9wIWVHXEKqcU5udOcFMa4c/vPJuWJzjSzKg9z1q26YwTRkw4Dj/Chdd+Ny7JlMhMyxwHYvWXMduVQ/b6QulwR8naAhIoKo/Cg64R87jiQ2tvNo4uT0/V+v0G48QK+Z6wBdt1MAAhw0u93cepOSMoUAVZeE4/tl0oRIcRwy8ZJ4WkElzOr4kbQrgDUUwrw1/+WsTyjhAfUrlZOOgSWCIGq5bRa1TFejuVjWvhekd8C5BL8DH8xjufC1Jg9Vag/QO07aahHoOUhQg1ruIJI6k0feBOqViDQxzOR5abvtG52IX7SHP1+FbevEwp+j42gKlebG8Gx+172UcOaEXp5vqkvFQTs5uXu/ApaLSlt2kUKJh7G9aOx5tF900UqVgeRAiecx31dGtRbq+GMzmK0IAI6O9DM6BXK8m1UBOPpPUkBTD5LV4Cfws591kNk7xlA6u/XZ831uiBTw7BlVJd0qrk00tDYP6sNLfPJbillzMM4TElAtq2S6vslGF7eWDQr/QnsWXVCVo/b1KmwyRUM+YWl7qlFVEEvGV+RrpMkevwyD6DUbfmEQJ9/lwCfbnkwImE+5CGrz8aRimOwkV5otEXkdDfX24+afztlIkiJbwsZaywTd46WyLwzTWfkAXzdv782wMOL32fycBGnVlXHx08qvVDlVMb3iYvRk6kmmn5cUjHP9k6UHe3YIcEKEMsGRo/iIghIJRyCttd7JZPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(1800799009)(64100799003)(451199024)(186009)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(70586007)(70206006)(54906003)(110136005)(41300700001)(86362001)(5660300002)(316002)(7696005)(6666004)(478600001)(36756003)(4326008)(8676002)(8936002)(2906002)(7416002)(36860700001)(356005)(81166007)(2616005)(426003)(336012)(26005)(1076003)(47076005)(82740400003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 14:52:39.5232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 812cfc1a-5f49-470a-4615-08dbd2455f51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add pdm use case machine driver support

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c | 12 ++++++++++++
 sound/soc/amd/acp/acp-platform.c    | 29 ++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index 1ab3edffe0ce..47c3b5f167f5 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -84,6 +84,11 @@ static struct acp_card_drvdata rt5682s_rt1019_rmb_data = {
 	.tdm_mode = false,
 };
 
+static struct acp_card_drvdata acp_dmic_data = {
+	.dmic_cpu_id = DMIC,
+	.dmic_codec_id = DMIC,
+};
+
 static bool acp_asoc_init_ops(struct acp_card_drvdata *priv)
 {
 	bool has_ops = false;
@@ -165,6 +170,8 @@ static int acp_asoc_probe(struct platform_device *pdev)
 			card->name, ret);
 		goto out;
 	}
+	if (!strcmp(pdev->name, "acp-pdm-mach"))
+		acp_card_drvdata->platform =  *((int *)dev->platform_data);
 
 	dmi_id = dmi_first_match(acp_quirk_table);
 	if (dmi_id && dmi_id->driver_data)
@@ -214,6 +221,10 @@ static const struct platform_device_id board_ids[] = {
 		.name = "rmb-rt5682s-rt1019",
 		.driver_data = (kernel_ulong_t)&rt5682s_rt1019_rmb_data,
 	},
+	{
+		.name = "acp-pdm-mach",
+		.driver_data = (kernel_ulong_t)&acp_dmic_data,
+	},
 	{ }
 };
 static struct platform_driver acp_asoc_audio = {
@@ -235,4 +246,5 @@ MODULE_ALIAS("platform:acp3xalc5682s1019");
 MODULE_ALIAS("platform:acp3x-es83xx");
 MODULE_ALIAS("platform:rmb-nau8825-max");
 MODULE_ALIAS("platform:rmb-rt5682s-rt1019");
+MODULE_ALIAS("platform:acp-pdm-mach");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index f516daf6fef4..aaac8aa744cb 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -21,6 +21,8 @@
 #include <linux/dma-mapping.h>
 
 #include "amd.h"
+#include "../mach-config.h"
+#include "acp-mach.h"
 
 #define DRV_NAME "acp_i2s_dma"
 
@@ -69,20 +71,25 @@ static const struct snd_pcm_hardware acp_pcm_hardware_capture = {
 int acp_machine_select(struct acp_dev_data *adata)
 {
 	struct snd_soc_acpi_mach *mach;
-	int size;
-
-	size = sizeof(*adata->machines);
-	mach = snd_soc_acpi_find_machine(adata->machines);
-	if (!mach) {
-		dev_err(adata->dev, "warning: No matching ASoC machine driver found\n");
-		return -EINVAL;
+	int size, platform;
+
+	if (adata->flag == FLAG_AMD_LEGACY_ONLY_DMIC) {
+		platform = adata->platform;
+		adata->mach_dev = platform_device_register_data(adata->dev, "acp-pdm-mach",
+								PLATFORM_DEVID_NONE, &platform,
+								sizeof(platform));
+	} else {
+		size = sizeof(*adata->machines);
+		mach = snd_soc_acpi_find_machine(adata->machines);
+		if (!mach) {
+			dev_err(adata->dev, "warning: No matching ASoC machine driver found\n");
+			return -EINVAL;
+		}
+		adata->mach_dev = platform_device_register_data(adata->dev, mach->drv_name,
+								PLATFORM_DEVID_NONE, mach, size);
 	}
-
-	adata->mach_dev = platform_device_register_data(adata->dev, mach->drv_name,
-							PLATFORM_DEVID_NONE, mach, size);
 	if (IS_ERR(adata->mach_dev))
 		dev_warn(adata->dev, "Unable to register Machine device\n");
-
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(acp_machine_select, SND_SOC_ACP_COMMON);
-- 
2.25.1

