Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E823276D74C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjHBSzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjHBSzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:55:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DA22109;
        Wed,  2 Aug 2023 11:55:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8z79eXdqkYpaEKeZtwWKBqoTgLIz0ocQDFKtJbTZN/Na7nbgq3dz9pWyUZ3YHeCDaK4RBTJ+afrIkRFRW1amy3uogvtWAL9gq8vHkpr7pzT5doaVEalgt5oJ/uUj3uQfL6ltb6cAmJ4vSH4COLcr3PVejRtjtztxxK+9znnZ4lH2WCA83SvzA2JGsQOMhhKrUxYbnQNPoF2gwYoPdORTiGSc/TLvDXO5Lp4I6NTns0+dCQLU5yAVBKGGD7U7jcaMg1D3xaz81BFIOnb4Iyi6X57BpdcQ9Mc9WIBTIwnjGNW/dcj6qI2pcA+ruyqXq4twGjn1mZ8KbuxHdq2P8ASoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwdOS5rpEJalS4rxUZYIGX3A/g5oR4uBVMTaDDb+BVw=;
 b=ZCKLIR2AjgPQGzZrqHuGWY01mb9DFGn0XrhjKcnTxo2w+OE7y41ug8yiQsTwk+xjLbn5eEstUdkbcnkYoHZYQ+Hhz8Pp7/HLWfDvPcTwvlW+EQreC96yI6HfyZETLvP7lWIJUSKumSUzxI8WFcuU/VnCxaApUwmpHzco+YJSPYbFIRk9U54951XqCu/ThcRBDCn/g4xu3LZZiS8aVXmHsQIdUFdRq7Xj1jK3swN/0bYh78XwYaIDe28Jh949sgONl3+n7FRa8ALiIVUGf2ZS5xKgDn6KNWo21Hx/YnaToQybfvge2bU3YpmDlh5mGJdJI4vbrE40SVWHwa0z6UFoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwdOS5rpEJalS4rxUZYIGX3A/g5oR4uBVMTaDDb+BVw=;
 b=GoWOFo9+ThyXAhaFgdesOjMbPwzrC70lPKhsRNRP+HfwpUKMyIKYHZaK0FTfuh9p5e1aqjOLFrk+xV8HtLsGp9y1NpZxRVzgmLKIKTR9pnJCM2OlZaR/gsu78iP1Dccw6Ic5/f/zu98pgLHDepaK5TOzKo4cz1iVyk7grLHrW50=
Received: from SA1PR03CA0007.namprd03.prod.outlook.com (2603:10b6:806:2d3::16)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 18:55:16 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::28) by SA1PR03CA0007.outlook.office365.com
 (2603:10b6:806:2d3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 18:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 18:55:15 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 13:55:14 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>,
        <hdegoede@redhat.com>, <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
        <mario.limonciello@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/2] AMD Address Translation Library
Date:   Wed, 2 Aug 2023 13:55:02 -0500
Message-ID: <20230802185504.606855-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 306fca95-6579-4f43-2fd9-08db938a0242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9QgGpIgRBNMj6JZq4c4jmgNMo7Vpz+uIdDg9Z90WpzUYxnVkLlogZsN9cUA6H2eskRefMfuDKp9uM5W6FQttlp8VGmtX32paN5sse9ZDUopQdCGBkm4m28+drUlDPUUESouzgw1j4bq2sy5Sorqs2iwHPbj72DAnA0N7HK/LUGQP0xKHlYYWaAaDyvY2MVA1W2IZUVpY5Dhw4Uc4S0w/IiF9qySlQivv34L2nPXidZhcPYWpV+pVyklpFIszKgS/AxpX2BNY3wN75ePktkGaMECe3XdDkojjlV42Cqc0lsxsTlCKC8W82LmZUnRIPeAOSuXcSsEu2giUJktgaj7VWk3AZZgsWcNy8OEqIkjC/CjKus3xSHDMarA3VFfD1oIx19ROgLFNDUT+otdxO0C9q7243F9GAmko+58B5gdnPhfVlnBlFR73v87bD9vhqXQJO1G3IzaoX+kKX4te4OGulQmAkV0Ll2Laxfj00+ha10mKPDtJ5ej1JGycjhLBbglXe3ktp97nkCx6P9MaFSnwqPY+P8yLdREozWW3hkxdmcwp3QMlgdb/O3KkznSKnDAPrAEe5k89FncYTWCO7KclIS1no75SvNqrcqo7Lu7A9sHMEoV5O7J1GAxnGCey2IWikJTKm+yt+lb+gfDaE5h5Zc8UWNqBQeL36v1dle1BlXaxkKkUUsa7B97QjUIMtXuKrI92GI+bgnU8+rGSsUAv3ceb8dLyP7bhcHT3HaLgnbG73tWDXz60iouSZ6fGfhBPIWp9tBC2kCkB/bJ2qK0IA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(70586007)(70206006)(86362001)(7696005)(6666004)(966005)(2906002)(4326008)(110136005)(54906003)(44832011)(40480700001)(36756003)(40460700003)(478600001)(83380400001)(82740400003)(426003)(47076005)(41300700001)(2616005)(356005)(81166007)(5660300002)(36860700001)(8676002)(8936002)(26005)(1076003)(16526019)(186003)(316002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 18:55:15.4937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 306fca95-6579-4f43-2fd9-08db938a0242
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
subsystems too. Patches coming soon...

Since this code is very much implementation-specific, I thought it'd be
appropriate to have it as a "platform driver". Having the option to
build as a module helps with development, but this will likely be
'built-in' to use for MCA and CXL in production.

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

The reference code underwent a major refactor. Therefore, this latest
set is fresh start. I figure it's best to match the latest reference
rather than submit another revision based on old code that will need to
be refactored anyway.

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

Previous set:
https://lore.kernel.org/r/20220127204115.384161-1-yazen.ghannam@amd.com

Notable changes from previous set:
1) Move code out of EDAC.
2) Another major refactor based on refactored reference code.
3) Addition of DF4 and DF4.5 support.

Thanks,
Yazen

Yazen Ghannam (2):
  platform/x86/amd: Introduce AMD Address Translation Library
  EDAC/amd64: Use new AMD Address Translation Library

 MAINTAINERS                                |   7 +
 drivers/edac/Kconfig                       |   1 +
 drivers/edac/amd64_edac.c                  | 282 +--------
 drivers/platform/x86/amd/Kconfig           |   1 +
 drivers/platform/x86/amd/Makefile          |   1 +
 drivers/platform/x86/amd/atl/Kconfig       |  20 +
 drivers/platform/x86/amd/atl/Makefile      |  18 +
 drivers/platform/x86/amd/atl/access.c      | 107 ++++
 drivers/platform/x86/amd/atl/core.c        | 212 +++++++
 drivers/platform/x86/amd/atl/dehash.c      | 459 ++++++++++++++
 drivers/platform/x86/amd/atl/denormalize.c | 644 ++++++++++++++++++++
 drivers/platform/x86/amd/atl/internal.h    | 307 ++++++++++
 drivers/platform/x86/amd/atl/map.c         | 659 +++++++++++++++++++++
 drivers/platform/x86/amd/atl/reg_fields.h  | 603 +++++++++++++++++++
 drivers/platform/x86/amd/atl/system.c      | 282 +++++++++
 drivers/platform/x86/amd/atl/umc.c         |  53 ++
 include/linux/amd-atl.h                    |  18 +
 17 files changed, 3398 insertions(+), 276 deletions(-)
 create mode 100644 drivers/platform/x86/amd/atl/Kconfig
 create mode 100644 drivers/platform/x86/amd/atl/Makefile
 create mode 100644 drivers/platform/x86/amd/atl/access.c
 create mode 100644 drivers/platform/x86/amd/atl/core.c
 create mode 100644 drivers/platform/x86/amd/atl/dehash.c
 create mode 100644 drivers/platform/x86/amd/atl/denormalize.c
 create mode 100644 drivers/platform/x86/amd/atl/internal.h
 create mode 100644 drivers/platform/x86/amd/atl/map.c
 create mode 100644 drivers/platform/x86/amd/atl/reg_fields.h
 create mode 100644 drivers/platform/x86/amd/atl/system.c
 create mode 100644 drivers/platform/x86/amd/atl/umc.c
 create mode 100644 include/linux/amd-atl.h

-- 
2.34.1

