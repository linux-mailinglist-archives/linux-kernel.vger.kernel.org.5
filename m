Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A957D0877
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376336AbjJTG3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376312AbjJTG3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:29:15 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9FFD49
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD9XrwYlWBpkNoUIecZrzBL6f6zuUAUt1TRIPpjw0usLVgtgAGmTth6zQRdHtpibbNwwLXeJSCbQVG05WrkUmMt/3dvKCpi4eJLmoXDr2RSvLqsTe8xEM9CU2ELEZhEXhgA9OCkNgwCR+dMTNRq3lFgFfH6aRYgaxIqCKKQ63rBi6K/7iku60oD8atqEZ699t3t6/HUWGNvxnbVD/XNl7PvHzw1vIXTShPzFl6eFTQEPnG9XQZqXn+Zx1oCIf7B7DgNqWSOs6aw1eGnO3o2+f3936E8P/6bsuRorin/AnRM6qhPxPqvmYTV0vv2hCBw3ND38x7LXwdyYbXiYo7G0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF3l17Y46tjLzoMfH6AT5Qo1MljznJ7mBGk/VDlhtDM=;
 b=CkrJNoL4jmzF0NB765KpCJgqPHqSwNxl4JUERwhOIeNY4zyNXWvgTM45vNT17fxQdrjeE5wELHB5e4ef5PUKiOg/5dCVYcGP6RIRkBVdhH2al+l0cUIrNR+U/gInlUljt9kZ/xl+MNAmi441LyPHkMQNQHta76a8erft6j+6ogg2TVS0QbCCeE3aEiPT8VYgvx3qXmM/HmT05JJ7v0Vgal3wHEZ+v47j83fZc4IlllNQuSxjbm9oqeNHjjMKEJqQkdk1uFGz/RFbrmFx5YA2MLmjsZ7Ly/aqQe1QGJr6NrlZbKYUXb8DzAlCwdfJzz9hPukMkXtVtzjNrt0C9J9jwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF3l17Y46tjLzoMfH6AT5Qo1MljznJ7mBGk/VDlhtDM=;
 b=u8pWQ/HhnTDpO9FUH/k8LHM/x5u9CZlMQ11ZJI8oa+ONAoZMvWDP+Ja/lW0Y2M83N7jWbmh0rzLM9LwKAtvn5yhl2oT03Wrm51VY2/0DIQNQvJzkLVRx1sl+cZOkgbX12VLO5StxamMFXVOHXeGHmJmC+b8jex5QnVYJf3UAk1Q=
Received: from CY5PR15CA0255.namprd15.prod.outlook.com (2603:10b6:930:66::25)
 by CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 06:29:10 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::79) by CY5PR15CA0255.outlook.office365.com
 (2603:10b6:930:66::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 06:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 06:29:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 01:29:10 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Fri, 20 Oct 2023 01:29:05 -0500
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
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] ASoC: SOF: amd: increase DSP cache window range
Date:   Fri, 20 Oct 2023 11:58:13 +0530
Message-ID: <20231020062822.3913760-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020062822.3913760-1-Vijendar.Mukunda@amd.com>
References: <20231020062822.3913760-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CH0PR12MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: 5310554f-188b-4db3-7fc0-08dbd135dee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtUAEBtCD9o86g8tdRKb6k9Bqx+QTqagwjyVNg70Qor9vJI2fHWHLcXIOKGhPKqUyHY+uN6sQbAS4GJnVfGS5x2dgVysR2S2yG5FF/Xfx2j6UqVbTUHtyVReipqPqZua+RMcsGLGaFN5LrDaUSEuRN24ZNG7/HY+3NEGKCihvK0i8w1lAT0FQ1ecO16l6kNKwIfu4XlHCgo3Pu/ZPy4qPnoQ5/YR7/woj9SR0ZGzmVCZxu8aFsI09WMgryiC0YFpCnRNypGhUxtBUEKzX7MIGNpDy7vjzhkFJSBK1471V5GlQlgri84NJcW4g1ZL3CW/4gMwsOotTmrXT1SblyPN36Chu6GozB32tGj5ueFIKuilXujWorjx5AdJUhT+eSgcT8fKrcE0S+vk4M+Xs5vJH/kel/dsfyLwboQeI4RVm1FX1AjWsKm+9HV60SP21yYYX0rUAB9Y+gYj1EAn8q4EcrbuiD1mSrG6QXT7ppX1zKqYRMy8CyEWtqxL765zfrWoT7HtY8pQ86tY/+qWeDXpljD01d9XAs5CA6Qkv22wv8wmKOgGUHIauOrhWm7YPJmkbbdcnWMDjHLk+cHFIJ+1eIKjIF5Bk4jeD4GRpMVwOPwKinDfFtS5Xf+ssYbR9j8ExpgVIve584bTZw97VTN+WMz5Ykue3vKfq6nOW6lsTh9m+RYVJYCCfIHDqSFT96ipbPMiA23rHveelgyqmGPJsXO1HZQqAxxDZV3ZUKfYu4rQGBSPY9SMTUj3YZvr3GZcovkpdjwjkRk8qO3Ivv+cPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(86362001)(4326008)(40460700003)(47076005)(40480700001)(2616005)(336012)(36756003)(82740400003)(356005)(26005)(1076003)(81166007)(426003)(6916009)(5660300002)(2906002)(8676002)(478600001)(70206006)(70586007)(316002)(54906003)(7696005)(7416002)(83380400001)(41300700001)(8936002)(4744005)(6666004)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 06:29:10.4886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5310554f-188b-4db3-7fc0-08dbd135dee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5387
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase DSP cache window range to 2.5MB to align with ACP memory.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 3d2c5f07ed44..205b434f0872 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -84,7 +84,7 @@
 #define EXCEPT_MAX_HDR_SIZE			0x400
 #define AMD_STACK_DUMP_SIZE			32
 
-#define SRAM1_SIZE				0x13A000
+#define SRAM1_SIZE				0x280000
 #define PROBE_STATUS_BIT			BIT(31)
 
 #define ACP_FIRMWARE_SIGNATURE			0x100
-- 
2.34.1

