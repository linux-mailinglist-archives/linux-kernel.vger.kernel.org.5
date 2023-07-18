Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C2F758095
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjGRPPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGRPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:15:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7026B1711;
        Tue, 18 Jul 2023 08:15:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERjfGXwCACr+JbA2ZAWuul7vM/nEnrP+waaAb5MAWtkhzCa2+gNfozqtOlG6Z+eSEMyI3ewgfoy3Iij8QfOk3GAUryXHloHpm2mt/uZ+TzV+Y0eZmbFkUgIgJr890GSpQJ8omoYO3J/iK1QmY1h1SDY3ICdv/KV2OnebIcYdeTKjVdLRzUoeMkkTaZbg12pHBtwW2Lm0eBWllRV6+qjJeZOhUGq8G6UOORIS1r6ROHIHG620kwthsZbSOv3hBmFnJKgB3DNrlieRxIKw6RLySXOvfLcJ0HLrl+AWCRkJXdofVXDWmA+5dy1GtHBzRq06m+m+uclrNCrVFMyhY08bgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWX9MsSHsjjjJVU4J9iB/jNe5RF9dAvoOinWs+RGHNY=;
 b=JpusonQzFP4JTsWvWeLpfgbQFK30lZtW7b5TT9Pi4fGSrnLsV2sSY0HDKvHmolrJOJDQgYV4AVV9bc8B1wztNxwvs9VCxlB8gLcm5GQCFrqnG+LdInYycgffRhB9qWptkRgxq2ytx/BZIUGRnQAoUQz+Q+JxbnDYwRK8OMS9Hx++h3h+fOe03D+JGFWPb+hzs+gXW40MenyrdbhpJ18FnmYuFkOFQ36fGnM9ubirWCL48usL4x+M8Omi+qBLeVw4kj3O2/2cBjCiuHJzqJm9vGf3NNzJjHgtAv/DNLJF54X0cwUqm2v+o3/l/vnie7yb2eQcJw7Q7Cxm7u2RbYdMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWX9MsSHsjjjJVU4J9iB/jNe5RF9dAvoOinWs+RGHNY=;
 b=ZNZJf88au8SMlXmT0Qed/UPu4PV8wiThAcxA2+wKXUJ0LfUhvc4u4O0QDF3OyUXwpP19lT36IHhoZlRjVIy956Hm2yDSVe+kMKi+LG/99GZ65z77/IYtMEcBVeoX1LK1OhrBA4nUaf3HK+Fz/rSxJR/5zL90v6kG9xgj2IJjUS8=
Received: from MW4PR03CA0029.namprd03.prod.outlook.com (2603:10b6:303:8f::34)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 15:15:39 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::49) by MW4PR03CA0029.outlook.office365.com
 (2603:10b6:303:8f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 15:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 15:15:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 10:15:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 10:15:35 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 18 Jul 2023 10:15:35 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <ojeda@kernel.org>
CC:     <jani.nikula@linux.intel.com>, <rdunlap@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konstantin@linuxfoundation.org>, <rust-for-linux@vger.kernel.org>,
        "Carlos Bilbao" <carlos.bilbao@amd.com>
Subject: [PATCH v8 0/2] docs: Integrate rustdoc into Rust documentation
Date:   Tue, 18 Jul 2023 10:15:32 -0500
Message-ID: <20230718151534.4067460-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|BN9PR12MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d4ee4d-0af3-455b-066c-08db87a1d6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfMkzBdXWlLDQ97aXwjiDBqC+M7EY5/yrexRspEMDZrdvCmpWt1EkDqlafJNEF3DA3n/fJEnvf7QyXcmVVR/95XI3LLEkGZJVSY1E9+3qaO/NkXmbUcVX1gz8X4yfPOZRYZO7bqHfhOGNaa23o3xpCHCj2L3iCSUwnR41B97ksGN7HAZjMiUaPEc0gLg78l9QcpIbsHVx1uq+UAdAV0L8QzdpBj8U+VZyBqpF+1EbdaclVZEHt2AP3I8yTBW7ygNZufJbpGUs657+CmtqpUxri277E/A839nfgDRqcI3R5IZ0magDjgyKolD6LOvtr9HfzwNZ0qt91AcLF1AwkU/en9Q3PwInJ9tlHS3JlQLRZB048tw53x3QE5PheSaz1LeGEEedST4ZVTr0WlnPP+MyiFkxrRDPn4jY0xxVO1eZSpYjXuNnO9MHjYcpaVUCMeE4zRJjMKRogXR2qsOY7GTzRHXw+m8T98hqCVYgIApZEj2iXe9veUzHVWqxNkS5QJCa8h28RK5afBuHlhGflDTXIr6Zra5aBl3XShBGOqyQwwjLEik2Q7uaYE1eBoJJbg2stemePL6hK2R1RtQTQ1IXEZt79CdlT/Kka2qt0mYtmvfgpx4NlDnDTeccH6f9KSw2WJUwQFNsCQ5X0fj3CG3arWNJHU2vuh65KI4T/R9qTqQ2BhMenW5EK28g/q733W6HgL2vuogAp2oIf4IpHQBNpOeMpslNtVBaZzI3QEXBlMMwijVJk/VYtgwADZjCbiSOi1vUvsZalFY3qV272Jfbcgo1Rs1ZeZ/fokMEBDKqik=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(478600001)(7696005)(6666004)(110136005)(54906003)(83380400001)(426003)(2616005)(336012)(47076005)(40460700003)(36756003)(86362001)(36860700001)(40480700001)(356005)(186003)(26005)(44832011)(966005)(1076003)(2906002)(316002)(70206006)(81166007)(70586007)(4326008)(41300700001)(8936002)(82740400003)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:15:36.6943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d4ee4d-0af3-455b-066c-08db87a1d6f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
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

Include HTML output generated with rustdoc into the Linux kernel
documentation on Rust.

Carlos Bilbao:
 docs: Move rustdoc output, cross-reference it
 docs: Integrate rustdoc generation into htmldocs

---
V7 is https://lore.kernel.org/lkml/20230717151624.3470714-1-carlos.bilbao@amd.com/T/#m5dcab9c7775e85331c0d067d411fe246ed39af1e
Changes since V7:
 - Use lowercase for rustdoc_output and define it with `:=`.
 - Remove messages that would be printed when skipping Rust documentation.

V6 is https://lore.kernel.org/lkml/20230127165728.119507-1-carl...
Changes since V6:
 - Skip Rust document generation entirely if .config doesn't exist.

Changes since V5:
 - Continue executing htmldocs even if rustdoc fails.

Changes since V4:
 - Limit rustdoc note only to html outputs.

Changes since V3:
 - Added Reviewed-Bys from Akira Yokosawa.
 - PATCH 1/2: Avoid error 404 adding tag `rustdoc` for Sphinx.
 - PATCH 1/2: Don't use "here" as link text, describe destination instead.
 - PATCH 2/2: Check CONFIG_RUST in a way that allows us to skip generation.
 - PATCH 2/2: Reoder Sphinx runs so they complete even if rustdoc fails.

Changes since V2:
 - Split v2 into two-patch series.
 - Add "only:: html" directive in Documentation/rust/index.rst reference

Changes since V1:
 - Work on top of v6.1-rc1.
 - Don't use rustdoc.rst, instead add link to Documentation/rust/index.rst.
 - In Documentation/Makefile, replace @make rustdoc for $(Q)$(MAKE) rustdoc.
 - Don't do LLVM=1 for all rustdoc generation within `make htmldocs`.
 - Add spaces on definition of RUSTDOC_OUTPUT, for consistency.

---
 Documentation/Makefile       | 16 ++++++++++++++++
 Documentation/rust/index.rst |  8 ++++++++
 rust/Makefile                | 15 +++++++++------
 3 files changed, 33 insertions(+), 6 deletions(-)

