Return-Path: <linux-kernel+bounces-8335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C822581B5D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E93D2892DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F6C760B8;
	Thu, 21 Dec 2023 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2IcttrlW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C34674E18;
	Thu, 21 Dec 2023 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA+EpWuDycCIgbKrN3Glb/SE0T0PoLP42iEG6sBQXUTzN/IYlWWvpbvXYFL5vib8NkdVBq3zytGB23Maewp6dXYIaYhI/7S73z+ErwYhFR2uxXQUKgpGc6F+huT13nsnaOWF/X4CCaQuvADAkEvJ3l4a/KEqDtcUTrg1o7UEoP+CpnmrcFdBdCiz5jJ11Adcr5FRHe+auBQrw4wYm0xEY/5Nhx6Jb3sDe+1D59dVhTx0ki2LgwqpSF+p406Zpym9CppHJFq11J0oeU3HLTq6yvUVk8GbotOBSD53BlHU3P1YGYLzyLvDB/xgnD9+b0EyovamIK018YvBVoMTUoShPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uO8Hkqf3nYkoWcd7AbiWmGc0BbzDrlT8pIaCDOVOBH4=;
 b=iQYfzr5Y/lJlcYKXyBy776tkphb0N6TM6MR06SvDKGZug8y9Mm8OildRDDuGqQz/LbI60KBPeeJSM9j9MOXdDh958pDqFAewdU8qd2YYXD0+jhADmvTSMjHrqvYDeZ7dndwd7qHvXbpf2gH/cfHTweM/HXwFoen8DVIS4025b6ZuRWwDaGAA30p/IFd2NczcVj2G58o+e7Eggo9mfe9eiomDF+w2Ehj++1ZAnh0Cpw7JIlh6KMTnxBzUY7/aRHm13V/0xbirrnh3ic6FGGXWmgtscnn6eYeRe0kImQHyeK8kOvzle5TRay7fCn34IdbtfMB0mP1WNNfVoM0vyBz3Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uO8Hkqf3nYkoWcd7AbiWmGc0BbzDrlT8pIaCDOVOBH4=;
 b=2IcttrlWW1dPoToL8+EvXKaG+nTRrxpAzZF7sU1IhpYJDie7zmx+c56beDc7G059wAIz3sPaCw9jn+uoWMtmkYABhX/A7fLw0dVBXVPJ2pl4KjPPeoH5wr+DOcfZDjTwfP50XeYJVpmVqZprcEITFmIcSyr+IkOjiPPRZStD4sI=
Received: from MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::23)
 by BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 12:28:27 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::92) by MW4P221CA0018.outlook.office365.com
 (2603:10b6:303:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 12:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 12:28:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 06:28:24 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Parth Gajjar <parth.gajjar@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Rob Herring
	<robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 4/4] arm64: zynqmp: Rename zynqmp-power node to power-management
Date: Thu, 21 Dec 2023 13:27:57 +0100
Message-ID: <bf24cde92c2b9e2824847687fab69fc25c533d53.1703161663.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1703161663.git.michal.simek@amd.com>
References: <cover.1703161663.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=michal.simek@amd.com; h=from:subject:message-id; bh=UqwBcwhjjOZze1EbwhuQ03cJrt3vxRGVfDSVVLHBiMU=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQWfS+biZphGv4+vzoE9H3CP1079+nX+RXdW0+rR6XeD 2WXXlffEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACYSK8owP16iTzcjayl73qXI Y+9tZ83aoW5/kmF+zDKZM6EOvYervXOMqt5IPFePfW0PAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|BN9PR12MB5258:EE_
X-MS-Office365-Filtering-Correlation-Id: bc475010-6988-49ef-68ba-08dc0220550a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NMNRzzTkoeYKbC23mU6l6nFTuMNyLRyHMxL7Ul61EUXuN9wZDAZVGTCEdSsmAwBElSJM4DSfYqX06jyzFm07X80jMAs92fnKEpXbSWcH1dj72g3731s0YQmXCuPkiJ5xN9B5Fu9FI7hCFmJWiAQohDEY2Kh38UAooRXoBiKh12qbzrsCUlxrZ6SHQRw9hbIBMz+knxb7mjRB46aIbB9kJbLofyo8S5m5uNYgvwS6RzRvvY8f+2BckkPYzu4K2ifZlAqC5ooDQKTdJqPuiNiaq9ru7Jtv6+1k83wgRHPmW0Wcg3nhPbubLYJelGVZ5sTjjGvZBQxCjuVAkXp5MRkqv23Hp05Lf1g+pyajkeD2kMKwNWwoyw8OjvA5d5d5CUAZVxooafNzAnB+FlZigFLZu5zKXQyJuYaS29G8CM3QMj5PMkFU2+irFJlVpM8LRW5hgSMBKSUKMKRm6WDAT8Htq4aF4z0giY3N7oUufRUk2z5XG7Gm0tWTDUsNEqbBDwCd74U67r2GgQAo0MNFX3NagNZfHWzihjWMQ7zmKraOPnZYLVawDufdCV+jNBtxUNP/V0puUnrUpdpyXoK8IfizCVkPATq6fnzPsKlLbFa2oWyEYyXGqh7WAcBXAIkxeBx3Zh0hmGFIfARLE3v+VhNED/2Y/KOOzjqz5nWimtlY7Q93EUYv/NeTtqt7iHiTSYixdph/fD8Jsi5b0beH7/GV4lpsW/IkBxzsyzSN9gBZSeCUb2M1m8G3zyX8+ZTHMdHTovoYfkrx3QbIbVC2PBhtaaSvi6TMdXs2rfJcVjQy0P8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(16526019)(426003)(336012)(2616005)(26005)(6666004)(36860700001)(47076005)(83380400001)(4326008)(44832011)(8676002)(8936002)(41300700001)(4744005)(2906002)(478600001)(316002)(5660300002)(110136005)(70586007)(70206006)(54906003)(36756003)(82740400003)(86362001)(356005)(81166007)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 12:28:26.7159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc475010-6988-49ef-68ba-08dc0220550a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5258

Rename zynqmp-power node name to power-management which is more aligned
with generic node name recommendation.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v3:
- s/power-controller/power-management/g
- update subject and commit message to match sed above

Changes in v2:
- New patch is series

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index eaba466804bc..ea1a9ba16246 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -186,7 +186,7 @@ zynqmp_firmware: zynqmp-firmware {
 			method = "smc";
 			bootph-all;
 
-			zynqmp_power: zynqmp-power {
+			zynqmp_power: power-management {
 				bootph-all;
 				compatible = "xlnx,zynqmp-power";
 				interrupt-parent = <&gic>;
-- 
2.36.1


