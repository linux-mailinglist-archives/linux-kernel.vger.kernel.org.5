Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E7807A43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442926AbjLFVVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379534AbjLFVVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:21:51 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB4BD5B;
        Wed,  6 Dec 2023 13:21:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VblodD+fbGsZ4x/VacJQMiyYvk0RzPgdEpzy6fdNU4eUxM67sONYxfOVfey5Xkv2vbMDLFbKNAlVcVeWtlSHkBnJNc0ULsxX2tQbgxQoh4p4BWgO4IXJ1EN4eb4r/E64Co1+WnHMj/FeNvZykezFXNfoN+QgIR64DiKA7a7utLjxJHqAjY9+PhegjRWgk8Y7V8+QjF0pWpRha4Cuyv7+PZEq+dY6mKxXncDolILZZ+gyFERABKLP0ZIR4RAZZd+26RSLLAsaXoXteC3qA1lHuybO8xbi65KPpbHpZXcDiCCmH+KpbW7q1Cpxx7kwtyNKRhSnCkQk5JssHiChlWCT8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=au2cpbVPtCOztqv182LcRqwqRxVcvEX43ihrmpNCi7Y=;
 b=J1eLZryCckEXN4rgzTB3+r4CGPmndKCNN/H7eWT7JZJ/7sIge4p0OB8LsVGFt+WY2Nflk0UZP47REG09Kn0Ckk+zzFIeY2Jdwx1Y395TBPtGVI1s1m2PmQc8IHHX0UGuD8kuXv1G02dQQK0Ax+drXji8NZg8HDJ8avp4Lkm/FmZpbNNLMaCpmW+QWNcq++22vie9qH3k7h7sq40h9jfPOA3vxkxl9U6tLjPqmeKQM+5cRmViHzZOf+RfPxOPx0QBmZ004+n7Wmv+JN2CFqS4pcNgrh9H1/476hSV4Vr8apJkglxgqkVXCLExqNoeL84Xm8vKp5KC/WW0+UXDq5nM6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au2cpbVPtCOztqv182LcRqwqRxVcvEX43ihrmpNCi7Y=;
 b=BqlF9JxRtpEEZhXJaYsTlZ7FE3DuQ3X2AL/LSTrjWqYJmQr/yAKRD0KRJd1Ubc19gfpJYo1l7NNz1ftBIYte6r0K0tVEBrKUiHCC3iJnknCsWOyTz1ZhLERqmHmijCBuIGA8k7SlhLDDIxo5ogiWjjcT0N1Y9QnScONjD8z7udY=
Received: from DS7PR03CA0241.namprd03.prod.outlook.com (2603:10b6:5:3b3::6) by
 MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 21:21:55 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::2a) by DS7PR03CA0241.outlook.office365.com
 (2603:10b6:5:3b3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Wed, 6 Dec 2023 21:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.26 via Frontend Transport; Wed, 6 Dec 2023 21:21:55 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 15:21:54 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rrameshbabu@nvidia.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/2] Input: i8042: Avoid probing if no keyboard and mouse are set in quirks
Date:   Wed, 6 Dec 2023 15:21:39 -0600
Message-ID: <20231206212140.7458-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 087f0af4-0778-42e2-0c3d-08dbf6a15f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ts6PYfKW9vEXHr33KjD6oteaBZpHHuVhZMxlZrI0VulOxMnoar2tIcc3IwKg2j+hJLGaIE5HpTUylfYG5Pq9BR91o06kQ2SopqXSHcOWkQkuYygWnGL25rmJwY+o/I17daoUAXK14ILuyJK7yw81rm2YeIWTqpC5uPG2vx45tv62ekWKCZ3MHg8nOJjCNZQG2zyJgV+DTmNH81Vm3sHG7zG7DwPmC1lRWfuaRNqRQuettmuA+fuP+WC4GYLBEVVMd16PgHKkqmp9VH4ehwthCGSB/qf0oyv4phIogOvBFwowgxrcNykDWiGW1O/06GJnqLDa0AaYeze+4BL6LDoghWjJMNaRHqB7cLgG6UeUUWcWdZ8Jb+ItWGqnCDCnJkGV7bfc+aajSkWgq1ToncrMHxVUTd3lpONu5ILU4KCuPu9EoyPQr3WP/A6gzAo4kqLJdzCpofdjdhup3SYJWq8uDY8oIOvV8Kgzuc8/ek4nNcysttdBJ3v5A7dGFlgv2eyDcinvL8PJfitMXqFRMSqXprOLa/TuaPbkIB68IPkNBbUbPxhmgUXA3mcR7XgiPxlbz8VvajEDLlTLOaRY7DOeZ66CwhkPphXxNb/jGsWUG2VXTlcc1Mcop1egHbblZN8AkOu1Lqd3qXidsyN4lZvn2JUm5iOEp4AS1dfGfc2dg62nbDDXw/aPaaQYG4hPcu+9cxvXgCwyyPbHk5glZqecPYtjhwp60W8pLrHj1M7Qd+Q2uphSsCzYbxp/tRthQsuT9phT73cJVIU/TM+hxlLS+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(36860700001)(6666004)(7696005)(40480700001)(478600001)(54906003)(356005)(70586007)(70206006)(81166007)(316002)(26005)(16526019)(2616005)(47076005)(1076003)(4326008)(8676002)(8936002)(6916009)(426003)(336012)(40460700003)(82740400003)(44832011)(5660300002)(4744005)(2906002)(41300700001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 21:21:55.1721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087f0af4-0778-42e2-0c3d-08dbf6a15f53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some laptops have an i8042 controller in the SOC, nothing mentioned in
ACPI PNP and nothing connected to the controller. Add the ability to
skip probing in this case.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/input/serio/i8042-acpipnpio.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 9c39553d30fa..0fd88bbfaee1 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1707,6 +1707,9 @@ static int __init i8042_platform_init(void)
 		"");
 #endif
 
+	if (i8042_nokbd && i8042_noaux)
+		return -ENODEV;
+
 	retval = i8042_pnp_init();
 	if (retval)
 		return retval;
-- 
2.34.1

