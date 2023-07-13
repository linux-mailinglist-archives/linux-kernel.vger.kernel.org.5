Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1A752207
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjGMM6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbjGMM5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:57:53 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E561D2738
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/j0A65AKi1UL2q+s2jPuhFxYFKZcLrx28WyZ9Xx/MPY1mMHqkGkIMQOyJ5bSxQ1FhqdedDuNSgl43/qZ5pHI05uASvd8h4kYNpKV6tYUt/Ogt+VXPQ290TlW10XEhwXsOdldO+NTk/t4wwcaQYNYMWj14YpBgbgCQVwolJGQ6Tsj4RYkCa+tflWiasL9Ee2o+qTFgfYKS01weIY+Wzczd2WxwWuzMu6+vGnJowT2tXt/aw5JdwgGG2vgbrz0lzf04xu6/AbTiEwbJNxNsXyDO1P9aXttB9TgXQLB7toBI8s6BHiOna9B01zV91MRqrw+4scNJYegGNudivAyGB39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWJHr2Ak5zPlmGToLxP7oSktv9oUsJrFoyds8SJ1ik4=;
 b=Y4zI8xQiOPnmG/jgCxfnDA2epT6Yt/FraWyYZ8/Py4C+dpvx49pCkMD3vq7vLSWx0tH/eatEt3Zrd9HjXGlSMu2HRwiAbiigAkq0KJJ7pBVbPpaZhI+oc5w5GwLz61PZ9MZaq2rWHphtdTGAnLt+6zyxQtIh18trLhT9rUOJbQ9L8mgI1Ljlsc8fdI3TfUPNIrehVK3SZHI8ji37zsUoXAb4L6PeHI4+/eglTboAMPpao3E1op1oI6JVzeKJeBqut3BSDWK0T2EPBpk1tesHnDr/17o8uIW0srZkKh0onATRYxzqVX6w8nvYM3a7nrTYMWEavqbJ1cAr6c/SEopusw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=amd.corp-partner.google.com; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=amd.corp-partner.google.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWJHr2Ak5zPlmGToLxP7oSktv9oUsJrFoyds8SJ1ik4=;
 b=1oEMQonnbJ6lKSMJkaetpA1oHDbna/rKLs5Pxmw9WEn/1j1z/SJbbQP16UvlZA8xM6jroQh1q4kz9ZJBYwszazV3NaH/Z4HqoZopJWBIooZGgV9cpET3Y40+o2dmuNHyCPGG+dbbur0N7/qmQ0tSHQPUNUTzM7IPZswwv2Uf9U5GC6/x+P2bdnhqq5806G/mDLbirtcVxfbA0EEXr/IeykH4ayIcHs0ikADIXu2GIX3466cQtfQEdIWQINHSxvOKEJ3zypqc6byuaXXliqsRhwxewxn+3Y9DHzQvqyjy5E6KrAXcCFxazQhiEKI9qR9LH4xdP0mUlV0nkVL+WlFrnQ==
Received: from MW4PR03CA0044.namprd03.prod.outlook.com (2603:10b6:303:8e::19)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 12:57:41 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::ec) by MW4PR03CA0044.outlook.office365.com
 (2603:10b6:303:8e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 12:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.corp-partner.google.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=amd.corp-partner.google.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.corp-partner.google.com discourages use of 165.204.84.17 as permitted
 sender)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.26 via Frontend Transport; Thu, 13 Jul 2023 12:57:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 07:57:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 07:57:39 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Thu, 13 Jul 2023 07:57:34 -0500
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
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ASoC: SOF: amd: Add Probe register offset for renoir and rembrandt platform.
Date:   Thu, 13 Jul 2023 18:27:09 +0530
Message-ID: <20230713125709.418851-4-vsujithkumar.reddy@amd.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713125709.418851-1-vsujithkumar.reddy@amd.corp-partner.google.com>
References: <20230713125709.418851-1-vsujithkumar.reddy@amd.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 58533843-c471-4226-0d3b-08db83a0be15
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRx0l6gguVfWPacPjilQVfbppV7hpx/pphga+cjIjeGJgWzT65JjOIDnzL8/3ea8zX6IIW2Lh+K0UYLWa/ibvoL6yXxtkdlrWWlv31p9e1Du+PX2kdt4uCp/j/FSJvbgwZ8lTj70VhIQwoRXwyJHve9n3moUWcPopO6LAAM01uCQKrjUKpIahuSA4JcvpgJ69cO6FRYijg2Fudz8cK+1Y3UsYgjQt58dI/PUtztnvYyj7F+Eq6MrxXml42Q5H+aAPsuQtqkafeoyRCBIKvB8sByNk+h3XgO8nskWzYonYvKd3Gw6xgHz+oQhD6h/ZOqsUV/r/VyUfVMDD9irTJrFMhNXNeIRbXIGSc9jeJUzGd0D6D7H7P6t10R7lOUBQXO/y6ZoVz6mULxS8BM0X5NMx+GLzVVHPs/ykD9aguJDKmyLKZ8eODg/2PeUpimhK9cceNipFwsL2kAhX64s2JSbLJ9hyAb69RnYg+4nUgO1KAFgP37bbzJG/rT2OGdyD8XdHVxb3aHpkHn2WlcJlwAY494iPYNlu/AYbVla4VJ7yAvk2XhHmkDXlzgmnLd8UJO8JJq9+Ff8c38iINkHKUdfTKTTxMA2/r3g8Cujn68lPOz/1quMdPVhl2fBDR7yibuUfe1MDyzSjfnJ5TBvMgJAi0Q70U/IisQ95If1Gbr2ICBVYVRImjxy4yaLImsJZ8XvI1eRg3lycfsFnDe8cOU1J7F3nWhdYrIrU1Dz48h/znj1UHosI7xJLyEDUUjKnEJm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(40470700004)(40460700003)(4326008)(70586007)(70206006)(82310400005)(81166007)(356005)(86362001)(336012)(2616005)(1076003)(26005)(83380400001)(47076005)(82740400003)(35950700001)(110136005)(76482006)(498600001)(54906003)(40480700001)(41300700001)(5660300002)(8676002)(8936002)(6666004)(7416002)(316002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:57:40.8707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58533843-c471-4226-0d3b-08db83a0be15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
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

Add Probe register offset for renoir and rembrandt platform to get
position update.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/pci-rmb.c | 2 ++
 sound/soc/sof/amd/pci-rn.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/sof/amd/pci-rmb.c b/sound/soc/sof/amd/pci-rmb.c
index 58b3092425f1..9935e457b467 100644
--- a/sound/soc/sof/amd/pci-rmb.c
+++ b/sound/soc/sof/amd/pci-rmb.c
@@ -25,6 +25,7 @@
 
 #define ACP6x_REG_START		0x1240000
 #define ACP6x_REG_END		0x125C000
+#define ACP6X_FUTURE_REG_ACLK_0	0x1854
 
 static const struct sof_amd_acp_desc rembrandt_chip_info = {
 	.rev		= 6,
@@ -36,6 +37,7 @@ static const struct sof_amd_acp_desc rembrandt_chip_info = {
 	.hw_semaphore_offset = ACP6X_AXI2DAGB_SEM_0,
 	.acp_clkmux_sel = ACP6X_CLKMUX_SEL,
 	.fusion_dsp_offset = ACP6X_DSP_FUSION_RUNSTALL,
+	.probe_reg_offset = ACP6X_FUTURE_REG_ACLK_0,
 };
 
 static const struct sof_dev_desc rembrandt_desc = {
diff --git a/sound/soc/sof/amd/pci-rn.c b/sound/soc/sof/amd/pci-rn.c
index 7409e21ce5aa..c72d5d8aff8e 100644
--- a/sound/soc/sof/amd/pci-rn.c
+++ b/sound/soc/sof/amd/pci-rn.c
@@ -25,6 +25,7 @@
 
 #define ACP3x_REG_START		0x1240000
 #define ACP3x_REG_END		0x125C000
+#define ACP3X_FUTURE_REG_ACLK_0	0x1860
 
 static const struct sof_amd_acp_desc renoir_chip_info = {
 	.rev		= 3,
@@ -35,6 +36,7 @@ static const struct sof_amd_acp_desc renoir_chip_info = {
 	.sram_pte_offset = ACP3X_SRAM_PTE_OFFSET,
 	.hw_semaphore_offset = ACP3X_AXI2DAGB_SEM_0,
 	.acp_clkmux_sel	= ACP3X_CLKMUX_SEL,
+	.probe_reg_offset = ACP3X_FUTURE_REG_ACLK_0,
 };
 
 static const struct sof_dev_desc renoir_desc = {
-- 
2.25.1

