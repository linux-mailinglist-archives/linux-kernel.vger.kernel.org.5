Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29BC758096
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjGRPPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjGRPPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:15:45 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B62EC0;
        Tue, 18 Jul 2023 08:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTfUOlFpQ3id+NtP59ClJV66knkZ2u9toNoB/1vhnweDRYyW6oOwF7fRBLaJ7ONYVMMICWOPhr8wgGN091QoGLV9yF9E963eRQEOfG041x7HdXgW2wfQAaVsKQ8bvPhLDl6msq5+THBZUvCeF+454xtY4YSefGBAqan3YkGFUjejREsr89zNNqQMbpV7r3KIVYKQR6H5pn/bioY2tyaPaointcLdmmSxlk9bi3IbbpCd1fvYkqEFwKMtYgK/LZ34wIS0WecTU4nWtFiuhTJeLFDNLowDV7SR8qxd4Okw179jh/oh8vjNo+RHmv2CWALKvM6H8zfSQEmpiusNb4iXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I/VgGnwsk4aIsKdQgj/IxoUQL+LxGruyY6YLyDbQmc=;
 b=a2r4Oj/qoKDZpA4GQve/dU97FRjB/Aak6+RFZpVPoH+DeHDJZa1QnNqVl/EkPASInHK+Q25wdHOM4p9wUvXx8MeMshs1/txBaNfhKE3k4zlXvTUERODoqq2TQmJbU2PV1ZqRIli3dwERyqsnrTgYoRsptSitOqJNJenx8S5oFRb+915t8ymyU0hNaCPJP5nVfULP8QsubbvnW2vWC+114t1lZLuu8OhYf1uiUPd04YLL+RhRXZ43ON2/26rTb6bvK1qmEBYJD3RSdIySVf9PkRce8l0U+kfI9OnOVjec54Bwc0SMA/vAylUoxLcpe26xCtd8ios3GCjf1IteuIa5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I/VgGnwsk4aIsKdQgj/IxoUQL+LxGruyY6YLyDbQmc=;
 b=ns6/f65IJPhOZg1QP4m/Hp0y2Sn5Guif0PA1RHjsszGJCRaepSG0o0CB1qkY/fbK2MNICW7WZyYW04L0ckSHK+daTQAzYmpIwiJIXgJl9fg63YuHA4OYRzuPAogmoTykRDYsMloQRJUjk3vkNhdM8iP7YPO9tP1jiIJekQHbfH4=
Received: from MW4PR03CA0013.namprd03.prod.outlook.com (2603:10b6:303:8f::18)
 by MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 15:15:41 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::c7) by MW4PR03CA0013.outlook.office365.com
 (2603:10b6:303:8f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 15:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 15:15:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 10:15:36 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 18 Jul 2023 10:15:35 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <ojeda@kernel.org>
CC:     <jani.nikula@linux.intel.com>, <rdunlap@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konstantin@linuxfoundation.org>, <rust-for-linux@vger.kernel.org>,
        "Carlos Bilbao" <carlos.bilbao@amd.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v8 1/2] docs: Move rustdoc output, cross-reference it
Date:   Tue, 18 Jul 2023 10:15:33 -0500
Message-ID: <20230718151534.4067460-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718151534.4067460-1-carlos.bilbao@amd.com>
References: <20230718151534.4067460-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|MW4PR12MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b059c2-0eeb-4e64-5845-08db87a1d915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o87mJ5HQmlzMdRUGw61aQ5NTrMk4NI6LFyBYAKINOO5Pt/iqj13Hzo3z0gYtCXoSJVZgfKcNZWo1SRugb1g3ZhOfveM0CDkw0M4gdhJs7MY0HHT6BkTU6sxDx41LksmyatPIqtoEKUgHe5fLZbpoyIlCcbJAWpf8BmdigCfrfG1UMQ1Lsc78R7UH6RzFz5fi58WlfEKP3Ti9JP21T2SUQXmUahyYmvDdDfXzdZNuDAOqTxzyVtn336PSIJ18RDde7jouKN0q5wAUEa2kMN4hw2PnJjFEp9mlGZ56xnzCvd8CWOolzr+8oB1DSCjVeqzHr7P/URoJ4+0ResI+SHRVSiK3c5lbQ255LMviR+u8GOilNGgx3k2g5S7bggXr3LpmJgaaBJ+fsVRDBmU0yB3qMjlshuYTZ3rFUL0PvrxljywoSOKTljkI4G7VSS+BG4dDUAXBF3nqjSi48r1ePOff5LeI2WyZ79iaeKxIZ1s5YhnhCvPmggtG7EVNByXe4LduQ707Ur0R2qu4kRv1f8yytQLPjmw59M5alsrFOibbDLYdcYXK8RtaDSCWVeH/EjrO57whu5DncOJorgGMBMQBRv/m5q5pVYP7/bWBchK/ebhPMQeyM+uU/A/EgpX1nqtWxZmBs+t2GkHVk5ljzGilYhQ/9Udtc6lHWEibmpYlQQygPyOD+a4yewZVaN4Pflvc9SWgyhNOjV7oXXqdJvVWJ6zYG73/4KSOBB6T1tT1Io/7B8xdkTIvB93kOp9bdvnCRFziAicnVk4hXCAFPw6cgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(336012)(478600001)(7696005)(110136005)(54906003)(186003)(1076003)(82740400003)(2906002)(70586007)(26005)(41300700001)(4326008)(316002)(356005)(8676002)(5660300002)(70206006)(8936002)(44832011)(81166007)(86362001)(36756003)(40460700003)(36860700001)(426003)(47076005)(83380400001)(2616005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:15:40.3033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b059c2-0eeb-4e64-5845-08db87a1d915
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921
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

Generate rustdoc documentation with the rest of subsystem's documentation
in Documentation/output. Add a cross reference to the generated rustdoc in
Documentation/rust/index.rst if Sphinx target rustdoc is set.

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/rust/index.rst |  8 ++++++++
 rust/Makefile                | 15 +++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
index 4ae8c66b94fa..e599be2cec9b 100644
--- a/Documentation/rust/index.rst
+++ b/Documentation/rust/index.rst
@@ -6,6 +6,14 @@ Rust
 Documentation related to Rust within the kernel. To start using Rust
 in the kernel, please read the quick-start.rst guide.
 
+.. only:: rustdoc and html
+
+	You can also browse `rustdoc documentation <rustdoc/kernel/index.html>`_.
+
+.. only:: not rustdoc and html
+
+	This documentation does not include rustdoc generated information.
+
 .. toctree::
     :maxdepth: 1
 
diff --git a/rust/Makefile b/rust/Makefile
index 7c9d9f11aec5..dda1aecb8161 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# Where to place rustdoc generated documentation
+rustdoc_output := $(objtree)/Documentation/output/rust/rustdoc
+
 obj-$(CONFIG_RUST) += core.o compiler_builtins.o
 always-$(CONFIG_RUST) += exports_core_generated.h
 
@@ -65,7 +68,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
 		$(rustc_target_flags) -L$(objtree)/$(obj) \
-		--output $(objtree)/$(obj)/doc \
+		--output $(rustdoc_output) \
 		--crate-name $(subst rustdoc-,,$@) \
 		@$(objtree)/include/generated/rustc_cfg $<
 
@@ -82,15 +85,15 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 # and then retouch the generated files.
 rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
     rustdoc-alloc rustdoc-kernel
-	$(Q)cp $(srctree)/Documentation/images/logo.svg $(objtree)/$(obj)/doc
-	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(objtree)/$(obj)/doc
-	$(Q)find $(objtree)/$(obj)/doc -name '*.html' -type f -print0 | xargs -0 sed -Ei \
+	$(Q)cp $(srctree)/Documentation/images/logo.svg $(rustdoc_output)
+	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(rustdoc_output)
+	$(Q)find $(rustdoc_output) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
 		-e 's:rust-logo\.svg:logo.svg:g' \
 		-e 's:rust-logo\.png:logo.svg:g' \
 		-e 's:favicon\.svg:logo.svg:g' \
 		-e 's:<link rel="alternate icon" type="image/png" href="[./]*favicon-(16x16|32x32)\.png">::g'
 	$(Q)echo '.logo-container > img { object-fit: contain; }' \
-		>> $(objtree)/$(obj)/doc/rustdoc.css
+		>> $(rustdoc_output)/rustdoc.css
 
 rustdoc-macros: private rustdoc_host = yes
 rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
@@ -154,7 +157,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
 		@$(objtree)/include/generated/rustc_cfg \
 		$(rustc_target_flags) $(rustdoc_test_target_flags) \
 		--sysroot $(objtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
-		-L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
+		-L$(objtree)/$(obj)/test --output $(rustdoc_output) \
 		--crate-name $(subst rusttest-,,$@) $<
 
 # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,
-- 
2.34.1

