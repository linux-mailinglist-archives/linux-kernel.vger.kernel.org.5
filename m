Return-Path: <linux-kernel+bounces-5075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0FE818646
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B6CB22D18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66B2171B2;
	Tue, 19 Dec 2023 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3zticQfB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E500168DF;
	Tue, 19 Dec 2023 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EthlP+dY1UbFg6/FSQiSlKOWjGictaFnIY0HL1IzjqCvnHRnkPdGrKTg92viCoWiQVdsldsvtE4wDVF2lHjzCNmy+izp552EslKqSAuOLaQd1p9uLenV/zxYAVksrQJEd/g1UcDMB7q8V0T4HF0p/UnYsi3SSecDLEJwYQKzAERsawGdrx4gv9Ot3olp6LWthaxFtcJ44OhLei17Hh7a3pBzJ7029nMGtKFS0zN7jYNVyyh8qulHAhQqgrbA5eVIP070gmTmWANnMK+sWnw1oGvoPaGvmgg5+/fFGOQrjalyrjVUzlPX9J8blqiH01ftz3R1bNtNq64RJQCRS3TzQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkSBLAMH4KwT70ANU71wmaX96JtC3dQeksD0O4Czt5Y=;
 b=cQ3s+GwSjQwooVdsThOXm954/+NePd8tAHwIQUIhtcNgdV9Cq8O+CvBWXG69MAudGpMST4pXLQylap/HlYSy0LXQXflTbnUQJGQxc+sZyQW+++LE1k+ljN30BznKyEkL5a/9hZpMBsPTDH5VFfxFekLFYgLvB8N6EDV0KEIUYaR0lhgep7jXmPQRs850eR8UYUOQ+vj0WMUGDjCJGdeopioujAeZ1c0il2GAJQ4th689k5XOjwH96fhXRv2RqR/ht5dIqCQy43K165/bYQWyNwdChRgGsacRUwHp49yHPoIgxUYPNo8+BGsj64T9WoGzHBjuTz6YEq6suMOUymcuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkSBLAMH4KwT70ANU71wmaX96JtC3dQeksD0O4Czt5Y=;
 b=3zticQfBjGGhxT/Joi99W4jX1zz24l8VGq/+MjC8CLP4TS39WljMhWjD0p0KbctlOi1S/Qd0tJRcROR/hv89tra/m1e3DxQiuS3q96xnRydsJhHIe3ZUoOHcoiM0yCFBBlwfcPrsrgdybnstoUIMjzPEuQiEDGQ0gjlzn+yxvPA=
Received: from CH2PR20CA0023.namprd20.prod.outlook.com (2603:10b6:610:58::33)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 11:24:35 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:610:58:cafe::4e) by CH2PR20CA0023.outlook.office365.com
 (2603:10b6:610:58::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Tue, 19 Dec 2023 11:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 11:24:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 05:24:29 -0600
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 19 Dec 2023 05:24:24 -0600
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>,
	<cristian.ciocaltea@collabora.com>, <emil.velikov@collabora.com>, "Venkata
 Prasad Potturu" <venkataprasad.potturu@amd.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND -
 SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] ASoC: SOF: Refactor sof_i2s_tokens reading to update acpbt dai
Date: Tue, 19 Dec 2023 16:54:10 +0530
Message-ID: <20231219112416.3334928-2-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219112416.3334928-1-venkataprasad.potturu@amd.com>
References: <20231219112416.3334928-1-venkataprasad.potturu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c476196-f330-4d45-493a-08dc008513dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GWoK8b/PKFsuthjaftaBcU553q2IGiLLs8K0EybvcOGrMQccHU06A0qn901w4EnXwz4Iuv3cce3lFGK1lajP9KyhB3N33mITArqjmxz9XbtGRiqZBHgNKtXhk3vLLklIAGIEajkibJgej58ewuhB6znNH3HIsCBEB3BlAolT1a+ivGDfxq3Gvje6J+4pAyldLmR/85ZgRMPxvYjooJX3eTEeMp1zxhSHso/cQBEiFCJEJZ5pJX1uNLU27gQX5D6Xwn7h/hinvwAil0SksFROrxFmqS7IQThhpc3wrJFF9CTbPEZr8TsMXFxj5o9FY5yIQRSljG3t4iUhe/09KGogh0qYaqZOC1djfUQ0kdU5XaMeW+eLi+bcK2odko6NUOm/8seqMJmKXAvtkPAee/xbQHan10VIwYnrKhqEjoF66qgLsZhXSsND3+Obn1y0TOjyQyI9HIk/KKRAjCIx8Lgn2nYQao1n124EN9qyBYC42rUrqQnMbVRczkJ38ltFKPmPKa4Nve8j+eb4dfARmeFpjWFWA3YCTH19NIi+O3Iqh2OKeaQMekkNAGK1iY7eqh5H5fyNjgVFBR59nqdHa25QEhVg8xjUgVJs36PdmnLVYYAgyJ6Avr4G77Ki3XJ86UF5G9ItcmR85UBUvl2EeNp+FGk369pe5YYO79l+ojMeYNGBwYIYP55PXUIX+GdpYMIpDf05uN0KKvTeDpTlN+58HlDQyZwbNFUlfogoFx7ymCoTarj0MY1NnHblxCehxd/IwX6ok9H95Gv0WwFxswLM33d0pP8zHEcOKBpX4/pPvV0dP+FwiAAFaotiK7DxF8tL
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(426003)(83380400001)(1076003)(2616005)(26005)(336012)(47076005)(5660300002)(36860700001)(8936002)(8676002)(4326008)(316002)(110136005)(7416002)(2906002)(15650500001)(478600001)(41300700001)(6666004)(7696005)(70586007)(70206006)(54906003)(356005)(81166007)(36756003)(86362001)(40480700001)(82740400003)(70780200001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:24:34.2593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c476196-f330-4d45-493a-08dc008513dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873

Refactor sof_i2s_tokens reading to update config->acpbt.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/sof/ipc3-topology.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index 1d9e1145fa8f..a8832a1c1a24 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -1221,6 +1221,7 @@ static int sof_link_acp_bt_load(struct snd_soc_component *scomp, struct snd_sof_
 	struct snd_soc_tplg_hw_config *hw_config = slink->hw_configs;
 	struct sof_dai_private_data *private = dai->private;
 	u32 size = sizeof(*config);
+	int ret;
 
 	/* handle master/slave and inverted clocks */
 	sof_dai_set_format(hw_config, config);
@@ -1229,12 +1230,14 @@ static int sof_link_acp_bt_load(struct snd_soc_component *scomp, struct snd_sof_
 	memset(&config->acpbt, 0, sizeof(config->acpbt));
 	config->hdr.size = size;
 
-	config->acpbt.fsync_rate = le32_to_cpu(hw_config->fsync_rate);
-	config->acpbt.tdm_slots = le32_to_cpu(hw_config->tdm_slots);
+	ret = sof_update_ipc_object(scomp, &config->acpbt, SOF_ACPI2S_TOKENS, slink->tuples,
+				    slink->num_tuples, size, slink->num_hw_configs);
+	if (ret < 0)
+		return ret;
 
-	dev_info(scomp->dev, "ACP_BT config ACP%d channel %d rate %d\n",
+	dev_info(scomp->dev, "ACP_BT config ACP%d channel %d rate %d tdm_mode %d\n",
 		 config->dai_index, config->acpbt.tdm_slots,
-		 config->acpbt.fsync_rate);
+		 config->acpbt.fsync_rate, config->acpbt.tdm_mode);
 
 	dai->number_configs = 1;
 	dai->current_config = 0;
-- 
2.25.1


