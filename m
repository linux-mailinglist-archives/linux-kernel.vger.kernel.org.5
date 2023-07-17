Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C261D756181
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGQLZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGQLY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:24:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909C210D5;
        Mon, 17 Jul 2023 04:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ny4nP1E+e4donYkJalMkgdcDoGMQ051Qf4N09cZqilZ1aocfv/7iu6P4qDV53E6Qth1I0R1waVoXwItyCHreWsbpFvx9wuC1KkeaIthyDDfbBUuMYYWakOlUyrzbgmeojL7W4IxkM1ztSMcPruBnTCJSyrCcYCNJrW8X2qCZpq6UFo68Su4T9+fJE1rViY+c0ye2wT/pHlYkHCz25iMYlpJCr+wbavup9iWqPnQnnQjGeYdQWADsu4Uyrc2eMdBmmGhCuBRWTGfZ17479oImVhEzrO4IESRCnnGYt7oUWRyB/gdR2FzIVhHqOieiqDq7i5ZiHqQnFOipZlpZVZCq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCeVRG4Z8c6IvROxNigIyzoyYOdsqldxjFadt/VZYNQ=;
 b=cGchgmhkfrKVutCWbxwMvfIUFU5csSPETjETIqc7p9Rynsqp+TFfAXCLEG49zAwDing+h7Hjqb6sREM6wPaDYflKpdWWhuhMNDlIP7P4TsdCunTsWxXcoCpeKDXnw3G2+uEZJLxwzGsq4RhBwMhUajCfKvH4Wglg3XxDepPNDqwrJxP76vWkvGxuMFeCQvAff1lEgBhFYzzi4yfFRuURYLfz/AaDoxCrf7KMtJq9yseup1JjPST3KcfdD7RtCX2ha+p8POXMei7gEhOYC/mVAEVh3+FuuwSXyi0HS5/H03jf08gayv39u92hd5/PnMSrGz3e0M2P/icn1Wg5o3nEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCeVRG4Z8c6IvROxNigIyzoyYOdsqldxjFadt/VZYNQ=;
 b=Iqz6dpZoRzjFYkMCNy6832G6CnZRDyBIOCmr+sOYEXgrMrxEXzGW8AMyRxsYzRkeHxnCWSAtHUTv/mb69uj/eG/3NH1Ih+ap62VkwDW2b/NiujZCOT8GepdTFniNmBXZnUFm0KMZaslFk4/mysd0QLrwwd5ZNtYI+mFsAecmvTs=
Received: from MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17) by
 DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Mon, 17 Jul 2023 11:24:51 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::a) by MW2PR16CA0004.outlook.office365.com
 (2603:10b6:907::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 11:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 11:24:50 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 06:24:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 17 Jul
 2023 04:24:20 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 17 Jul 2023 06:24:17 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <michal.simek@amd.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 2/2] reset: reset-zynqmp: add support for Versal NET platform
Date:   Mon, 17 Jul 2023 16:53:48 +0530
Message-ID: <20230717112348.1381367-3-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717112348.1381367-1-piyush.mehta@amd.com>
References: <20230717112348.1381367-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 982fef9d-5c37-48a7-326b-08db86b86f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STdmS2UFJJ5fJXMsTpGTeD9c3QqKguwnoBHlAGuzAThfEXlWAxKyZvWH+zS+c5lJZNAWbkkrJIRO945It0Z9XDWBQatI3ljMQjwRBw3HreYTHvMWTlKUx0sR+vkMY/62/skpSHvbJEIWeC2mr/HPTdujs1+EBPJxtBmv/wSkCsPZsfr9O8EaE3QHxggEXVCnMk1/OJDR6uGuPuqczEqSQTIYSxoIRf/JRx62Qs7NfG2meKBJ3KX4skCEExB0CpdauQWD78srsb6dM5dWpy42+rn4bsi9jSkV/VD2uyMDlTdDtDq9jHT2Ihrc9mKYZJ8bfcyEYsuUJshEXQ749lFvddPsPuxlsjb8UumpxxxbeXEwjffo1bAXcbzPMLYHSzUVLoMjZELcnYTqhi8hdL6IgROAP14i3Dj76y9SydB18bMZtn2fdHc7P8YTHediOis2uSqCqrqZo00t3lmtVZALBM7cFOJeNY11NG7/oqorlFHN4IOXKezNhg1SJ6+HhCAynWXqDzDTmawSv15BUrjeK1omNNSw3j2IfnYePvPOgHlvKQr6zuX2GbvAAfVGYK/YML0EcZ5xF2M93vn3heoAFqY98R8K2DIakYj9g4d9JN6ExPoZObUkFIcQddSr1U9fWxtQVMexNSqUA4WZArwdafmwQHOKN9fwqc+rxSDvJnEU0a1GoOG5zzswopua5dtixPLEGB8IdK5i5wGKmIdPNe6rHJAASwlcfuIULDGKCkPZbN7QyVpj7BH6ouvWCfG1g+rqNuz15IMC7sX/mnJaug==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(426003)(81166007)(1076003)(6636002)(70586007)(44832011)(4326008)(8676002)(110136005)(36756003)(316002)(70206006)(2906002)(8936002)(5660300002)(478600001)(41300700001)(336012)(40460700003)(54906003)(36860700001)(86362001)(40480700001)(356005)(83380400001)(186003)(26005)(6666004)(2616005)(47076005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 11:24:50.3550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 982fef9d-5c37-48a7-326b-08db86b86f75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated the reset driver to support Versal NET platform.
As part of adding support for versal NET:
- Added Versal NET specific compatible string.
- Reset Id and number of resets.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/reset/reset-zynqmp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index 59dc0ff9af9e..2391ac16a180 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -14,6 +14,7 @@
 #define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START)
 #define ZYNQMP_RESET_ID ZYNQMP_PM_RESET_START
 #define VERSAL_NR_RESETS	95
+#define VERSAL_NET_NR_RESETS	176
 
 struct zynqmp_reset_soc_data {
 	u32 reset_id;
@@ -88,6 +89,11 @@ static const struct zynqmp_reset_soc_data versal_reset_data = {
 	.num_resets = VERSAL_NR_RESETS,
 };
 
+static const struct zynqmp_reset_soc_data versal_net_reset_data = {
+	.reset_id = 0,
+	.num_resets = VERSAL_NET_NR_RESETS,
+};
+
 static const struct reset_control_ops zynqmp_reset_ops = {
 	.reset = zynqmp_reset_reset,
 	.assert = zynqmp_reset_assert,
@@ -122,6 +128,7 @@ static int zynqmp_reset_probe(struct platform_device *pdev)
 static const struct of_device_id zynqmp_reset_dt_ids[] = {
 	{ .compatible = "xlnx,zynqmp-reset", .data = &zynqmp_reset_data, },
 	{ .compatible = "xlnx,versal-reset", .data = &versal_reset_data, },
+	{ .compatible = "xlnx,versal-net-reset", .data = &versal_net_reset_data, },
 	{ /* sentinel */ },
 };
 
-- 
2.25.1

