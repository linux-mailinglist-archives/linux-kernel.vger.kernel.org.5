Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310107BA7BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjJERRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjJERQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:16:14 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B33C25;
        Thu,  5 Oct 2023 10:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+DO69AfL0OP513E29kBhKd1M/FHOBruval0tIOok2xM9LIZrIDDKNilfLtrOFGRbj9xBl/buT4A6wat6Ct8RPywQ59xy9rfXMczjtPbJ1oRQuhzQN+WPx4DBLfMJwuEZ0r5sqa+RVKjz5wRpq4304a+Vd2Q/0fV0Sw/1Ug2UCB0u+g0w2JGq8Yq4YLrLfeCSZu/VafN1dHhaq7RYOK8y0V7QIOXUKVrUEA+8f7SX7JPmyjKnF3fB+JGKCokTmqnQqt/cMH/tYnxzB5iNZZX1eFSN1gqgstq23RGhS7+kox3sPnxYuI6BMimIq40MGHjVbI2yIqcI1tTBNpSIuJIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beVl1dPqUEdyNsSiBdvJ22V4gK8AwPSTRuT+j1cVGyM=;
 b=ZiGOXXQcIHFOuYlCHxVXaqP/7wF4r/N22Gdn3H8i9X+6ba2pdonKH3GP/MODK++axS8EHnqHnqxlSRVpaFyMY0XR2dmd24vcQyWIwgu88N9et+COtjU0nKjSRNvS+i5mLYt6Ozgy82pE3rEHm8ejILeuDiveUQqEarOhTYXqbBpxBC+mRRCWPqdukncXmbESDMHAbOkp4dvl6ON0/NlyHayBnEg00HQEDAvhNBJD5yNqUxLDLGSYUDBuCqdbgIPIyN5oxvAoN/ut9QMQ96Znv4tpl6zScBX7M99MaFKr/9gkn7MaoSFvwdAep7hAVO2Gdof1JnTX9+3h0MKPsT0PZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beVl1dPqUEdyNsSiBdvJ22V4gK8AwPSTRuT+j1cVGyM=;
 b=IuvD5HjdJd4nUDNAfSrnTsZpgzbekz5+/t/L+J/XITkT5HXh6668g42jIi4zZ1VtBX8ccC+qfE6ieYmH2e5d6y2NPwLZyj8hlkRMmjEcLthIhiSmVU6xEegsaxqcgwC6HY47wP5POMzgblAEJ4S0S+Y7EmKY6j9hM6aXFv8GW0I=
Received: from BL1PR13CA0201.namprd13.prod.outlook.com (2603:10b6:208:2be::26)
 by DM6PR12MB5024.namprd12.prod.outlook.com (2603:10b6:5:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 17:08:34 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::bc) by BL1PR13CA0201.outlook.office365.com
 (2603:10b6:208:2be::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Thu, 5 Oct 2023 17:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 17:08:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 12:08:34 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 12:08:33 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 2/2] dts: zynqmp: add destination mailbox compatible
Date:   Thu, 5 Oct 2023 10:08:25 -0700
Message-ID: <20231005170825.3521669-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005170825.3521669-1-tanmay.shah@amd.com>
References: <20231005170825.3521669-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DM6PR12MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: e501db63-95fa-4d7f-5660-08dbc5c5b537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: juzLYmMOdRyOpbPLBqN0uBf64W4NRdW7MLkImVXLgMlcq9cutmqyxRoHN40pOe7T+P6i28xtB41BN+2I3NROrE24LY5l4EyBmiuhKSG9oHx06oavEmfOUppDtUyKaFemT7/fcOPaYqzZ3TqoGp2KHkl88Q4BkXuhlroQ8Nl2JkgmQ6U/PDfK7Av6+hfjqJ9FeNbGL9S5e+u36rBxYAguDVx96LhYfS2wY83JVXQR1Aq70OrncXZiJq8VMwcA/wxIc3jMA/tPFVM0gWR4X+0u/j1Kodo2ha5rKm7Ym+ri56RpCMVax/2O3OGsaq+m4CW2NB9DG6CWhlxzlfaxAnrTMY2SiVF1Ckx/1z57rkUELzPEoiNmvKbyP+acTZAkXIuZqwAqTviDU7nih3xWN5XGPD2opAihTqNHBoPP7KeORW1A6XwPJC1K1AlPo+Bm+fcay8SQgab1Z7IwXaE1zQQyqq9Xavjbb6wc2UlwiODB9sFT6HRCoyy3qWAFEsXLyQyHlcmaLRkf7T3uZlY7Zi0FM6e4FGxJVIVRw1xIa9syLK0eeZm8yNLuyGPWuPTuRCx/79+wtNpFHxdE5S5fiM8MlzKbnW5Yujbe6RkwFoohH9YZcW2HKEgWgWjKLa7APQNiDCoAVxsLgmvt4HV6JcNOV1wl5cIXgEvv+O2D60ihz2jB2nE/g5k3qzSE8IaFogOINbyijwhC33O+3+19PbhvvP8ZlMAFqPahZZJLf7J62PAfJT61H+aevx3ehIPq3JvV1ZAtBvSXsRGdJDIQo/7j/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(83380400001)(4744005)(336012)(426003)(15650500001)(36860700001)(40480700001)(70586007)(5660300002)(110136005)(86362001)(47076005)(82740400003)(81166007)(26005)(2616005)(70206006)(2906002)(356005)(1076003)(6666004)(478600001)(40460700003)(36756003)(8936002)(44832011)(4326008)(54906003)(316002)(6636002)(41300700001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 17:08:34.2120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e501db63-95fa-4d7f-5660-08dbc5c5b537
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5024
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

