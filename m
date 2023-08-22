Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0003A783E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjHVKp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHVKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:45:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41971CE3;
        Tue, 22 Aug 2023 03:45:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lziOl3FAKEOMWEmeoAjIYea1AvVBCTidvmfJwpXYWAz4wzANV/IHzyzgu5mluZ1IypLjXJ5C7LOab1o2UBi2KuTkainNwaEFA8D07WlZseeTtSfYcfIoBb37EsIY6coIClrSvGzfS7CXILnljjGLtgC+Vp3Syc7nJeI2Y13eOpEa66Ye/H+Fq5fvBrGaLoB437/5h+odL1jotOBwrvdfPBm6BR3xHvQlQYFCJqlN/uMuyOo67qgBg9VT3g+jBQDjgvRI9TqAKQeHTCbZGyb8XnJxyBaqAl8Lgu18p9tHzK7sIZnYXO1pl8sJxOGbgNvQe1/RkuUfGwQa2UMCT70Wuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrqG3ViIpI/Tu7LQnF+0rdg5FcVriq0455LPzRSRc5M=;
 b=jJhxDXQVIJWW2iuCsK0AZx2y0+yiww7CMtaeSwb9XL13/j2etofOgcmYleL8UOE2P8j16XB9kEEjJX7nmzne6xWKlxHDGwFwZ7+KLkS+hdbx7YtuhYaxnA7MMxkyg6MMrklklN7QhXPMoNmLH8WAOqjvcc3Wr8FyBCW2oQXYxcwSNVhC9AI+AXuzh/TTs7qlyTD7SavwnHyD/PjIRFKDGx/QDuzR2O0KMRad3a1vn0Rn6iaEOui1IROrmn4fsV8FgGHbUdMpGo4/5UgKxptnQF7uf0/o1YHLmTTKLV3k27t1puh7hzAughACWaP2DCtHvMgZK//BrV/eRLtdEFg4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrqG3ViIpI/Tu7LQnF+0rdg5FcVriq0455LPzRSRc5M=;
 b=V5uuIoMKGdN5f33yhwZVy3PlZCr3/Ev1rzBmHlr0rL3Ew7rvYKULNOv/3ymPmydxR+uIUs0hAn46/s8G2aSlek0KT4IcDA2BDlkzdPde9460FieA5mG/igUV2e3BzyXjtz3A3qccFJfVOHxLJWEszMV8DVXcaKJpuVscTvp/UEU=
Received: from CY5PR22CA0036.namprd22.prod.outlook.com (2603:10b6:930:1d::8)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 10:45:49 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::9b) by CY5PR22CA0036.outlook.office365.com
 (2603:10b6:930:1d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 10:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 22 Aug 2023 10:45:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 05:45:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 03:45:48 -0700
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 22 Aug 2023 05:45:44 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <gcnu.goud@gmail.com>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH v2 0/3] can: xilinx_can: Add ECC feature support
Date:   Tue, 22 Aug 2023 16:15:33 +0530
Message-ID: <1692701136-1422086-1-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 784bfa6e-92bf-4362-2080-08dba2fcf300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWWaa/4A8W3jkmCdPqH3IVymYF2heYwpH6kr5C/Xq1hrD4hnznysCrcD+1imqms9tZxVB35aO8UPopfrwmDz2fDsbBnyYW1BQYaE7c9k7fI40R6nmHEn01dGyghHYTpG9S0kjaNbgcICij5fE4Eo4o/CyKzuc6O2sMFtgcQu4bqgceRHkMlbRT415HjyTmVnOnYW00J2h1toM/Tv3ihmipJSi5SvAmmZo25T4nHxR73XoBEKYmIGzEmHYLcP/Tm+7zMRlJ6plPQeqXdzbbcsjn5ac6188KCx7WzkWCUa0zm4iU695y7+7xdwG72sLpXlPK0OY8zXW4HhHU2nfB3BqU2MPV41WwxMa2lkuKdpaJXNk5I1D3kexiGc+EAL2QI+m6597hfxiM++qumyO45AFAY221fcPAyEDd5uegm3CYdkTqs+JfL5Yy2KBNU5BFnimS+I06fb31VazYGOisUkUEToxLcGDqFyuKIxf5BRVAv9T7oXblSmgEWtMc9ndB9VDq4J1WtY8nJe4yr1uSpKMy87+JdWHVpXgofTJacqdrZWWmes4XmajBkX+902AZq6mNd7Z8WZu9pln98bpImZnX6nzKH1iFC3qwqQ3OY+obU5y88SmO0RPyWt0+54vbOur0o7pSVzIeJbqSaErXonNavb2xf5cWNxlAR9JVew53CbTm7NmCyP+S5mY8/7HupMCFLanSBjYi/GEKL752U5QJ0gh89/FN4rK6smgqI6EeZ/MBqrLOUitKfx7wXOIMAFpG2E71M833Zz0HPZyOwwqz6NFnqcxo9Pp7oGhXGRbRg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(2906002)(4744005)(7416002)(40480700001)(83380400001)(5660300002)(44832011)(336012)(426003)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(70586007)(316002)(54906003)(110136005)(478600001)(356005)(82740400003)(921005)(81166007)(6666004)(40460700003)(36756003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 10:45:49.4293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 784bfa6e-92bf-4362-2080-08dba2fcf300
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ECC feature support to Tx and Rx FIFO’s for Xilinx CAN Controller.
Part of this feature configuration and counter registers added in 
Xilinx CAN Controller for 1bit/2bit ECC errors count and reset.
Also driver reports 1bit/2bit ECC errors for FIFO's based on 
ECC error interrupts.

xlnx,has-ecc is optional property and is added to Xilinx CAN Controller 
node if ECC block enabled in the HW.

Add ethtool stats interface for getting all the ECC errors information. 

There is no public documentation for it available.

---
BRANCH: linux-can-next/testing

Changes in v2:
Addressed review comments
Added ethtool stats interface
Updated commit description


Srinivas Goud (3):
  dt-bindings: can: xilinx_can: Add ECC property ‘xlnx,has-ecc’
  can: xilinx_can: Add ECC support
  can: xilinx_can: Add ethtool stats interface for ECC errors

 .../devicetree/bindings/net/can/xilinx,can.yaml    |   5 +
 drivers/net/can/xilinx_can.c                       | 154 +++++++++++++++++++--
 2 files changed, 144 insertions(+), 15 deletions(-)

-- 
2.1.1

