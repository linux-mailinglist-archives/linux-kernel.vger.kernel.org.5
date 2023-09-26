Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285B27B2284
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjI1Qff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjI1Qf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:35:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539C8193;
        Thu, 28 Sep 2023 09:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njyOKal7PmHJuKyvRiNLdxZl1ymhP+zoAC6VJssFvtRdNbw3qwoFwNmJpj930k8XpC35gA7schffkVtEAq0dA4/mgxirzvY/1goljtEuwoADfjrhG1CLmQcCFycYw9kx61PfaxSTZVrTv4BN91aUXKiatM/guruNe5GWrhUz/adx4gpARL23246U0wVqiGqjewlwMPKf/eT7jqK/X+r/wDS8V7oBJzzEjuKpbikWWe922LZxSFiplLysH1XC3CUICyQdVl+6+r8V+XMRJiBlbSRLe0EW4Yr/WCjivcifNP0kvUoE9gc4Aa4FotlrVC/kj/rktl8PDU/mbqh/0Bu/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Def7aua7Saf96hnHEYbIARDNTIxX/ofd10KyHqIMrQ=;
 b=Ys3SCl5cB407jRudITy2lRnkbraI+clJK4leO2RFd5x71qpw1D36A51sKoJ8Fqf+ZzHbf7iAe0U1474Dj2MpUS6ArQ2hcDSZv9RWqrdXAf8Yq4ZetTL8fdJN3HzVEvLtlxr/QFJSP5BADuUAxLUZkmPhca3qAHVmH+zVc+nOgtyLI81LdoXim9V3yOvIU6mnAeHvR1A4Bzg4K+SRF9jbCJOU4yQXylfrwkkDNIwhRuDe1xVJ10u7SaHhHw9BF4Xdugb9QIpvKQLbTXqV7ofR27KRQOoJ2RWWLjHjIkKChtB32/m0aW8J3nPbrPO3a9f/n2DJT7zdzAVgugOsdAupFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Def7aua7Saf96hnHEYbIARDNTIxX/ofd10KyHqIMrQ=;
 b=fOoj6RoXw7VdiBI+j3MeT3aVDXuL92amtAKZ7OxpVHZpTfL9Oix02+2vjUpUJ4NeQqC3KvQ/6eiW7LR+emddXdCLFcv+L8D6/WZFTBT62CisCO1D8bGZR3Gs05K8d3FrxGX1WF/VMQDZE9BxYGWOl2oceXS6/4OXhcLjWIcz/AU=
Received: from SA1PR02CA0011.namprd02.prod.outlook.com (2603:10b6:806:2cf::28)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 16:35:23 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::3f) by SA1PR02CA0011.outlook.office365.com
 (2603:10b6:806:2cf::28) with Microsoft SMTP Server (version=TLS1_2,
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
 2023 11:35:21 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <amd-gfx@lists.freedesktop.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Alex Deucher" <alexander.deucher@amd.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Jun.ma2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/3] power: supply: Don't count 'unknown' scope power supplies
Date:   Tue, 26 Sep 2023 17:59:54 -0500
Message-ID: <20230926225955.386553-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df7feb7-0847-4b46-876d-08dbc040e96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lqn2EKFmjAVeUN2fIA5wwgdjEjzyBqJXxPfTH0O6CStFMMy0h+g54WiojlOD90Xj6Ms/WqhUelO5P3+Y/MKumXnG5TQIrwIJQeqT7OjMz4QYA1pzsNWKj+H+6Af5nd+xgXTlT/S85Ef6Omf3Dp6Gginit2WUAdUj9kYRoTCDdpobR96RfuzCwAh1cQ1Kfbuhe5ABnjwVZea1SgS281IlkVZczFGLyYs1k5exA71Lx1bUhoWMh0B6+KBdm7xjWld2y/+kjcXu9Fwzq93DmD8xxUV5R4l1sF1dQU/TBAlGuZOypil6k0U7qm1L7TjcUMEwTcqmxtwFU/Z+TZm4VCkIIyFaKdRIgD8Kzg5dJG6BRf+tes6aoem29daS//TJvh3ROe6OH20bvRnQMbwFUuLOipT3GCIySDCQkkwhbWnwUyMtrM29cyTVnDMtn5ZIsjWmpRxDu0mK++R/2bG0WAqtvaA8lijwB2Gc3Eh6DgggDhDfqz4yvTZeHDA/0QgLo9CsFTB5mjdHZ0VzdvmNJDUN/9Tbloj++IPhGcckGr4RMzv95VEScL5HyPMn3bcCVCPcPLuqbN2dL7DpMffDsMMq3Ini5pIJpd/a4bQU5be6Ts/+uWi/xhHKCT/Qz+O92Lrut9ayZMKbArKtbgZ2paPCWRz+qkfRFVkkpSCCOfC/mpC0UKalLOytC+Vlw9Ya0CJftzMKJWLXY9xoMcTRvpSZRI1JLOeDMSuAuVphElDuoLA2GxOusa+PkOavvBJYZGlIu5dGxdHr3nV4NTClichKaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(2906002)(44832011)(5660300002)(4326008)(8936002)(41300700001)(8676002)(26005)(70206006)(6636002)(54906003)(110136005)(316002)(16526019)(1076003)(70586007)(40460700003)(478600001)(7696005)(82740400003)(83380400001)(36756003)(6666004)(336012)(426003)(2616005)(36860700001)(81166007)(47076005)(40480700001)(356005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:35:22.9363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df7feb7-0847-4b46-876d-08dbc040e96e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems AMD Navi3x dGPU triggers RAS errors on startup; but
only if the amdgpu kernel module is not part of the initramfs.
This is because the hardware is not properly programmed for the
AC/DC state of the system when it is loaded later in boot.

The AC/DC state of the system is incorrect specifically when UCSI power
supplies have been initialized.  These power supplies are marked as
POWER_SUPPLY_SCOPE_UNKNOWN scope. As they're 'offline' the power
supply count is increased but the resultant return value is
power_supply_is_system_supplied() 0.

To fix this look explicitly for `POWER_SUPPLY_SCOPE_SYSTEM` power
supplies before incrementing the count. If no system power supply
is found then the system is assumed to be on AC.

Cc: stable@vger.kernel.org
Tested-by: David Perry <David.Perry@amd.com>
Fixes: 95339f40a8b6 ("power: supply: Fix logic checking if system is running from battery")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index d325e6dbc770..3de6e6d00815 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -349,7 +349,7 @@ static int __power_supply_is_system_supplied(struct device *dev, void *data)
 	unsigned int *count = data;
 
 	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
-		if (ret.intval == POWER_SUPPLY_SCOPE_DEVICE)
+		if (ret.intval != POWER_SUPPLY_SCOPE_SYSTEM)
 			return 0;
 
 	(*count)++;
-- 
2.34.1

