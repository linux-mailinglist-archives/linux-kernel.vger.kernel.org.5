Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438387D1D9C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjJUOv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjJUOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:51:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1050DA
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdRGiIn6g3c8t8jvCp1pRzHWN7U0nAESiI0/uizwUz0XyKQbcu5zN5H0me/xzk2Dvx7iTpZdIXnx8fVgbfaifh/x6lo1NDhwJM1bBtzt+q1n8YMa0MrD9CUckUFgr0Zc+CSGvUGD7O9mLmuecw4e1GwCbGSmXjRRVd6NhTgMSal/J1Ud7VCtAucvk6sgxxstg6m/daoTxx2yNPczTJCK1b/wRJKMnstXD6nzx9K5AZgQCQIKKKqGtgL4LkAZrXttzCv8InBKsNKXlGTVDArrMGddMct+Etghodlv3OE/qDTmvOYbDb4zF68hb8bHcr10cU8ueFq3Pt3w35nwvO3FAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAG39eZ1BVdDuYUo95xzfJdqnqe77LBQtVNF2w05y5o=;
 b=UOrqbhqYh+l7kvHz4R6RFfRMzLeh1pkRK3J+x2XaKnVrJQdKMP5lkRb5Q8jnA26dsa91iB9NSvtMyc2jQdZhgDtCr3Td0Hs6+Vd94mhHJU5mp/UnAjDhXWW57PZgsTWkI1iQ4Q+MvM2hBM48tvHJyVtGmiqOs9bE7Jf99gYOLZPSaXjJg9QhXCNe89rkSaoYWtI3+s2TYt67vix9GxmYywLQwUkECOoJ7pseh9sEWEnPVuw1oD7UcrSrcIjzczThRvrmMB4fxfDNEvcm7UqPEhMdkcESJVyH8MJ3NXDnSX5/ZuvV+krjqZIw/R41wJsYNzepItbVkpD+ijEWLKKpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAG39eZ1BVdDuYUo95xzfJdqnqe77LBQtVNF2w05y5o=;
 b=YdfhmYLv2B6AcHZhi4bXMLuU/1N+DA4CdcJFXwrRtIFV0jTYv/SIWSyRQZu9bZmqEki6oQp5CpBJIxfpnLagf/2A+ivIDF+ffN8OV54vdTHIcyxxE7V5gLkApr+/qYCIpgIvf9u3c2OVRKAb9OvUzsGZSjFndPK9jB+poaPv+O8=
Received: from SA0PR11CA0168.namprd11.prod.outlook.com (2603:10b6:806:1bb::23)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Sat, 21 Oct
 2023 14:51:45 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::a4) by SA0PR11CA0168.outlook.office365.com
 (2603:10b6:806:1bb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31 via Frontend
 Transport; Sat, 21 Oct 2023 14:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Sat, 21 Oct 2023 14:51:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 21 Oct
 2023 09:51:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 21 Oct
 2023 09:51:44 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sat, 21 Oct 2023 09:51:39 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <venkataprasad.potturu@amd.com>, <arungopal.kondaveeti@amd.com>,
        <mastan.katragadda@amd.com>, <juan.martinez@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/13] ASoC: amd: acp: add machine driver support for acp6.3 platform
Date:   Sat, 21 Oct 2023 20:20:45 +0530
Message-ID: <20231021145110.478744-4-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: c9552501-e94c-43b1-0091-08dbd2453ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qie3VoTBsrbFjpKOsjl55hi8DqczYHTYp2q7dpX1vej0WakSHQQa4w0rtICww4gUEoSInzY+DscDOKZv+GenEbJVHNN6ZLhJuQcyXF8athG6E08/pLt5Nv8yBzTuXosez/9WbY2iSVNlK6fK98pn8e/AZebL2NBSB8CS7mtsvyXNW+cKIc2s66kbkFZo2HKbN9UFIDSRDVh1YXf6a/14J0n5pkFCWS8SsmyCn9ZsHGnIzQGYy0V5VYEXXTB2Ptq/R/lyXc3xt1IzqNju3JaD5Rqq3yWLe/ijOiq8NkwFRjBs3fMhwopt83MGu7Oz6lF3ioQdndVI5lO2KAZAUTmPd1u5o1ZGhzWmCyHyCGW3PwQmGXciJlL/Z1ckehf105KO4ksGNacqlTBxVEzD80g7JGX8D8E8kLrM5HTcA/HuSbcbELEScggHXGi4vCkOh1zpAGx/P/Q55r6MyWeWG1qEup6i/lwM09vs52bIInu+9pDPfOs6fmflcwLQBduMExlO7pDdR7x1S0TJTpYQnvlBkBXb3TgTQnL0TSbO350eTS6s9PLsDI50G3WbO/DAnVlGaVBGVGf8vBs3rdLPkqa0g2SdEYinhzMV89z2MOKrjTWZH6874BRJecpHnDhUK+cObKSdziQuhpd1m5glkSkkASSDhS2oBOWf/vWXMGJCosW9ygiEGCYNXV7SdT6w/BxrVN1yxm6aNKpqjLxysu/rR2OAfxQ0/wgeatjKx9u3NINJhFb3vvrApVx8xki2txKYba6u2dSRNaK6osC1ZZ6M7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(81166007)(356005)(82740400003)(1076003)(2616005)(6666004)(26005)(70586007)(54906003)(316002)(70206006)(336012)(426003)(7696005)(478600001)(36860700001)(4326008)(8936002)(5660300002)(86362001)(41300700001)(40460700003)(47076005)(110136005)(40480700001)(8676002)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 14:51:44.7943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9552501-e94c-43b1-0091-08dbd2453ea4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add legacy machine driver support for acp6.3 based platform.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 15 +++++++++++++++
 sound/soc/amd/acp/acp-mach.h        |  1 +
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 9def77bfc608..88e91af47532 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -1260,6 +1260,12 @@ static struct snd_soc_dai_link_component platform_rmb_component[] = {
 	}
 };
 
+static struct snd_soc_dai_link_component platform_acp63_component[] = {
+	{
+		.name = "acp_asoc_acp63.0",
+	}
+};
+
 static struct snd_soc_dai_link_component sof_component[] = {
 	{
 		 .name = "0000:04:00.5",
@@ -1570,6 +1576,9 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 		if (drv_data->platform == REMBRANDT) {
 			links[i].platforms = platform_rmb_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_rmb_component);
+		} else if (drv_data->platform == ACP63) {
+			links[i].platforms = platform_acp63_component;
+			links[i].num_platforms = ARRAY_SIZE(platform_acp63_component);
 		} else {
 			links[i].platforms = platform_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_component);
@@ -1634,6 +1643,9 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 		if (drv_data->platform == REMBRANDT) {
 			links[i].platforms = platform_rmb_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_rmb_component);
+		} else if (drv_data->platform == ACP63) {
+			links[i].platforms = platform_acp63_component;
+			links[i].num_platforms = ARRAY_SIZE(platform_acp63_component);
 		} else {
 			links[i].platforms = platform_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_component);
@@ -1677,6 +1689,9 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 		if (drv_data->platform == REMBRANDT) {
 			links[i].platforms = platform_rmb_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_rmb_component);
+		} else if (drv_data->platform == ACP63) {
+			links[i].platforms = platform_acp63_component;
+			links[i].num_platforms = ARRAY_SIZE(platform_acp63_component);
 		} else {
 			links[i].platforms = platform_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_component);
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index b0a3f6bd172f..69db61f12eca 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -53,6 +53,7 @@ enum codec_endpoints {
 enum platform_end_point {
 	RENOIR = 0,
 	REMBRANDT,
+	ACP63,
 };
 
 struct acp_mach_ops {
-- 
2.25.1

