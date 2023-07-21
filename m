Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C39775BD24
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGUEMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjGUEMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:12:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302C8272C;
        Thu, 20 Jul 2023 21:12:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvdOzSVbuP4jMgsHHsTgGRPWfsn5n5/21Y0OkGrIvVmlgdgOKtjGGg3BZmw2Byg4yo2pC3bNKllWvkLSRts+wB1qlWu4JumSBvxBn6Jt+qpEsKAY9kB5I0SzkK6nkbk50LskTWWFvBdEf8L/IQnbFJxJkP5g/ETw683ShBA2oDGYL0AWezQgMMzuWYFj2ZerCp1mSPjLIbw7gNB8bzoLNoThiIX/WJkoYDrIU/6WHB7yA0nSa9l0prcyYQZ5Zio7ydASGWf2Ziv0DdSeT00XipYJIQnTVQRgbtanwU6dbzsrd3h7DrQktULphkRNK0jQYKvp2Lk+5Mc6SDW8JxC3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCeVRG4Z8c6IvROxNigIyzoyYOdsqldxjFadt/VZYNQ=;
 b=cDNEc074MKD+cs/Ua3+ch3i7+jAy9l71ewoeDx49eomu7gkR7TenvtjQRiP9y68SjqqKHFWzpdKgtpHCM0xNOThu14L26VNzIT9qYukhyujNEP8zTf8ZJj7NBNLx8xQlh5QbpQOzD9PDVePh7Lv5FDIQ+LsSxN01u0/Y+tr6YxvxGWhzsfIVT+Qh+cxXNSfL9Ws0QXH6X/N2jYpSdcgrapk6XY+seOK1BJqNco6Zvk+EUeQGWaujkvTNcgCIzkqgw0jzn3/vCUuaXatSugeHYhr2V4+hN0Klxc4o+LS4bSVQ8jmNC+6s2nb89EcsCdKBe1bg1TeQO+6y0SoGQFZpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCeVRG4Z8c6IvROxNigIyzoyYOdsqldxjFadt/VZYNQ=;
 b=DR6RJox9zkhObaWuWHJIA/XD1S+dXHN4gQEMXYYxrQiX30yjgKGFOsruQ9keCydunXAKUHSQu/mYrfNcgyr2NVpvN8MGAfXdNHs/aWSXf8b3KrGlNVtnNalXq3//plgDM6X1HPrvTP0GUzM2kDv0DFaxEU5ZGEl10s83pySuFsA=
Received: from BN9PR03CA0658.namprd03.prod.outlook.com (2603:10b6:408:13b::33)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 04:12:00 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::3a) by BN9PR03CA0658.outlook.office365.com
 (2603:10b6:408:13b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Fri, 21 Jul 2023 04:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Fri, 21 Jul 2023 04:11:59 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 23:11:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 20 Jul
 2023 21:11:58 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 20 Jul 2023 23:11:56 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <michal.simek@amd.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V2 2/2] reset: reset-zynqmp: add support for Versal NET platform
Date:   Fri, 21 Jul 2023 09:41:19 +0530
Message-ID: <20230721041119.4058430-3-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721041119.4058430-1-piyush.mehta@amd.com>
References: <20230721041119.4058430-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT053:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: c77c3a28-8ce3-41a0-37bf-08db89a0a120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DjjMhvo8PBbK5Xie3XnT9L7tTY1Hb4CNmjy81UsrY/YhYTulk691xAS9vZgsIP2Ke2GijBAhwt9XZqxP4knY621pofBUdGlKnio0naJOVVo31tePsRPs2GiefI8hkxvJuxyPv4KK3Vj67Ap1yK7xYXX5veUEPG5G9wfD2h7UMjwbaQ80XjELKm/FMtzIYN6upPI6dOno+i71iRx1rYW4OYIAiem06+IpHrhzu1eRzrmIa9raC+CKQ5RiYVBKyNlo6sc/ku7XZ4IieVWqajihFrY0XBVLFe4SUPRfNsXZkjocLbsYEEHg+Yet06O62NNDPB0ZGNWRtlMAIxovnhDxj2Z0J+JKhYLdDMSce1GSfr+yThmEr3zWNH15Cr9mxe8+IhayOF0xmlfNSEgKy01b52sCE0/nxo0lS4IIInt13bgMeq5enH4ZqeUubqKkq9SZ5mu5KIcH5Qait3I1V1dodvzVnGmDzWh4O1AA4ogsGZ9m/vkVP2bwhE3DQir0OGreYtaiqInAOKRbSyPSm57Tnww2vqSwVMnERQ/UUtknFogwquSNO3GoetKefA45GVQOC4T0UXZ/EV9evQnhjNl2gRiUDBGYVFUKBC+vyLNAtHGdprQgkntRvHEBy2WR3lErXTY3XqJC2OmgHjreKBEsBaai5cHHnlZIiTuvcVF3eer4qQL2QDo5MVVWhVWHxAt7gLksC4m4Vc8EVA+/Bc/wCY2FohBUaup3hJozKYLY94UiaelFH+yMAGlpj5ijnst2E3VGLIMPlMI2vFA1yq2gyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(70206006)(47076005)(70586007)(40460700003)(2906002)(6636002)(4326008)(6666004)(426003)(83380400001)(54906003)(478600001)(110136005)(336012)(186003)(356005)(36756003)(82740400003)(86362001)(26005)(1076003)(2616005)(36860700001)(81166007)(40480700001)(41300700001)(5660300002)(8676002)(8936002)(316002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 04:11:59.3604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77c3a28-8ce3-41a0-37bf-08db89a0a120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

