Return-Path: <linux-kernel+bounces-30197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03207831B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6011F2733B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2549A50;
	Thu, 18 Jan 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0GsojAh4"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412F91E87A;
	Thu, 18 Jan 2024 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588242; cv=fail; b=VTW7u4jhJ4N8PJSrztJ+4T+HuXj696HwP/522u8fBtkETZqhupM6JLmJ+m4WEeBP0w8+mluWgblaZSEkjclU7XtagY2DfMag9+Azn2EyGZuEuL6qCnNj20gZ5AS2rWYbecaq7hVPYOx6jmObTyvGYEnOe5+8iGsnCqFgRvG1eAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588242; c=relaxed/simple;
	bh=ylSjPkkGJ8BeL6beWllqIu7WO1+Woc+cSxpoGcJTrh0=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=X+OHutjAI7AisDxTHxhPtThaaDzvX2C7sjzI7gzGUUuSYAP9u9dLAm8KsK0iel2DVOFbVbNNEexchcTmPGKK5fupkCnwLNNmSDBoqKjj3gmx2De+9XI7+C5DoPoOzYJqzx8AsUAWDDIBQD93Ho/Nkaa5aIiwFQqe2bcicbqyiWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0GsojAh4; arc=fail smtp.client-ip=40.107.100.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+SvKPlBE9d7K7lAwiNxCVoRtt+OEKFXyUz7QunxYY6Gz/nsdvlDijpTvDzbR9R3vazT0Y2+4YM/VnKO5E+K9FTWK26A0hfKZ1OqRbNbDrS43aY38Vi/YzpZbT0Oiic5rnOgunEKpB5k8UAqkkYx5lHdjYOIO3KYw7Cu3LmqklMyuofN1p2oBsxWaCeGBbKn2ceSQQcE9oJKFl1yVA6tTQGHbxO71pY/WOmcZcfBwIFlEkORqMuRdfHckzYnGAi1FoybbPZASfx5XeN+jPw2JtzpFycYHEunbT1g0ouPqSwn4FignZ41C9yR+oF3eu5IJDKABur+y7vowxEqcA0itQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3xET7IjH+V2KLOSOX+7zCVySi5nBDvoo7+XKjtjYeg=;
 b=BX0Ztvj6CbO7SwZn5EhcmeYskAXEA0t70g3vTxBs3o9ygyabh3QZjNCDi4B000WYjyXZjcr8tyiyIR48jBsbt5kAbMIRAj1wGEj1AFC78dEjttyTLaCpStwUk7vAD2J7cnLtEBogW/61uJezL95tBe2qhwN6RFn/oc4yv1xMFAiMnGH60585QGtCw1eyQZlpg59mbkjriuKgPH+YpTNZ+y5I0hZ0nmAsyxHGo22mL9Dw1y+6F4je3vEpGYOWx5KXnVzJ7sfZWwdxKK/9d9UzI9fFwQmkAaHCwLqIDCGwLT/MMf70brciUeWw5Yfw+CYgwi9IPmHbxDE/hIntDU3RYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3xET7IjH+V2KLOSOX+7zCVySi5nBDvoo7+XKjtjYeg=;
 b=0GsojAh47+aw9PR/OFQUbZ6F51LO4exJqMTIw7ag2pcGVFretvtYr7/DeHOC05C7U2vZxZtw3Jeivptk2GgB0bSVydWXah19Xvole8SMo9tWY5D4FuQXYWPj0kmQEsg1kaAbO2OUudp7gHAlgmqnvjMvCMcEbj+MPfHiXgKRuuI=
Received: from CY5PR18CA0036.namprd18.prod.outlook.com (2603:10b6:930:13::21)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Thu, 18 Jan
 2024 14:30:36 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::79) by CY5PR18CA0036.outlook.office365.com
 (2603:10b6:930:13::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Thu, 18 Jan 2024 14:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:30:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:30:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 18 Jan
 2024 06:30:32 -0800
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:30:23 -0600
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>, "Venkata Prasad
 Potturu" <venkataprasad.potturu@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>, "Alper Nebi
 Yasak" <alpernebiyasak@gmail.com>, Marian Postevca <posteuca@mutex.one>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "open list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ASoC: amd: acp: Enable rt5682s clocks in acp slave mode
Date: Thu, 18 Jan 2024 20:00:19 +0530
Message-ID: <20240118143023.1903984-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c2a7aa-a6db-4938-d29e-08dc18320914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q+IMjM6QxEEjsptgBWKDjuV+eKBZPpPqEswJe/GLcExkP8iq/YtbJsF3fQPd0u9hrfXK6vfQCfu6o8ENLNGTO97M2Ivk+M91AjJSpO60JSTevd0QHX0n52y2q3EzQHjm8ON/19grhLfHmgvFx+/w7AKVIFMFgoRw9uHttsiOJwbBW9twUy9xFbY610gvhUnIGo9raSIG+sLSZPGmUEHn9eYV6oSiMm2cj8s6EYTfiHN+8ODhdOJNxBOHhnWOBa6BxFals7JI2t4fWWfxc5Z8EnipJZMkpsSnDpSlhMXn2Z9JsAXxfEupqaMUuyQTszg1/jt2DiQnxoJ9dCuO+mhTjtm3iJjiIlNlx5sls65kzocZ2UTq7UN2ThYuAfjrniAw1NiqGXb1NLNuSHC6oxd0e5254SNYsLD9UR2td3d0IbB+pNTJpF6odiA6kS8hskCwiXUqwPCSI8AFRD+TCSkS+g2Uxr25M3o+PvwyeQSzE8lZgxL/YroRcRUOCSx+4pdWjrKGuCiu57x1fPa+wK7Spc2Qlq0VHes9ZY+jnN4sCK0UX4UCG+d2kxf/jmUGAs7exHl32wwgncvVi9F6lv50mHMQ1GIrrR6A9DhLlozNQFnN0hXmWGuZwh6dGUv59BJQgKblsIlZd4PmpK/IBCvfk3GIT0FcBIbjA8HnLwSGs1I2BmJl5/o8qd3H2AJQc4xz0AwCLoYf8hm1oArx4u9ie2bSwU/fhqPy+ZqnYOOZKU0pVA4zte3/Er9T1obNJpES339jTUa9kLLdBEep9/8n6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(26005)(1076003)(426003)(336012)(6666004)(86362001)(36756003)(356005)(81166007)(4326008)(36860700001)(7416002)(5660300002)(54906003)(110136005)(7696005)(2616005)(47076005)(70206006)(4744005)(82740400003)(316002)(70586007)(8676002)(8936002)(478600001)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:30:35.8465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c2a7aa-a6db-4938-d29e-08dc18320914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

Set and enable rt5682s codec bclk and lrclk rates when
acp is in slave mode.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index c90ec3419247..a224043ccd42 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -505,6 +505,13 @@ static int acp_card_rt5682s_hw_params(struct snd_pcm_substream *substream,
 
 	clk_set_rate(drvdata->wclk, srate);
 	clk_set_rate(drvdata->bclk, srate * ch * format);
+	if (!drvdata->soc_mclk) {
+		ret = acp_clk_enable(drvdata, srate, ch * format);
+		if (ret < 0) {
+			dev_err(rtd->card->dev, "Failed to enable HS clk: %d\n", ret);
+			return ret;
+		}
+	}
 
 	return 0;
 }
-- 
2.25.1


