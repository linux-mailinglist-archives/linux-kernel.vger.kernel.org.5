Return-Path: <linux-kernel+bounces-4269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB93817A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F9D1F23315
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A491EB24;
	Mon, 18 Dec 2023 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Upg9iYj4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94402495DE;
	Mon, 18 Dec 2023 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8XzmvWyFnPTarTDmce3OR/KtYCHJnFOT8wYLJhIMdQbfPW2d+KDa0a+ROL9lG7WfTcElKaJaGpxsb3o5TEjZey/YE9W8rDRIfozJLc+lnJF+Cjy+WW0rSiFFDdSg2dov6PhHmJQImiN3txlhz/1b4g2kan9KGJu0POOdO9JcY9tIzuqSi4xoLjS9Z3dNyoqTIjpNrAM3dX5OYYUJQW+Spl91tUiwcxl2fHVV+8pBoBuCaThLqr54dYZ6grQ1fjaKcDvYahUCuZuc02E6AGaObkU1s/IrE1I+ZmhHPMIa/IzxhBvsPVFVZtKXHRG1lfyte2eq+ek7FdLYmq+RJSrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2AUZAAWKVgQ5xSwKSbw+igZoRERnQMnfYj15B8a0Gw=;
 b=bRNT/dxMAGJ1TdJsVzFwt6DS7opkLK39OvBXmTwscsSHBx+KEqLhwnW0XxYM+HD7zUUxANXa5O52AhMbrkWwrBbMXy0+ONyYrb8imvXB68aJ4jnJhCSHfkYAsxxxtNv9Xnfnwhm6znTUPq3PzHRfZF8Z3oV/tT1IG/m+VavzrbKEWhYkcq4+HVEwcj+jr1E4Xt7g74VB8VO34ykTRh9r00EN0ipJR0cqzXrNWLrv79xotOoEYO90bTP1am1RmliaDMYRPU0t3TxZIUpk20dLnKvcI4ch+Etf2sYC6wwCcBDu95CtRQLFdIcQcUw+iSqp0x31KVG2G6ldy4ZodwaD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2AUZAAWKVgQ5xSwKSbw+igZoRERnQMnfYj15B8a0Gw=;
 b=Upg9iYj4cS2iG+7ylHgIDxqpmMl7EtAB2HYWelkbZGrVzmS0U1rjRdEa4Pf6C5i4XLF9YdP4E3pVLCR6oZNIRWi0CFg9IRxg4gPMBsl1cG4I2O6JwYddJST0XQOjlcEiHBXcM58UohuiildQx0GLQlgbLYv7ufdY92XhY2esSb0=
Received: from DM6PR13CA0003.namprd13.prod.outlook.com (2603:10b6:5:bc::16) by
 DM4PR12MB5087.namprd12.prod.outlook.com (2603:10b6:5:38a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Mon, 18 Dec 2023 19:04:20 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::79) by DM6PR13CA0003.outlook.office365.com
 (2603:10b6:5:bc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.17 via Frontend
 Transport; Mon, 18 Dec 2023 19:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 19:04:19 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 13:04:18 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<tony.luck@intel.com>, <john.allen@amd.com>, <william.roche@oracle.com>,
	<muralidhara.mk@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 0/3] AMD Address Translation Library
Date: Mon, 18 Dec 2023 13:04:03 -0600
Message-ID: <20231218190406.27479-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DM4PR12MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: c842b539-2adb-475c-9e4b-08dbfffc236c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g5VKz1qelI8ttUjQhdj1oaH09CCKiCDE1Hc5+WFrtnqMWWgTcukPnocGXnwtuf0vRG4pc3u66buTD8jafrk1kWQ+alRgLW5cEhhho/wF5ZA86dftplHq4nmhVnDVE5Ji5gCqoYhVmcvA9OAaLhJxNvSbriM3JNkBzY/3DpHqLHeZu/z0pO5BO8WSm+cmpHs+pvLnCdZ10JiKB5NAybs754rEcahv9KUfTMypQCwopRdXM1M1juYSePwYVEmJwsIgtz08yK4xhZqe78AgYlx8LNssQRTrv4nyyuJSEBskJEyW+hEQFCJw9zBy/gvM0WvLrhKueMpq2SlARwiHuPv/GbE9IGmNBbg5uslH/Mrf3l8X6DSioDxeSvY7Uocpg4e/6FvhYCx3cbJnZtAms9f7vfF6ljRoCAuymHoxrpi19rULi0/3QaLwXnx7astQHL/omyuDBFAtUQAYoPliXqWeG8G88nkXIIpdNG36oCBgJmRUchbO3MU9DJjeuKnq37XMAiKBkZwZNRuPYLa2zDGC/SQfx18XdA2grm3ujJTYc4LCEA2DUf6i1vvmCvP7xRms5FKdKuTJ2jGyXdpbqCu2DFNmoetI+w6ef7gzHYuu+jtobvwiuHnQZe5c+dT21KZAwQKBKt3+DqaM8azmmI0sok9obwCTipYbiL1pLRcf1T5zvBBIovvT2l1Ibw8LC7hVYqhHW5yPbdrF/paa1gfQDaDho3hWeXF1yZJCCqWrruz4um5OBKvhQBeNNnnEUYPWMgGW2KOKwSjOJAlRhMCKMw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(83380400001)(16526019)(336012)(426003)(7696005)(2616005)(36860700001)(1076003)(4326008)(44832011)(47076005)(5660300002)(26005)(41300700001)(6666004)(110136005)(316002)(2906002)(478600001)(8676002)(8936002)(54906003)(70586007)(70206006)(82740400003)(36756003)(86362001)(81166007)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 19:04:19.2500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c842b539-2adb-475c-9e4b-08dbfffc236c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5087

Hi all,

This revision addresses comments from Boris for v3. The most substantial
change is the removal of the library "stub".

Thanks,
Yazen

Yazen Ghannam (3):
  RAS: Introduce AMD Address Translation Library
  EDAC/amd64: Use new AMD Address Translation Library
  Documentation: RAS: Add index and address translation section

 Documentation/RAS/address-translation.rst     |  24 +
 .../RAS/{ras.rst => error-decoding.rst}       |  11 +-
 Documentation/RAS/index.rst                   |  14 +
 Documentation/index.rst                       |   2 +-
 MAINTAINERS                                   |   7 +
 drivers/edac/Kconfig                          |   1 +
 drivers/edac/amd64_edac.c                     | 282 +-------
 drivers/ras/Kconfig                           |   1 +
 drivers/ras/Makefile                          |   2 +
 drivers/ras/amd/atl/Kconfig                   |  20 +
 drivers/ras/amd/atl/Makefile                  |  18 +
 drivers/ras/amd/atl/access.c                  | 106 +++
 drivers/ras/amd/atl/core.c                    | 225 ++++++
 drivers/ras/amd/atl/dehash.c                  | 416 +++++++++++
 drivers/ras/amd/atl/denormalize.c             | 616 ++++++++++++++++
 drivers/ras/amd/atl/internal.h                | 297 ++++++++
 drivers/ras/amd/atl/map.c                     | 667 ++++++++++++++++++
 drivers/ras/amd/atl/reg_fields.h              | 603 ++++++++++++++++
 drivers/ras/amd/atl/system.c                  | 283 ++++++++
 drivers/ras/amd/atl/umc.c                     |  41 ++
 drivers/ras/ras.c                             |  31 +
 include/linux/ras.h                           |  11 +
 22 files changed, 3392 insertions(+), 286 deletions(-)
 create mode 100644 Documentation/RAS/address-translation.rst
 rename Documentation/RAS/{ras.rst => error-decoding.rst} (73%)
 create mode 100644 Documentation/RAS/index.rst
 create mode 100644 drivers/ras/amd/atl/Kconfig
 create mode 100644 drivers/ras/amd/atl/Makefile
 create mode 100644 drivers/ras/amd/atl/access.c
 create mode 100644 drivers/ras/amd/atl/core.c
 create mode 100644 drivers/ras/amd/atl/dehash.c
 create mode 100644 drivers/ras/amd/atl/denormalize.c
 create mode 100644 drivers/ras/amd/atl/internal.h
 create mode 100644 drivers/ras/amd/atl/map.c
 create mode 100644 drivers/ras/amd/atl/reg_fields.h
 create mode 100644 drivers/ras/amd/atl/system.c
 create mode 100644 drivers/ras/amd/atl/umc.c


base-commit: ba7d5744cf6fac619fd0bf1165c90ee930956ebc
-- 
2.34.1


