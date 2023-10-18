Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F409E7CE213
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjJRQCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjJRQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:02:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14F4118;
        Wed, 18 Oct 2023 09:02:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92826C433C9;
        Wed, 18 Oct 2023 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697644926;
        bh=UUb5tWHJhw3ZVTTxx162aDZgpzTjS6VXclV4Y7Ipafo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9AT1Bxb2Noz3VcHVd34N9fA5590gJ9qzsyLlSGzHV3fCcR6DnzlNQdZqs7xbI0h/
         XCWPHpZ+nSG2N5W6Zz/qXP410lm7wFo0F8YT7PH6/8LOjraIfXtxLBXoeHqN0d4U7y
         r3ZHwxZoSWnCnAhbSHkpaHP4c79v1Qlj7ws6JQAe/eXiEaotIrVfniCPV90lcZ5a9l
         cdMJEFBbsfxXUcHiSQVLgITuU8aCsuAz15i4D37uk6oPMdN4y9WTGAET+Yg0XYqzmi
         8hBpCUnnz702QkUV+6Y3IcBJEk81IN7fncUpVdaSlOXdkIZWxwS/Zg6jI7mzvM+fVx
         9nL9N9kKnvM4g==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 2/2] kbuild: remove old Rust docs output path
Date:   Wed, 18 Oct 2023 18:01:45 +0200
Message-ID: <20231018160145.1017340-2-ojeda@kernel.org>
In-Reply-To: <20231018160145.1017340-1-ojeda@kernel.org>
References: <20231018160145.1017340-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rust code documentation output path moved from `rust/doc` to
`Documentation/output/rust/rustdoc`. The `make cleandocs` target
takes care of cleaning it now since it is integrated with the rest
of the documentation.

Thus remove the old reference.

Fixes: 48fadf440075 ("docs: Move rustdoc output, cross-reference it")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 373649c7374e..040018111f32 100644
--- a/Makefile
+++ b/Makefile
@@ -1474,7 +1474,7 @@ endif # CONFIG_MODULES
 # Directories & files removed with 'make clean'
 CLEAN_FILES += vmlinux.symvers modules-only.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
-	       compile_commands.json .thinlto-cache rust/test rust/doc \
+	       compile_commands.json .thinlto-cache rust/test \
 	       rust-project.json .vmlinux.objs .vmlinux.export.c
 
 # Directories & files removed with 'make mrproper'
-- 
2.42.0

