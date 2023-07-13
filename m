Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B876751B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbjGMIbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbjGMIbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:31:12 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFED55BB4;
        Thu, 13 Jul 2023 01:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMLmZkIvVpV23e0byE3yon57N5SH6oQOyykp36mKDxjtkd0ZnvYoTfq1FwRWSE6OtATR+708YLlug4cA/NkP4GT7XZ8j8pQRn7E0HwplSF3jXrbKYvTS5e7FVC9hOmCwXUYdocYgCX6l24CpqdROtV7GKIrZO/ROUBCnF2LFmlk+TS3Z4Cs1QmCD44hZedsx1TJEgoG7482Qw4dHuMzbv1FAI7MR3Tf8Od7Z6J1xPOJUUIjkMohUeMbQITG/UIt+lf/jSoV2BK3wyGE2kYozg6JgaVhWH1Jm9gZwn2S0XhrTDVk/Ev7rFUsAfEmaBpPYV4TgcZuI+G1rb4FFgSEzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bddm9GQYkwvCWCU/LaSEoDRJLL0Q593Ax8c6ACbShU=;
 b=j4GDxkg6K/tTwovg4MiQo+Gj1I4/VHKyErm9mf0GEwK/Jkgd51MbOrqZwdaHUZXuMgfb4XfaYrKAMu1CDcZVfhCZaNYNAGBOVnrnSQgAi82LGMUUI3E01h+ezuhcSRHn1QZVArHGLi+ElbidNEix40I5YxjD0rZw3cfQirs4NaDKhndmoxjqeDvmAojMoVsYehEYw0/KIKaeIcTSq8gdhKGTeufkLg1g1TmZIBNMdb6l07vsLQ18FEGr257praI0+SnduWNkMz/Jdndxmu1ENHgbfLVj73mX+EdCP8/o+Zz436Wdl94Bn/EwVj+WRh/jZZdRZ1bqhKz8DSxatTsF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Bddm9GQYkwvCWCU/LaSEoDRJLL0Q593Ax8c6ACbShU=;
 b=mCSIqWWXRuNrlK7KrEcWBdlR0Hps/8Bpxw9T6SUxpsQk1jSc8Gv4sEDL7aJ5tDy+7hrRREll0mZZsqvkDlJtEfaFFA4x/nVAfVE0dkB5Ic7yyh/mTWkGEci7nWd06XH+v0rOk09izOFmsVXfTlpDth+0fIVRDt5bHwHvYH+FitU7hJMY/+WJPOUUgtvjSxEgXJZ4/ZMAU8t210QY4O9C5bCiHcYDOt3DkNG8kkxcz8ATNmubRNyoAd3nC8EhX4h+dBEMg4nwNLEpJK3UXYm/7n4E5gcA3EJwBfO2Xjk1ubwacuhJ+RcYYuRcBVKaPQjpqjqgGC6MQxY0CEe7yJ0Gzg==
Received: from DM6PR17CA0032.namprd17.prod.outlook.com (2603:10b6:5:1b3::45)
 by PH7PR12MB5999.namprd12.prod.outlook.com (2603:10b6:510:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Thu, 13 Jul
 2023 08:21:29 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::19) by DM6PR17CA0032.outlook.office365.com
 (2603:10b6:5:1b3::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 08:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.25 via Frontend Transport; Thu, 13 Jul 2023 08:21:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 01:21:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 01:21:10 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 13 Jul 2023 01:21:08 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <linus.walleij@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-gpio@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pshete@nvidia.com>
Subject: [PATCH v2] pinctrl: tegra: Add support to display pin function
Date:   Thu, 13 Jul 2023 13:51:06 +0530
Message-ID: <20230713082106.838-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ZK7BRXa9geC8SAGs@orome>
References: <ZK7BRXa9geC8SAGs@orome>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|PH7PR12MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 5291a2a7-3f97-491e-5142-08db837a28d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pVwfSBU2NK99R1wXJmvrVBhyBQnIyrF1hLpR3TYRIhG1lJsKuufajSCUq714i2XzzX/dC9+odgejpvCS3vtxH5FisQLCuJXyLcV/biHZCvnFXkEf9we6e6i9cX0N7fLh7x8s4EGPJR0Jmu0WyKmaO9E5Ms9rKfi6cTUbGffFQN1Pv4Rw39kYazA7NvOLIxk2rywJRnKGPpyuaJTiR0T8kDMwPpw5gTmH9WGMHYEEQSKIKpzWUWDgVj7vsCH8okpKRXmJOgViWH2hJfGpA/rU9YhPRVaD7TrPE1i2h3VIILAI55ebAXvGfk5OEHxgxx0lWA4wuRe0XQ0fdKSKwXupq9YaOiqqYi2Hh9SeQUK0cDHiQ+na7ZRpVL1LZ5JX/Z7nnmShEtFTnqAEr+X5FUTCTLwO15M0gQPHSGvVWet+x0Gww2GfIRWNJdCwS+IeCxkMKUuODGVYc2eRm0Jq+PNnkAAfXuFhQMKGbSmLe7zXRa4NeVP0XCXKz+9PrCYR0x0TPUyV5Uvop4Siv+icM++TLT/KbEz1ssyvCRFHEb+6mYkdtePKjZTncQqT101KUsj8p4fwcXAHpHlu4NBKOi2qIOE2URNWCXQjaPeK4vOSZneo6Pir+JIToHXBIEbB6ThmqG+4zkoqFd+DU4kiem9FNtgRvh/8oitdG9hKaBftSzKNfJyMTsttFOC4QBA8URdtPk2BPW0kOshNUb0+5k8b0dEJnziNXg3oW96JjJ7AKOdOqDOoqvMZ7V2XCSlGywFq
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(41300700001)(316002)(83380400001)(7636003)(110136005)(426003)(2906002)(336012)(4326008)(5660300002)(36860700001)(8936002)(8676002)(70206006)(2616005)(40460700003)(70586007)(82310400005)(1076003)(86362001)(107886003)(40480700001)(36756003)(26005)(82740400003)(7696005)(478600001)(186003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:21:29.5549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5291a2a7-3f97-491e-5142-08db837a28d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5999
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current function for a given pin is not displayed via the debugfs.
Add support to display the current function that is set for each pin.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c | 19 +++++++++++++++++--
 drivers/pinctrl/tegra/pinctrl-tegra.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 4547cf66d03b..4da8873942cf 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -96,6 +96,7 @@ static const struct cfg_param {
 	{"nvidia,slew-rate-falling",	TEGRA_PINCONF_PARAM_SLEW_RATE_FALLING},
 	{"nvidia,slew-rate-rising",	TEGRA_PINCONF_PARAM_SLEW_RATE_RISING},
 	{"nvidia,drive-type",		TEGRA_PINCONF_PARAM_DRIVE_TYPE},
+	{"nvidia,function",			TEGRA_PINCONF_PARAM_FUNCTION},
 };
 
 static int tegra_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
@@ -470,6 +471,12 @@ static int tegra_pinconf_reg(struct tegra_pmx *pmx,
 		*bit = g->drvtype_bit;
 		*width = 2;
 		break;
+	case TEGRA_PINCONF_PARAM_FUNCTION:
+		*bank = g->mux_bank;
+		*reg = g->mux_reg;
+		*bit = g->mux_bit;
+		*width = 2;
+		break;
 	default:
 		dev_err(pmx->dev, "Invalid config param %04x\n", param);
 		return -ENOTSUPP;
@@ -620,6 +627,7 @@ static void tegra_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 	s8 bank, bit, width;
 	s32 reg;
 	u32 val;
+	u8 idx;
 
 	g = &pmx->soc->groups[group];
 
@@ -633,8 +641,15 @@ static void tegra_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 		val >>= bit;
 		val &= (1 << width) - 1;
 
-		seq_printf(s, "\n\t%s=%u",
-			   strip_prefix(cfg_params[i].property), val);
+		if (cfg_params[i].param == TEGRA_PINCONF_PARAM_FUNCTION) {
+			idx = pmx->soc->groups[group].funcs[val];
+			seq_printf(s, "\n\t%s=%s",
+				   strip_prefix(cfg_params[i].property),
+					 pmx->functions[idx].name);
+		} else {
+			seq_printf(s, "\n\t%s=%u",
+				   strip_prefix(cfg_params[i].property), val);
+		}
 	}
 }
 
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.h b/drivers/pinctrl/tegra/pinctrl-tegra.h
index b3289bdf727d..e728efeaa4de 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.h
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.h
@@ -54,6 +54,8 @@ enum tegra_pinconf_param {
 	TEGRA_PINCONF_PARAM_SLEW_RATE_RISING,
 	/* argument: Integer, range is HW-dependant */
 	TEGRA_PINCONF_PARAM_DRIVE_TYPE,
+	/* argument: pinmux settings */
+	TEGRA_PINCONF_PARAM_FUNCTION,
 };
 
 enum tegra_pinconf_pull {
-- 
2.17.1

