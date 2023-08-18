Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3551378031E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356914AbjHRBXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356870AbjHRBXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:23:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB3A3C04;
        Thu, 17 Aug 2023 18:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuppLMJ2R3vpPDJOuxB54MIx5NrWfTMnZnROfmHwJ4rRcOURApIuxgsxKvI8uVNPa8PtDykVtD7cUO8HhdF9bVyY6F0zw2H90+0ACrqZNPZt0/Cugv9qUspHok3qb6SV/jRAVDFLZPkN+E0H7U1se3GqUDQjYR81M8nVi+5HG6xMQkIBAGCRJOnzaq5TwlhANFf5x4I0/reiPFrsKIbG/YtSbEEWDrdyUsIiHthD3MLWRnIdrFhgr6J0D4vEQv7ZrGvS2yG1mE+KQSkgRgLPGZYOxV6yZGC9F4FOMljjshbzoNE6rXl32Kmgsv5EPMIAAy4mdlsMKS7/OInBzSeo2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg6qzTd16PrHNT2/xadLlk0Yv62CaiGrs1hoI+rhHkQ=;
 b=WJa3T7D38u+5IEA8rw0FMPDelHxXGrF8iedcZZ0NJLSmu7CJWZpayALnGn0N4hFBvoc4urZr/lEgBZEs8Zz9zK3R2yh2F9M+I+bKfo5sY1xLYPXndTNHad4uH1FgWT0Jj3qluM1GixOE/lgLI41lQ0qTaG+26kksdu1XOyfHwoDTA2LBJFp9iruIzuLDm3A3XwBPBMVlQwJkppjDCcldGMBVuXhaihIr4K20mo8wJTHHNT7Lb/TkRqVNeJ8UzQcH97kujqPs24gQT892gwShC9NludK6c/PMbGRye7bpQsl4Cht2BqWH8/QC4QyioOs8/fSWieLqXNU8jSPcAvb6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg6qzTd16PrHNT2/xadLlk0Yv62CaiGrs1hoI+rhHkQ=;
 b=NIMFFcnrSAuAvp45QRVAh2I7+j1e1Kd1Ky5N0sx6A0ilX/bXVfh23SygQXmEIi18euaQim/uZkqve80lxp43BG7ee8IfMy64QR9+Yuupj9GA3VRTo1Vq8plOziZGEz5KoDzPvWeDOMFD7JDsqN/m8ACUIlVc+9qDNFTB0248bH6oazvPPSqvMEm8sHtJ73y5Bw46w8ddp8osrmwihxQZZhxdHSb0BvTNaYm+CebGOxfsb5rjxY3K5vhS2z7SA12S2pr5n0IacCffDRGYXLvcVQGz4TQU88hTmzXLDG4+q3p6q5vknAsvb4rSvbBqrW2CV+VAG42GVOnPJcz/FnMlsQ==
Received: from CY5P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::25) by
 LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 01:21:33 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::4a) by CY5P221CA0014.outlook.office365.com
 (2603:10b6:930:b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 01:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 01:21:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 18:21:18 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 18:21:17 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 17 Aug
 2023 18:21:16 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v3 1/2] pinctrl: mlxbf3: Remove gpio_disable_free()
Date:   Thu, 17 Aug 2023 21:21:10 -0400
Message-ID: <20230818012111.22947-2-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230818012111.22947-1-asmaa@nvidia.com>
References: <20230818012111.22947-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ea9396-1169-485f-dcb1-08db9f89753d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 361qddnL1nPffaERVZMPu3c6NOY3ptEcL0UbItSRpyifpfelVfTS9DMPGM4ZO2ZBzjdgupbJB01N0R+yUsillCtMbaOnY0piqCtJE1UEtqtpHMJznXASkl0owWr3vDsH9cndNZYMFqqsR4GQqpX7gN0byUk0Ju/8HXRopHYrf72qqPDDJUpvlLyRCcIT67EqRe4iHlWv91Hm+LKP6Nnp9VzMnffdSReRn/QKdfNvUO8KMVeZKwDh+wmvndz/Na353qE5JX1z8d5pHSMCbW5+saQnq5VgwrDTMDf9mMQk6WQjoXYr1TeZvW+03JRPvF1gxwOpTHd1lo9twYP+elLthHpzGrhLO+o0u4+ULusx28p/CfIDSJI3bzgihEVnjhUqXq+XNOgciWIYK8WIG3+Hnd0TLDKA812/H16iMf6/ltbqpivaIGqvh/yl8V007hDx4V8rXswmz/MatM+M4Qcr3xfrjrYe7IrRtBpF1HJ8ZTW2dKnFd9M7nI5m1LxdQQjpXmLkbVwtXjhuLd6s1Mo24XKdNtAOgO8cZABkD4XpOnZFEO6Av5BVSO5xeb7ZkBZtuHlJaFW1rZYcnqpxIibL7mN2KcA6do5uW8HsYNf3pwt6KLED3W+JQjxUP3lhNo13AM3s/T1/z/dC8QGIQeRjJTyHWXMqgwSycJ0fYIDCm7ByNm94jiKB79cotZSTKA80oV5TbRlIajhTbOfrGJ4Wu18t0gzd/Lsz1LKpxMZorHxLtxrgtSVg3DAuT6sJRQ+T+QidoTkZiNfn3gHPzPTt1g==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(86362001)(36756003)(82740400003)(356005)(7636003)(40480700001)(107886003)(2616005)(5660300002)(110136005)(70586007)(478600001)(70206006)(7696005)(6666004)(316002)(26005)(1076003)(4326008)(8676002)(8936002)(41300700001)(40460700003)(47076005)(336012)(36860700001)(83380400001)(426003)(2906002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:21:32.8442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ea9396-1169-485f-dcb1-08db9f89753d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove support for gpio_disable_free() because it is called when the libgpiod
command "gpioset" is invoked. This gives the GPIO control back to hardware which
cancels out the effort to set the GPIO value.

Reminder of the code flow to change a GPIO value from software:
1) All GPIOs are controlled by hardware by default
2) To change the GPIO value, enable software control via a mux.
3) Once software has control over the GPIO pin, the gpio-mlxbf3 driver
   will be able to change the direction and value of the GPIO.

When the user runs "gpioset gpiochip0 0=0" for example, the gpio
pin value should change from 1 to 0. In this case, mlxbf3_gpio_request_enable()
is called via gpiochip_generic_request(). The latter switches GPIO control from
hardware to software. Then the GPIO value is changed from 1 to 0. However,
gpio_disable_free() is also called which changes control back to hardware
which changes the GPIO value back to 1.

Fixes: d11f932808d ("pinctrl: mlxbf3: Add pinctrl driver support")
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
v2->v3:
- No changes
v1->v2:
- No changes 

 drivers/pinctrl/pinctrl-mlxbf3.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mlxbf3.c b/drivers/pinctrl/pinctrl-mlxbf3.c
index d9944e6a0af9..0e852a0d5ec2 100644
--- a/drivers/pinctrl/pinctrl-mlxbf3.c
+++ b/drivers/pinctrl/pinctrl-mlxbf3.c
@@ -223,26 +223,12 @@ static int mlxbf3_gpio_request_enable(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static void mlxbf3_gpio_disable_free(struct pinctrl_dev *pctldev,
-				    struct pinctrl_gpio_range *range,
-				    unsigned int offset)
-{
-	struct mlxbf3_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
-
-	/* disable GPIO functionality by giving control back to hardware */
-	if (offset < MLXBF3_NGPIOS_GPIO0)
-		writel(BIT(offset), priv->fw_ctrl_clr0);
-	else
-		writel(BIT(offset % MLXBF3_NGPIOS_GPIO0), priv->fw_ctrl_clr1);
-}
-
 static const struct pinmux_ops mlxbf3_pmx_ops = {
 	.get_functions_count = mlxbf3_pmx_get_funcs_count,
 	.get_function_name = mlxbf3_pmx_get_func_name,
 	.get_function_groups = mlxbf3_pmx_get_groups,
 	.set_mux = mlxbf3_pmx_set,
 	.gpio_request_enable = mlxbf3_gpio_request_enable,
-	.gpio_disable_free = mlxbf3_gpio_disable_free,
 };
 
 static struct pinctrl_desc mlxbf3_pin_desc = {
-- 
2.30.1

