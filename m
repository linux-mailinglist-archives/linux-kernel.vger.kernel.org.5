Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8C07B7C77
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242035AbjJDJnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjJDJnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:43:03 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072719E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:42:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhyqXLJKquBzuvwVAzWvyHtlz6yU7/GoGjTM7E8tkv9H+aRjeMci9MkRDtVOhsyUtO9gYSHBVYawNLxV0Mq1GCcCb+nHF5kzCezw3QdMLXLg62ukgvH0aB1uFsg8oM+Z0iBDEX6b5d2vqFwuIYyfVP4zSt3SkBoNthXheGt7kK8bo19lxgpWb/OTz2CgUkv/mcXkQAksdpj65oHzGWgt2aj2Av0iVsZrM88MplZ5VnXitdbQXO6OnFM0cV9vMCXayNU/EFVsfuTohH7BnDBTCZpvsGzCN7x07IbReqTdHiZA7/9haOhzxbZQbe//a4G64Oze9zc00uqsG6uufQQP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aJ+5Qjs46oF05nT2MhQfbBB87COywfWoqCnk7gdxWs=;
 b=hrzk/AfGN6o7h3zsofGGJKoeha61ej/LRHc8mORDvOudLU5giHUZ+vlNV9KLKkCBrpq0w3pD2jpdrpKsVTknZrdyleG/U2H3S37GB6dhThBX9lsCexVNVrjNuaRo8RY4smXKIcQy7n+nHVFv2znRd03TGD2cXPmmTa6M9XF3VyOXHBSef9l12MRsbwWWifvgsXXV2bxZcC59roywJHFvvHJwOxIYFDTAlDpQr1RAGcqGA7ily6XV4Rk/b7qjkJ7o1pWppGswoEk94nX4xMDSAiDPoLE0kDe3OlGsVumQxkZ4ZpIkudSjVNSHpTfj6+Qu8wUJsFNhGZF9KNJV+l7JMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aJ+5Qjs46oF05nT2MhQfbBB87COywfWoqCnk7gdxWs=;
 b=Oo17J8Rht15krOfPQ282dxXYCy1GnLOhzk8HdzQBLjxt6LCln+qyzrCQ2TpcYaxjz4X5TVA+Z1YyGK4+YPU3PYzn3SE21QrGnhRwWNmKoN8INPtxomZoVHzrNLNOQN34qGKiRJW80KvBS6jeJUD5QdFU33AtCokhxxZ2op3YYMA=
Received: from MN2PR15CA0033.namprd15.prod.outlook.com (2603:10b6:208:1b4::46)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 09:42:54 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:1b4:cafe::8) by MN2PR15CA0033.outlook.office365.com
 (2603:10b6:208:1b4::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 09:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:42:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:42:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:42:53 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:42:52 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <nava.kishore.manne@amd.com>,
        <ben.levinsky@amd.com>, <robh@kernel.org>, <dhaval.r.shah@amd.com>,
        <marex@denx.de>, <izhar.ameer.shaikh@amd.com>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v2 0/6] update for versal net platform
Date:   Wed, 4 Oct 2023 02:41:10 -0700
Message-ID: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2b0526-799e-444d-c379-08dbc4be48a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YS86HtLnVR4UB/kUmcaGZ2LCAVs8/UhQhvXcydPC1ocJsunbOx+RDixTIvsEDjaZBe8MavFh3y5K/5u0gxHpv6psxZLZfD9PZ0un1INvXO6n0tP9R8w3wDBev5MMFalBhc24ZsKNcgWgP88y+DfKHxyKasNHXaSW5hyYMXSdwPf+uZ1+XFGgVOzksu8G+cL5Y35pgr0/BqbOrrypZeHBZgcAZo4wi3flF1WIFpXOiTYxinaC8WnZkQsj6vlAK5Zf9tqt712aWguUB4datoRMFyOuCxBBcNmVMAQMVo6X0ygsbIW/HjTJpWZDimxvhko+ZUKY730jXdwJZby+VzAWGnXzS54pEcVf8f/aPR7PXxJTOSQ/vEuh+Xc5EW6cA5UlnRLhXwHwHZaogKxnuSDxBOMxQKYqTCDj/qNVYKW8dgCDb/pYy80bmlWQoF/LCyYja2PSRaPa0brG3PjdnOjaLzETIZy1nhciVXn2tIOJWK6fEoYvLYE6eK6Y23jelPGSMRGuqIoKFmGQaaRgvvv9LgCh2xul8WeRb1gyEH8t1iLcbZMwxhPKJceLIxjtx9PoUbjQ78Cpm/G2pISNe9GJaeBlEX1q16RJY5zJRoX2FLYQticTyoUpT/8u4L5rwAqVbwAOweP9QkDeMBYzK4yThKZJu9dUbY77ieotUD0Qmz9W2+pV17iyKCDpTc08hxIjCQ03PqQmfkEmCmm8k95D/GEqXrN0cjJ133ePQrX4A1YKzNQxpHoAZDg51PqdLXpML4kNHSHtxiKlHkzfonL4Kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(1800799009)(451199024)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(40480700001)(86362001)(40460700003)(54906003)(70206006)(110136005)(41300700001)(70586007)(316002)(478600001)(966005)(2906002)(5660300002)(8936002)(8676002)(4326008)(44832011)(15650500001)(83380400001)(36860700001)(47076005)(81166007)(356005)(82740400003)(921005)(6666004)(2616005)(336012)(1076003)(426003)(26005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:42:54.4438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2b0526-799e-444d-c379-08dbc4be48a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update firmware and SoC drivers to support for Versal NET platform.
Versal Net is a new AMD/Xilinx SoC.

V1 patch series link: https://lkml.org/lkml/2023/9/29/308
Changes in V2:
- Removed below patch from V1 patch series
  https://lkml.org/lkml/2023/9/29/313
- Corrected maintainer name format in patch #6 as per tool requirement

Jay Buddhabhatti (6):
  firmware: xilinx: Update firmware call interface to support additional
    arg
  firmware: xilinx: Expand feature check to support all PLM modules
  firmware: xilinx: Register event manager driver
  drivers: soc: xilinx: Fix error message on SGI registration failure
  firmware: zynqmp: Add support to handle IPI CRC failure
  drivers: soc: xilinx: update maintainer of event manager driver

 MAINTAINERS                             |   2 +-
 drivers/firmware/xilinx/zynqmp.c        | 210 +++++++++++++-----------
 drivers/soc/xilinx/xlnx_event_manager.c |   9 +-
 drivers/soc/xilinx/zynqmp_power.c       |   2 +-
 include/linux/firmware/xlnx-zynqmp.h    |  15 +-
 5 files changed, 140 insertions(+), 98 deletions(-)

-- 
2.25.1

