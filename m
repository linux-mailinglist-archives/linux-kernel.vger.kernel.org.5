Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD407E2984
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjKFQOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKFQOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:14:36 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0774191;
        Mon,  6 Nov 2023 08:14:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIUDPjWMcxpydh/gGHmxw3ldn0k+e2AwFk/Xvvm1SfJfz0mngTFZv5ftvvLwheRjEscGb3yr4I8Mnd+V1IpM/uxJmBJeqM1EpzmF7CZZST72TflKseneHVyDtV1PBOCU+M4JT9B6vAUqkGnkfIWY1yLb5mObwywvfDpysVsDEz3gf3beD0EL4viPn8ggd/kt9VAL9jYPAnUuhhU01Suths4c1omCysbk+/h1WgqOiptez3LcZ0UM3/TUcJOAyQgPYDohkhNmrKwlpksyQTB26LLLq+luftXq9bT/7e1ZQ7BcjB2ku0aJTLTzvqe9lSV/9wkNLhnZ6axdl63P7t07PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2mL+KkGXonHJHAgYbiK6/0T1VVxwti/vlt9O5i6ZWw=;
 b=dyKr1P8yL+a9CzEzxIoW7fpW5fCuJ/LAd5+VaTYXDyeW2dcghr6UvjXO2KCeUpzTAUMXoORn+GdgKHcCQxiOKRJufS5X8sGCR2i1SY1pJ0u3+YY20cbQUEwLY5gfSmP+gLp9s4jHeqe1QZNQrVe5++/jny3xkaWxltry1o3lgxqbNVtz2l9Niqx9ENhLVayap2R3COpIJDsqHf8CS13p60+/oL2JPVYooLG397YzA6ConokBi/AGaucyllLOlfTgD0Av7pCPzGw7XxTErc71/1Dmx1M8oT6NaQIGlWn8alO6JG8n7uSeYCUk6SZyaqwEjtmcoQ/AszjhgyfubYmwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=towertech.it smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2mL+KkGXonHJHAgYbiK6/0T1VVxwti/vlt9O5i6ZWw=;
 b=RxCi2Y4nlYmQhvXs8icrlFFucfMBnvLG5wIg+3Oxt7atcgwO15+T0zkb9TmlITjhcMX1wi8w9sfkxviBMMxCB/SycnjLHmQMTAw53MulPo4+Qc/++c9lAhkh+VETCK6Kt0vHpw0DsqQC4VWRygjC09guM0Pxg4E02rPH+g9Amf4=
Received: from MN2PR14CA0002.namprd14.prod.outlook.com (2603:10b6:208:23e::7)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 16:14:30 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::6c) by MN2PR14CA0002.outlook.office365.com
 (2603:10b6:208:23e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27 via Frontend
 Transport; Mon, 6 Nov 2023 16:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 16:14:29 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 6 Nov
 2023 10:14:28 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <alvin.zhuge@gmail.com>, <renzhamin@gmail.com>, <kelvie@kelvie.ca>,
        <rrangel@google.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH] rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
Date:   Mon, 6 Nov 2023 10:23:10 -0600
Message-ID: <20231106162310.85711-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc86b6d-c54b-4fd9-4c31-08dbdee37495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+dVZ+BcEwg7JLP4u+nVCEd7EapiAXTtrAW6yjCCA5qwLVeEpCnhHaE2N5WAUwVe4pG0goUHcc+5mh+WpbNYtqEMvgoFw5ZoJ2B1dCAdOlpwcZto+qjWyQIDfdxexDoj9Lvyq/qyUQj6FioACtk/hlHYGYphLaUS+UpQvD1rDs9SUPG4zSpNVQUzdRnbRa+E9UuL5VowsiBlYr9SXuQr1l++NFiwKEpK8QHVDsCgpgP6MPMQoDxVkF6nWcF/ZlpJ3nYpdiH0sVlnf5dV05vB1dscgrGtOliagKQgEeOh+nP+OFX84DO3DWZNp4f4M52Aa9VaWZvWSJqi1bvLOjdjpcfbXw7/YrXCX4NcDA8voZU6gBJdTPN/MOUo8Msca6Z4x3RYE9J+8oUwyEQb215IPZA2ohFMyAaCMPXdxmZ4kvZkOcElS63lrU1B30YEm2MYq9jPJu//PA9k8LFPMBWtpZTOs9Yjmcghkz34ZriSMrRlgwpoSZIcr6zrPdJEmLGW21cS4Iz4Mx6cJPHnYxeWJSQSAWhv++tZLKOh3zS1jerdZmKR7SJKXk3lHr8QKtOG7t/xuSwYP4S+BnBN4zxgURRKoMmj5Zvdj9KW1LKmU32gvaldDVtMcRvIR6Uoz8++6LkXvE2zjyE4XIKe7lZY/ubO5mvbzJudLmbmlmNaUjvYpXd9deyYR4BxjHGiF/cxRFBpPsTTl6hWIuo/8T//WnOUyFdTs4WS0MvoCFhffCkhMsRJdf/3DfS+AAAivbOfOsMwu0/BDaeo+dptb7zvSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(5660300002)(36860700001)(40460700003)(41300700001)(2906002)(86362001)(36756003)(356005)(81166007)(82740400003)(16526019)(478600001)(426003)(336012)(83380400001)(70206006)(110136005)(70586007)(26005)(2616005)(1076003)(316002)(54906003)(966005)(44832011)(6666004)(47076005)(7696005)(40480700001)(4326008)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 16:14:29.7316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc86b6d-c54b-4fd9-4c31-08dbdee37495
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel systems > 2015 have been configured to use ACPI alarm instead
of HPET to avoid s2idle issues.

Having HPET programmed for wakeup causes problems on AMD systems with
s2idle as well.

One particular case is that the systemd "SuspendThenHibernate" feature
doesn't work properly on the Framework 13" AMD model. Switching to
using ACPI alarm fixes the issue.

Adjust the quirk to apply to AMD/Hygon systems from 2021 onwards.
This matches what has been tested and is specifically to avoid potential
risk to older systems.

Cc: stable@vger.kernel.org # 6.1+
Reported-by: alvin.zhuge@gmail.com
Reported-by: renzhamin@gmail.com
Closes: https://github.com/systemd/systemd/issues/24279
Reported-by: Kelvie Wong <kelvie@kelvie.ca>
Closes: https://community.frame.work/t/systemd-suspend-then-hibernate-wakes-up-after-5-minutes/39392
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/rtc/rtc-cmos.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 228fb2d11c70..696cfa7025de 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -818,18 +818,24 @@ static void rtc_wake_off(struct device *dev)
 }
 
 #ifdef CONFIG_X86
-/* Enable use_acpi_alarm mode for Intel platforms no earlier than 2015 */
 static void use_acpi_alarm_quirks(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_INTEL:
+		if (dmi_get_bios_year() < 2015)
+			return;
+		break;
+	case X86_VENDOR_AMD:
+	case X86_VENDOR_HYGON:
+		if (dmi_get_bios_year() < 2021)
+			return;
+		break;
+	default:
 		return;
-
+	}
 	if (!is_hpet_enabled())
 		return;
 
-	if (dmi_get_bios_year() < 2015)
-		return;
-
 	use_acpi_alarm = true;
 }
 #else
-- 
2.34.1

