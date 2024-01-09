Return-Path: <linux-kernel+bounces-21305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A78D828D54
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB58F1F27247
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616C33D543;
	Tue,  9 Jan 2024 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XQV9NJX0"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3BF3D392;
	Tue,  9 Jan 2024 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIvsRemrW8wYs23kTyqQjiohos8yfeyP0c64gOVmmxjOKXucvjbcuMVlVADB9TU+qBI8RAl2Pi1sFvsGxkZ6T9BHScvWK7rj3jV1SQ8LGulCkpY0H8BA21WHGCWYfU9pDsGAOsXcGJ5QvLTIqSkbPcZTh6KNqsTO81JW6D2SsZ9fw+YY3l9DA4CIxJf1qDtxrg68d5z5LR06RYnkP1oExALGEAkOBaCZ0TvuVNXXCVzuBvDi1tRKD1vyRrMY8DuPtydUx5Ew6aprgvjqqX2BZc54A0aPJ9FCpW4zL59EkXnogJNuDHsC78cvrnoe5xU4HEsv7GKj6C8VCFyWaE3dZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YLLwLPmhd7cs1Zk8vSWha4aczVD0+nSpNIA8mmJhbk=;
 b=knYVhRtBbOSPxxOiNa1Vaeyows1dyWKuGASAR52ZKkc3tZ2oeS+JmQU2+7Qxw/D1UaQAZ56JUprggcPKiE/IWdsQaII0KyJCGp32ZCLjR5VNzL+zuhiP9OwJ+Q9NVfuXfvol5+RDeMGricH90lDIpTAfzSBi+uq4mjKzkGqT690jjEGwUmkJ9EWvM6vN12fSBqk+ujFsiBcrMQjHGaaYP5YIzKh1T49KDyJwMrBx/9vlfpzAPUwtNb3Xhc7FuRZsg1sp5+0xg/Kt9ynw2cFJBRuG5Vd4sgcNyxsXdCNJg2C/aCpWAVHorikwTF0YQ6jRUJ9A82KEWmo9E0m4ln2Q5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YLLwLPmhd7cs1Zk8vSWha4aczVD0+nSpNIA8mmJhbk=;
 b=XQV9NJX0miNt/JdzvPPr8RQu4ThRFFMeYbo1G2rdteqHMGEFVzg9CPwnremUNaua5lwN6j/o7FgGabFS63DQUl/It3JZM3ZX+Ebj/9iarF+KNCDomK1Q+5tl0rjeFxQkqQVgumSvVDQJ2Z58mHKPN+tEBGTSDwGSKDyQQXouQdCD8oltr8lNkfVtw7Ps+efhIUDvCz2dljCRgWA94ZgQrmBOK71PK4WtGTI67XTjGOteF5ye9rcwJ+ojZyX4OVGQviBwbTEX0jTpY39ZohmUgrlwpZLqYPBPv0uuV9PcdddqfZhdwh1H5rULSZ76eRZEFxcHTO16rUJc6rqiNi3TQg==
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 19:24:48 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::4b) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 19:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 19:24:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 11:24:30 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 11:24:29 -0800
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 11:24:28 -0800
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <acme@redhat.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<john.g.garry@oracle.com>, <james.clark@arm.com>, <mike.leach@linaro.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <alisaidi@amazon.com>,
	<vsethi@nvidia.com>, <rwiley@nvidia.com>, <ywan@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>
Subject: [PATCH v1 2/3] tools headers arm64: Add Neoverse-V2 part
Date: Tue, 9 Jan 2024 13:23:09 -0600
Message-ID: <20240109192310.16234-3-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240109192310.16234-1-bwicaksono@nvidia.com>
References: <20240109192310.16234-1-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DM4PR12MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d711796-81e1-4173-62b9-08dc1148a520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	17LC4G6dyFFNwsObckUt33cSJoAPiokcOck2NWvuio/pwddRcQdnu05keqX5Y8nlzkBCaCDAfUarrSEuHUUZs9wje6X77cb8XkJOur+tmNNo93odu1wOhqkxrojsfYfqOT2lZN6rxjjTKRsIqyF4c3SyygDmqTTU7QeGN9unIHVM31XYg9OmMzkwruxQIEZi6xOJUWE0Xy21Cjn1h0pjncWTBQVapGL561YW4d03bLUbzfwA2AvIJcVOJwjH1YeH8OzElffbR79Td4MAphfJe6GKXfjW+2hhLDjnehveVkxLFXfsZepNp3K11yWIbxDSwzTllNy2lr4TEwpf13UAajdPO2wrt5HmqlhaxYpIn0/ZaZ6LGyigQ5JbdZQnOaiN7rKICr2ZhXbCzAxW/cymZ7zS7X4U90Ukgg1zqH37cWAcSHt6QZ/ifJn31quy0CZM5QFK2/F18mQ71557+1SY8HJTEovqOkf4IEGgEQSy5SClnnmW9jcZQ/vxNHG43SXTW2SGoIpwzB1uQAkHS12PCn+8C42bMCx3SkyIJTSNvoqVPo0djh+jNyQ8+KGd58Tpe5ZUlomVtPAbGTG9VDpa3KQRPw+e70rKQ661Isto4Z+1PFZl9G4HbnKpzTC1jqQDNuUVDwQ70Cv0a+0OY9rpcrPZsCsn+lfifYj5b6w9a3GgMh7oJI+EyJ9Xk3cHKqfA/1fE2NgTVVjto6uvgO2SNqIP6feghvWzdverYvhnHbfKIZNXjT8q5KQIMN7Q8K+7R09+gBATYSEgYHj+A9KLtJBwqswcqDViPQ0qGu1R0MYHF7C5xD57YPllXj0Gp6ix
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(26005)(2616005)(1076003)(6666004)(336012)(426003)(478600001)(7696005)(47076005)(107886003)(316002)(5660300002)(41300700001)(7416002)(2906002)(70586007)(6636002)(70206006)(110136005)(54906003)(4326008)(8676002)(8936002)(356005)(921011)(82740400003)(36860700001)(36756003)(7636003)(86362001)(40460700003)(40480700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 19:24:48.4042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d711796-81e1-4173-62b9-08dc1148a520
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167

Add the part number and MIDR for Neoverse-V2.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 tools/arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 7c7493cb571f..fe13a25fa082 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -85,6 +85,7 @@
 #define ARM_CPU_PART_CORTEX_X2		0xD48
 #define ARM_CPU_PART_NEOVERSE_N2	0xD49
 #define ARM_CPU_PART_CORTEX_A78C	0xD4B
+#define ARM_CPU_PART_NEOVERSE_V2	0xD4F
 
 #define APM_CPU_PART_XGENE		0x000
 #define APM_CPU_VAR_POTENZA		0x00
@@ -156,6 +157,7 @@
 #define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
 #define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
 #define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
+#define MIDR_NEOVERSE_V2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V2)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
2.17.1


