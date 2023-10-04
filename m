Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B2E7B7C7D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbjJDJnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242087AbjJDJnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:43:16 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A5FD9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYFkY4bL8cpUyM62/mb8OKF+Tnky0HXC5SnmYHLPqQ/BJCHj3DtdDbDYNPGmmfGz+traw5pLlrSvvLgx6ddUHMcFhvwzs258NkP3GToKOTN8eipV2otAGCdgk5df2n4ie1jtCwo5F7hUIoQ7UiUVhEPb9Ct5E6zFT5WNFOk4ZlcTgptz9zgVQc4P8dzouoDqRsG9fzSsNeopNh5Iwi/KPypNjzTEbNezYmUUhKmrjvebRt48iLPTETKEtQM1oAMWAescmgDxle8i1QjSqU17+i6WPt/gOkGtiPW6aHeZyBMyEim+2RyeWOJsYC/eMhIbs2oNPooUH+VNtYR6QzMS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1tMlNZSsc0NCz9cjCpGTGHz+MHBa4yIO6Nis0+ArdA=;
 b=j4Fg6dqocJ1tJfPseWMVzr8pqRXMEUOnvXrD0l8TOefWyzTEBBS4aUbbksOXoYYdertJaIzpGl/G2ByU/A/78aIsBaBV4X8nB7lBTWOLtH4Z1CHQTsm5jWFM2QmkHbjrbzz9yc1hZmVyxePRZTtV0CsvnkQIsbapF77v6Ppe2W9Q4Oaipa2Dn7bGKSM5ww3v51n0eqCFsqCBv3kDybBWdkOpj4OSWd8+MJetHwJC+vnsJUtVjcAzSwLrQH6K7Yl2+RqSRuuGTtjMuPtPYTGI1Jb71OqZ9c9rEmzp8cAE4RNkoP1ZYMqHjgKyr1N4MQWBQq328izeAxZY/qFSbSN+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1tMlNZSsc0NCz9cjCpGTGHz+MHBa4yIO6Nis0+ArdA=;
 b=GvzWM6Xp/7OydzQCTz7/B9BDrSg/xoe4saz2HGAXDEhxZxV1C+Ct8cxw9Hj9CWAmMUNo2T2Vyjh419RbjW9LjCZ6QYrCSCz3ZKRjOz1qx4W9ZiTO3pMi9R0D3ViMsXD8CJiNHERUTxaH1cYFNbz3luOlAfmL2ha38evioJBF5Do=
Received: from BL1PR13CA0269.namprd13.prod.outlook.com (2603:10b6:208:2ba::34)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 09:43:04 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::90) by BL1PR13CA0269.outlook.office365.com
 (2603:10b6:208:2ba::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 09:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:43:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:43:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:43:00 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:42:59 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <nava.kishore.manne@amd.com>,
        <ben.levinsky@amd.com>, <robh@kernel.org>, <dhaval.r.shah@amd.com>,
        <marex@denx.de>, <izhar.ameer.shaikh@amd.com>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v2 6/6] drivers: soc: xilinx: update maintainer of event manager driver
Date:   Wed, 4 Oct 2023 02:41:16 -0700
Message-ID: <20231004094116.27128-7-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f07f69-b143-42cf-d9db-08dbc4be4e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OE9chN2iY7zqLEllhpXNXnVCj9rnbsmREpYwH++0VnrtbJhblp3daAc90GfWDMaU7F4rlN0o2Mai5b0sPe4NfYpB194g8Cn0cHDsYK9c5olHPGwObsl7kjCsBK3wZhhLvscztCHf6cVSZQrnA0kjHPz8FLSeidwbBjzPNJ7EHFGKDK8BCTaNfXXTkgwoaKGq/ffWtx0/BNPZC755eZY+J8L9TdlCXUfXD8LCvozKiKih1yfsx+AKVb+oDnZLYR7mi54w/QlrRhjv4ztA4hMkwzkvrnfy7ZUoHDDWoC/gd9tZuRRBnUv9gzqvXovi6EYRsHGYWjwcK21yyLV26qRdumHIJdX5ZsxQLdzQLQdsONDheITdVt0Rc9DUqIumx7/ARNR0fKq7DplA5EY797du03u/Owm28RQE/go21m+dP+17XVjnbDYctHJ/fitLOdpx8BTVT0jUjc+WA57o9Nw4xkWAGoN7Bvou0XADcrZtSi+B0iilmUePTALUcTVg1z2Lugw0ZK+pUwK6biguO8zgbhJwbyNk8L7cVTbd8/Q9CSsmRmOe68FBFlRJfGQ/0emdhGoD8GoOm/EghvPIfkAgwdFP0gzB/HYN3q9Km1AHsYH+tqjog6duhikH/3iKB+jJnWVfmwZrg3HPthGqRBKcoQy+sQLI3fEkfFviA9d4lZZCNy2bczfHyJY1+GIZnfCCioZDVVbL/j/93Yf5ecuXpUhw8uCj5q/bnxjtlBMEm1LQ4wdmL2EvsVMoyLHCdGP+jPWcxgOt40JU1xqiVKLJ3KG1htRS63b1dYT7kH3Y3J0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(478600001)(6666004)(36860700001)(82740400003)(86362001)(81166007)(356005)(921005)(4744005)(2906002)(47076005)(83380400001)(426003)(336012)(26005)(2616005)(1076003)(36756003)(70586007)(70206006)(8676002)(316002)(110136005)(54906003)(8936002)(41300700001)(44832011)(5660300002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:43:03.8357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f07f69-b143-42cf-d9db-08dbc4be4e41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added Michal as a maintainer of event manager driver as Abhyuday is no
longer in AMD-Xilinx.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35977b269d5e..f36fefd7032b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23672,7 +23672,7 @@ F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
 F:	drivers/net/can/xilinx_can.c
 
 XILINX EVENT MANAGEMENT DRIVER
-M:	Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
+M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
 F:	drivers/soc/xilinx/xlnx_event_manager.c
 F:	include/linux/firmware/xlnx-event-manager.h
-- 
2.25.1

