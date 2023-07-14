Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FDC75398D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjGNLgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjGNLgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:36:08 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BB92D79;
        Fri, 14 Jul 2023 04:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y60L/8U6iK19ZjO+w7Z+sIEaGhngXj5eyvoOxY2vmIN1VNK4ITJbN/ZcXUwdLgNUlcrpXnNEYFL0cZZmmKRM2Sg2MF0RkClbNik7glYdNhXuybXlujgJQ/4HPX+Ypw3OH1DAEwP3xDA0H3Q3SaO9IStvUbYkTJgNHi8wFs7wCjg6kREIsXb7A+wFk9HW7r+Jn0Hd/++zz9OFuDAKJkqbJ83rUUlQExs3mM8c5Pc6QOaFAG/U+fJf7FlGeq5nTTh9N4XnvtWsP6cGNxMCDbyINZ9IcRxhCx5MAwJKNmVE5vP6C0wEswYXuxuyDdUg1ntSEJryg57z7oE9xpE39nFrhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z32NVmj7ycKKg3qLHvoWtnfvGw4/6pZvIPdu9kLXKSk=;
 b=KIcNmbT0mTyba/jrjc/JsHoyPB9DiPwLtqNKpmf7QpBkKgIySZbfbOjXi3dAdhMdf6MMK4Fy3xyx98OfAEG3bKUxI4DDb1JWk35zvtA/18Swqw4kR5Dh1DJT0kxwn3BPGqOzx5/loenIXt/IjQamZkLoeQNNVFfqpu7/VtE1UwEOtGA8CQfcCtTCQydIjhnDLW4H1/0LwUqregQIYTqGwA7bUppeLxmccAU7f4ZNER44F9N9YQ5IWVDrNprJ7Wan68RbMDOBfu21hnD5uLi+ihfatWW/I3Knw/pOKQBMwBrVtduV6ohpzAJICfLmTX7MRWZDPCUj6e2BxlHKLkqsaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z32NVmj7ycKKg3qLHvoWtnfvGw4/6pZvIPdu9kLXKSk=;
 b=CLKsbCwZCwquMPVLOIlKJVef/kqlvBr01DMepb3V+Hc0nljDo8ua5KKvhOAU8P2hZ/+zCfu2BfvcLX3rB058jc3SS2ePVX+4eM3ml7t7HdtVCerDciI+Q+PBFBMLE2O8nCczlWdgs7V102PfLuH4cQXTjWJ/ylShHY+sIqj2Xi7ARV6dRJCsuKjl42EsPk5yIFHetN93QLUzjuiyg142dNvCUiGNOs7nJLt+ZSuHQYOe/EGQSsp7P8r8FbfDKTUmcWvw4XyHwKxBkW6M5ARP634qUFLvGt5kxI5i8aBsUJyTwNcu8jyW66H5nVgi/tf5TZbSS37MV6eVfhnQ0x3tFg==
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 11:36:05 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::a9) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28 via Frontend
 Transport; Fri, 14 Jul 2023 11:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27 via Frontend Transport; Fri, 14 Jul 2023 11:36:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 14 Jul 2023
 04:35:52 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 14 Jul
 2023 04:35:52 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 14 Jul 2023 04:35:50 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <linus.walleij@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-gpio@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pshete@nvidia.com>
Subject: [PATCH v3] pinctrl: tegra: Add support to display pin function
Date:   Fri, 14 Jul 2023 17:05:47 +0530
Message-ID: <20230714113547.15384-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <0cf720bf-ae4b-5780-bda4-5c9bbb2d1d67@nvidia.com>
References: <0cf720bf-ae4b-5780-bda4-5c9bbb2d1d67@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT053:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 4596a86b-e2e0-4364-9da4-08db845e81a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSa10qUi6BPGCFTRo+cudKOBjHQnMComccOdusNzdaIr/AV+ZZ/T8L6mpgz70oaojq05pGKU92zt/mLJ/+B2xnsyyKKutE4YOebIkG2a+/UpCYL/s96LZtk1wEitT4bI14upmDrJ9UTEyszQRLUQ4SQmzmr1BkHSl9O0QHERdpaTgSIP89vibaVP5glZvqTI9qrcMWOceaeRV7rjB8Gui8YVMdc/7DFNk1jC448pmBSM0eNK2RVKOAYbkuww/iTM1xqziQxALb2jw5am9xz/WkURykqSbLk/46iT6vv7bGFkNoJ0mynODLyd6Awzl4uDqejIcCKwn7wsGBZOXunVjJqEPG4a0vrxXR5C2tQ9rzksdpcYMvbX6Xxw5egTgWH1MUNePeU8tiD2iJ65JMRhAs42eoY9ac5WsDfv1fI6h7BTiD+edC/k2JwelIDuRfoiU+An4JyZB5ExNVJ9F5e3YYBNW79Y5WKAflEs3eSCmc+hEo0pdi8fs4eAhjavW32JonCfvE622Q1lb2CPLKaArFHTTY89154GASdfqFCgrP2NxTp20akvPmuylMT7pGD3dWjUErwsoXaKxa/pNeCPHnvWgI0K4LXSTAKVQzopD0ErZTkJoQ5HrFgcNozYmhtR9BT67fd5F1C8dISBMk5B0vqPLuPpiSPTGhdn4b3SrbQcdDioAB3vK8pAFuOusre6UStmYSMx+BWMb0TO415347K5fMpvXF4fLWUbCqt6VwJPtTOaIymJfkFThzYEh12/
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(8936002)(8676002)(316002)(82740400003)(356005)(7636003)(41300700001)(40480700001)(40460700003)(86362001)(2906002)(26005)(1076003)(107886003)(6666004)(7696005)(2616005)(47076005)(82310400005)(36756003)(336012)(426003)(83380400001)(36860700001)(186003)(478600001)(110136005)(4326008)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 11:36:03.8673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4596a86b-e2e0-4364-9da4-08db845e81a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current function for a given pin is not displayed via the debugfs.
Add support to display the current function that is set for each pin.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c | 19 +++++++++++++++++--
 drivers/pinctrl/tegra/pinctrl-tegra.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 4547cf66d03b..cb1d67239cd0 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -96,6 +96,7 @@ static const struct cfg_param {
 	{"nvidia,slew-rate-falling",	TEGRA_PINCONF_PARAM_SLEW_RATE_FALLING},
 	{"nvidia,slew-rate-rising",	TEGRA_PINCONF_PARAM_SLEW_RATE_RISING},
 	{"nvidia,drive-type",		TEGRA_PINCONF_PARAM_DRIVE_TYPE},
+	{"nvidia,function",		TEGRA_PINCONF_PARAM_FUNCTION},
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
@@ -633,8 +640,16 @@ static void tegra_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 		val >>= bit;
 		val &= (1 << width) - 1;
 
-		seq_printf(s, "\n\t%s=%u",
-			   strip_prefix(cfg_params[i].property), val);
+		if (cfg_params[i].param == TEGRA_PINCONF_PARAM_FUNCTION) {
+			u8 idx = pmx->soc->groups[group].funcs[val];
+
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

