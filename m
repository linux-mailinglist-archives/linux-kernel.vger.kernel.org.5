Return-Path: <linux-kernel+bounces-21306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C121C828D58
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FFE1F2619C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E923D396;
	Tue,  9 Jan 2024 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZJTNoF5G"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A73D0DB;
	Tue,  9 Jan 2024 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3Wh2PWzERRhfRQ6xYN4kGwy4aAvTHVVBxkdBfZj3T5WcqpqQxRcCMwHV4bF0El0cPE7yieXhKqOF5nQ3IaieWruuMj+stsIkBcAEgbgq0DrttjGNLYrImcKTaWOfReP1xPF72zWnhXPQJkLm0Wsg8KRRzd7vZH/2J50EkRFBM4K4TDaZ40Ys4C6qAsq6yy2UkF4cRKRThtEyqI7rEk5l5rFtdY112cXCVOEuwX4eL3RgabFKQmlVcHn3JycRC3mLl77huzgTAPcMFIBGWBHWjCQ2QhqL3ODXUFUeUNMINzZ6I/Acj61YnsvWwa6Fy8Hk15/GEiz4uxxQqgwvlBdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XChYkO+yKDyMgr93oBR8OotlVDAG5byYbo5xcIbbFV8=;
 b=jJ3vPRtGE7BcR9LLs/X9puIyjGFyeVqIZ2lpGuvrWaPNhFtd1W5fNgdFMpVVDMbD1W8dnK2f2SAHbELA+NONnBBlXZK+nxBK2r8Fa5mExuipaFN/gDzyct9twIhTKk0GxntY5526B12MtfB43NPfVcza3nLKsyzrBNMlPOPbhlzybeUpDgYGp37y70H2SEYLJsDtVvpdep+VGG/K7MbaWZynstUmBy98R62rhtngqJwbSwAdLuwIDZf8qXQBDTf5nT1EMbsKiXnkmNklWU4F/EDVvX98SnPbquMMd+wixTm2s135ySUmJX/NlbUlGDJwdBUN5z/UTluoopLm7ZfABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XChYkO+yKDyMgr93oBR8OotlVDAG5byYbo5xcIbbFV8=;
 b=ZJTNoF5G+4wvB9hAPSGl5Sd84XJP9IXlTbLAfMU5FvUKHTe2lh+lBplzvEgvboCmMvzOelFlcikEzHNQKLpnlh0U/+8fgUylvlC+iRLG0oDduABAntol6HFiylXUm6tpwprjLjOM/psg1HPnLKM0AixslNr/cN4u7BAq7og5T27BBAqAgWpDI20D8KHnvp1Cg8mvDuNW0C2EeyffZMOkg7kgHTuK3YFwACe5vBQIfOxuC1SgPi8kkquitDPmskjfFb6oUx+P8ioquLjqWfDzmrLNXT4mLy9lTNN2KQ+XiyqMkBGPRExLb5a94y39+U655zc1P+kvT1rP6uO3LOh22g==
Received: from MW4PR03CA0071.namprd03.prod.outlook.com (2603:10b6:303:b6::16)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 19:25:52 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::b5) by MW4PR03CA0071.outlook.office365.com
 (2603:10b6:303:b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 19:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 19:25:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 11:25:29 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 11:25:29 -0800
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 11:25:27 -0800
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
Subject: [PATCH v1 3/3] perf arm-spe: Add Neoverse-V2 to neoverse list
Date: Tue, 9 Jan 2024 13:23:10 -0600
Message-ID: <20240109192310.16234-4-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 977489fd-c5a1-4355-5d6d-08dc1148c9b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RLPglGza1Zzzy4ur4P1WiVhhxOC8mDpifUtUT2YKoeKY1mQfBF+l0Jd6k6G29TglmWG4vK9fOIq2L0jgSsEwyndMfPGCKNGOXTW/HkQu9t8uB/AWLAzdMCZSk+6RxrVjUdKwwpB1on+GKKMJf0a87d/7DZG44OTe+3KcCUZ2TSKfvulwkbDUi0nEovzhYRmRAdXgpGrmKZHIFXY5JON/9Ew2NLQMWAzxuv+L2ga/hOUSramxqgdBV783DaRkWX6PVcAkxrZ9hIPOAOS1RgLmkZnUjeoC+w/Z1Cx/0GuiA0YcJf7qr3y5bTAz/3Ls7uxmXBP6NQoW12IIXwP+eG9qgEnFQYbiYbQJc8YRzUyVtMZfUrP2PDfRfY2K0dOLBhEHdQibWlyIkCnRZZh1IBQuWai0qfE4M+niLUfF0btbbG9LhfwRd8dUQnaq8/fpX7Elpq+dyj2CaxGCg9TFhMC61waaep/9e50mtaujMKzgGb7FdteecXNlDQrWnGLHU4Bmg9G24muzzHvBm95OS+tFYCxXP5HxDs5IqqKnCN5uElpjXnBbkN6uqYX93CGKv65J1HLnIZYK2kT/WLKDgBNfLjiySmMY7XLs/J2jSzLHILlEXPdptqFVu6HVu8YWBAnTCeeadp+HVTaFtKG0BbAYzphT6GxRU+8E8DUDUAu2O8p9kb9WROGqeOgDA97I39COwTiNBs2BQOJM/swYJuGekEUd92bMF/Bl4A3ujzrUDos5pJb1ucD6a9RVtZunkGRB38MHfqzD8+hekWvOc0MyHUjVO6Z6oxD0YcdFbN2DSAyeJ+KYU7nd/2+0QmIf8J2b
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(336012)(426003)(1076003)(2616005)(26005)(478600001)(6666004)(7696005)(82740400003)(921011)(36756003)(86362001)(7636003)(356005)(7416002)(4744005)(70586007)(5660300002)(41300700001)(47076005)(36860700001)(107886003)(2906002)(110136005)(8936002)(54906003)(316002)(70206006)(6636002)(4326008)(8676002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 19:25:49.7915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 977489fd-c5a1-4355-5d6d-08dc1148c9b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599

Add Neoverse-V2 MIDR to neoverse_spe range list.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 tools/perf/util/arm-spe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index afbd5869f6bf..936d2222e6d7 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -413,6 +413,7 @@ static const struct midr_range neoverse_spe[] = {
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 	{},
 };
 
-- 
2.17.1


