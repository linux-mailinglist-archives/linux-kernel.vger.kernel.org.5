Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B1D7D7DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjJZHmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjJZHl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:41:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5A9186;
        Thu, 26 Oct 2023 00:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN1pmpHEDoXPGtXUIyGRVy5Fl6/oMS/RJ7DsHWZEjH2DYft8vhTf6zaszcASBR1DRFlXiEHZ2EtXIoT66WAvQlki5HFdCZGI7hRKvL8q+YFc+XM9Fz8snDB8LGHN3/epfBKcFLw6g72wqFV9AG8lmz9zwfRxeNEIS7bTF9Gp+ID/V8p1dndHPXKXUZ/YO/ampH//Ag/wWBaGhHlp8iWIzuYOJm/T96m6qbSMUegMbdDnG/jA0P5w6CS4pbbLy7irVcJFDvvJtEMkYqUDe0O7fm3NWjrFavVO6wtMCrG3vj13erlXAhWNYCU6sXiAANkzMoAQb4RH+Tf5i4BvArUl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYPC5aA5vCT0RpUFzi3Ffqik11yqzDWUr5NuVUz8Hmg=;
 b=loqsSIuBW5LljVzQbxNqh4j/w19kWhCPRjcdwgNGH7wqJU02p4cmZQNi0L1ybAxPNfUlfauLuOqmiQecLmJtFDR7/w2wn/V47r1KN/CnMDIFahswaQxrd6D9EG99L8UQxJ/KOfME717rSPLQpIx8Uuc6i/tSB3sW7FgxWcctlSpaUL8vUCMF4kajvxY6NaHc018kvMkHs1jUwaaDTQARy65BWANPuW4rrccI8ZRxJHHK52d80JcSVpmqTEijpOy2Y9aZLtQ8jGOoewCAh6Kr19T8XcuqdBKVzKjYzbG0C41n82ZIxY+6gT2ZsONbHEg0dlMMvFU9xVXcMO0VY2Cpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYPC5aA5vCT0RpUFzi3Ffqik11yqzDWUr5NuVUz8Hmg=;
 b=mXA3w3L0EYkOLh5+/qOVn+bEeghC51oU9d76LiUIeEPA/j4uhXSk6li845fQqYYvG2YE5r+3+o7wJA4Ld4tC7Q3fYTTNg+d9W1bo35w5yzHjctfY12RAQGktL6xG6QbTz4Dluzt/wEGQP2CEEisX6qg7SN9J+AVrk3V3/1nHMmA=
Received: from DM6PR21CA0014.namprd21.prod.outlook.com (2603:10b6:5:174::24)
 by PH7PR12MB6612.namprd12.prod.outlook.com (2603:10b6:510:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 07:41:52 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::57) by DM6PR21CA0014.outlook.office365.com
 (2603:10b6:5:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.6 via Frontend
 Transport; Thu, 26 Oct 2023 07:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Thu, 26 Oct 2023 07:41:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 02:41:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 02:41:51 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 26 Oct 2023 02:41:50 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v2 0/2] update for versal net platform
Date:   Thu, 26 Oct 2023 00:41:46 -0700
Message-ID: <20231026074148.7927-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH7PR12MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a7609e-cc36-4061-1133-08dbd5f704dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOW4nh3L8YLO/4s3DyhIEi8dScNXG0q8rWSf1rMyDZp8Z+YSJrvFQeh4bIZ+4iPjk7fIlyV8lc1btv5iEPOyxDKqmoiY9jYak8dKl/0hGJ3tjn6zQ1KtIlgaUWhJI2nPquklIBi3FYpyDVFlN7LCrH99tPOhHFRbS6KVS4/qovb6gS49/+zcn6MzSUW8pZCRvVCkNSBU76cRLebAhj8JJXREUH+BRHVuL+gUGgKX/BAkG0NY0nGQfFQSI6OVLnsFbLWzHnDMUT0Z0V/VL6WFKZu7Z8Uv+YriP1kbUmt+BXEZqvlKPUPPezQ3rGjtc/yO61agzDUWtzxFxTErxxYW3EBdyx3nLiadIeW0hhBIMJx3RpV84oUrIlBxQizCojwrUSDIRqlSvymoauhjFwkHlaJBc5G2Yv65NMjGyN7fbGvksf4ob3he7TcOMVmg6O0I8YH4Hq3dXvkf4Jq43qYOkQ5cwkEhNJ/5s2CKpVFcwxXzHYQT+vtaoXwROffC/MNdDDCGqwH6X5t1e/5Z7JPbbE8L+fUFF4BMM2S/nbJywzEgT5FC9KUZumV6FmQuVy01Xdmlt9+35yKAl4bqbhNaSzGoRSHfZsMCHStFtGTplGxQDfr8nm45GpCSr89rnYgs2Kqp/zShgmMSfqV/EXNpNzSYoVflv59hmn9aoioGxqkEhMZ5cdZGeGb9UluhkL0Vo1YzXkJdXPAf/Py1uM0FR6JFhIS7W4qwdtsekohq55TjpQZxr8jACjAxsD34iGI3zhEmGQo4soYLt41hRk6Fxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(110136005)(966005)(41300700001)(8936002)(8676002)(70586007)(316002)(44832011)(4326008)(70206006)(86362001)(356005)(4744005)(15650500001)(2906002)(478600001)(47076005)(36860700001)(81166007)(36756003)(54906003)(5660300002)(40460700003)(40480700001)(2616005)(336012)(26005)(426003)(82740400003)(6666004)(1076003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 07:41:51.7445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a7609e-cc36-4061-1133-08dbd5f704dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6612
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update clock driver to support for Versal NET platforms.
Versal Net is a new AMD/Xilinx  SoC.

V1 link: https://lore.kernel.org/lkml/20231016113002.15929-1-jay.buddhabhatti@amd.com/
V1->V2:
 - Updated logic to use fls() to get max width of divider
 - Added fixes tag in patch #1

Jay Buddhabhatti (2):
  drivers: clk: zynqmp: calculate closest mux rate
  drivers: clk: zynqmp: update divider round rate logic

 drivers/clk/zynqmp/clk-mux-zynqmp.c |  2 +-
 drivers/clk/zynqmp/divider.c        | 66 +++--------------------------
 2 files changed, 6 insertions(+), 62 deletions(-)

-- 
2.17.1

