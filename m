Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2804C7B2CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjI2Gti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjI2Gtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:49:31 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221731B0;
        Thu, 28 Sep 2023 23:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6k89gNS0yffhUhfFhY9bgqiJG45vfTbC9+obIdYvnEFwtFWX57LIdGhh8HrEjCeeT+gVJMa9nlzgnALbKiSWnjDBjdSOknJN/5mJByg8aWAmMTkDkxk1RutfqBzTlgMZV4TQCRkGeA0aGKmZy/npdHz76IkGr2qWLSEypcbAeSvhRCpUVw8AIg9Kj3Rx/K7Og6GFHp9GPQcymG9VzeO+8J0Z/Ra6bWNvjKDrExNY4rizELWhuPPvHkQd5H4OTz7/cfwt9Lf+ir0aX+Fx/FwCwLCxjjfWNPoXBpmvwIZu2oFZGDUxhHLMhA0hxopOeYv33B7+4Dg674ANX3z/4oDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPoaZCgR03GIQe8UfLJKb7AhUigR53gaTJAIQFfgXGk=;
 b=Qc4D1zzbujKCwQ/PYolvtu9ngG1AsKdtTFzpgGBFAbmPLjazGY7M2gqa3mvHSvhsKlXZaVdV1FcyloQJUMySX2ImRf/9e1Qf1zwk3uOjbMFb4ZPOeM7JJTACSckmYmpSyhi4ZOUF667juBQxUXr9kyESih2a/ojRaW+v1iu2lNJ+eduCWk60x4GvSY/fvycOMHxwRpICSVUz5KYUDUGRd0UhiY0BZdk7ihk4MXYRgcdLj2ckyY/s0N0szKkHONE7KP94gfBuYpYtWaCnwVM7xq5WzvEdBHjtnlUIgUbIC64I9kKv4H3LTLqxvdBR3FGtfvLcOHG3iAnZTvApYE8nEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPoaZCgR03GIQe8UfLJKb7AhUigR53gaTJAIQFfgXGk=;
 b=wsk3wAHi7z3+qL+oxVF+Z78Tc4IRoZNlv99tuHHy4HQt+Kk90MXOizXo1R4GMuaMdA+yPDR0gVhNIOHVCARp2ggskD/Tx0LtIWafOnWpQ95y0IuW94XuaHTSTAh7hnZrkwgKOZJadrOVIl9eM15wX+zSgicUFOeuYhwMCqHJeKY=
Received: from BL0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:2d::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 29 Sep
 2023 06:49:26 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::eb) by BL0PR03CA0003.outlook.office365.com
 (2603:10b6:208:2d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Fri, 29 Sep 2023 06:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.18 via Frontend Transport; Fri, 29 Sep 2023 06:49:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 01:49:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 01:49:25 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 01:49:21 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <peter.chen@kernel.org>,
        <linus.walleij@linaro.org>, <paul@crapouillou.net>, <arnd@arndb.de>
CC:     <piyush.mehta@amd.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>
Subject: [RFC PATCH 2/3] usb: chipidea: add usb2 phy interface for Zynq platform
Date:   Fri, 29 Sep 2023 12:18:51 +0530
Message-ID: <20230929064852.16642-3-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230929064852.16642-1-piyush.mehta@amd.com>
References: <20230929064852.16642-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9bfa96-8ef7-4c78-4e80-08dbc0b8389e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKd5zHOHIRcUUU5KVOi0abHUrqm3MrVLjt9JhAZMBgCT9QqZTSF7JIqZQrZ0gAfk+BMmG7zSeGH+y96Ik/v6K6QCHiTq6jKRUox8O/+ZjJbfVu3qgHUwRofISLJS94VNaPnW52DVnrQ2ra3b/vXKgoAJWdtDGx33ANVXPf1EPloknoiF/uFZ85lHl4gxwVxJidXeobxY7ak856uCB2OwgOmXJrQay02zxMVDpopUAczgY9pWawfTgjLVS1O4LN4t5LNKNSABzFsIZC8tCUFE/1f+6Bb0hqG3qTrPpjzMpGiOtHYw7V6P2Q06Lp3it+uBSv3v4E+zhlWXJDsix01AjRko4AbkUVHouydUWJoKjBs7HduOLYhid08cJoq4Z5KIPqqNGtDDY+x1EM2b5pq762oXUEoUDjUZd1FV7VJ02iiZ5xq9eWCwQOJog0DX6APmnKKrvXQLg4ab1zEP8bb53QJbVDVG7OZR4ymQFTFYGoV1kRbRmitLfxA9U8M3XPWE+czV32nYqaMZsd6vEcN0v2ISWrLDUlXqccjuebcMm5zwB2xPoDGpQo3EIgaUSf9PM2K9STqmvDZ1QbuPuBy74yvy5ZykAzM04unolXvDCKQihQW3RKJAm1MWGYL+Y0zBl6VbqMMUQ88GRV0qKA+UdyANBbnqHCNv0MufpIrGORlbcVDzoaCFDYxwKBYMQf+GEkjtBOrEQmQh5b5y+kE13rMsCYYuSPqk+fHMeM0uIZw4EIEs5kvc56ZzrBO6vwJvTNBDDE38sUQQS3A7t9Kkig==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(36840700001)(46966006)(40470700004)(6666004)(8936002)(70206006)(44832011)(316002)(54906003)(426003)(478600001)(7416002)(1076003)(4744005)(83380400001)(5660300002)(86362001)(336012)(70586007)(2616005)(4326008)(110136005)(8676002)(41300700001)(40480700001)(81166007)(356005)(36756003)(40460700003)(47076005)(82740400003)(2906002)(26005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 06:49:25.9002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9bfa96-8ef7-4c78-4e80-08dbc0b8389e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB2 phy has been added to the Zynq platform data. This defines the ULPI
phy interface for accessing the ULPI register.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/chipidea/ci_hdrc_usb2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index 1321ee67f3b8..a115383fa1ee 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -65,6 +65,14 @@ static int ci_hdrc_usb2_probe(struct platform_device *pdev)
 	if (match && match->data) {
 		/* struct copy */
 		*ci_pdata = *(struct ci_hdrc_platform_data *)match->data;
+		if (of_device_is_compatible(pdev->dev.of_node,
+					    "xlnx,zynq-usb-2.20a")) {
+			ci_pdata->usb_phy = devm_usb_get_phy_by_phandle(dev,
+									"usb-phy",
+									0);
+			if (IS_ERR(ci_pdata->usb_phy))
+				return PTR_ERR(ci_pdata->usb_phy);
+		}
 	}
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-- 
2.17.1

