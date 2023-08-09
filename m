Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F168E7751B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjHIDxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjHIDxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:53:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788F41FEA;
        Tue,  8 Aug 2023 20:53:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSFcokedlCgDhu7FfuhH2rccFPAliRsylS3IpTVdLn/DMj9WS64KnWXvwMZTZYIXkn0WNVz5S+hpjrdwQ9jTiUu1h6D0Xp06ik3SkYQIF8BVtBnsIjfGHokv/w9qJY7MrzJljNEPjSUhyqmeGZTc2VQmemVaA9mSR1RWaMtUQ7IC9FfM0IxP+oA0f9SiAYo37XqX2qjeeCcH6fanL9Ad9Pu1qDE+rPrtXXpc1gFsU3Xg3hhzIO94RY5Szn9027xLrQ3U15B/dDQX0QbnPXaulDZHGvrJTfs7daxSYMmC8zQpP7Wl7JNwQZlc1+M0Pg+k7ALnoD2vCM8b/T6uNWYg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI33U8UPa/z717YTkblxNZ6VCf/mgkOtNULadtG5VYc=;
 b=EqYmBQWMxHCnOFPhIg4p6UmIACunuWk/jwtB2ihBZu+o5aaxW4Jcs+zGZbzd+oWWASJ2R69n4rQO4N9SKcLXcoxDqTO7PXTyxBfwATEI6ZYcNI3GrbTZ9Czhsl2UHR6d3xmcNic+nNmCg5uQLD8jP9ZJ0DyIQQs97LdDfg5x28Jl9Cny5piUzm5zym9P1ZNhDN2Z4frGoDmmlVVxEkCL7SZcUfXGuIRyA93/3ErZWYuvMD1pbfp7cq8VXEAq98oviYc10VALVAsTUAmG1Strt9z6//Z6UZ7QHVDzN/CnFWgPNYn+lUFW7efcgN7SP0h2aMxI71+TJvWY3Khh74KHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI33U8UPa/z717YTkblxNZ6VCf/mgkOtNULadtG5VYc=;
 b=mesiuFeTT4oVAdiP6D0SwD15bcGzovmSOzzyvSZYDIy1Zbg8DzSEHbkEMHKSjE10LTUmmYcQAa4vc7cSPn2lHhZ7H0UDRogiyBUjgMozO7fHjArLzMtZ4zHQEQRMkYzek9M87mfoV+VvxL4Way433N9SxHw/huJUw5DIoqI1YoI=
Received: from SN7PR04CA0059.namprd04.prod.outlook.com (2603:10b6:806:120::34)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 03:53:27 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::7e) by SN7PR04CA0059.outlook.office365.com
 (2603:10b6:806:120::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 03:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Wed, 9 Aug 2023 03:53:26 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 22:53:26 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <bp@alien8.de>, <x86@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        <yazen.ghannam@amd.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v2 3/3] EDAC/amd64: Add support for AMD Family 1Ah Models 00h-1Fh and 40h-4Fh
Date:   Tue, 8 Aug 2023 22:52:44 -0500
Message-ID: <20230809035244.2722455-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809035244.2722455-1-avadhut.naik@amd.com>
References: <20230809035244.2722455-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d719b27-c7c5-4bd2-8f30-08db988c2ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCT3252SF963ZfJfg83gPPHOxXQHenrv0aAFyVJ+JDqvCKoNl3/9HDj2rib2/8vIqsyC9MMjb6TA1snRD4K9vXCF6PDO2NuDTrRMaF/tFfd1MpNdaC/O1QZWwHJm4sbtsZufFQjpHdMcmbV3QQ7Rq0URaVuBMuj3yMQ4xjs1uGQ4b9ZnDqs6Gxx5ccbh2na1YV1wD5rHVSAM1LvzdSRZ4QrRK0a+nh0VaQOIq6lTyOgdwoXPVINso17I/y7D6vlb1GWtQ+cpArs2GR4zUYF4YQTwmtoNm71NoTQVy0yZ+/SpqtQSlee0NueDQV+SnWMiaXG0kLnIaNmDoyU2k3x61U3ILSD9srV924XAHr0mXAgoJhUbc7F8tyjZsRoa1bCytkjwZkA6qxK12mKCqtNRW405hDVbAYRFKtGuke89/mqnffVLde4XoW9NE5gaapVW+bx3916BW/jx3nFeXAIAqTbX/OIv1CHY55+zajNBmuEnfMeuP4y98buN8GP9vkAFVtDPt/YkG9C7IGDZRNnKCn0sA4KUm3AQXkO0ld9nmbXn3FCUJHkPaVXkISw9JpquF+lwD4gNFAntAuP4OkTAu1ixjH+chb8HuNHqQNWR5eNjF6E2gpZut0HhVJJm+FGFGzdh+1ltfDDTSmPDh9dYsgJK1j1vaoaNbNNreXsvexpoOik9hJ8SLLL7uoZAC+pWPo0VPoBIDyIJjLl36Zbj/zNLAzZfjAR7d/PnyKcJdJZ+o5J12hI71XdilyKfALAmaq0l+Jf06OpVja11Jx9aBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(82310400008)(1800799006)(186006)(36840700001)(46966006)(40470700004)(426003)(44832011)(8936002)(5660300002)(8676002)(4326008)(41300700001)(316002)(47076005)(86362001)(40480700001)(36860700001)(2906002)(40460700003)(6666004)(7696005)(2616005)(26005)(1076003)(36756003)(336012)(70586007)(70206006)(356005)(81166007)(478600001)(16526019)(82740400003)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 03:53:26.9766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d719b27-c7c5-4bd2-8f30-08db988c2ff3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avadhut Naik <Avadhut.Naik@amd.com>

Add the necessary support in the module for AMD's new Family 1Ah-based
models 00h-1Fh and 40h-4Fh.

Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
---
 drivers/edac/amd64_edac.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 597dae7692b1..e3b59c488ed1 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4150,6 +4150,20 @@ static int per_family_init(struct amd64_pvt *pvt)
 		}
 		break;
 
+	case 0x1A:
+		switch (pvt->model) {
+		case 0x00 ... 0x1f:
+			pvt->ctl_name           = "F1Ah";
+			pvt->max_mcs            = 12;
+			pvt->flags.zn_regs_v2   = 1;
+			break;
+		case 0x40 ... 0x4f:
+			pvt->ctl_name           = "F1Ah_M40h";
+			pvt->flags.zn_regs_v2   = 1;
+			break;
+		}
+		break;
+
 	default:
 		amd64_err("Unsupported family!\n");
 		return -ENODEV;
@@ -4344,6 +4358,7 @@ static const struct x86_cpu_id amd64_cpuids[] = {
 	X86_MATCH_VENDOR_FAM(AMD,	0x17, NULL),
 	X86_MATCH_VENDOR_FAM(HYGON,	0x18, NULL),
 	X86_MATCH_VENDOR_FAM(AMD,	0x19, NULL),
+	X86_MATCH_VENDOR_FAM(AMD,   0x1A, NULL),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
-- 
2.34.1

