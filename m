Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E5A757383
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjGRGBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjGRGBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:01:40 -0400
Received: from germane-culhwch.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.217.159.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1B810C2;
        Mon, 17 Jul 2023 23:01:38 -0700 (PDT)
Received: from jacinth-ogre.authn-relay.a.mail.umich.edu (ip-10-0-74-216.us-east-2.compute.internal [10.0.74.216])
        by germane-culhwch.relay-egress.a.mail.umich.edu with ESMTPS
        id 64B62716.39D52385.317E5C5C.1115286;
        Tue, 18 Jul 2023 01:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2018-08-29; t=1689659155;
        bh=WWZmjNjUdtOVY6mFV4Fs1VBGqTdLbx+K3/EPKF1ZPXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=l8An3RRY+vM7LBin6JUJOpFfyyUZq2wzeCxFsxZt01beyoTemTgWzfAeQoT2FyIHD
         8TxpLo1D3k8NddnESMD9ZosMtr3MVUFhmbDzAjEvo+iOUB8KcrgNJJwhhcKTgU2yKb
         Be1M8HkTYSDFpEWTCgHwIOs7r3Xs0SDYsISxc11xbJ/o3X7HC0Uwk67QaKl1JzR9uI
         hERsz3tuNTBgJbpvy2zkJlN5XoWnB8GZDaTeGw55mnc8pLrLk7T/TL+TOPYntmZW7T
         JS4LqjNh0HGmoz3ouipZTqkH1BYO1PhBnn5MntA9dA6dn8mRXxsozAAZNau4sCYBtd
         hIiy6cvSYX/VQ==
Authentication-Results: jacinth-ogre.authn-relay.a.mail.umich.edu; 
        iprev=permerror policy.iprev=68.32.216.219 (unknown);
        auth=pass smtp.auth=tmgross
Received: from localhost.localdomain (unknown [68.32.216.219])
        by jacinth-ogre.authn-relay.a.mail.umich.edu with ESMTPSA
        id 64B62713.1A83BD55.686D6C9.46279;
        Tue, 18 Jul 2023 01:45:55 -0400
From:   Trevor Gross <tmgross@umich.edu>
To:     ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        benno.lossin@proton.me, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>
Subject: [PATCH 1/2] docs: rust: update instructions for obtaining 'core' source
Date:   Tue, 18 Jul 2023 01:44:15 -0400
Message-Id: <20230718054416.861412-2-tmgross@umich.edu>
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

The source for Rust's 'core' library is needed to build the kernel with
Rust support. This must be obtained manually when using a non-rustup
install, such as when using 'rustc' from a package manager or from a
standalone installer. Currently, the documentation suggests cloning the
'rust' repository to obtain these sources, but this is quite slow (on
the order of a few minutes).

This patch changes this documentation to suggest using the source
tarball instead, which includes only needed information (<5M) and is
significantly faster to download. This is more in line with what
'rustup' does.

Signed-off-by: Trevor Gross <tmgross@umich.edu>
---
 Documentation/rust/quick-start.rst | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index a8931512ed98..bb67deb19100 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -56,16 +56,17 @@ If ``rustup`` is being used, run::
 The components are installed per toolchain, thus upgrading the Rust compiler
 version later on requires re-adding the component.
 
-Otherwise, if a standalone installer is used, the Rust repository may be cloned
-into the installation folder of the toolchain::
+Otherwise, if a standalone installer is used, the Rust source tree may be
+downloaded into the toolchain's installation folder::
 
-	git clone --recurse-submodules \
-		--branch $(scripts/min-tool-version.sh rustc) \
-		https://github.com/rust-lang/rust \
-		$(rustc --print sysroot)/lib/rustlib/src/rust
+	curl -L https://static.rust-lang.org/dist/rust-src-$(scripts/min-tool-version.sh rustc).tar.gz |
+		tar -xzf - -C $(rustc --print sysroot)/lib \
+		rust-src-$(scripts/min-tool-version.sh rustc)/rust-src/lib/ \
+		--strip-components=3
 
 In this case, upgrading the Rust compiler version later on requires manually
-updating this clone.
+updating the source tree (this can be done by removing ``$(rustc --print
+sysroot)/lib/rustlib/src/rust`` then rerunning the above command).
 
 
 libclang
-- 
2.34.1

