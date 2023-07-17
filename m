Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3CD75675D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGQPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGQPRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:17:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B221DA;
        Mon, 17 Jul 2023 08:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5ZbqgeNYRezssN0324HiI+SfFZlq95qNHrt2tBYMix9psensYDp1TqK3yEOmUcBb2HMZY9USakyzltJcmkFNsCIityxMbYPh+k9Bst2d7JOF5FGMg6Knv1z0J32BSXciMx2wXOBXGbvaCBSQA79mnm3xmyFO2ZCaTylmNJN5xMRgMsJP9OOlmTlInrpQZ4jzEfdVo0RB3EmzxCkBeTezrNvRjoLZf7Lzl0gxgK7OnHcRA0NRyAakx5orCTSpdb1Xdeb1SnqyJj4xgWxlGp6OwpCZuU7gJPCvyfSSs2rNt+KEH+7hCfstSkft063D3q6RWaNSarVXukB8rrZyJkBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ircVmbbilcx6EDilkSKGSo477GpDbZLTm0NNOitGIZs=;
 b=AYcHIBg3MAa+wvsFEJO3gw4Z8DSKUpW4/VX8XXhYqVte6CWX4wpxC6DCeG72AdN9hj3pFO9pLqj4w192YhvXUfgnVI5pOnXuhQgrv0CEy+sL+2LBmNDlC6tIzRkUcEoq+28eyPEVD7F/IbOZ0obXOAnAj+IZTjbAz1IgAy6SekIrpThLLmXnPfWlWOdFOkNclL2kTWJJSWYch5ua/6OCrVb05I0AIFv0ABZFF0nRmD26Du0XGCQA35hGnKTAS7bEIyAc9sUy4BQtMBAqYT0jWt1+LZG8b5d3qrL796eH3CEnfJ00iq2wJG1saL72e+BciJytcSDPWn4sGOuJ7YU2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ircVmbbilcx6EDilkSKGSo477GpDbZLTm0NNOitGIZs=;
 b=UtiUAhxo475//eIyF/x/qsl1lQXoLTq4TARbjAsXRL+yd9IlT7m+8kD/JXwrY4ihLPgNz1prralqK/ohRpQYheVjUuVPZKbrEk6PXqiSv7F7FOfwIag1XVjuWzQyNDCBi7+1QNnNA9G/EZ+PjgXSjJvW2TYMLQ8j7aAa6ZKaY9E=
Received: from BN1PR14CA0027.namprd14.prod.outlook.com (2603:10b6:408:e3::32)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:17:15 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::1b) by BN1PR14CA0027.outlook.office365.com
 (2603:10b6:408:e3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 15:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 15:17:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 10:16:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 10:16:32 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 17 Jul 2023 10:16:32 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <ojeda@kernel.org>
CC:     <jani.nikula@linux.intel.com>, <rdunlap@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konstantin@linuxfoundation.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v7 0/2] docs: Integrate rustdoc into Rust documentation
Date:   Mon, 17 Jul 2023 10:16:22 -0500
Message-ID: <20230717151624.3470714-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT035:EE_|PH7PR12MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: 754758f9-4110-4e29-291e-08db86d8e685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aS+JbU1n0lutAj8Kqwmk8i1PWeomZva9eI+2RdEMhE9GVM3cdm/OYQL3Xq9WZ4JL5jB5yhiewJXYc0YUqqYRgZuSVyASwwRAO0QWtQ0yDV73P7EgGKYOe8ADBptXSbJFX8tWY5DP6eWBL4QMe6gU3nG0YKLUynQm+tqX4PIWoYKCUt9vaOn6jOuYKmGK8RoCTvh0bqz3Rb18oJ+Bq86X8h6AXBX5dBRPzZucE/GS2L4kklxZtOiOeRSgek5tIqlvWbGAe2Sr+Y9n1f4QdDJVxXHp3ZNeVWDX8CYaSXNAGjH6uhx8RPSVX+KnNGZFlitfqdCaCA7gyWVepXTmnSwyuCv9SJn08tUG0H8uGIZtJshvbh+ojpCv+kDS/M5URIms1JG8bd3Dad2HBNJa1f2Gi8v3jmY1rw/Q3A2AYGG7Jo9vCivfJ+o576HJQxcYxY7LH5GV1Lwsrq91qpHkNShdNxD/2a4UCuYxgKutZaOqKhzcrpAyJehJs+jTe6Yz51HjwB4TxdkvXq0+OamYkDKaJQZ7xsFpCcwZ7W+qorKWsJYU4rt+4dQWRMo/pccbrZ5UQ3FG126KdqfkP5JrDRktGkIxqo0b1vWAFWMnbYy0bypJpOByUQcBDHCL1u5INpHaKRWK4uQVwCsKZ/f58yK24yf7SUCXnaxv2HfKV8KmQgDg774dYUEqtZhkypjswQxpZaWcZwbfGICNbeSzBk8qhOpEg1okdCAtNjGDubPwCeh+BfalGABr8B2YrIxRrwWCjxFzeb6GKyfalf02ut0wXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(26005)(478600001)(82740400003)(1076003)(40480700001)(40460700003)(966005)(7696005)(6666004)(41300700001)(8936002)(8676002)(44832011)(47076005)(5660300002)(70206006)(4326008)(70586007)(316002)(426003)(86362001)(36860700001)(83380400001)(2906002)(81166007)(110136005)(356005)(2616005)(36756003)(186003)(336012)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:17:14.1289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 754758f9-4110-4e29-291e-08db86d8e685
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
V6 is https://lore.kernel.org/lkml/20230127165728.119507-1-carlos.bilbao@amd.com/
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
 Documentation/Makefile       | 20 ++++++++++++++++++++
 Documentation/rust/index.rst |  8 ++++++++
 rust/Makefile                | 15 +++++++++------
 3 files changed, 37 insertions(+), 6 deletions(-)

