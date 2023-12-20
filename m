Return-Path: <linux-kernel+bounces-6669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E1B819BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A11E287E42
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0EF200D1;
	Wed, 20 Dec 2023 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="akh+uFk6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE81F932;
	Wed, 20 Dec 2023 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfzfNRo+M7oreC6KiS+0Ft+iNEtxbrXuyB+cwtW/6//T4VapkP2nlR92M11ZtSmpCxV1yIzLBav2FqZiR4i1wNz/Smgbt+yUCGbCKHXTgfoYhQva4SxTjsICjj6Td0rfuMBDt+/+B7ciU93U+4W962rN9cj0qJdrs+iCv6Ra3LAJ4KdKNc4Zl/ccjMmKm10/aqpHtjx8ep5H6oz3epwgI1FV1/u1qoZjc0+GizB7maqPtSn+mN9f5sge7G9LE1jE+Z2CfwPRw132fzTMsU3edoA7F6CVj6jYGk2KZpul+BLufXDEPB89XJaVMRBoC1UqVYHDpvPnACqzDFkdzKtfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOb9yhMFJr01J+1fUuxeff8bSczLIqnAbEUZlshJOVg=;
 b=oSp4E6w9relHBgDRwJ3v5PykqqOC7CduYHXt0JMyTFTMKei6Zjt8WwgJNljGVCLMsiar5xXUWoRbpYmSy8xiRcXBqqiFwDqvxVnNRRmi9+OKJGQcChmYMeWUjs4XRSC87PGamrs3pLTTDx/1Yo8dBiGw4QEpI7qU8Z8js3jstcJQVO0zEFCx8x4DEuVv6M/tM9KvNWhdcO99U6cPOj6Zm44ZgpmVArnALw/yr6diYMwXshAk5DeQzUM8DggLAOrVtiKMfRHAeUvPC3iDsan9ahTprzMWCV3nRxauxPJD7ptEhyGyqUrLllTztL5D7+hphtZHwm2VKWchs4EOt4JIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOb9yhMFJr01J+1fUuxeff8bSczLIqnAbEUZlshJOVg=;
 b=akh+uFk6D6BZ0sXUEMg2DhFezV8zEDZFd/KTdngPV/KowKGgGkWS7ooqy5YpA6fGy+bGHSHX7H/79LoQiQa81U1gwBM3NIVFQwar4PkDlh6uqarZ9bswi/l2/j4PjPqMCSUoQmhWGp/QnIjLGSlgowABSOnmBGIEJVncbGe2Kpc=
Received: from DS7PR03CA0174.namprd03.prod.outlook.com (2603:10b6:5:3b2::29)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 10:00:46 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::65) by DS7PR03CA0174.outlook.office365.com
 (2603:10b6:5:3b2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.39 via Frontend
 Transport; Wed, 20 Dec 2023 10:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 10:00:46 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 04:00:32 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Mark Brown <broonie@kernel.org>, "Naman
 Trivedi Manojbhai" <naman.trivedimanojbhai@amd.com>, Parth Gajjar
	<parth.gajjar@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Rob Herring <robh+dt@kernel.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, Sebastian Reichel <sre@kernel.org>,
	<devicetree@vger.kernel.org>, kishore Manne <nava.kishore.manne@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v2 0/4] dt-bindings: xilinx: Add missing firmware child nodes
Date: Wed, 20 Dec 2023 11:00:26 +0100
Message-ID: <cover.1703066422.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1017; i=michal.simek@amd.com; h=from:subject:message-id; bh=EiQZfZvVQpebTaG7UujcoUb3Ml1vcn0y6BKZV45+EXE=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSm3eZqfFnzLyob7VOLcde64tL642LI+pTZMSEL/or4T 1R4qPm1I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzk1SqG+Wm3q8Xiq6Mdvkev vv/sT5TA0ouyMgzzCw5tlteynnNe+dLBRV6h0e1z1qoWAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd1514a-5e32-4124-3883-08dc01428940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XGd3HBnShd05Rj4d0FfNsa3g/clc/pRfC5S8BTjkPV8/iMVSOAwBHLYi0W0GCsYsIxae6krv22nXzd5wB50830mhh0GFxjm2yHpDxIh+Cz/bi+V7C/fZ37ow0uLKg3I4FqyxbGKZ7zI+DFV4R2sw6mqgkWmVx8834I409ji/kuowfPGo84KjDwLA+cW42M6fpdclG5Wp7pC6gfJMbngxRtZgS57Y3dXGqd9IYGKLx8hxN8kkdFnqZ6ShMEBUzI8G6Yb/59xS4BDrUQnRb1bwYc5MTZHErg3P1NswTKwWGlBScMzqDwIRHRlxpa97vQG0F08dg0LHYmv+WftoEIajrnjuZsvf0mryrxKNn0kMkzh5nAzDTQbAeI7+lebD6o2HPEF1k0epSmn/WJ5+kcRuzQRTdnobPyfOeCrPNtdO4fPHFKNF03RBy8Kp8tHuO9I9bS0Hd1f/OFBFbat3dUVCwwjfga6obR2rASUyvbBXeH6cEkho2LhLxyIb8luLmhfNjr9XzrqHsyEhnNbaDrfrxvSj2lnj5cnenFAYWGLBL+2ArSfpaHpbiQ37C7LGLyGtz5GSBAiwEJWoaF04vA2WjsMMdGYSwhvNYoEIpDl/7BvFgzDiQ/Xv3dpruHuL7r05YwV8xRzK4lm7DN6jmGxwAd2Z5f4nlfVkU8Y+IQ1PnXq8fu9UGCpqcce3ER2EHtSMaw0Wbq08EqQnPwNPNb+MAsd2epvjbX2nLC3xbCqF7abU+8J4yHWvQWY0Ki7iQCVx6Te+zSz6oEO/dzx386Jqng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(40480700001)(16526019)(26005)(2616005)(336012)(426003)(6666004)(40460700003)(36756003)(86362001)(82740400003)(81166007)(356005)(7416002)(83380400001)(41300700001)(4744005)(8936002)(8676002)(4326008)(44832011)(36860700001)(47076005)(5660300002)(110136005)(70586007)(70206006)(54906003)(966005)(2906002)(316002)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:00:46.1143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd1514a-5e32-4124-3883-08dc01428940
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419

Hi,

series is converting missing descriptions for child nodes and also
synchronizing name for power-controller discussed with Krzysztof in v1
version available here.
https://lore.kernel.org/r/fc7863a2-d3c5-47c8-9484-ef9cd6d7dd5d@linaro.org

Thanks,
Michal

Changes in v2:
- Sort nodes by name
- Rename zynqmp-power to power-controller
- Keep only single patch for easier handling as done in v1
- New patch in series
- New patch is series
- New patch is series

Michal Simek (4):
  dt-bindings: firmware: xilinx: Describe missing child nodes
  dt-bindings: firmware: xilinx: Sort node names (clock-controller)
  dt-bindings: power: reset: xilinx: Rename node names in examples
  arm64: zynqmp: Rename zynqmp-power node to power-controller

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 49 +++++++++++++++----
 .../power/reset/xlnx,zynqmp-power.yaml        |  4 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  2 +-
 3 files changed, 43 insertions(+), 12 deletions(-)

-- 
2.36.1


