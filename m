Return-Path: <linux-kernel+bounces-20650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 934AA8282F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9491F260FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1635F12;
	Tue,  9 Jan 2024 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Atjw4JAQ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B94341A9;
	Tue,  9 Jan 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAn6Lanx78tpnWx/V4M5LB/GOkY2bHzOaT3XTKR8K3Z4X5S2bYmF6Luq3q3dZa/S5MzxhZVCoTn3zTtgvDZAEHW/ayx2wJ3n254IFPDV84gxJtIRK1MlN9zpGl0HTz8nCLESnMKf8JK7hxiFhaJUgrQ9e6RQ/rAHQhFxxk8zyScs0bGaTGpKVw7DcEQq3gkEtNfXXm6RdDVvyCdx4miqpkTDlsKkeNqq0yDL3FjxFjNr2/2AN+Z0j8wUSopBlBsmXVirGmgx11BRc8fuFD8KSYFDocVfT4Av5WY8VyOqoCOu9x5JCIV4+iPNJTzmorULOSqENdYPAEBhJQHI2e15DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+o5KvE8nwX0WSeMin6w0eEZKvdESyMS9s4vHsWXmjE=;
 b=Dgwx87xaVnJsN2xgy+aSnd5Hd3vpxkdM01OHKv3MZTez65mW83LV/9B/NuGNyhnV/Xav1QhwEpcgrys2xs6PrEmrXfZSGg3byW9lxc1J7CiYcVtW0CPRiI5zmM3eimsuE4TPrxpnV45KZL94KPgpxj7ovxhXn1AoVt/ANwoBE+v/jajT0tCysP8FRp2UwV+2SqzZvu/3//6jTOoUflGIpA+/Ej4ZSVe4yNC0Ob0aVHiyZEEoarggFbCVkF09qmuZI0zkC4uz2/oZ38q/Mo6Jl9B1vLiAX+lMvTL/is0BEEzAo31d8ztXEsTZFia9YgCINwdu2yDWJRlXNscOPVOY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+o5KvE8nwX0WSeMin6w0eEZKvdESyMS9s4vHsWXmjE=;
 b=Atjw4JAQFoUdiZK4IFPTowqEZbQBq2Nd30XW5YMB19h1wOYZULJqJsQ6bdVXVVjAAJlb2LrjulY7yxMqv4IxBK1iM4um61GFP3HageKLdSPpm9X3Av7dNreo/LJP6vCi0l1SdDGqmfvfS5LWjsVa7exHBmzWyRYc7EtZBbuc3qocISKCeZhu7nZyMoDX5MmsCHhbDxskzwBUBX+Uk7t143PASidmW27E0uZrJj+owAhE9J2qQOVPqOmNu8SX26TWWtJsGDX7iM3i0GPVlMsu+USw31NlwM71q7YrP8m0YXG27a6az81fwuwD2gVFJmEUn9MXdUYRcHLKwqk0+fyhIw==
Received: from MN2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:208:1a0::26)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 09:18:22 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::32) by MN2PR07CA0016.outlook.office365.com
 (2603:10b6:208:1a0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 09:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 09:18:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 01:18:05 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 01:18:05 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 01:18:01 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 2/5] gpu: host1x: Add Tegra SE to SID table
Date: Tue, 9 Jan 2024 14:47:05 +0530
Message-ID: <20240109091708.66977-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240109091708.66977-1-akhilrajeev@nvidia.com>
References: <20240109091708.66977-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 3866e1a8-ae19-4acd-b80d-08dc10f3ecc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jgEG3GE6e2lPiPMtxgt2sDA1e9GupHIquxnAeCxCmUdo4EKJ6Ky1vxHHJWmTmyRkNBQTd6RgW/PcKnxgLh6TG9cBRUdhToI1ffFGMdyzXEMlsX3/+8EgHGNrexoLD7Zi5vUYTlyxBd226+NWnL/Hr8Zaqu12KsnZxvvjgqJcBZOWo9BKOu3cFRkbB6npJ97qTA8B1Jbpf7skjApyucHH4wStjCE6weSsSHtFJ5xb+mzkDRY+GWPIRLgR6xiw6wUDKoVusDHjxJnPt9+t9IqxpheCPM37dBYMc3g9fXlEK5yH0aYCYyK7O9gTuj8QOJwQn0k0h81XtqbAnLoih50CGgdkIP5hWE5Z/mSy9SNq9AoWgxE6pvdNru2mOki59a/TkeJRteOKQ4v8zDBmhf4791xX+Fgkek7FDiqKl0Xv1TK2phdtQ05mg4Oe9T1Pb7xovBnZgYutZc+P1nsVyj4ar4gf1ljOlBius7fjhgmOjifN+6Y/+SloFfmHqOTT9/jqXAXsTjuqoT+8SZDMvjIi5qUnDi1eHtgS5BbIKjx3+9vMplraWuMYiMkGCAinSpFJtDaAsse1dVqy5DF6UgYr3zAAKC8sKG/PQyQxCD+llE0ZVgygolIWly5qahjjzNhi3AMAPPfKiSmsiC4AKA0KtpxLGeEEsHG1+6/CNXlBqeVwU+89lByUkS/ksnB3SPgdsCpQQj5pCYt3Le4HHp97K5aNhnMLbr9m0B3S/E2WCGS8DQr2/sJRJ8xTA/kXKjPMc9BIOdj7Vv7ZftWUMI+OHKuIjayJLF/qCwNBa35oUYUuxU0Y3/ibfnwwfVqaQAZG
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(921011)(83380400001)(41300700001)(70206006)(316002)(70586007)(356005)(7636003)(36756003)(82740400003)(86362001)(36860700001)(47076005)(426003)(336012)(107886003)(2616005)(26005)(1076003)(5660300002)(2906002)(110136005)(7696005)(478600001)(8936002)(8676002)(7416002)(4744005)(4326008)(32563001)(357404004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 09:18:21.3280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3866e1a8-ae19-4acd-b80d-08dc10f3ecc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781

Add Tegra Security Engine details to the SID table in host1x driver.
These will be referred when registering the SE as host1x device.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/gpu/host1x/dev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 42fd504abbcd..b564c7042235 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -214,6 +214,30 @@ static const struct host1x_info host1x07_info = {
  * and firmware stream ID in the MMIO path table.
  */
 static const struct host1x_sid_entry tegra234_sid_table[] = {
+	{
+		/* SE2 MMIO */
+		.base = 0x1658,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE4 MMIO */
+		.base = 0x1660,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE2 channel */
+		.base = 0x1738,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE4 channel */
+		.base = 0x1740,
+		.offset = 0x90,
+		.limit = 0x90
+	},
 	{
 		/* VIC channel */
 		.base = 0x17b8,
-- 
2.17.1


