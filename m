Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F47BA84A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjJERoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjJERnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:43:41 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61FA1FFA;
        Thu,  5 Oct 2023 10:35:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAaHxvC2jrwwfYS4ON6ZmFaIGO710iafpu5iO+sCn8rtjhkJYJB6hONecAGL6ZAd3yQjnK8sOPMgo2xRm9BrzsmDTHuZnWdIETuvx7OzFfKjhz6v+VFehxhPvVeAxXP+I1GGV+WfLu3vQ95IAPd/LQ32hyxCgdOyqIDG+TXJxWxiYDKkOAJIMXr6+xbzwaqoXBNvjQH8CDey6/Ny0Q/Rf45NsKoXGyL6UyjxCnCvJmsy6MDEqIdaREtXfJJsjaTlM08YwYmzi1UmH4X+G4n8i+rpTW6kcu+C8OEbBg8T3Bc8EPJClm5DuLJv6cNZTOKLFBh/7KayKG3BwXA2vDHu/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmDdnWb4h68jH/jzSXTy+QOCJkwINPdG/BNuZwqbLPE=;
 b=kMJF8tbO2YsmvK+HfxfiPUOmPVOAn6gGP/w0zug1z9kleMRr8QXznVBjQkAYinqTJXwnyZA1FiZTkZeOe17he958pC/zljePJsK63tATeqTtKk1AOZvGoiN9WwAdyZaUAv4Lw7S829mvLSgXdrsKw1AAC5layi6+RWBZ6TdgJJgVJDqr59QABWmM5G4ph6P8ud3YXvq17ZS3lSrK9n/cJOHLdG3jztOvDZAnfTZGXcVpcC4TU89iBgLncEJIskmI1BPlWx4v+imc9HKHygNvXz1SQurOvR4rba2Ix8tG3kKjOibWoRs0o3QKVrs7EdXCjXpc/geCdzoihRbcXDsXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmDdnWb4h68jH/jzSXTy+QOCJkwINPdG/BNuZwqbLPE=;
 b=CiQ0R8eojco/QK2+dWI4pGvQpeTTeJ0FbuE7Lu6cVbuPLphpuq2HpaUS7QGi6kP9zO+LzwnRN4ucwZyRMWT226TFuHRBBbMB+ev2D3xNGUmtQnbFem9bU2s/u0og0iYOiEJw6kWzkhEXFiLhmJWm7zdHLFhvcOksmgUPDGOoFzU=
Received: from CH2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:610:50::40)
 by CY8PR12MB7338.namprd12.prod.outlook.com (2603:10b6:930:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Thu, 5 Oct
 2023 17:35:49 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::a4) by CH2PR16CA0030.outlook.office365.com
 (2603:10b6:610:50::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Thu, 5 Oct 2023 17:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 17:35:49 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 12:35:48 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
        <john.allen@amd.com>, <william.roche@oracle.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 0/2] AMD Address Translation Library
Date:   Thu, 5 Oct 2023 12:35:24 -0500
Message-ID: <20231005173526.42831-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CY8PR12MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 288d00a6-303d-4d62-a8ba-08dbc5c983b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wukr3KOTJicM6XLoX7KvptGIl3YBusRf6SRAc2BzwLkoO3XxnXPDtGgJ8RY/q/+v+/oY1c5+OdKGHu6LOfVtsoa0PFa/7wnhq5zYK/RsSC5+idA2W4qTJNZHoElsdRovRkLnEZobEMiLiuFzDl3hE/opibENzuPjOjBUP2Qk+QIHjDl8DBCSohAe3W5qnd3zFsuZMTWhMaAALJcwAfJuweEXUkvtsILqdKaf5jV2r2aHjVPnfOfEOV9w7FXH9xOVDLFlJP7c9unu6cuIlkYSn4O0a5tN1ST+tcpE6JViKR4C4AXuao+E2KSPtHmvz/OZ9cieh5ZA77vYtrtrw1CTcOaQGbpZ+Q2aRq45x7hZ8JMsB4zj2mUbSkMTIwTGEBsU3EPh+c9ry+uwKq5AIVu6nzYQOzfV1r5CYI2m4a+tqXfn6IuKhj2h5q7yun/MQ4hBAsn4swxGOf5p8emrm27PGtDpB44sOPB1WUotUaP1mjhCaCatRgbVWrc9kTKbhXECFCNaVYqiwt+77mmH2NDcpJMjzu2Q4gQA7Db/LO7tuIT/m2i080prqfqz7u9ly9wjljSkZHbnoW3cSWXotIm3VbteyltBLVjtMoA4S415HeIQ+IVhsQ+2mQs1PLofM1B6jMD3AQu5YqNkDpAxbXw4fa7ShDU1vhpKGC9ii5h5srA6ELvXIqqBJuogXHjKb5sh16uH59pyEZbJStXd4RQqBlj2Rqr8q67BoLDVnMcyKpidenLvG90RPWnUseG3h1gPiczjIFdVPixo391t8pwlF/ZkCUTGJHJwBuSP17qASmY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(426003)(2906002)(44832011)(5660300002)(8676002)(41300700001)(8936002)(4326008)(1076003)(110136005)(316002)(26005)(16526019)(70586007)(54906003)(70206006)(40460700003)(83380400001)(40480700001)(966005)(478600001)(7696005)(82740400003)(2616005)(81166007)(6666004)(336012)(36756003)(47076005)(36860700001)(356005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 17:35:49.0963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288d00a6-303d-4d62-a8ba-08dbc5c983b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7338
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This set adds a new library to do AMD-specific address translation. The
first use case is for translating a Unified Memory Controller (UMC)
"Normalized" address to a system physical address. Another use case will
be to do a similar translation for certain CXL configurations. The only
user is EDAC at the moment. But this can be used in MCA and CXL
subsystems too.

Since this code is very much implementation-specific, I thought it'd be
appropriate to have it as a "library module". Having the option to
build as a module helps with development, but this will likely be
'built-in' to use for MCA and CXL in production.

I had planned to include example code stubs for MCA and CXL with this
second submission. But I got occupied with other things, and I don't
want to hold off on the current set. The MCA subsystem integration is
starting development, so working patches should be ready soon.

Patch 1 adds the new code. This includes support for all current AMD
Zen-based systems with a couple of exceptions noted in the commit
message.

The code is based on AMD reference code. Much of this is arbitrary bit
arithmetic. But I tried my best to make clarifying comments and to
restructure the code to be easier to follow.

Also, I purposefully avoided "over-optimizing" for the same reason, and
also to leverage compile-time checks for bitfields, etc. For example,
there are many uses of FIELD_GET(), and this requires a constant
expression as input.

The reference code underwent a major refactor. Therefore, this current
set is fresh start. I figure it's best to match the latest reference
rather than submit another revision based on old code that will need to
be refactored anyway.

Old patch set (before refactor):
https://lore.kernel.org/r/20220127204115.384161-1-yazen.ghannam@amd.com

There are many code paths that are reused between various interleaving
modes and Data Fabric revisions. And these aren't easily decoupled. So
run time checks are used for code flow rather than function pointers,
etc.

All the code is added within a single patch. Mostly, this was done to
get the "whole picture" of how things fit together. But I can break this
up into separate patches for each Data Fabric revision, if needed. I
also want to avoid taking the old code and incrementally refactoring.
Since the old code no longer matches the reference, I think it's simpler
to just add the new and delete the old.

Patch 2 removes the old code and switches the AMD64 EDAC module to use
the new code.

Link:
https://lore.kernel.org/r/20230802185504.606855-1-yazen.ghannam@amd.com

v1->v2:
1) Move code to drivers/ras.
2) Add "reachable" check to header file.

Thanks,
Yazen

Yazen Ghannam (2):
  RAS: Introduce AMD Address Translation Library
  EDAC/amd64: Use new AMD Address Translation Library

 MAINTAINERS                       |   7 +
 drivers/edac/Kconfig              |   1 +
 drivers/edac/amd64_edac.c         | 278 +------------
 drivers/ras/Kconfig               |   1 +
 drivers/ras/Makefile              |   1 +
 drivers/ras/amd/atl/Kconfig       |  19 +
 drivers/ras/amd/atl/Makefile      |  18 +
 drivers/ras/amd/atl/access.c      | 107 +++++
 drivers/ras/amd/atl/core.c        | 212 ++++++++++
 drivers/ras/amd/atl/dehash.c      | 459 +++++++++++++++++++++
 drivers/ras/amd/atl/denormalize.c | 644 +++++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    | 307 ++++++++++++++
 drivers/ras/amd/atl/map.c         | 659 ++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/reg_fields.h  | 603 +++++++++++++++++++++++++++
 drivers/ras/amd/atl/system.c      | 282 +++++++++++++
 drivers/ras/amd/atl/umc.c         |  53 +++
 include/linux/amd-atl.h           |  28 ++
 17 files changed, 3403 insertions(+), 276 deletions(-)
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
 create mode 100644 include/linux/amd-atl.h

-- 
2.34.1

