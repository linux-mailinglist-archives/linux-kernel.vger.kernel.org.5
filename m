Return-Path: <linux-kernel+bounces-23926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9839882B3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4481F220C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D82524AB;
	Thu, 11 Jan 2024 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i156WM3q"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394DE51C26;
	Thu, 11 Jan 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBIpTewYhDQibQ0uxcvzNv+p6VctKw5VhXVJimw6JUu5Qh35vVigXRnhHrQZKct8hJ8NWAg3jKooRm4s7yKDGQIohDyw2trE82M7dwrQnwB8Dt3+W6/SkERNvDGf9sEGozbGET8Z20nYLd+JbtptkVnDPagFZvFnfE8Q5G58VfWIN/AQD4tF35jKnLG1ed1ULwROLwPuXmUW6Cd+4O9XK7Tlq3lPfRW4gLlhnpw4U3lyy6lFuikx6VHZIlKhHog+vZFW3gXRE8421N/fQIjcltHd2HS+h22ugG9o1mLsBYESVnrncPrGO6ADW678wE7ri27j6IAHNvMAqogEt10Elw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MvrR2NUP4T+ddTUU5lyMAZCIqpspYV3QwLDJit//Mk=;
 b=NSsGZYV4CbGbNi0sAL1ig9QbsaCsZXzlC0g6wPS1ogIP+sEGqJm1CF9mI4tmDHNZYP93F2q98NsS+4HtvrvRFJZqHkj2zESoDNB6X8eN3WgaJYiRrrTKJtj3jKGQRck4yku7KHRt36pmtjrPmNeAQSx969MMKcdTEPxf1bZYHDOZeDWBDvxoLG36HBaQrr44T/XnfuSHFc56+/HZ0mIXsaR6jCA/7OYBsU9QFvRua/kY/S9w8IksfJDyo/p5ZGqAd0+7On49eWIyTRst9SmV2HGbX3/kD4K0FGTNbKqauTvPAj4SZhBvJLqsOqADb33DfgpagTf1PqFoWwwYo+Ekrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MvrR2NUP4T+ddTUU5lyMAZCIqpspYV3QwLDJit//Mk=;
 b=i156WM3qXxQZLT06NWodWf5E9HcOjWpUYXJTqvxJOey86DTXDwNbxP70mGcImOhPgBiDYpI5tg56zD4OoRLCmnpv3Tgyq0CuCbWa+N3c6hn5vSsAvsVcdyJN2CmBBVyK/U5WWfW8Th5BZM5u0/LAufuumT9WaOswIanT8zplooY=
Received: from SA0PR11CA0070.namprd11.prod.outlook.com (2603:10b6:806:d2::15)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.25; Thu, 11 Jan
 2024 17:22:28 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::a7) by SA0PR11CA0070.outlook.office365.com
 (2603:10b6:806:d2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17 via Frontend
 Transport; Thu, 11 Jan 2024 17:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 17:22:27 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 11:22:27 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 11 Jan
 2024 09:22:27 -0800
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 11 Jan 2024 11:22:26 -0600
From: Ben Levinsky <ben.levinsky@amd.com>
To: <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <shubhrajyoti.datta@amd.com>,
	<jaswinder.singh@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ben.levinsky@amd.com>
Subject: [PATCH v2 0/3] mailbox: zynqmp: Enable Bufferless IPIs for Versal based SOCs
Date: Thu, 11 Jan 2024 09:22:23 -0800
Message-ID: <20240111172226.1816105-1-ben.levinsky@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c1426e-7885-4b30-dea8-08dc12c9e28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n9UopmYb3s2K6XJyTCQrJdH4tOev1z+58qBUoIDfNPnb6DgdDEgy2Az3OL2md8uZNhwp32y0zfQOHnO6gdHZv2cd7cuGDKJQo6sLiNP5L7InXngf4qLbL+zzrkXoKymduqWrs8huyN5fyRWRtHHtxpe3QLPKpKvWd5Iqx2Dwwjumcj4sf8JR5Cp9HN8TqdATp8x9DkCeExgqeL14zoVav7y5sI1oTJsHNo2MofFhGgGPOraXS2gSZM+FMgD3f6XAelhB+cnl9GO7/tVBT1UM3SktQUDACwLOmcrC7KvNJlM3SHIlofIr5rv4PP92DdXn8UCLyQfIOTR14+stOQ9491zT9OwhkuvbzS6QtbxiFRO65rhIqTSu72ZcCVH7q47W+OUGcLGwzV/k8tudUMvVRvtQVeGGKKopgARK6MxrwlcWruq80oJ1jVZXeuKxiQnyYXnWYLxS8z0gSxBZVx76KLE77RL/MOm8FlTqa6IGzLCi98zmamc/zslQNrTC/UiKndeJl6DxcHDPVQgJS1lNBAU8Zd3o3dUBuCiMaqgfa0RqzzlOCxTP7xjczld7CfyhzZuaR1XOrbEqqRI9T/2SzuNPTsWZfdpRYQSKQXIvo12QcA+JXlYPV1tklwdETbQGHUEeihhgy6OWogxdpt36agDOgB3akgNNcVKlC5vPW7OdMetqwGJXlDxzuhR7Oa6p6FJYpqqw/TAI6/F0b9zfImCUPItEDbmQZERRL+Vy7ZL3jC9Y2aA58wjW1oAvRJHSyAsklyVi2W94M9DT/by3ag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(2906002)(36860700001)(6666004)(5660300002)(966005)(15650500001)(478600001)(4744005)(81166007)(4326008)(44832011)(356005)(70586007)(316002)(54906003)(70206006)(36756003)(47076005)(110136005)(8936002)(86362001)(8676002)(2616005)(41300700001)(426003)(336012)(1076003)(26005)(83380400001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 17:22:27.7883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c1426e-7885-4b30-dea8-08dc12c9e28e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561

For Xilinx-AMD Versal and Versal NET SOC's there exist also
inter-processor-interrupts (IPIs) without IPI Message Buffers. For these
enable use of IPI Mailbox driver for send/receive as well.

This is enabled with new compatible string: "xlnx,versal-ipi-mailbox"

Original, buffered usage for ZynqMP based SOC is still supported.

Note that the linked patch provides corresponding bindings.
Depends on: https://lore.kernel.org/all/20231214054224.957336-3-tanmay.shah@amd.com/T/

v2:
- formatting in 2/3 patch
- remove extra handling in 3/3 versal_ipi_setup()

Ben Levinsky (3):
  mailbox: zynqmp: Move of_match structure closer to usage
  mailbox: zynqmp: Move buffered IPI setup to of_match selected routine
  mailbox: zynqmp: Enable Bufferless IPI usage on Versal-based SOC's

 drivers/mailbox/zynqmp-ipi-mailbox.c | 258 ++++++++++++++++++++++-----
 1 file changed, 214 insertions(+), 44 deletions(-)

-- 
2.25.1


