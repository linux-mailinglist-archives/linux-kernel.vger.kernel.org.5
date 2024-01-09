Return-Path: <linux-kernel+bounces-21302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164D1828D4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4841C20AC9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D198B3D393;
	Tue,  9 Jan 2024 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eWaId/QD"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F6E3D0CD;
	Tue,  9 Jan 2024 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNMuQ3RqwLARfpgNg+2bYpcqQnAz81NjSMypbR3cWhAb3mpuDCO6OgkLU9IMdx75IzszjnnNeG3EAfaehNNzZ5YQ+LKeYT/h6Hf9FFVSUbp5VMwy1bu84Dkopf9OdXVtrYjtFuClXi/sqUX4Rtac4zNnF9BrJHmLpsRFkcwNmPwhJNplkUSwEBaRFi4Qm+E6/53egUdpbXxYcganFp7Djz5UnKAAJSRJtDO7yrMA6a2rzaxtUKv6AiNZQN/4titV11mddW1Xw/2pX4dSwFKZO+fyIEsWQuw3PHCb1BwkEwRtVd+6N1h8++U20EtPxexnpu9DBuvdT99+riBEvcu+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFl34CDZeuQ/Ua+KK1MpJMTf95Xw+2Fae2Wfl3NcrwQ=;
 b=S1o5Cvh5Icm2RMxXwpjs7YAkNILDyjW4GpUye33t83hYzKTAmKZk+EwL1xOmUR/1Medjg7iYtDZmhK3DP0eujER3JVQ/M+cjuQXjvN9DBgBaIFSJmWWth796VTzpT/327DB1vwR9qjaKFOjeUBUogVxVnndgquOMAXPSDCS5Ijo10i9GxzYOCoQEPkg+OwCFuzcxFsFj/XHFPo3Q8tiN+SGot5goYsHvT7fFiCMiiMzwbPUr1OjgK0D0dE9/ojPYlPsyZAtMqEArpoq4+mXN9Sqqz+7RkHioyO13LTN8Ch/BD2FdQT08486giMXj8U162xMVqDifH53eUJA5rYHR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFl34CDZeuQ/Ua+KK1MpJMTf95Xw+2Fae2Wfl3NcrwQ=;
 b=eWaId/QDgLu/S9AXDwhYIqBxih3rACQ5mgl6+0/NJK1fLWORV0SMBOMUH5LyTtfOwCqRkpfF9ZKaywfzjpmGBMpRj6sRQxKmk4HpD2IfaAUMILkTTsqK4O8+3mRXbgdPVUTzdufRZxHvrrKfmmhcxkvWZpIBelAAiYbC9kF4/rT2WBm87xyutmqyimlH1mb9EbwZ/nemkoyOugj7ynJp2k9bUDKYbxwOLluKmUspKW7/LPk133zAbmypsskW34LQtbV6hVz72VLsMHkoiQ1s+UPaiiaY1PwrNgqs3CsqWSiydaSKTLIBHOmn76Gx/oFtl6nwIjDfs7uWNSyY5P4Yhw==
Received: from SJ0PR03CA0136.namprd03.prod.outlook.com (2603:10b6:a03:33c::21)
 by PH7PR12MB6786.namprd12.prod.outlook.com (2603:10b6:510:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 19:24:04 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::74) by SJ0PR03CA0136.outlook.office365.com
 (2603:10b6:a03:33c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 19:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 19:24:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 11:23:47 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 11:23:47 -0800
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 11:23:45 -0800
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
Subject: [PATCH v1 0/3] arm64: Support Neoverse-V2 for Perf Arm SPE
Date: Tue, 9 Jan 2024 13:23:07 -0600
Message-ID: <20240109192310.16234-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|PH7PR12MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b75b1e-5153-4cc1-bbc6-08dc11488a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sZrK74vLQbh/rKBvRFjkTh/WPxwjXUEIp6JREf51rHx2MQTFEDlS6hkmdEkhppjvE21e+obvAKWfVI3jSqvJ7X6dCerJdrcfuMvuFpP++c8rdaoNj3g5JfSk1UEx+3h1Xcn1+VNprU6l+FiMGVxDINMAITsajwY/Ci+ZN8MmsqUDiW0Klx4StJRZwk/bLoepqL7ke71Yn0PQG56Y9M1Tw7qNqzm2fek9Rx1TK01W2iHD6XiGRqpffkZ7VUfNkG7kRkMWRzEGompv6hoKAgHVpJKL5c+BMMVg58mREDVnfRenvveBBxXzRNUjWdaHRY/l+ywY5ZQWctRBUMYaYcG1d2eQku2zOvh2CDfCvBc9/dDQF/cTTrcV5iU6/LKMdshBFZTW40vkUlPhZrD8jyicMSjsPsnDSA1hgR7Tdxkrwz6W7YEm+JNuv+7J4pYZvVV8yR+fGVqFJBaVTinfSpEl67Js6n+IFevqM2Hn8vxQEje3hev5+Zpu7oJMkT9u9/YwE7VV4OjYxCnPedqEVEfb3OQPVqWipTmbulCzQDvchoRLsEMTsoRnlgJ15y3qY/d4z9jlNR7ILuDqJvofkir7GReRMsTyVPSapa7JlrRY6vyGYj3+YT89gym0Bq0rOJynWWhs5d94Xgk17g6zXDJKru22kyWkvmZsrZMSE7uxzYlASkatf+GCm0ZXOKo5Dvs46VMHcSdEVETA+D7HP2sUH6cMsXkDnPVh5lmkvfRdxLAhxTA8so1H4LRVhvTZVbPE2XdDjIPex92BRUn7UqOPz55VsWGX5fxP+vUER2QyWYw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(316002)(107886003)(336012)(2616005)(1076003)(426003)(26005)(82740400003)(47076005)(36860700001)(8936002)(8676002)(5660300002)(4744005)(7416002)(6636002)(2906002)(478600001)(54906003)(7696005)(6666004)(4326008)(110136005)(70206006)(70586007)(921011)(41300700001)(356005)(7636003)(36756003)(86362001)(40480700001)(40460700003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 19:24:03.5461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b75b1e-5153-4cc1-bbc6-08dc11488a6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786

This series support Neoverse-V2 CPU in Perf Arm SPE.
The first patch adds the Neoverse-V2 part number in kernel header.
The second patch syncs the kernel change to the tools header.
The third patch adds Neoverse-V2 into perf's Neoverse SPE data source list.

Besar Wicaksono (3):
  arm64: Add Neoverse-V2 part
  tools headers arm64: Add Neoverse-V2 part
  perf arm-spe: Add Neoverse-V2 to neoverse list

 arch/arm64/include/asm/cputype.h       | 2 ++
 tools/arch/arm64/include/asm/cputype.h | 2 ++
 tools/perf/util/arm-spe.c              | 1 +
 3 files changed, 5 insertions(+)


base-commit: d988c9f511af71a3445b6a4f3a2c67208ff8e480
-- 
2.17.1


