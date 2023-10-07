Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65E87BC4AB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 06:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343536AbjJGE12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 00:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343492AbjJGE1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 00:27:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33233BF;
        Fri,  6 Oct 2023 21:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxrlf22FAtaaa3midmhl3cDaxVHJ59c6ntRpGfkJxGUzASHPwkquM9qGthBTdNhREgR/Blj2D+O4SA1B0ci0+emyZQAXFNPykyhcnYz2BvQl0dUPcCYiIDHwkUWCSv7dgs1ZZS1bFV8oSQwysI4tg7shz+sqg05ht/FP1M96nX8dkLxgeft2uQo3QjsjIdvM1EuX1afN8LihCHDa2pstpRpOo4Qh7778NF5VjWI1CUZoFvmyvqjUM69kgGi4CGDChJu4YheiGQmej+rwQw5l5srJoal/wJULzwLervwPk6ZXfDcLoZ4uBRZN4R5ROBwBQB4TvhIW7cnltMTDZFcccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beVl1dPqUEdyNsSiBdvJ22V4gK8AwPSTRuT+j1cVGyM=;
 b=IkBy8IXCs0Y0bYkaAsQpkmz1mSvj04DqIQhy7L4wTFr5Tp2EbnUPzonEbFcyqeWLESM281b+HYhwMzkLrWww+aWrYHVvHkNSjKgkjiHgFoPP6TRD+tOe7bX0125Dpx9y+H4OrmzrNgMN+MdkzNKGEei54tnOX61GyOo4t6P14Lm2yBE+4jC/luePs0VMr7zp7oa7VcEE+/SRUkMTjKVT/k/Z4Mkl3r75KuX3KJohM9SwTAl4tIqS30i2boWbZ0sTUUTpEMGBE8YdDmBu3Nzj0LFl5fBKZXTkNZZi34tuY6A624KNG0YnwJ508iSM316hVoZ7zigOKfDD012KhMuXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beVl1dPqUEdyNsSiBdvJ22V4gK8AwPSTRuT+j1cVGyM=;
 b=nrpf2gUmo9wncqNOfXN4i2Gt7CwsAhjuuGZeTMURcN/YC3A8FPrytM8bjVK18pqjEhvAf4tvHKN5V+XCkdvrOOYjud77+oFYZ2AQ6RK9UajRbLhNIEPJ8kR8Ba+7KrAIwN55Zb1I0z/yaSybVEC6f4kGckpaXXNVmBYDeRBnKQ4=
Received: from PH8PR05CA0002.namprd05.prod.outlook.com (2603:10b6:510:2cc::20)
 by SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Sat, 7 Oct
 2023 04:27:20 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::22) by PH8PR05CA0002.outlook.office365.com
 (2603:10b6:510:2cc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.19 via Frontend
 Transport; Sat, 7 Oct 2023 04:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Sat, 7 Oct 2023 04:27:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 23:27:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 21:27:19 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 6 Oct 2023 23:27:19 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v2 2/2] dts: zynqmp: add destination mailbox compatible
Date:   Fri, 6 Oct 2023 21:27:02 -0700
Message-ID: <20231007042702.178028-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231007042702.178028-1-tanmay.shah@amd.com>
References: <20231007042702.178028-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebb31e1-1bbc-4e9b-fe36-08dbc6edb269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: koU3xvtyZBxvuo3yyWud+y3nIyQQ86J7DyebO2FpDpwdoCWjZGG//3nIH34wCBr7ZKZdyBMeZagGgozoG/1QxhDlA5DQN7KgPO8phLCAktZS6aa+hdVJJhiW/vH1P3vRGEbHiXU0Y/SRWmPEyHH6OZUDkTSI7jOa95f49Ac0093BCgEiHINrQNeHQlOWR8r47DEpA8oqonSeHmOEDXEAu4EZGwWMMZEonhRjTOO2SPbSp9YoqiZa5MnJHVEhTNwCnRSJvXK6j2MRAnmwRdVXFxb1MAmYj/ojdzgiHg0EPGDZlUyVi1Gy9pahv2Et/JNGWksllGa8HKbSb7VpmSZVYxv50zk8mTbfpxTA3xebjFHg/vsYIMEY7NVszOe/lH3Bcm4kdTYq0/ZP4xRjaT8aKkFecz8uLAIvwGXSscZgD88HX2gRlgQjdGBHd5o2mxW24DqHH77SLzndQMLWTGpoPgsgQ/C3fG2QECI2lZSKzeoMy4u+STcjR2e8ZOKRvOav5T6fkKWUrcbLJR+WZDV0EMFh6gcOQAh7QvFF+iPOw+dPuuaAgQ0uiv3Msv9XMWWfjb7msyLV8NJj4HgCT6oS3SWI0aZxOEdb9rUGBFYCEsVwRwt0p4mwBM1DfV9eTEW/qJCmUa3zrAjWKP8GmNfIuQcTJ9D8v4wY9QDIq9DcNAzk4rNB26oj5ahoohXaz3RTaTxyKK/IkRQB+bkw84Gcygodr66m06iSmbUJJltur5D4dFc6p//sJFn7riKiOd188MlnYe36nbtQkt5XYnzyBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(2616005)(316002)(70586007)(70206006)(54906003)(40460700003)(6636002)(41300700001)(1076003)(426003)(83380400001)(478600001)(336012)(26005)(36756003)(6666004)(356005)(47076005)(82740400003)(81166007)(86362001)(36860700001)(110136005)(40480700001)(44832011)(15650500001)(2906002)(4744005)(8676002)(4326008)(5660300002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 04:27:20.5271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebb31e1-1bbc-4e9b-fe36-08dbc6edb269
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each node should have compatible string to identify
itself. Add missing compatible string for zynqmp
destination mailbox node.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index b61fc99cd911..8aebac27742e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -141,6 +141,7 @@ zynqmp_ipi: zynqmp_ipi {
 
 		ipi_mailbox_pmu1: mailbox@ff9905c0 {
 			bootph-all;
+			compatible = "xlnx,zynqmp-ipi-dest-mailbox";
 			reg = <0x0 0xff9905c0 0x0 0x20>,
 			      <0x0 0xff9905e0 0x0 0x20>,
 			      <0x0 0xff990e80 0x0 0x20>,
-- 
2.25.1

