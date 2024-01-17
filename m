Return-Path: <linux-kernel+bounces-29081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF69830815
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825061C23ED9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AE5208A5;
	Wed, 17 Jan 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5f1LJ4A+"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F556208A2;
	Wed, 17 Jan 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501800; cv=fail; b=QfscC6zGySdYPwgVz87UPorw4+N4ocJKFVHcA2S6AUzA2aSuLDKu7NbzGO0mGIhGtTJ6vYmkgl4pepP+L/GUBo3+N9wJm2OBmN1fdOfrblv5DV0q4pR+ROlaaJtLnFuGmgX8h2sU+Yhs1kwnl5GBuBE4jA8RVRAmTEkLR5p/ahs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501800; c=relaxed/simple;
	bh=5MGeDMwdac3qOnTXylMmZDfoh8QhiSf5rTd/nPCo/e8=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=auH5qDL2l6IxDHa6xNKDhDKE1q8DSx9Q3QFFMIAarFMoXSgNSwywzUyGW4fHzw/g3AdYFuZzeYmagJ2uMf4Esz+oMCMCn4K/unV+V2pAMmWdBKqrLl8kI93rl6yif7c6GEA0XCNDLdrdA2s7sBuQPiMHAK1GuRn6FgnxEiRt99Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5f1LJ4A+; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjgVr3sA5S99BZOTP/HY8JaifHuPqMhTqpez1b0wwzY6XizoPJ7itoYzIBk0h/vRxnLxH4mdJRzQDNnKqnuwE6dxV3cipBNJIm9lG6iWT2Z6N6phG4EuP6JSgAbe5FHWQPUYZ7uA1c6FBT97h3PdxbSNU1pliYfBAnV+jRSMuR9drxmCgesG3ZOlgzjbiDF776BxZEE6/bTwaI4fo5REB8NPqzuJmr1DawTkqBGK4YQ25ILD48UlJt1CxYKuYJnuLL+SC6/bvYaAHEIUw8bbEx1o1Va9ZfqKFJuN5QolhsT+OKn97RBJHLt0nFiIXhVCHpZIgtbVfTUtwYNdQVMWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROyCHzRr+wDiwZvVrEPMZhAzfPJSRR/6CH+IKYyKJ04=;
 b=jn9OLPLPXzCJk1jbYojwhyIaaGqC0iGs5QXz/8h2dNsYqVxmlPw9XWzj75XIQeqPkTu+qYCPPjf20dqNwzaz3C3XjzpqPDqlG7DisEtspKPlOt8HbSKs7on9ZIqS/Dmh+TNwM1lnz9++65yTSEnIsbUA80pJVlcU+0vUhFtCQdaly37ErEMfCsZ2fZ9N9kbnH8Da7nkYpkP9ERiyAysrxovEYsSs4Jx2BXbPFvV2nVeKbi22wu60gKHr5GZS1dMvo5ps76XdKIR0IaYjWSUcfEANdsGq5CGJLnLG9NvIoBY4bNYtaqFU7pn4lcZETJsrgXgyAYlHOifV9/DriFReHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROyCHzRr+wDiwZvVrEPMZhAzfPJSRR/6CH+IKYyKJ04=;
 b=5f1LJ4A+7MNKCuC+DVrEHm10nnFbvPKy0ti4rNNmjcGRCKAt5MiU+rlFpT6CsCvrJSdkCNQIt8a8ZmcrLT2fKUAisZNRuGS7T32X3gj+l3HyhjP50b5qBhs1+sfKiwIKNyhF9uUQXRRFf8HFMUz0iVDqwXYuMecEdnyaGSamV9Q=
Received: from DM6PR07CA0095.namprd07.prod.outlook.com (2603:10b6:5:337::28)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Wed, 17 Jan
 2024 14:29:56 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::81) by DM6PR07CA0095.outlook.office365.com
 (2603:10b6:5:337::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Wed, 17 Jan 2024 14:29:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 14:29:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 17 Jan
 2024 08:29:55 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
	<brgl@bgdev.pl>
CC: "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Mario Limonciello
	<mario.limonciello@amd.com>, <stable@vger.kernel.org>, George Melikov
	<mail@gmelikov.ru>
Subject: [PATCH] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04
Date: Wed, 17 Jan 2024 08:29:42 -0600
Message-ID: <20240117142942.5924-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 91440ce2-3bfe-4420-1b30-08dc1768c70a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d+wiLKJoVmuVqIlrO3jMRJrs55hSoOs6iR7oye3GnKTD7AL92wMABJKpE+OG3o3JFFH1jpyl+LkKQUYNk3kjQUojbDDRX4PGVGl7KV1OKXcBflX12WMHrgmvS/f4ARis04MY0UPvScTtgStWoFROQNQz5YVQ7UU6KP0eK6/Ig1LYGGjrxN/EIlXZ2hAFyVFx2l+2OgtBOTGHGDxB4I2P8CPgqbxj+df32xaGSoHnLMNKHjiDBtZfH0ZcxYDPCRGYBe0f5sVyv5/BL7aQuf0XbQf4e4edkN+ZsumHtZESzPjGtjjbAFyllfS+QJCp7UZkPp1a7CggsFaSt1b1tOl5/EeMGOjMsQN6Ib5xM8OqA41wmUq6BZ79p52GXarzC+QpM9h+Lx1cHrAgLHg6eC7yoHPzwNMUdyVxAUETibCpigijfFnsqW6VDeOzH6bbaG24syCMxbMjKnevOuQV7F9nLBSz2A4sfy4d9gOtvMXpTe8E9WxKpuWvIqLntsHkN/3gfXcAezrTGwKgepenF7XV2N82/Smhkywi4d4TTG5rFdQaJGvRM+QvV+1AkN8Z5c+MZQnuKUxZaOFS6h35XRZcSZuQ5RHUe6rEEg3Wt5yWw8u+ho3tGWEzvRYXn706MIaI7v3w6kxJH002kP3JCut0C+MfYcwmjOQXOXF5rawLdKOj5T/LBs00omQ9uaiOLTdGzLSPF90Fo4FNqMrY4q/v4JZdD8jq29tmzOxLIbcM5Sk+C/dQb7gIVu30vOvC5oJr
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(1076003)(40480700001)(40460700003)(6666004)(336012)(966005)(7696005)(16526019)(426003)(2616005)(26005)(478600001)(5660300002)(82740400003)(86362001)(81166007)(356005)(36756003)(70586007)(44832011)(83380400001)(4326008)(41300700001)(47076005)(36860700001)(316002)(2906002)(8936002)(54906003)(8676002)(110136005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 14:29:56.2196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91440ce2-3bfe-4420-1b30-08dc1768c70a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008

Spurious wakeups are reported on the GPD G1619-04 which
can be absolved by programming the GPIO to ignore wakeups.

Cc: stable@vger.kernel.org
Reported-and-tested-by: George Melikov <mail@gmelikov.ru>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3073
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpio/gpiolib-acpi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 88066826d8e5..cd3e9657cc36 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1651,6 +1651,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_interrupt = "INT33FC:00@3",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from TP_ATTN# pin
+		 * Found in BIOS 0.35
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3073
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1619-04"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "PNP0C50:00@8",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.34.1


