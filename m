Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B230757384
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjGRGBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjGRGBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:01:41 -0400
Received: from germane-culhwch.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.217.159.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D776D1;
        Mon, 17 Jul 2023 23:01:40 -0700 (PDT)
Received: from jacinth-ogre.authn-relay.a.mail.umich.edu (ip-10-0-74-216.us-east-2.compute.internal [10.0.74.216])
        by germane-culhwch.relay-egress.a.mail.umich.edu with ESMTPS
        id 64B62717.11552E7.18B8CF7B.1115286;
        Tue, 18 Jul 2023 01:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2018-08-29; t=1689659157;
        bh=32KuaL9XprTSau8shHufKOsqD5/ATF/mtI1/00+YRqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=s9+fYcCr1NEJtujl318yCSU4k+WYadNcttOxXc/ppCJNAJYF0SlVX/nydtAY5/Brm
         soSuIGVL8UhFAQj8feVZSllfbzlf1dojWKZYoPDDIrtqLUE8RdTlp467T9Fjzb2mby
         1bYRI24vge4lU14/E+UHmgN+T+w7PkMo56Dem+DwngdyGcEh1bU0D5IAeUPqGi22y4
         pAwikZ3aqFOmMG88a/jeDHDwudAOjIQExvGjs61AqDOX6DFOcDlovZh2fkg1Ku3j36
         ET1Z43nmt1Aos5/mdVC7eBejKFpzHxssAjLbaoqaD2ifXdMtc0dS7oPJ5aQCvbgvow
         amaotLeZB2B2Q==
Authentication-Results: jacinth-ogre.authn-relay.a.mail.umich.edu; 
        iprev=permerror policy.iprev=68.32.216.219 (unknown);
        auth=pass smtp.auth=tmgross
Received: from localhost.localdomain (unknown [68.32.216.219])
        by jacinth-ogre.authn-relay.a.mail.umich.edu with ESMTPSA
        id 64B62715.21F24970.53FCB6DA.46279;
        Tue, 18 Jul 2023 01:45:57 -0400
From:   Trevor Gross <tmgross@umich.edu>
To:     ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        benno.lossin@proton.me, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>
Subject: [PATCH 2/2] docs: rust: clarify what 'rustup override' does
Date:   Tue, 18 Jul 2023 01:44:16 -0400
Message-Id: <20230718054416.861412-3-tmgross@umich.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718054416.861412-1-tmgross@umich.edu>
References: <20230718054416.861412-1-tmgross@umich.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The behavior of 'rustup override' is not very well known. This patch is
a small edit that adds details about what it does, so users have a better
understanding of how it affects their system toolchain (i.e., it does
not affect system toolchain and only sets a directory-specific
override).

Signed-off-by: Trevor Gross <tmgross@umich.edu>
---
 Documentation/rust/quick-start.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index bb67deb19100..700d37dcff5c 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -38,7 +38,9 @@ and run::
 
 	rustup override set $(scripts/min-tool-version.sh rustc)
 
-Otherwise, fetch a standalone installer from:
+This will configure your working directory to use the correct version of
+``rustc`` without affecting your default toolchain. If you are not using
+``rustup``, fetch a standalone installer from::
 
 	https://forge.rust-lang.org/infra/other-installation-methods.html#standalone
 
-- 
2.34.1

