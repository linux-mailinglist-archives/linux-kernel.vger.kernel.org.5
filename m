Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302D27CA6BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjJPLaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjJPLa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:30:27 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F04FEB;
        Mon, 16 Oct 2023 04:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty7s/651kkDsTVqxdH9P9v6vh48wrLfkTO/miySMLVPKLnD8dWpwWUDjD93iIdjbaSgiBFITtntbnGD/+hMBxt72HvvpecmlfbB+B/9z5itIYeL7XJGjtgQhcF8J3uAm8migvzKxUvhjBPu0kpeQ3eQkpk6JGirPfmKjzZAn9l0aGfvTjGQiuHxwK0Bvo6PL+g7O9/QGxU+C/rJXFv5AbAdHM+SlvdkOzneExlVq6VdK6UI2Zk2FdwrxIBjLJkkrrYmYCxJEgfe5R1Lkw0RqP2NPsexxH22rYdb17ogrXhXW2eChn/65cj3bdMLZFTDfec70OvedTiWE8UbOhRjsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaoOu3CMYkndc/sLaTpOzxKw7/xeOWftlTmvq/r/VL0=;
 b=XSt1nrMRg6NE5Q8Me55kteApzZyDENk9Y3h0Ns18NnAdUQjulM9vrvAoocpZX7eWfC5A/QuiS27j6OyzBMLHX86O+OVX6yoFEJiRqA65lnfM2YdaPR1SAG9Ioo/6cO0sRCvUdofipnFkhykxft7cd+Xlhl3ScnKTfRbcliBQDdSL21A9EUWkW5eT/AwBsU8MVtNmnHKwuTo3MFDXo9BDWlN7UTkt2Qc+AsZvF6N+FRkYvOQMKqTMHEYkKO5tRv3oV/ESw6coGNjx5w2No4jdJOkASqtvnyhH6Z3bC9j/VAS43nWkQx2ow7/XyQLnU0pZKZMw0u5G+5zTBYMiaf6wUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaoOu3CMYkndc/sLaTpOzxKw7/xeOWftlTmvq/r/VL0=;
 b=WowqINoO34g4MFFgODF5Vexxw858HimxVFHX5pXsR76eEmS53wHDjCkAzEwDWjaQ3N6wRKFNIqtRpQKEk+7yJ+B16x5dCffYfzowUoRs9EY+VqoRa3/lZWyy7rrmqx/G/dRG5cvs/VJUnRRdFxM3LrA2vv64flqg2bHsx+UMOls=
Received: from CH0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:610:b2::11)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 11:30:23 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:610:b2:cafe::9b) by CH0PR13CA0036.outlook.office365.com
 (2603:10b6:610:b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Mon, 16 Oct 2023 11:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 11:30:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:30:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:30:21 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 06:30:21 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH RESEND 0/2] update for versal net platform
Date:   Mon, 16 Oct 2023 04:30:00 -0700
Message-ID: <20231016113002.15929-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c62c719-ddd1-468a-e6de-08dbce3b4910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jg//DpxMuDx46nrRjFWLn44rsv2oRBHsHwZyXJdCx6U/Qkd8Op6M6tbIRdoZIdjmcUC0YQyuDVPkLQPCxF2+yc1M7ycG+LK1uUZG+g7uAGVH1sD+2X4MO8aAMhiV1nscXLpwUeGdLoRsGL5XBuHL4CEDYLOLAIoX+Z2lfDT7zUUSSECoBoYuq87BMM00t5iqUxjPk+HzsxIo/JeOQiqvBFwweHea+O0kpca2/BFMPrc+e+G0rP0AD7jfshJQTOPSyZkhW7IQzaXkL851GJ/I5TveS+Gxjm4ToQNmDVKACcATgMQAnrjYk6iALdYysLLVkrmYOGrTvTo4tIeeTjHXNNq3o82dbbJIUhLRoHeAFdxGbDvjtz4OqxhIZx6+rFCzyhfq//nT7eovRDj1kLSQgOpTZcJ6hpbGuelL6urU0YexVn8jpCKxzLu6u9bSj+oZwZBha2zLA+1/jHwKMpk3DyFHbYUe5q2IrZW5gJaBZNROGgDVQIPqUR9JAdDk+hfjng3bijLdeUf3pzYEDt/8zlNSF6qfvFlGZFQuGlEMStwBwfviMkMHlgJ10OShjVxhH3NL11b0wXRiBYTc/HQxdL04h5rSwmB6gRBrofZNPTa4evW3DmHkV+snqdlHd2ETfmiWRwWK5Go4y3rtDGEsK++Xlcb+kYkv9QenUAbyByPs48y/ctnOcWbI1zzvNWi4uBNDXA/yrTP1+dQjkheSgks8W1Bg+8lPB9h9aDB/0AkfIWsQhrDj9kcBY7xcyX5Esdpe9fycJVrxFIyYlWUhjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(6636002)(478600001)(110136005)(54906003)(70206006)(70586007)(6666004)(26005)(1076003)(41300700001)(336012)(2616005)(316002)(426003)(8936002)(4326008)(8676002)(2906002)(4744005)(15650500001)(5660300002)(44832011)(36756003)(81166007)(86362001)(47076005)(36860700001)(83380400001)(82740400003)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:30:22.6200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c62c719-ddd1-468a-e6de-08dbce3b4910
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update clock driver to support for Versal NET platforms.
Versal Net is a new AMD/Xilinx  SoC.

Jay Buddhabhatti (2):
  drivers: clk: zynqmp: calculate closest mux rate
  drivers: clk: zynqmp: update divider round rate logic

 drivers/clk/zynqmp/clk-mux-zynqmp.c |  2 +-
 drivers/clk/zynqmp/divider.c        | 70 +++++------------------------
 2 files changed, 11 insertions(+), 61 deletions(-)

-- 
2.17.1

