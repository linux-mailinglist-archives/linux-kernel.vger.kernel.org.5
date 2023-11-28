Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B607FC1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346607AbjK1PJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346602AbjK1PJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:09:32 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18919D64;
        Tue, 28 Nov 2023 07:09:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gthAygs2IdbyucLigv7Kn1QVnSOya97PNEUW8xdIQCrKTA8ixEBpSlH9KktY36ee07+dXyyWzPRzcYgcWqvdbsQbb84xi/agBYKqpF59QbeXKzBZ8Cwk9DXsEsfMgUOeFLnYAYaN95ZSNkVjQoshzy6D8M9WIGmdLKdG1u6sgTbqmsTwqtGy0mmPT+Cq5J8Rfb/W/SaeU6IfIRsJUd8QHPGlITxHgPm5Tffa/UMgs4QUdt0J9HBDu9WuxF8/4MyjkjeLK4Tv+55F6mkCc3Ix8NgzDn/SY60jpsHsM/VOufsnR610J85MKDm1V45BWV+X0TtAscTfNMdi7Sd15NVCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dz8cfwkXAHlLPZfWBcvBq68MWVCGFC8bGFZXLYKP8fM=;
 b=bD5R5OhTH2kCbaSZCFvhPZOBqdI1dMg5rTLCY8JfNQoowtPrnjrElb6J8VA2nE9GwbJgUscnQ+/6G2C4Sd9+SJTdgSqK4RQDiwYNHOgg1w0yDLf0tIfRD6renE2AR6aFpN1fvE92AXr3KqeHvotT+0X87a4+gQz+mQrgGVgiHPUoRMzW8cF+Pl9x7i5ND19blxzCOtg/Cvei8G2ytjHSLFTbEXRFmgMErXkqcawv5Yafh/q+yLPueHNm/M8gpqUJXN6KC24JAMKUtCrAiRTqup/CtOq0NmE1OM0aL1E5Vjugedx7JWnMbrEwUHsxOqHpAqpq+/ckJja0aQlq06j4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz8cfwkXAHlLPZfWBcvBq68MWVCGFC8bGFZXLYKP8fM=;
 b=NQoEOQx6HWdwhTN78CP1h3XP/x54iXS2BWtkeuQHQLoQOjXizxRe42VNaF+OIl1K3Nxnl/ZbMFe+RfbFT+YyY0fKQuX/1EMnD5DEo45z+fw0li5wS9tAjHwkRyQ+G8D869EhHJ8EmozrW7oAdODroZUvQDWBbWklxelJxM835Fo=
Received: from AS4P189CA0034.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::12)
 by AM7PR01MB6833.eurprd01.prod.exchangelabs.com (2603:10a6:20b:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 15:09:33 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::22) by AS4P189CA0034.outlook.office365.com
 (2603:10a6:20b:5dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Tue, 28 Nov 2023 15:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:09:32 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
         Tue, 28 Nov 2023 16:08:40 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH] backlight: mp3309c: fix uninitialized local variable
Date:   Tue, 28 Nov 2023 16:08:39 +0100
Message-Id: <20231128150839.2605003-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Nov 2023 15:08:40.0474 (UTC) FILETIME=[C53A5FA0:01DA220C]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DD:EE_|AM7PR01MB6833:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 30df66d4-570c-4c95-41a4-08dbf024070a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8TQhz1epE1G96nIHkEnF3isvlj2Snq7l21/3agvMF9HZ3WagE2kgx4fU8yKSGyZq9qNT7WuXK8JwbwitcM08PvYlFbtQKji8vQzI7LAsYYbSzlx75+w48uo5nbNRCQsmEx2Ha55H/cXLjSjcGwc5w19UOxf0/4autZxkIkRa+Zn+IVlH4M6vJSrZn3jWCVE/EqXZy3UHus3exqxF5uykID0NzVCYlZWVFb3dlJSXxIuX5ku39/pYMilL18CiwbAPZcGtayBNflUjRPLswxqY7Pj+YA1E6P+WEKuGBDTvAax1vfn/ZIGujfPC/dAoGPYPZcZF+dKzWVtlM/U46JrpvGWJUBXlJ33gQFZVHoV5hoOxmQgtEB2zqOPDU2ThUBqs883BDG9CcJX+p1HG7dn6TeUD4k2NG3p27pIEq/30iKvfNV6Xj5R58Hw7d98UzpjBGokAcT6eBRV3O7UGaGJH9d6xNBdAmbmIqLP9QB1PWdslAIuZPeeTJm8QVxlzmKbADTYOPkz3KvKtO+yYlHlbL3rA1tCjA0XgiiNs+qXsHqvLBMgvHxu3Nmw9woq8oS2Byy/kT+J4FBkRd2gIaxBOhUWgSkG5YDK+ixT0zYMJOhNEEu9ULiLCFSj4unKwjBVGm7zXa/NeVdcOl+R1szhzNnUxx1Dlox0ybSrXGHze5Xffcjo1jUhuwfrAmTDavIcIU03jsM5NC2c+wHahOfu2vdnJjadeHn98i1aozJMLJ+vDN7GVlCibgX7Bia4jIhSiWFvpkfDVP0bLulFPKI0q319gLlCPu52DNKcvsIZgJU=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(39840400004)(136003)(396003)(346002)(230273577357003)(230922051799003)(230173577357003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36840700001)(46966006)(336012)(356005)(36756003)(478600001)(41300700001)(81166007)(8936002)(8676002)(4326008)(450100002)(86362001)(70206006)(107886003)(316002)(1076003)(70586007)(26005)(110136005)(83380400001)(47076005)(2616005)(36860700001)(2906002)(5660300002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:09:32.7846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30df66d4-570c-4c95-41a4-08dbf024070a
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR01MB6833
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function "pm3309c_parse_dt_node", when the dimming analog control
mode (by I2C messages) is enabled, the local variable "prop_levels" is
tested without any initialization, as indicated by the following smatch
warning (thanks to Dan Carpenter for the report):

drivers/video/backlight/mp3309c.c:279 pm3309c_parse_dt_node() error: uninitialized symbol 'prop_levels'.

To avoid any problem in case of undefined behavior, we need to initialize
it to "NULL".
For consistency, I also initialize the other similar variable
"prop_pwms" in the same way.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/video/backlight/mp3309c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index 3fe4469ef43f..733cad1dd15c 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -203,7 +203,8 @@ static int pm3309c_parse_dt_node(struct mp3309c_chip *chip,
 				 struct mp3309c_platform_data *pdata)
 {
 	struct device_node *node = chip->dev->of_node;
-	struct property *prop_pwms, *prop_levels;
+	struct property *prop_pwms = NULL;
+	struct property *prop_levels = NULL;
 	int length = 0;
 	int ret, i;
 	unsigned int num_levels, tmp_value;
-- 
2.34.1

