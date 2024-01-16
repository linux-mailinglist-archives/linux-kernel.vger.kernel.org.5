Return-Path: <linux-kernel+bounces-27294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0063782ED72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCD2B22F54
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021E41B803;
	Tue, 16 Jan 2024 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ehklcKog"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F91B7ED;
	Tue, 16 Jan 2024 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhs7U8UdGwmnZIGxEvazTR7r8q5Ste6GIBRLL7WwyIHJFbBhoqlZIqUtgBOEba/5XENoRDgIPhCNoTIrPw8DEIKEnu1rg699NXNIHQqu1Vajdz11OcyQ0gupU6MbBv9BSrLaC5GsSN7WsYzFqucGjuSZC6Rob37HQ1xQcgEU3rnOLxPdDtCz4aBgoieKRwY8iMYZyoas9jljVVXtGMWriFimyUPqfhr5sA5XH5WLL+o6rvoRtnYlbtCaAOmVIslkW2aHzqZQ1MdFtLvAdWKIRY+RD1mJUcDfQddUL8fwu7OIlHszRXlFf0Dx3Fu0vokT+YyskPDRwmpViuAB4LgXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntE0upevUUBMg65dUBhcHt2K60qt6418bgwT8nuPgl8=;
 b=WVjIXnZOtV1zMAOQHsqGjomO7SDmRxE76hSgcWl5t9xv/Pedpod6a22ErZi8U/1YUGEXiqv71Zt3kd71d+fsWspLsNW1Z/bbIWJ5FhV8tjUpQtYcbJulXRYr/k6Lh8UAyPbIPH+NKCiiw6sSwoA2DJQ4Ri6CGZvbX4KIRMs9DNNBWNDywN6fumL/KWKTaY9ie87Cu4UnJNtqlH2SJBmen2w+uj4xbIuW1nY6t4Crhhz902H2fVM3SBuj16d2Otic7enrjRaTH6T/ubZtLbPzMn0VAajhJmgA8hj7OBHRRveba0Y+4tVAVEB1IDNJMD+yJA3w4XN8wG/05VYRGmJnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntE0upevUUBMg65dUBhcHt2K60qt6418bgwT8nuPgl8=;
 b=ehklcKogSmFrrsEICRe4R4Iz54oQHKu0NHegte2CI2g2VSw/fW7PeDAmtHDz2ndutFQuyFez7CNu1TYEzEjJkIM5JkvKlpdnz4H7zJoA0ERlfXm3vxXjmHhvw38zxRWxmXY03oqqujOyeOktG3e3cn3E4jHIWoKb5z1a/ArYvUk=
Received: from CH2PR07CA0042.namprd07.prod.outlook.com (2603:10b6:610:5b::16)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 11:11:44 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::79) by CH2PR07CA0042.outlook.office365.com
 (2603:10b6:610:5b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Tue, 16 Jan 2024 11:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 11:11:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 05:11:41 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 05:11:37 -0600
Received: from xirdraganc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 16 Jan 2024 05:11:36 -0600
From: Dragan Cvetic <dragan.cvetic@amd.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <michal.simek@xilinx.com>,
	<linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH 0/2] dt-bindings: misc: xlnx,sd-fec: convert bindings to yaml
Date: Tue, 16 Jan 2024 11:11:33 +0000
Message-ID: <20240116111135.3059-1-dragan.cvetic@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: efcb0475-e3d9-455d-ce77-08dc1683ec0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rkIClw61y65AuhTBpSWVfCbZLZ6Woj1olhelmERdazs31e6cTWnf6rK4nIUt7G5qP0ec94w4ahR4V2qN8Y0vScSSJs1o610uJLmD+6TXQh45Gpy6Q8Xtgz+v3trZrYXzWuTBomulPoxWFla+QzfyiOg7rA1xTWTGT9sBdpCaCgtFpA6QVjwmUWDy6slD7cDW2vKupctIKqCAWUMjnqdmxy8I66JMCA/GVsOoNo+JF1wLV21Mzjnvh0DKeo97Cvve4S0tG+sbLfZNDyAQbGUk7AaWvARrq5bCkCZKySrfnt7IakVe+B22HtOrjdcpYkdO1QpsH/kge6DJwbjiK/LmJDgyIn1IsA7tbPR1XGtOWyEpFTpy4JTZG9SieZc6JcOaDKWTFMiH9rSOXkILcj1NcY4828TvObOvQwhPgcSj9S8NWkQ86uCSkSOY2JCbTxXtTYO5+mK+GR3qnph9+TsP0C+a2y7ttIGQ7UZlWEe6OLnqb1DimgXMZDFROZMu+AF/RNMX5U70MEhz82VtGoBZ4ScMlTQOs1S/Pk4YyoVsy6Y2Uvg6iXm4c4+0+ek20oVyXwR9RXS93nwHwkX8I4RbY8bbCUok+ziJvd77OOuqxj8Y1eIqoNJeHBa6t2sUi/Ag/RLLLTcn0cQc9v7eHHh/OskYqGrJ9Kw27GjxSpd0YmDh2rmJaJPcVoMaeATh4Ws/hEQzqJIgziPAOuTPdOnSqZTuH+Gv5x5Tl+RDY2pI3jkB7wd2XOOQ7In2KzxCdoi2h53392A/JDiNm1pnZO/dJA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(46966006)(36840700001)(40470700004)(82740400003)(36860700001)(336012)(47076005)(83380400001)(36756003)(40460700003)(356005)(81166007)(40480700001)(70206006)(54906003)(70586007)(8676002)(8936002)(316002)(110136005)(5660300002)(4744005)(44832011)(4326008)(1076003)(26005)(2616005)(6666004)(478600001)(2906002)(426003)(86362001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 11:11:43.5553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efcb0475-e3d9-455d-ce77-08dc1683ec0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965

This patchset converts AMD (Xilinx) sd-fec bindings to yaml format,
so it can validate dt-entries as well as any future additions to yaml.
Conversion txt to yamal is done "one to one", no new changes has been made
in DT binding file.
Convert sd-fec DT binding file extension from .txt to .yaml in
the MAINTAINERS file

Dragan Cvetic (2):
  dt-bindings: misc: xlnx,sd-fec: convert bindings to yaml
  MAINTAINERS: Update sd-fec documentation file from txt to yaml

 .../devicetree/bindings/misc/xlnx,sd-fec.txt  |  58 --------
 .../devicetree/bindings/misc/xlnx,sd-fec.yaml | 132 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 133 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml

-- 
2.17.1


