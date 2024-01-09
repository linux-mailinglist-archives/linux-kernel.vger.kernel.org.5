Return-Path: <linux-kernel+bounces-21303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E3C828D50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E07B23DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BC53D38D;
	Tue,  9 Jan 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dqp6pI1d"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB73D0CD;
	Tue,  9 Jan 2024 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMF+9pArs1vhCamtWcHXsfUjmKYio6pjj1qVYrXfio+j3hl150+eDMUTojf/9uYsYdHbo7a1a/I0pj3A76r12eCnbVCx2+F71Pet7eoZP6bDc3pUySVsMT7YhGDQNJIHlWZjmOz7Ss3QzkiUdtLKDIf9ZNWVAOl0pqifVZ6fhnup+P0wsSm0sRyxtKAjdkFuaj7q0ZLuXoYd0uzUS3ZNuUERt6UjTUPQQRxltX7VSEyTqyA5pbYIkS/qpsZgMiEd4wizBeRC9mr6/luLQvKG0H2X+0pxQprIsmu0C/2D4hUCcN5sTqalHSVqJoMVTLoj465rY7ahTI+MgFLRqOwszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBJyTN1b9V8CFlpxLjATl8H79QcpsxU4Q7NUgK9cPh0=;
 b=fDx3VhNhIqiogkGkSaiZvnfw/OA6l88XB4KrtuyoyypwgQJ0QN0wuG8g2ycfIZzYtOnCWQ5e3bPkCE+iAOtw1J00gr9NupLSzP8k5GqNPGkDdM/K0mBfZ+8hNl5uKlhaGFfsqhpFZHcwcs3gB+3st40nrR3Le1A14zTEr4Euq4rfmMks1gPqo3PQr8kuKlWqOwWMkFZpjg60yTY7kHkn7ZtB6/y32Y6yA0Z92X2dq43nEViQzZLiA5qkx7A0p4QEf1rrZrAwG/L4GKm0GYShepsSz4LiQeS3CbjbzEU43jYwPOLj1+DnkEmkgak5+dxjQZd1aB4HYJVQtNgactattQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBJyTN1b9V8CFlpxLjATl8H79QcpsxU4Q7NUgK9cPh0=;
 b=dqp6pI1do+wwPN0pYp80NKROCMiaA0AJ4bqpAsINn9LnCjYzflMUW4xWIFAaItE7DANQXwuArspYPizPhGozPElssDV3ycgMWyCgO1ugkBgD/oJNitwvj7LJIuLDo8cweUu04Zxo8N6+xOssdRqGi8Iocplfa2hI7mRWEFUy//j8TrTI6HU27FCgnf1ENzikY6pRuPTmFXd1ferue/yV9y9DtFyTuDIIw2ousT55k0TNNTFCAe3kAdWqKx45opCKK5eC5I/zVxsuHwIDxKPBs0IPMT/3AJx+cebLmfLRKzwVXTlfauRNd1w9wdGztKDNsL+kbBArSGkvDjvkBuCqhQ==
Received: from PH8PR02CA0003.namprd02.prod.outlook.com (2603:10b6:510:2d0::29)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 19:24:33 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::fe) by PH8PR02CA0003.outlook.office365.com
 (2603:10b6:510:2d0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24 via Frontend
 Transport; Tue, 9 Jan 2024 19:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 19:24:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 11:24:10 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 11:24:10 -0800
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 11:24:08 -0800
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
Subject: [PATCH v1 1/3] arm64: Add Neoverse-V2 part
Date: Tue, 9 Jan 2024 13:23:08 -0600
Message-ID: <20240109192310.16234-2-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 1666ad53-a8b3-428c-d65b-08dc11489bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MC28ZejVDVqkw9nRk+GGmIQqsYYfmLgEyOCu9u+iBlWb7uPfMLqRfAZKOwm8UI3vu8pj1L4Os/JTW5iMTDDgo/ocY5RAyCaTidOidJdcrnTMQ3zFD+WIMuyWBylHEjUd0E87L5/nOvEeAWhbjIariKzPmMx8C6qrZT0Dn3sxZJAvnjtwB3pZUcneGb7qCta6cSlINxmyQ75B4xjgc4qTDmZM7HJbcRn94yqSGbZtksVEPPLo2ENStzGD1VLRxesy+RzNc8VokqmwG694+OuJZEB84f08zXdQ6ed9FmFGOpGbqWUCCIb9ZirL5q4VJv9sFqnSDJYjYtdjZojDKaiUVjRtiya2MnpgMXdG5ovsxBUGemegfATglH0KaS6txZPORB+v1ZKgCiUSEJT2+3kpm7DatGqh1Ltk5tqO+SJcxPGFjBBtdFXkCNWUXFoKVwWBrk38zZ7o6cqqj3Y+iRGg3smLJOVfksj+8QG2UtDn14+SoCQ1ha7CArlzZBsLRY3tMNop3ZTU1OC8ntD5Thl45eK33TBTOHkegTjiyqlTGitMFSYT0A0joXOEJn+rcavyCn+3BW+IQ6IzWPRYR3dah3/ONzJvA/3XxEMKvjYAu2pFRMd3g5M5i4QoKwdrhnJweBwkkgR1cuMMugejChM2sF9pv1pZPIdPdnCwuapk/oSTq8l7mGVcGBeDGpGWPbB4nSIDGbiH8KjCEGovuQP2TnxCUvu3EQgeXXZparr81Dpd1R8NUSDqGunxNJ+c6atf4c3eXWlIMPTK36CrJ5Lt9DlU4AYOf4G8rlAYev2VnUZVXSo88ji3GCs0rzArxvg1
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(26005)(2616005)(1076003)(336012)(426003)(478600001)(7696005)(47076005)(107886003)(316002)(5660300002)(41300700001)(7416002)(2906002)(70586007)(6636002)(70206006)(110136005)(54906003)(4326008)(8676002)(8936002)(356005)(921011)(82740400003)(36860700001)(36756003)(7636003)(86362001)(40460700003)(40480700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 19:24:32.8292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1666ad53-a8b3-428c-d65b-08dc11489bd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370

Add the part number and MIDR for Neoverse-V2

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 7c7493cb571f..fe13a25fa082 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
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


