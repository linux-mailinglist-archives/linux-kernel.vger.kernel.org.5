Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57F280208E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 04:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjLCDZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 22:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjLCDZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 22:25:00 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBD4114;
        Sat,  2 Dec 2023 19:25:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0261urfrYPKhMUoH3EP/lR5Eo2e1obVhCZ9vr8XGlsGpgB2tGY8bORNJ1YuC/jSDE3SZbpb4n4m+WL3raunxt589c4JgS7m9ix1aOv4atjHbWwbj00FCYGO1L+jwOTPr/96Rwepr/Mu+92MSouN3eMmxOumHBsTP6x4UReMrpmuISd1wctTF+RQesl4wn0qZoN4fco9hPvc4KqCGhJOXyfYYKq/WsUIebluB8H3SFePvjKWvDvvxu7Zr1fraXhvzFmnGD9LKituQAgMffbEIWmKtR6ERDtFXv8falojEwzET8iLDWw8TrGqGTPmZxCKpE0VOUFW01RJ9PILCRAyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+0tFVgE4g8WGLUuwmexyRvYTYNkNme3z3im5Uc+8MU=;
 b=Ow1wWsWB2asQW13/Yg6Eh5ecSuzyZSlfa06ChJWG0MU+5v9UHDGQ4kzsQI7rMZqTdY0QCzYqK8Xyqnyj98SQnkxntbEXvnlZB+JcD7RnBC+DeBeIh+cCQduv8LIfjpuRXcA1KhOojic5VhL/tIdo9SsrbASRF50ma7sf6icY2oVxMzwsqpq+Iizc9lITG93n7081nh4aOA3xf4BH9JamfNxYxuYPSIQiv1NK9Gs8NTq6p5Rcuv8wx02aqiv7qf/QjRXFdfnIWWUqbd8dqHrfZJ48GGHUZo8zVFG4OvRl29CPxV5qUJBbEfj4+Ixq+0A1vzm0tG9++cdzzOUTlF+AQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+0tFVgE4g8WGLUuwmexyRvYTYNkNme3z3im5Uc+8MU=;
 b=5ZOvbeGnezMQUNNwGrH9MUoM9FdYZV/ZVyWhBb8mWJKZjonUr6/aWFqbxZUhau2DaVP33NIwLPUCRZfi/5C6ENmyQZNl5g9lnv54WwiQb8AgqBxSMN5VdxUkqxAeuWLfhYXzTsIp2oB+aFQVn1XI5N5+Bd0nUJivgSG7GQhThLc=
Received: from BL1PR13CA0259.namprd13.prod.outlook.com (2603:10b6:208:2ba::24)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.30; Sun, 3 Dec
 2023 03:25:01 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::54) by BL1PR13CA0259.outlook.office365.com
 (2603:10b6:208:2ba::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.21 via Frontend
 Transport; Sun, 3 Dec 2023 03:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Sun, 3 Dec 2023 03:25:00 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 2 Dec
 2023 21:24:59 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>, Marcus Aram <marcus+oss@oxar.nl>,
        Mark Herbert <mark.herbert42@gmail.com>
Subject: [PATCH 1/2] HID: i2c-hid: Add IDEA5002 to i2c_hid_acpi_blacklist[]
Date:   Sat, 2 Dec 2023 21:24:30 -0600
Message-ID: <20231203032431.30277-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203032431.30277-1-mario.limonciello@amd.com>
References: <20231203032431.30277-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a48e995-9ad4-426d-4b69-08dbf3af6e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8qQOhgY+Mhz412zdr/Yq73u5C3ZD42yCV1rLYY8D6dVAx/uq20HjKQ2JbyqVERFSGq7Nuu8zvO8iaI4iHj/4NnaZ+w8WXprvqLa60dZp8QJT3dJHEDWK46nYEcbwpUjrjfNTHv7xJwzVSdqGyyFRuW0vz89mQL3oq4sUjTbDdgO/IGFxk8Ni5QXLc911KYIDDmgcxqWMnB8lC/Jg6cQEyUfOVY+sSBwweIEzjlEC6e+sWStqwPihcJChy9cxppV9u1SayX16Ncc2I8Y1nkR/ttJQBi3MNGXifdnnRalHdTtb2f6y/DSR+DYqNby57VTlb+v8Pb8odFvJqxqwBufmCH23sJ6gW6HQqxFYMR8lAcW4kfKGq7vKazHsMP+AijdVJqYqPJGBCZCysZUVtfHyB1yartybfjoY00qvTwu4VGnNL8XbUSihhHpvLPUfLr/X4EBBrP96r9ZGYwMTXkqColtZq8UkceNUEeyHdhUnnGr6CAkLfELFRvvPKYaB7A+2yMLCx8yKZyLeuKeImVW1/OSDRqeZ0e26S2wArbZUQaeLd11+vDg42vg/UsbBuaOz7MMoO2cbRC/OlTEkNe74kg3K6Heh72spa7UM4UJgYrVaKN705wCKyYvOLSpNWr4AX5M11rSv9pZJzPFzJ+5poJqn3X7VqSJ6RjrX8jf8v80gubFGn5e8s+NSWCaQlbOoyCfQsBHMPhHmMGxySn2gKGBUMTN+Hs0n4bookDta2Q6NVaoHVHKVNiJMxIyk+pF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(47076005)(336012)(83380400001)(426003)(16526019)(82740400003)(81166007)(356005)(41300700001)(70586007)(26005)(70206006)(44832011)(36860700001)(5660300002)(8936002)(8676002)(4326008)(316002)(54906003)(110136005)(1076003)(2616005)(6666004)(7696005)(478600001)(2906002)(966005)(86362001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 03:25:00.3373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a48e995-9ad4-426d-4b69-08dbf3af6e9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users have reported problems with recent Lenovo laptops that contain
an IDEA5002 I2C HID device. Reports include fans turning on and
running even at idle and spurious wakeups from suspend.

Presumably in the Windows ecosystem there is an application that
uses the HID device. Maybe that puts it into a lower power state so
it doesn't cause spurious events.

This device doesn't serve any functional purpose in Linux as nothing
interacts with it so blacklist it from being probed. This will
prevent the GPIO driver from setting up the GPIO and the spurious
interrupts and wake events will not occur.

Cc: stable@vger.kernel.org # 6.1
Reported-and-tested-by: Marcus Aram <marcus+oss@oxar.nl>
Reported-and-tested-by: Mark Herbert <mark.herbert42@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2812
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hid/i2c-hid/i2c-hid-acpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index ac918a9ea8d3..1b49243adb16 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -40,6 +40,11 @@ static const struct acpi_device_id i2c_hid_acpi_blacklist[] = {
 	 * ICN8505 controller, has a _CID of PNP0C50 but is not HID compatible.
 	 */
 	{ "CHPN0001" },
+	/*
+	 * The IDEA5002 ACPI device causes high interrupt usage and spurious
+	 * wakeups from suspend.
+	 */
+	{ "IDEA5002" },
 	{ }
 };
 
-- 
2.34.1

