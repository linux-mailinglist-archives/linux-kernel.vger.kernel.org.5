Return-Path: <linux-kernel+bounces-27355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D21B82EE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65081F23F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9131B976;
	Tue, 16 Jan 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UXajY778"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDE1B95E;
	Tue, 16 Jan 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItFa1DOCRgTxW6m3CaY9nWa0lJcJTXwOy57Nt6dOVZ9SaEIz7CrI3upjBz4hLm5mf+53vVshbFW12j2GSR1qYScZjGtAa7vENLmJG1/3K4pdi75QWjifWWBSpR8UK3jrZOMSFw5Z4YGTYwOLLC3gRzSLLlvgTWXoc4fQyip9OEh4sN13Mjjm1jcLEYfokHqNm+xzwrRjZRibR5XHxacyYbMHbm2xdEoH+aORhkILgITAdbeMLKJSwO9WW9lGL02/UoHy7LsgW+si6TpLXKDtLFZYXBxFc3IAUyTJ9sxHs5875MGXn8LCiooL0BPpy6/kwJvUtWZ+NS8xKYqgeeTeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA2KB+HyJRDry8LXwRmr4qcxP3kHwIiMY/OLaAbBEz8=;
 b=P3fbjU7sTuG+jqq2fciagqf6rAGGiAwrX3MSX70WPpNNPqxzw5GRzOhC0SGBQ27I2zPOaNL30RQCURX3QGHim/1xK+N7WjNmWxKVm0DdwKzAjw7cQrjwqqnGhpgrofBHuj8ZIwiTDlnZpG38cv1bpIMTDiwFIGk7qTbvNyB1sIRBbcqFpd1E0qGdMRrgbhL9yHnzxKyfk+lUXa07B0h4R7eecBPm52RB5L+3bRRlH5LYNd4jFODxP4OhehYxRwHvVIyyCHti76ljYjLZ7sIoykL9+EU2GA9xUPk4554ZteWxyu2LxYmLur1sdh2I9q88ISvJPFOijYzXVWbrOlSp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA2KB+HyJRDry8LXwRmr4qcxP3kHwIiMY/OLaAbBEz8=;
 b=UXajY778nU1nZBulWsBMlWW8Cz1wJOQ8szRCLhTxApKc6fm/1sGJmCr9R1g5DgKPiIv3R+u8Am9id23ruH2DdY5tTy2CIYikzcVqh2D+M1nHmzIA7Qcnv79Chgyj3yChUo7PZWD2avue+BM14sZioEbI5PJYrkfopKgxXrG3AerjQL+kq/UTY2S3PE1n8iKu1ZiGgvWJZ9IO0HSimoPQlYA54pHXdAL9yYVrVztnK5E482mHJBKCPDF4k3YJl0xSYhM2rcBsV1xspAwR59XToUs8W1BM2S6QjCgNK0nPNFubXnDUhS/4K1BTjrHdkI46Cl50iW512cpSrbU21PQvAw==
Received: from PH7PR10CA0015.namprd10.prod.outlook.com (2603:10b6:510:23d::17)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Tue, 16 Jan
 2024 11:59:53 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::2e) by PH7PR10CA0015.outlook.office365.com
 (2603:10b6:510:23d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Tue, 16 Jan 2024 11:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 11:59:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Jan
 2024 03:59:38 -0800
Received: from pohsuns-pegasus.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 16 Jan 2024 03:59:36 -0800
From: Pohsun Su <pohsuns@nvidia.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Pohsun Su <pohsuns@nvidia.com>
Subject: [PATCH 0/2] clocksource: fix Tegra234 SoC Watchdog Timer.
Date: Tue, 16 Jan 2024 19:58:36 +0800
Message-ID: <20240116115838.16544-1-pohsuns@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbe1b9a-2039-42dd-460d-08dc168aa609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uieTyePWM62dq9369HG20xXT/xSpSGn5apbCtB8RkNnZbIDjcUnkLfkxNwC398xx0j0CgYaqlNA1bJRkkTSUi7sLbqzhLyTfBaxpJRIgFKtceDNnwQ3vj5nSGV/kh4dPu1jtags58IDvpcSzI4BIaoMgdgNkHP1v0Fccly4xGQNLTIgAkr03P2koso+NfFCLQpJ2cADwnx6H2+zthLYmcOUYHd8wkFYxn2s7m5LSYQXJ46hC9mzeqNXf922THmF/pcEHEUJ8UiwQMywDhBZw3Tt3xpI/VtS5iZF0J3ZcTV/nT+WzETcbujB5kPXTNKp5jes2wL1kqQNivgiAktPMhk89vDLH2eswIpEPWLvQCP8q6mL6nrvXnA0YzWuk0VkbQH8i/g3bo+KP/N95MYqlbUyfJL51AMJ49g8hXL1r2L5rwvO6R74/qaEgj/H48gFAdC/2jfwAJpbaXim2dHJ4RtTOanDTcKmCUKgMiPkW+joGQaj9NrQFSGwJuB9Icg7BkJOUtdXN2y4RSI9zM45TKWtSh7iGkx4KOIud/sq0BwzvE1639jO/KtmfxerxOPkUmrOAws3+A12p7wx1shsfTd6OD2oOlZF4/UNIJe5kgLmNWwg3poRsPGUyroXek4bL+t311oFdbe2iqwSxLzzddDqeuMy7UFAOlCXQ4rsUZTaPx5qhI7/FaQX8ijjURqOXhIohwAWCVRxrOpaqusiFN+aynAcitnGZLS75LX1LcbjV7hYxBg7Lmj2/DFOQJ4n9Gx4WgwF8u8AjpBBNnifp4g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(82740400003)(2906002)(5660300002)(4744005)(36860700001)(36756003)(86362001)(41300700001)(7636003)(356005)(54906003)(6636002)(316002)(2616005)(110136005)(70586007)(70206006)(478600001)(7696005)(83380400001)(47076005)(16526019)(26005)(1076003)(107886003)(336012)(4326008)(8676002)(8936002)(426003)(40480700001)(40460700003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 11:59:52.5285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbe1b9a-2039-42dd-460d-08dc168aa609
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355

This set of patches includes a fix for watchdog for it may not bark
due to self-pinging and adds WDIOC_GETTIMELEFT support.

Pohsun Su (2):
  clocksource/drivers/timer-tegra186: add WDIOC_GETTIMELEFT support
  clocksource/drivers/timer-tegra186: fix watchdog self-pinging.

 drivers/clocksource/timer-tegra186.c | 65 ++++++++++++++++++----------
 1 file changed, 43 insertions(+), 22 deletions(-)

-- 
2.17.1


