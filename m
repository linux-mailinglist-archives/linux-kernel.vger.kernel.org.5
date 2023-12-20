Return-Path: <linux-kernel+bounces-6676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B4819BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304DF1F2668C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BEE20B1C;
	Wed, 20 Dec 2023 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kU6V5lhV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461921374;
	Wed, 20 Dec 2023 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVpfrLULRRbtdZEQnwKJjqyYiGHtgaR7Yd9YLfUN741YHqEPER6j1kyNlMFvmEJ1mld+5LL6TA1PPZ3aIBAWSpXG1vKE9J60f7DnEqvCcl8GtIKoW/I0SmBS4rgiboqIUdd1EvrUHBLdlHqhS2xOHtqEH279TYyNcteiVbtIl1XdzSo1lAxGCFHMJtM0H9eT+h5SqvWOlhzSIIaW8SE0gUn9hBv9uziKOEcB37RI9Z/O/KKwIKGhtl1G1f2EtzCcA66P7T+RKLp4OirnZUmTLsw2WPwOJQiXXy5ZVmkg0k2eoYrdAf4xuxIU20kNbLr8fOpmMaVc9wmFD8eX/I5vww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2uYXvJJALBupuMJ/7KQRHzo19inxzhpvrXvqUNIsHw=;
 b=YOcWXjrTjdi1WHZ2LMZhYQHfPgqiy75CFjVCf1fp9w9Y3iCvAJmovRmTHf8ISmm1gR0JsAzp3St7qjDbOjdahXZO0jwXidWxlxQjf0Vn1kjF0jYe9RZnwx0YErqH50AAG/rq7aecTAotaqqVaV4C4cBOqKRuUciwYzPZkDCDR+/+IHXDV1aybb7u/inIdaR46Zx0mtZoELpQm255yq422W9X4i5Le+giO+1jdWZ9NcV+flcPF/gkRYyhCD6G9XJolPfE4TV06pJab4i+t06/EZNe8l1X0vXSIJbS7E2+Qhs1QUBG7S+1d9rlYT4Gozdw6wF5T67/6cQRNsgQ0hllNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2uYXvJJALBupuMJ/7KQRHzo19inxzhpvrXvqUNIsHw=;
 b=kU6V5lhVEgGzzrODD3hiIiJtmW3VM2SyThamcjfjRg8B9nnFRhCLkmZNcDkYWj/Q/fWHpOJnhjCcCzvZC0NcT9Q6w+sRz+/FAsxxttDmzbL/l0u4eER23B/NKf3baxxMPqh21MN4Fmf0mq6rTHEsFdO6IwEpFz+51yLTnZZXSC4=
Received: from DS7PR03CA0026.namprd03.prod.outlook.com (2603:10b6:5:3b8::31)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 10:01:27 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::90) by DS7PR03CA0026.outlook.office365.com
 (2603:10b6:5:3b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 10:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 10:01:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 04:00:56 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Parth Gajjar <parth.gajjar@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Rob Herring
	<robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 4/4] arm64: zynqmp: Rename zynqmp-power node to power-controller
Date: Wed, 20 Dec 2023 11:00:30 +0100
Message-ID: <48590ed3fe1b834cdab111b023b6ce3777a5f96d.1703066422.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1703066422.git.michal.simek@amd.com>
References: <cover.1703066422.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; i=michal.simek@amd.com; h=from:subject:message-id; bh=m+K8LhO6PHTUz6bGixAgVOGrMYWZDR8wIayK4IfRigs=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSm3Ta3zXbnfZ6h29VcxdSSV7VhIvOvaY95xM3EPlRnx Qc+b+fviGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABOZFc+woLEv8urlY+/Xxki/ j2o8E9W3Wvz/Fob59fP0DgdMSHNtm9OUaSJ/Mmjnbq4dAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a2ccb3-960a-45f9-57e5-08dc0142a1f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NL98RAbZBoJ67bDMNTqb43tcIntV+MN8kaJbE+GFgx9SMwTvnj7cNYy2DoFvtGAKjkhuY/S6znCCHKDW5lOvjikGw73djEXumKHnEoPmeYTd0vm6p5xzIoiOfb8bqjpDazqs0eX/tGQoFAZWGQojJnQ7wj/A/DFcER+oJghzlYqNI9S0AvJQl2ZXPo7LwhFOwbnploFEHyjIjn/FKoFqMTTh5cbxWqqnlL7VWwd/dfYMJH7BFo06IbIItyICy31F9cL8xhxeMzbLfLbu58WpFVduC4gn2iaqhcgo03opINWJYycRwWQm/5JnM+AkP0yVyiU/lPwIIZLX0tRT/f8+maXGaMezWHJdV3sVLgdU/hwI8F9Cej6LNGmWmNHF6Yf+2NxxwEiakwWikme1FYVeWYzOM1ngLsL67I+rbupS84mcAUAicPMuzHTGsqFnZC3m3Zih8CYFVcZJTR/UMiHQUjccYjPzwQJmzGsOSGCyW6mNBArqLDDQlx364lq4to+vyF77J6lb9tVvLd5HyADi+Vwc8FxTGzqtHR5X6ajQmAkZJf3HIAJoqcTL4sgHo+qWzUyGGum5guUB4rDKIxtNQhCfP/fcyzB2+22eQJDFIwqvj1aIK1FGAX8h88eEW4GfiFCq/JHIuiGgl9DO78oLdMqErIkPQj/p7ZwKGPZM6ymCnE6BHZhVzXfRaZKvpNI5dlE0/enGLThaeT0MEGAYt55wrWq4i59ezycYBk/wPy5fkNxlvJ9waxgNgQEBp/yJDd7UscH+RrjZdJDukH3T/VArOOAG/SRMusZm12v1F5k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(40470700004)(46966006)(40460700003)(83380400001)(426003)(2616005)(16526019)(26005)(336012)(47076005)(5660300002)(36860700001)(8676002)(8936002)(4326008)(316002)(2906002)(4744005)(44832011)(110136005)(41300700001)(478600001)(70586007)(54906003)(6666004)(70206006)(36756003)(40480700001)(82740400003)(356005)(81166007)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:01:27.5863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a2ccb3-960a-45f9-57e5-08dc0142a1f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270

Rename zynqmp-power node name to power-controller which is more aligned
with generic node name recommendation.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- New patch is series

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index eaba466804bc..b1bac486c3f7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -186,7 +186,7 @@ zynqmp_firmware: zynqmp-firmware {
 			method = "smc";
 			bootph-all;
 
-			zynqmp_power: zynqmp-power {
+			zynqmp_power: power-controller {
 				bootph-all;
 				compatible = "xlnx,zynqmp-power";
 				interrupt-parent = <&gic>;
-- 
2.36.1


