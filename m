Return-Path: <linux-kernel+bounces-24624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E10482BF55
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E161C2379D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A126A004;
	Fri, 12 Jan 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XyoBtAcy"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C81F18C;
	Fri, 12 Jan 2024 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu5MXPhaprTFjkOvsdSf2thUFf0rgbI7scn6+/0J11/bijSd/TRplWlFLWudI23fUNIeofoBbRcorIT6o9OP5dtshG/Qcf9uci1U4C05E3IFkZU4Q1ApdstHX224PfLEaB07hDyoE1ubfiaqYSBU8rhYoJ+yvOO6xuZ5NWKv7iYr9eCUdZjPkMHBp+/23segwc1KH2hQL6y81sE9Dov6ix9E27wm4c4oc9nfD3dRKviRmJylg2yom57MtocLMWvRSZZAj+odpY+ugfu5e5a/PUdwwHc0FrJb++Xb2Br/OqhKDaGzYqdKLhEehascWKKOlFczWFVrsgx47m7atI7RzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hkC+Z474aZw0nJ3LVLL6L0vb1RyXUgtJQ2KvgsZELo=;
 b=UUEZfryj6l17E6j1iuyPu5pb4rFbBQj9S1ywxfOnYkm03JskWUr/4nD8EcWadKniOFLU9pp9z2e2S0zQA2s5LDOzMyWixKnhA/jB2Ka50AkOPgNWvOlEH02HGH6vEiXqZ2aBuaVN0WxGtt/FWyZutNivr7z1vCv37VpIiufo+56JDHYs6Vp4ZISp/HzBVGmjGRIa6FRl8WkZcof3NDBa8nMT+dnwT+bWDuC3AFLzGXPB0extVRLcHK3WTtmlBGau+dZyJbmuHpGIMV6th0QJO5pvGc+mWutgB3nE5HqgE5CQne123cEvnizhNdHHyJxOijokbbLckfl4D++uWita4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hkC+Z474aZw0nJ3LVLL6L0vb1RyXUgtJQ2KvgsZELo=;
 b=XyoBtAcyZvoR0e4HKz5SbojFoFVmkVwIzhdIrGnpamGgD01z8GkUfcEYv4z9H/AZaH+UOb95oosLHInFf17Dxpa1Ys8lzJpP2BXDV+hpO4ZWVcXXOIQ/csnbAu/3RkYgjKEHMoHtl7SDQjT5SGmUHgN8S5VFlLoefROP1svBvps=
Received: from MW4PR04CA0246.namprd04.prod.outlook.com (2603:10b6:303:88::11)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Fri, 12 Jan
 2024 11:40:51 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::ff) by MW4PR04CA0246.outlook.office365.com
 (2603:10b6:303:88::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Fri, 12 Jan 2024 11:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 11:40:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 05:40:49 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 12 Jan 2024 05:40:45 -0600
From: Srinivas Goud <srinivas.goud@amd.com>
To: <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC: <git@amd.com>, <michal.simek@xilinx.com>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH RESEND v7 0/3] can: xilinx_can: Add ECC feature support
Date: Fri, 12 Jan 2024 17:07:30 +0530
Message-ID: <1705059453-29099-1-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e7132d-e256-493d-5342-08dc136353e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cG4XOyzu2M2y84pq24W2LH/PUn8s0S+wkBZ/dg4Oa521wA9+SswaPyZXkTomL6j/HBhQ/OIVmbUhA4p8hJZCHnjZ4uBVWSXJ/LEzSZBC2GNTDH2NGqx8s5G4hBvNOhfo4/USHkKD2bsieoJ1Jq0XA5dlNPNAGXW20s3hBczF2rI4q13mZ+ODGuinzfbwN3MK6q8LeYwUxLuV4jMolGmn8bWro7LYnyr5Oz8Rp7lDBnXSVk4CohXsM7Xhm+OM3FCWQIocVUOJfJRxH1lbMKRcdGMmGRZg14tMtqVfJAoufDvapY7FM8Y2DnoWqbCJTevswczIUABKm/xuLbPrrwUg47MAJYTljZsu2ut05JTPuTbsrNhuSfQT6p1FWaKPlF2+e3PcalS/JxZ0qQ9YIEjdBVoNUpXwwtGC9LQqSFH6IttncfbXpwKrDf6fgMXJziluUdUyamrYJLEozBRBJWsYD1FLH4CC/lNfRYEMpxICewwNwsiTeJB5dzdX4A7sCrTDfG8Xh7Z7w1SowAYPNMCv4WRVd5PgALrw6jQNrvJESxf4Xmg6KRcYk9ICmLadodIR3XSTa8xeaFue+GPsyewGBwc8PbZwJIi3PPBefsYoeKQpGIhpXcb5efj3fr0GKIgFNstHSvsckcYXH7avDhVOFkm4oN+tLhfj7DeUYBmybf1CFN93en4oLktsvyDf72SX0JPT1zFEDFhp5wtbEcLrFpiCcYt8lRz8vzYyWEq4mZyhGrboHPV93BbtPTMkE3s3RTuS7alUDtYUnm1Y21cjEjBpTzkOIK9AFyi8S55wN9S45WXTf9O9/Q64ljebrYwnDcUIimkjZVWymr3T+DJ9mQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(110136005)(40480700001)(40460700003)(2906002)(7416002)(5660300002)(44832011)(47076005)(6666004)(8676002)(8936002)(41300700001)(921011)(54906003)(316002)(70206006)(4326008)(70586007)(81166007)(356005)(86362001)(36860700001)(26005)(2616005)(82740400003)(478600001)(83380400001)(36756003)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 11:40:50.8458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e7132d-e256-493d-5342-08dc136353e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

Add ECC feature support to Tx and Rx FIFOs for Xilinx CAN Controller.
ECC is an IP configuration option where counter registers are added in
IP for 1bit/2bit ECC errors count and reset.
Also driver reports 1bit/2bit ECC errors for FIFOs based on ECC error
interrupts.

Add xlnx,has-ecc optional property for Xilinx AXI CAN controller
to support ECC if the ECC block is enabled in the HW.

Add ethtool stats interface for getting all the ECC errors information.

There is no public documentation for it available.

---
BRANCH: linux-can-next/master

Changes in v7:
Update with spinlock only for stats counters

Changes in v6:
Update commit description

Changes in v5:
Fix review comments
Change the sequence of updates the stats
Add get_strings and get_sset_count stats interface
Use u64 stats helper function

Changes in v4:
Fix DT binding check warning
Update xlnx,has-ecc property description

Changes in v3:
Update mailing list
Update commit description

Changes in v2:
Address review comments
Add ethtool stats interface
Update commit description

Srinivas Goud (3):
  dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
  can: xilinx_can: Add ECC support
  can: xilinx_can: Add ethtool stats interface for ECC errors

 .../devicetree/bindings/net/can/xilinx,can.yaml    |   5 +
 drivers/net/can/xilinx_can.c                       | 159 ++++++++++++++++++++-
 2 files changed, 160 insertions(+), 4 deletions(-)

-- 
2.1.1


