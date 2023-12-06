Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55CD806D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377956AbjLFLGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377943AbjLFLGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:06:30 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE995137;
        Wed,  6 Dec 2023 03:06:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWGEW/4sLc7xrqEvinar+IG57jcRg8WAIzSuBf8XaOlFVGS2hQt2UrElFT6+fvK9+iX+zjU+k14PL3eIKayvAYRhmaNc412M1SMvmVd0U8kXcFEs3CkFFVz8vM3iAzmFye3m1dWeoRlSX/QfooC0e81P5V+0n5JcejWCNyiIjT/evNgOlMaafQCMiJNsRfrE0WP5G7zSP76uyyKiykSFHb9kDem8EfTNKR8pBd1WtzsG3ZqTxT5254EZIkUINI7ZE4QCodUbuiMTrm/GX++gUvcKdYzdF7SUeLBy++UQBUBC0bMQXifqK57hYXrgO161z4he0xWggXmTrhRJR+LfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/NzWYCG5OQPPxl4qdNffnyHNAPl6R6W+0oTRG5CWGY=;
 b=Li0EJAnvPAt2er6h5MqAQhcdoUcEmVD6z9E03+QayOpuNPTTOu1yBJFPzYXyHf66pPaugE6+LygR0QI2N73G2S/umzHc+lqZ1RJ3KWqUYtToZshPw73EbBVpD5P7R7kKfZUGSrgj/BekD+1gL1rg8f3uy8s09dwyE5JEBtF1fg1Illeqa6jUecg9jgM6JUJLV8fiFCBioLqCnNMR+/C9/ry8x1UCL0Sml5gCH/QTHfzlawO5rwYTbscZuCArDe1kpfs4AqX/7wIOf65Zrv1mIEH+NTioiM9IVvrhk4W4hT+PAqUKDsZe4QYgi5CqF3RB4KBBD/iI0SEq2/qQbm2Wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/NzWYCG5OQPPxl4qdNffnyHNAPl6R6W+0oTRG5CWGY=;
 b=MRpqYSghPuLSpFdXxlMyg/wdQ7qHL2xNZ1egySYNNtF1iNeBdxlZTqxZvx7lgeSxAPQmOYBMk91AzRGQN5i4unM0MS6uA9ZRtXsvEb6EM19Ar3hl54L1VZI5FAEPf5mi9KcsuFDuLlDop1t2AVn3Hj+0wXXD+kL1iD94aeGB004=
Received: from DM6PR11CA0044.namprd11.prod.outlook.com (2603:10b6:5:14c::21)
 by DM4PR12MB5117.namprd12.prod.outlook.com (2603:10b6:5:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 11:06:34 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::8e) by DM6PR11CA0044.outlook.office365.com
 (2603:10b6:5:14c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 11:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 11:06:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 05:06:34 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 03:06:33 -0800
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:06:30 -0600
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>,
        "Venkata Prasad Potturu" <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marian Postevca <posteuca@mutex.one>,
        "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <linux-sound@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] ASoC: amd: Remove extra dmi parameter
Date:   Wed, 6 Dec 2023 16:36:14 +0530
Message-ID: <20231206110620.1695591-3-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206110620.1695591-1-venkataprasad.potturu@amd.com>
References: <20231206110620.1695591-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DM4PR12MB5117:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea3cce9-95c2-47cb-9175-08dbf64b68ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rc37HpcUg6sDr+m+yCpq8MjfyTx1Zu02bUHzWDaIEeYbJMNiegiGP65JbEcoV2XtrBtD5N3tU4jTkNqKVV19MHdSv4uv/S9Qwvz2iOirzXQhoy4nRhav3BPUetbBbv5+WXq3uJ0HY3MXMzoOv4YwwEc+JIRwKZqE0VBXj6WDSHQBRCl4aTplFMGSpXvFawdU5FVIZgtDZNsT+0wnB/slN+aqRf8fkXzMzi1U4YxVjMG3PltBRumb9xA8//I0JPnuC4BcAjFjU8eXNbMRPCqV7WTE1Cc2l+4I2voWWTAVmtcbeMVXuk8Y8cCJ8w8MxP32YloyVFqrjGtfp2kSN/IgabcP2kiz+yAnN/tUXVaRxg7oPNuLh/8ob6DhCxgrT4eNnTS3NSzH7mAewMiYaZup6TfYJaTtglEPgVWlaP+wZNIiysstb8bBK26rtVsY0T6551iS6LHIjBAUfb4RO8ZBtA/RmilVkNOItxkZpPQB3mtSvj6avm/y/JYYViA8cZihj5swTgThpZRSti/3E7nR/3AVl6mAk3WGIwpx2Goa6QEznq+I6mwZnC6eHgsTPoQKbp0V7axd/9phvw2obzk8fus+XH85U5tgk2SLDkTJTEWPrnSAUX7kEkr4zDyuoIOoVdsyxuLQ/Q2/0/6xFEWcR1LgHRypoiGD1LJkD9jDcmy7pYfbIik4gI+2qFCr7GlhezRTO47IPZPNf+gXoCDii+gp0w3XB2gU132ioLhQpSlbkCFViBx825zF/ZCYpft8RfUFJ6F5i059t6x02NCFqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(478600001)(4744005)(40460700003)(82740400003)(5660300002)(36860700001)(2906002)(41300700001)(86362001)(356005)(36756003)(81166007)(2616005)(1076003)(6666004)(26005)(7696005)(8936002)(8676002)(70586007)(336012)(70206006)(110136005)(4326008)(54906003)(83380400001)(316002)(47076005)(426003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 11:06:34.5786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea3cce9-95c2-47cb-9175-08dbf64b68ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5117
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra dmi_product_family entry in amd config entry table.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp-config.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 19a30f145143..04b58fb29a35 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -68,7 +68,6 @@ static const struct config_entry config_table[] = {
 				.matches = {
 					DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
 					DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
-					DMI_MATCH(DMI_PRODUCT_FAMILY, "Sephiroth"),
 				},
 			},
 			{}
-- 
2.25.1

