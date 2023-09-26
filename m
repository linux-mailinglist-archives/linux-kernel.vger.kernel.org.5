Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7627B227F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjI1Qf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjI1Qf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:35:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B2CBF;
        Thu, 28 Sep 2023 09:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEbSUtWBTHUNpMP6PZWmJ1uQ2JeVAg4+9eWi1Rejf+k0HE/IHOHdkjNr4fQtcNOPJxdvh5aaZ8N1/N2e0RmW/QWo+f6C3nP7Dr4l/dsjOzg8eYEUyj4HyyGuewht1cz0XDQJK276OpygCQdrTbikOAYZ1H8yQMO/JMEr6ZpFxS7RmihdlqH357MkMSsFPSXB6d8XqXS4Spdz2JTqDRTJn74AWW4/805r3XUbTWLSF4PeWc9VVIC+qJXo5jCXUm2DT8Ql+UVGDd1dcC3Ymt4AoSJaX7IG5ZYtr+d8OzBmhhOa+95Y/AcbJ0PX8qks0AujQzE2A0+ZvXuWJu5DtQKEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=677s5/v2RCD50dIi6oZiOGkmwZEmYBXuyVLUMjCt/w4=;
 b=OCpFca7ZnEFVkA1rySBVm0dwtd/Z/JN4OIEqcTdcMdGkn+/iyiUzgQRIvBnmjFtTJuAa1orylBiNxpQcD3obEP3/VqKoQOUpzrW7gNaGJYwHEv/O8fV+FrFVx9S7dI4JTjOJlcpXflg/6OEcTvdQBWHCQIPTw1HMFI1bh3Fjbk2icoHUIH8w6Ws6fCGM3KUmdfmsvOE66N+yo/6PVW+WoI4LpG4JD3mWFpbJjKSF+rLVMGJokn/LteuXr467HPVLhgKwHHbiIVKWjAlFR1P5AIh2r+4YSgL2RcqTGELmxvqycDNo5HGZnyFE8E6BFzwpjuBZgQQVmrUmC9JpnZ/sfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=677s5/v2RCD50dIi6oZiOGkmwZEmYBXuyVLUMjCt/w4=;
 b=qtFIHPmeQe+82kan5izhcazAZ7L8XMj3Xf3eR3B1QpYtMt7XGc9B1k0M48wOei3Hd9Zoz86EexFxd7cU05TLq13Y+kGrGcbr3ZeFbnIMpBUbk5+vD8mqWKiEy+nir85bDWENP8Q7xNFKU1IC/oaXI/dNvNaS4gAzr6senivz7gw=
Received: from SA1PR02CA0008.namprd02.prod.outlook.com (2603:10b6:806:2cf::13)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 16:35:22 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::5a) by SA1PR02CA0008.outlook.office365.com
 (2603:10b6:806:2cf::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 16:35:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 11:35:20 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <amd-gfx@lists.freedesktop.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Alex Deucher" <alexander.deucher@amd.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Jun.ma2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/3] drm/amd: Fix detection of _PR3 on the PCIe root port
Date:   Tue, 26 Sep 2023 17:59:53 -0500
Message-ID: <20230926225955.386553-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926225955.386553-1-mario.limonciello@amd.com>
References: <20230926225955.386553-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH0PR12MB5420:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0c4f86-aff2-4c48-0383-08dbc040e8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dQ0rlQaWgxO4Fh9COCjqm9WxK4IsJH8vtkZR1xERDfApbIUgg/y9UbZVSd4YVOJRzRjTmwmmqD3NQL8wHy/zhemRU0OV0nqgBS0AeYQd35/Sp7IKaJTD2k1F5GLUOQecSO1LjenKfNYV+JKLNQSrPpwosz2UlVC7dZjLVv06iCiOrimXQ4suoY9rJ6EgV339WWYZnaOSo3kFxePW3d8QI4zGJCZhlgGPGmpwVbhi668RQZ17IwgVF3Tehd8l9gs7iqi8ld0HOKd+glFwj859M2RpqWfKl1EAyyF4B8oZ1MyI2O9DN3DiP/oxRsuiPpATuzv/bRGd1oHqT+9MvAdvb5wMpDfoiWF+rrNX7r7j4ZpFTKriVfXU0ss7HhBymYDrq1XCBuN8UCVlzQVFxjeuOJBuF9xvvXIQcMC4SjbpPMPh/Z8DuyLK5zUNoAhMa4BygOHRJLsky70iaVx9tXjUy4XSU2NJkYoLMv1wjM/dlAiYIhuD4fqVVGKOQ6SuWp4NXUH3lkWsxk5ZvNQYPu3caeRuIg5YWu+8orhdadFayKpTg5WYnA1SLerTW+FdybGPcySXRk0wufQUy35SYVwshGKVAfRJR0Ay3ZJb0vkWErmW3fWl+oARSlxUfvC5ZJc5r8aKH3La85qF4pQCenaZEKneTRasCPgwa8H3tw8VLo5Wgo3QaWKGOStBWyWfltmvKfg5G3MMK6wVrNPXM4uMS3CXFoM/gVHKrJfdReyTeQGD+RHQi1LDYax78AONbEXTFb9IfP4M7SH5iXIIxHXyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(40470700004)(46966006)(44832011)(5660300002)(2906002)(40480700001)(70206006)(54906003)(70586007)(6636002)(316002)(110136005)(4326008)(41300700001)(8936002)(8676002)(40460700003)(36756003)(86362001)(2616005)(1076003)(16526019)(26005)(356005)(81166007)(6666004)(336012)(7696005)(83380400001)(82740400003)(36860700001)(426003)(478600001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:35:22.0456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0c4f86-aff2-4c48-0383-08dbc040e8e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems with Navi3x dGPU will attempt to use BACO for runtime
PM but fails to resume properly.  This is because on these systems
the root port goes into D3cold which is incompatible with BACO.

This happens because in this case dGPU is connected to a bridge between
root port which causes BOCO detection logic to fail.  Fix the intent of
the logic by looking at root port, not the immediate upstream bridge for
_PR3.

Cc: stable@vger.kernel.org
Suggested-by: Jun Ma <Jun.Ma2@amd.com>
Tested-by: David Perry <David.Perry@amd.com>
Fixes: b10c1c5b3a4e ("drm/amdgpu: add check for ACPI power resources")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e4627d92e1d0..bad2b5577e96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2238,7 +2238,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		adev->flags |= AMD_IS_PX;
 
 	if (!(adev->flags & AMD_IS_APU)) {
-		parent = pci_upstream_bridge(adev->pdev);
+		parent = pcie_find_root_port(adev->pdev);
 		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
 	}
 
-- 
2.34.1

