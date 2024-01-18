Return-Path: <linux-kernel+bounces-30198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE71831B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38FB28A8DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3C41E4AF;
	Thu, 18 Jan 2024 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="weBsHIFM"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E46B1DA29;
	Thu, 18 Jan 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588244; cv=fail; b=ADAdRKsU8WvcfFJaHPotMJB4DWMigZYNUcsR/cmzwtNm1M/5+XLIwOOIve8Wcoichf4iAhtg7YiwO7ETURAx3Me4+GR9URYSEy/GqipRKLBMPymB2SrM7LnoRYnt/pX42cJbk97Wkz38AI9nqgvNsxHj0JbSsALDCRM/SiosSeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588244; c=relaxed/simple;
	bh=gOfieN7490cPbJfPtXzRaXimfz+0dlzLF6vnvn+fG/0=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=rxQcXvynBYToE+C6efzDXsk98mP3fsEvA25/jTAe6Ni6ib+nTOxjUxxpKkMtLJZlUXMVzbLKci5E6/SiTf1dirH4JY2CP0Ij2eFatWmIlulR3jhjWrLT/zvrC4Vhe3Frv/93uvNlqGXsItLFIrmz/kavhiaGGV4bMf0CLDe4FNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=weBsHIFM; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBMaZLnnSZXpS9UMgyOprpta0871blnbz/7GwpoF1uHd38tXA702g8NQoEkx5KA3hRVF4khP2cLlc/vSrtaDev12UMrmkXUyi0Z09nclDGtS50QcVCz9uUrHAdPnxW3YMX4AcbonRv4ciSIoRDi7Rb9ueB+msaHLZQT4C7DSVliYmyPHjBaU7UNR0qdIxDHe6t+WDwo8x/Lrc2hMlXZG+9Uk0NExmM7M7IDPGhP7UQO9OHpwEYNDy/UrVVIAksD/Uy9gIgIyGEj+BlQadQjmsFyUf642Pj80DYhxiWqP6lKoh1yQJ0Hcsi+Df0MsEnHbgUZ10nTLqTFQEvUxjRzgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN0GYat31RrwnxVX0Dd5mpQethFz3y93HaqE2h9k7+I=;
 b=f6M1O6tbtyJjvf/IImEaAdgpeIdFG4M/pB3VTVBqxTsW+mqoamhpal5ZhTXirea2FwizjxqDTEctZL68ETaWnuwUCeimStLn8CnEdnUaHlNyXijxhpvLPPcWsXLerupzKPYKpPv/Y9rAX6ZPgjhNRN93q3POtUwXrv9kXyi96x4u4RPKnY2a9VNOli+WKglvTOjR0b/zD6gwxrLimHfcnOCvHcFfZsAYgYFKn9j63RwHDzWTYeGJUPIw4wZtYLcnrBOhM/jK4aYYLKiYiUxzjwvIWaivaGjyjDhqLqLmAP4+7TK3lmt3NXm1NxCY1nLzb6HbUIuqZx0x21CBrA5yjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN0GYat31RrwnxVX0Dd5mpQethFz3y93HaqE2h9k7+I=;
 b=weBsHIFMT+FDIT+5sIwp10UyBfV8ELFK0sH0Uq8wqgUcPok0QZTLAdZOKyvvUXTeNzS1Lw5vLr+sLRrEmGyHQFDOu4hFcKwyvCUq4uPCEVbcruOQEJ18c5w4AOlQ/AYvwZrT2+APgpAntujEdnuO8Umym3JCDy/HpbJLFFpGqHU=
Received: from BL0PR1501CA0017.namprd15.prod.outlook.com
 (2603:10b6:207:17::30) by SJ1PR12MB6171.namprd12.prod.outlook.com
 (2603:10b6:a03:45a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 14:30:39 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::1c) by BL0PR1501CA0017.outlook.office365.com
 (2603:10b6:207:17::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Thu, 18 Jan 2024 14:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:30:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:30:37 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:30:37 -0600
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:30:33 -0600
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>, "Venkata Prasad
 Potturu" <venkataprasad.potturu@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "open
 list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] ASoC: amd: acp: Update platform name for different boards
Date: Thu, 18 Jan 2024 20:00:20 +0530
Message-ID: <20240118143023.1903984-2-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240118143023.1903984-1-venkataprasad.potturu@amd.com>
References: <20240118143023.1903984-1-venkataprasad.potturu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 352d061d-900f-4030-af41-08dc18320b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TMgoeRtec49+1a3pSKD1WP6kQGbheSmasH+hYFF7QoPy9WRDemNzKkeVNC4c2VQWEt79nsRNsZW54jhG0g8fIr9ib6bPRA18S7oAW9tHFMOQYp64Hs0P/JDGZQrq59/krOjCbIKAmCKeB2NDg9OMxkqhmnUCBv1bUgTv7nhSigmPpCI15z6AgDgSgWmXBRFs8g1f9kd1vK9dM732RD7CEBe3IVM0o+/Pb2qgl7CaWnvkMZ0DGdaZy1vuIER0jxofIxDIXjGcqDEDAdQwQfrZDIj+0jynZ9tR4WjHGl6Cys5CqdFTan/ApRZsawKl75ZH+t9niPJVDrQt3SjaFPZQ+/TEAhwOQeGSTBlNIHnE5DKBGxCa06naXK4ozJ1prSTBZFfoRF8OAHmINFg7JKwsL62uEXWoVpXXgGDj9EzDVseYHv+/PYgTw7FzR8s0ab0fZrEHZ0rF6d7PlIE2AzVLkSkNYZTXGOwCaFIPIyFQji7YFnmdk43VHqZ8hykGBFjxinHJrE7ZFujXmsMuo/zeaXbw5ehvRkNsJV7ChxLzsbDLv4k/cWdNvlY22R5eEklWSWjITtWPBAx9zltgBehAYlf3k+mi9j5kZ+VtxPCf85z2R7simi9zJrQfy1QmYRlaFCml1aQLJo7tYfuLI0cWyvLPGtjcDGy5RMqr0Z6T/D7+FTsnE30AMefVqf4akU06pHjiMN/RZWoQzaCO/Vsjtv11wLFv2AQ02BxuqnY0daobuHO/URk+ozND74rA25J7U5Geuw3yK1obfTImS1H4Fw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(478600001)(82740400003)(15650500001)(41300700001)(36860700001)(86362001)(36756003)(356005)(5660300002)(2906002)(81166007)(316002)(2616005)(6666004)(70206006)(70586007)(54906003)(47076005)(83380400001)(426003)(4326008)(8936002)(8676002)(336012)(1076003)(26005)(110136005)(7696005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:30:39.4954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 352d061d-900f-4030-af41-08dc18320b35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171

Update platform name for various boards based on rembrandt
and renoir platforms.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-sof-mach.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index 2a9fd3275e42..20b94814a046 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -48,6 +48,7 @@ static struct acp_card_drvdata sof_rt5682s_rt1019_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
+	.platform = RENOIR,
 	.tdm_mode = false,
 };
 
@@ -58,6 +59,7 @@ static struct acp_card_drvdata sof_rt5682s_max_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
+	.platform = RENOIR,
 	.tdm_mode = false,
 };
 
@@ -68,6 +70,7 @@ static struct acp_card_drvdata sof_nau8825_data = {
 	.hs_codec_id = NAU8825,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
+	.platform = REMBRANDT,
 	.soc_mclk = true,
 	.tdm_mode = false,
 };
@@ -79,6 +82,7 @@ static struct acp_card_drvdata sof_rt5682s_hs_rt1019_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
+	.platform = REMBRANDT,
 	.soc_mclk = true,
 	.tdm_mode = false,
 };
-- 
2.25.1


