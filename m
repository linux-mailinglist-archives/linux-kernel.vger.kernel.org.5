Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E3756758
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGQPQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGQPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:16:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FF7F9;
        Mon, 17 Jul 2023 08:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7qv6ea+IIjuqXKZhOwhYMEkhpXST0MSkaQ1HM7Tmp81q1k1cax3Aeb4HtdXbn8dkyKqfOy9IbDz/pcVR5sawBKSDteL/k9l95Ag8plaN68BWhP7+M95ifM0B55ctfyt6Od3w+khNNc+F3vIrnRJGgnzxU8I1NDAVUzOMuYcA1nHq/SX8DaojIxtXil1gUXji2WxW/a7bms31iiGoV6pwjILxHU6xuMULqsf/H2st8XtE4y2qd1a4w+pxcsSFIa039liITKj9rsYA8a58GXw09nN/18i+/WrwkP/IL1ZpRzRZYHjJ1U3KNFl5vNodcjMfliq5pVbFVxXJNkxKh0SYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouJE4lQsQSp8Q53IctGDqr3oacP/jSEf0ga1NP1BMe4=;
 b=imLpigCv62/Ob0O8pv1r+pFVmejSNReCrZzsgi/MecBdkJiHcpS/+hcq+1S1rGc7k/cpZ2ZEaYsLvidFzmEhT7nKDsb9Cm5hRC8WtQ4ApisXkSxx57T7WpPLTNh6aLjVCZLbQVQbmYjJLR2mXIFX0p3oa3UKHenjrG0Ev9itCuVXAwE0dbX2vZwD7J4NzUbt9OqtDLIYb4MQ9F/0xrDcUKGaMaRMetilTGUwFHA6jlJDLcnkN3mtkjNKjIb6xmK7ylcf9EVGb6y/QtCc37XiKscegb+xwwTya+1nEUkq1vQtJhNbdUhUAgUyHiI77OuLhyV4AmXjmlEM0guHwrQ7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouJE4lQsQSp8Q53IctGDqr3oacP/jSEf0ga1NP1BMe4=;
 b=fEa4caauXBlOPfpQfZ3tMTcpEdkCUi3TSk7WLTcbhcK4eakaofsB8xl8ulPGqIfdrjTq6g3ONuZbhhM0uOojh0nm7e/hDb14605BBVSPWM98tZ0I7hvXjPWLeIQOEiLw08lVmSbu+BYwnDk8p9cZ588eWnPyQL6yEszY/siJH5Y=
Received: from MW2PR2101CA0021.namprd21.prod.outlook.com (2603:10b6:302:1::34)
 by CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:16:43 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::43) by MW2PR2101CA0021.outlook.office365.com
 (2603:10b6:302:1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.8 via Frontend
 Transport; Mon, 17 Jul 2023 15:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 15:16:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 10:16:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
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
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v7 1/2] docs: Move rustdoc output, cross-reference it
Date:   Mon, 17 Jul 2023 10:16:23 -0500
Message-ID: <20230717151624.3470714-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717151624.3470714-1-carlos.bilbao@amd.com>
References: <20230717151624.3470714-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|CH2PR12MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: b796c906-5278-4a29-e17a-08db86d8d432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkhqHy1pAX5nYDeDIpD+GFCcda6E0mzlGc2p77+py6QJ4wPsCHECPZWVqboAAs8eT/MLVEyOF4o7KE5WcVP6C/NTNId4RuGvwCVwmilIQjIZjQITPndyFm8A9E9+DXzcvnx1oxh6XKJv9o2B3IuD66TB8PdJ85u3qt/tLf/GdSP1Hd9ENtbGhAKyRM2gX5uwEC7TZuxAJhngktik0C5vA+7QNKJZ/YVNexSPHcxa/+vctBtb/5uWTs8ZhdcxhPjP2xT7Gk3mLOItfs9p7KpX2ed9z+YOIeJDx86ViK0tL8HOdAMPD8CtVX3VIuXBe8rSkZ8zEmHYsZxCpjXdR4+qFn3otfaf/TeMPWdJYna+ZZi3mhcJWZdB3WxYToVY3NerkIKnPVP0Evk4MPcgGP+zIhHsvAQIUvt42sb1h60Djt8Yg6DpAYEMJqK2vVtuYiLCeV5UIpZri+wCc4GO8YTPAPPjn4c/CpUtdjsLkXtKsSkyeTIom/gNtCbtu676suvjCGjoXM4YPaCUWkixO9uPCgKbuEaqMmZbhXzA8x/zBlOeuOtXBbsPuBd3XVwIMv4oQMvrJiY1HnomT2i/fXwilBmGtypJeANsJae7N8WBtK7iOXqq49aURbVgPFnlTPDQdnyV7CGxFRqtVCTYTT2FdGA7TxDOEeHuDsz/4nZQn7cZAnUiZGCzjmPzOIcYlA4VgJx+M/Lp5Jwt6Uho7xaqQushM30U7qcFrS2xyXvqG2Zr1WLugcZS/8LF/FSKgzHB+yjmPSzlk/rpp4Ooh/t9pQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(110136005)(478600001)(7696005)(6666004)(54906003)(1076003)(336012)(186003)(26005)(70586007)(2906002)(44832011)(41300700001)(70206006)(4326008)(316002)(5660300002)(36756003)(8936002)(8676002)(356005)(81166007)(82740400003)(40460700003)(86362001)(426003)(36860700001)(2616005)(47076005)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:16:43.2657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b796c906-5278-4a29-e17a-08db86d8d432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 7c9d9f11aec5..3d502818e5d4 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# Where to place rustdoc generated documentation
+RUSTDOC_OUTPUT = $(objtree)/Documentation/output/rust/rustdoc
+
 obj-$(CONFIG_RUST) += core.o compiler_builtins.o
 always-$(CONFIG_RUST) += exports_core_generated.h
 
@@ -65,7 +68,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
 		$(rustc_target_flags) -L$(objtree)/$(obj) \
-		--output $(objtree)/$(obj)/doc \
+		--output $(RUSTDOC_OUTPUT) \
 		--crate-name $(subst rustdoc-,,$@) \
 		@$(objtree)/include/generated/rustc_cfg $<
 
@@ -82,15 +85,15 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 # and then retouch the generated files.
 rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
     rustdoc-alloc rustdoc-kernel
-	$(Q)cp $(srctree)/Documentation/images/logo.svg $(objtree)/$(obj)/doc
-	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(objtree)/$(obj)/doc
-	$(Q)find $(objtree)/$(obj)/doc -name '*.html' -type f -print0 | xargs -0 sed -Ei \
+	$(Q)cp $(srctree)/Documentation/images/logo.svg $(RUSTDOC_OUTPUT)
+	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(RUSTDOC_OUTPUT)
+	$(Q)find $(RUSTDOC_OUTPUT) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
 		-e 's:rust-logo\.svg:logo.svg:g' \
 		-e 's:rust-logo\.png:logo.svg:g' \
 		-e 's:favicon\.svg:logo.svg:g' \
 		-e 's:<link rel="alternate icon" type="image/png" href="[./]*favicon-(16x16|32x32)\.png">::g'
 	$(Q)echo '.logo-container > img { object-fit: contain; }' \
-		>> $(objtree)/$(obj)/doc/rustdoc.css
+		>> $(RUSTDOC_OUTPUT)/rustdoc.css
 
 rustdoc-macros: private rustdoc_host = yes
 rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
@@ -154,7 +157,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
 		@$(objtree)/include/generated/rustc_cfg \
 		$(rustc_target_flags) $(rustdoc_test_target_flags) \
 		--sysroot $(objtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
-		-L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
+		-L$(objtree)/$(obj)/test --output $(RUSTDOC_OUTPUT) \
 		--crate-name $(subst rusttest-,,$@) $<
 
 # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,
-- 
2.34.1

