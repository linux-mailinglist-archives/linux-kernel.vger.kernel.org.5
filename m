Return-Path: <linux-kernel+bounces-7955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAA681AFA2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF358B21BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AAF1773B;
	Thu, 21 Dec 2023 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LSs13XA/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF3433DE;
	Thu, 21 Dec 2023 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA+GaS5+aTJqcWJMX9pmP318S+9JT8cH+ztmhmgwi96xR6KfHldIolyT9uO4aXZJKUw4R+PX6xHiRxsCTnBJSyLQc50EkcjpelHoGdnWr73IcDW1KifmDXC5ui583BJf6Ymw234b6EIShqtKdYCcOLm7Z0C/aCv50Ll71FCSwKl5LDq6Sr0FLOAAjn267HXLdIYm65xUHUJsGghmpgLMjZgUAu1TUxGInB2U/ekLGLkRCocajVbWg/0cLNaMlfCmk5YhnTkU77je93SOqBtKv7s80HpKIrPE0lQ0EFw7xWAl5xUH/DC/wU1i74XLvT5Hr/LDEzA5Xx7Ixur857QhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM5IfcLFOV5I+4SsS+sfeBeWW0qVpPfMyKw8GVqZb7k=;
 b=Bs4rpIjyEhEGze6fHZG0rnwGOjSJGwud5PzfefpYOK3yzPDttMK3Jy3vLhLge3dvJw0blMAOZw57DpxLK8WRmGlF6TRXjajxklaO3+7m0pPev1gj3hziY45P4vCyZwLLwTFDXlizqsu4QI4D48PhGG3q0SFEjUv0joUmLGIV9zN67AzcwX5D+J2LBflI4ffOiu4c18GAlw+MxNKcRNKqpmC3aEQnLNBaT52mDfWPoEg/bthSqv3LJpv4hQzXH4M3ecDJlr7X40cieX+buDIT6ocIuLUSZQlE+TAnfE/4AmT7V/rwRJC8vgvG/Oy3jh6cZ0oiynq8/9uQ4BULH7BRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM5IfcLFOV5I+4SsS+sfeBeWW0qVpPfMyKw8GVqZb7k=;
 b=LSs13XA/YNABkdYHFn2KAYm07HypxBxM/23MELayuvz1xqB5CHT9AOmqsE3ohkyxlVD5ovHsino+YIOf4lhFOdSX9VxbL7S/5ql0+SuU9gjF4Gq1H/OzK/G9wF+u012z7CzufmIGGdW26xoxINGXLusAhbz9zwspr0xFCQrFEy4=
Received: from SA9P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::6) by
 DM4PR12MB5117.namprd12.prod.outlook.com (2603:10b6:5:390::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Thu, 21 Dec 2023 07:38:06 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:25:cafe::50) by SA9P221CA0001.outlook.office365.com
 (2603:10b6:806:25::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20 via Frontend
 Transport; Thu, 21 Dec 2023 07:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 07:38:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:38:06 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Thu, 21 Dec 2023 01:38:00 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <pierre-louis.bossart@linux.intel.com>,
	<vinod.koul@intel.com>, <venkataprasad.potturu@amd.com>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, "Peter
 Ujfalusi" <peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, V sujith kumar Reddy
	<Vsujithkumar.Reddy@amd.com>, "moderated list:SOUND - SOUND OPEN FIRMWARE
 (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, "open list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/12] ASoC: SOF: amd: select soundwire dependency flag for acp6.3 based platform
Date: Thu, 21 Dec 2023 13:05:57 +0530
Message-ID: <20231221073558.3181911-12-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
References: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DM4PR12MB5117:EE_
X-MS-Office365-Filtering-Correlation-Id: d811e0d1-b37b-4c79-ac3a-08dc01f7c5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L16iV3L2uvGjc8YnrXcA1Mav1SszGu57GFfLCue8k93x/Eu5n5G83uXxhob70nbISPHvX6PCwiMmFa69od6BetNsQIvLWbrhcvGfO3464IpugtX1RBld2yMhNDyA+laBLM/Db7r33Q+FsFy9NOQPCAT2qlen4AWnyxtMVo4fxrjfUvjbWHc34KzBlZzf8kGQHbPdayYqOVNiA++UnrWuChm8rIbD0D6KwDhuvwyHpFfaQmEKld7upKOvNVgGzum94i9HkiniPqJl3Kiz60st3V6frLhRcuTVSVx/Ct18WyNBCWq23Gzhb04W7psdYJXUDbXc4gMJ+qQCHhQ3unR90Y3EKKm4m76hDHryq7fwQMEmQ8IiaCkvlow1r1vo8vN3330edDedSaoRSutaS9+CC+ufT+HJQ0JTqrUS+pO735E2giqJYnTzT36DRdggSOpBGe3/Qt+RbHWGe7k9JoeG+hU6BM7R/Tl/0Frmklmk6J8OuT72U8OgZJHr7gHD/3YiD5qvX1F32tzL31TXAdiCbLQKKqlmB0g31a2lKbXbGLhDh6Qox3B4nRu/P/DEi1pm+0/gZI7OznKXj28EkIc6OQ9BzfRzyVbVJhUYB3LCOXBMHF6u1NOT5qjHoJ0n5YU7n600yyA0sj4k82eynnRRtKuaWETuQPNmU0EGI10IR2ZhoErq0Jf6OSeh0VpD9ZPR6UVx6xx3oqVx8EQWRhMzT2vnzwbxXK58m2iU9jTckTJ7vZuZpyvTqKBfCS4JkfsLMdvvSS2WlKvz5FN4pTFNBA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(478600001)(110136005)(70586007)(70206006)(316002)(6666004)(82740400003)(356005)(81166007)(36756003)(41300700001)(86362001)(7696005)(1076003)(26005)(4326008)(5660300002)(336012)(426003)(36860700001)(7416002)(2616005)(8936002)(4744005)(47076005)(54906003)(2906002)(8676002)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 07:38:06.4579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d811e0d1-b37b-4c79-ac3a-08dc01f7c5b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5117

Select SoundWire dependency flag for acp6.3 based platform for SoundWire
configuration.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
index 1cea1d75130c..c3bbe6c70fb2 100644
--- a/sound/soc/sof/amd/Kconfig
+++ b/sound/soc/sof/amd/Kconfig
@@ -81,6 +81,7 @@ config SND_SOC_SOF_AMD_ACP63
 	tristate "SOF support for ACP6.3 platform"
 	depends on SND_SOC_SOF_PCI
 	select SND_SOC_SOF_AMD_COMMON
+	select SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
 	help
 	  Select this option for SOF support on
 	  AMD ACP6.3 version based platforms.
-- 
2.34.1


