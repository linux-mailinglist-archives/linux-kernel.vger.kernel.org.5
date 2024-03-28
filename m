Return-Path: <linux-kernel+bounces-122291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFC888F4C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FF81C309CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54A128383;
	Thu, 28 Mar 2024 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlqR9efp"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771422C1A0;
	Thu, 28 Mar 2024 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589794; cv=none; b=YD7/UQ63jZhVPFOgk0YtChXVTY7vm7fYs3GyAb0tOiPeQR+vPFi+f8NWQfOpAYY3uL3gHlXIOb6/pQZ/jvzOuVZvKszIy4f0rLCwBZsEnkVEzt9M3NLZPzQU73OH+LJXANbskgGyqFHU2Xwnd1t/NeLqvl1q+PSdLNbqvKsdKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589794; c=relaxed/simple;
	bh=a9qCpjSJu/40/Ng/MwFCPHcWMmIMeqcSckh86NCOiYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKduTYcCRrziEfEIXG3hGTx4lDUaBGt9086IfqrNjIWA9OaqEGtRBVce80HYGaJhpYlgy9Y2MySz5C4G6lHrL77ef9+mZ4KRgkKPpCZqgrxt/yS0Rgx1H/DWJ2upsyylgsOrT3tdik3GtBQFS+KsWmS3IC9Isps5zl2ZjiexV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlqR9efp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0878b76f3so3908915ad.0;
        Wed, 27 Mar 2024 18:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589790; x=1712194590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0Zfd3SE3MBctw4EoLjsGrq3YrADGlPg7fDyggHO6FY=;
        b=nlqR9efpkKIU3AiNk39xkTD/9ndN9xj8NnIAoSyCHbnBBDr22SBIYjrOWCyXCVyOsW
         wRgIOWdDhvNTUCYXU6ArnZ8MweSHRFNc4AKMBpOR/rbyOlcvs8E9GKC1HNmnMpjA2VDU
         VwmoOcjqvlHhgyn8zvvgKDEm9RkF+iWr/4gPrciFSuit4yd4fb5J3FnUI7qYDxGKyByo
         GXAz0frK/N9xbUQN3naOf9/YIK1fPEaeeYETualzA6mxMdQelqX09A9750JVs3yMUsRB
         BWg/G91wNHIHYDmUzEglk8/N+IvKQ+SvvML60g4tsElGzAdYY5dhfLIa0pvPtaOuSnOQ
         4s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589790; x=1712194590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0Zfd3SE3MBctw4EoLjsGrq3YrADGlPg7fDyggHO6FY=;
        b=HsnPL/MTqQ/ZvzuedL+ZS5nuj6I+XJOLPNSrItg8JT84ayHONz9POZofQLPm2VxHKl
         aDYOttv60YNmAeQi0IMtmTN04bjlWTaShtu6Cy2+kdSNe+r1LkIzGwaVCGZlBQqzhTmu
         LAdEMZ6cqhJD0PIIGpQPk3WEnqj5aSzeYZqdkPTZH6zzN9IzAAsuKbppBGcZl31QitlS
         0g8hz9y6KNgvSgVCWpN8ovDvQW1ge2ma32eQp7XISk9nFC2ZnKQCHo0YX3/aoFUjnkFL
         g9L5F1TPdZoCHcgBPAWt/VG5Xp1XAu+/Kg3LPieNsUkS/zfCLM0s7J/WNY504JewxlHu
         J2XA==
X-Forwarded-Encrypted: i=1; AJvYcCX26VGLu9gAH10LSShv0hnvgn7os6ro7aXE0Srz4iwbIUJ+sKtOEkwP03r855fMlqy5tCL2udbx5zYV7zg1Kdd0BEi+fRcthqigyIhB
X-Gm-Message-State: AOJu0YxYFNv4q+/6BrRKq2f//CuonIKEE46UzAZ/ZqKJoYF+HBJPUxNb
	g6J8az4jgbVWeG6QEOWB5oAQTGGsCAkjnWJYqn4w6TrkoaSKL4XpKC8xeX1c
X-Google-Smtp-Source: AGHT+IGgnH8gormv9i66h1b8VYCybZk0krGOgUmecrCzd/OdOygzHsyN5kIJtChZ3KnEe++4sMDCBg==
X-Received: by 2002:a17:902:d2c8:b0:1e0:e14:b19d with SMTP id n8-20020a170902d2c800b001e00e14b19dmr1388244plc.18.1711589789986;
        Wed, 27 Mar 2024 18:36:29 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm189144plf.282.2024.03.27.18.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:36:29 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v3 03/10] kbuild: use the upstream `alloc` crate
Date: Wed, 27 Mar 2024 22:35:56 -0300
Message-Id: <20240328013603.206764-4-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328013603.206764-1-wedsonaf@gmail.com>
References: <20240328013603.206764-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

Switch away from our fork of the `alloc` crate. We remove it altogether
in the next commit.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/Makefile                     | 16 +++-------------
 rust/kernel/str.rs                |  1 +
 scripts/generate_rust_analyzer.py |  2 +-
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 846e6ab9d5a9..ca86abac4ed0 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -61,15 +61,9 @@ core-cfgs = \
     --cfg no_fp_fmt_parse
 
 alloc-cfgs = \
-    --cfg no_borrow \
-    --cfg no_fmt \
     --cfg no_global_oom_handling \
-    --cfg no_macros \
     --cfg no_rc \
-    --cfg no_str \
-    --cfg no_string \
-    --cfg no_sync \
-    --cfg no_thin
+    --cfg no_sync
 
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
@@ -123,7 +117,7 @@ rustdoc-compiler_builtins: $(src)/compiler_builtins.rs rustdoc-core FORCE
 # due to things that are "configured out" vs. entirely non-existing ones.
 rustdoc-alloc: private rustc_target_flags = $(alloc-cfgs) \
     -Arustdoc::broken_intra_doc_links
-rustdoc-alloc: $(src)/alloc/lib.rs rustdoc-core rustdoc-compiler_builtins FORCE
+rustdoc-alloc: $(RUST_LIB_SRC)/alloc/src/lib.rs rustdoc-core rustdoc-compiler_builtins FORCE
 	+$(call if_changed,rustdoc)
 
 rustdoc-kernel: private rustc_target_flags = --extern alloc \
@@ -219,8 +213,6 @@ rusttest: rusttest-macros rusttest-kernel
 #   - `cargo` only considers the use case of building the standard library
 #     to use it in a given package. Thus we need to create a dummy package
 #     and pick the generated libraries from there.
-#   - Since we only keep a subset of upstream `alloc` in-tree, we need
-#     to recreate it on the fly by putting our sources on top.
 #   - The usual ways of modifying the dependency graph in `cargo` do not seem
 #     to apply for the `-Zbuild-std` steps, thus we have to mislead it
 #     by modifying the sources in the sysroot.
@@ -239,8 +231,6 @@ quiet_cmd_rustsysroot = RUSTSYSROOT
 	rm -rf $(objtree)/$(obj)/test; \
 	mkdir -p $(objtree)/$(obj)/test; \
 	cp -a $(rustc_sysroot) $(objtree)/$(obj)/test/sysroot; \
-	cp -r $(srctree)/$(src)/alloc/* \
-		$(objtree)/$(obj)/test/sysroot/lib/rustlib/src/rust/library/alloc/src; \
 	echo '\#!/bin/sh' > $(objtree)/$(obj)/test/rustc_sysroot; \
 	echo "$(RUSTC) --sysroot=$(abspath $(objtree)/$(obj)/test/sysroot) \"\$$@\"" \
 		>> $(objtree)/$(obj)/test/rustc_sysroot; \
@@ -448,7 +438,7 @@ $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
 $(obj)/alloc.o: private skip_clippy = 1
 $(obj)/alloc.o: private skip_flags = -Dunreachable_pub
 $(obj)/alloc.o: private rustc_target_flags = $(alloc-cfgs)
-$(obj)/alloc.o: $(src)/alloc/lib.rs $(obj)/compiler_builtins.o FORCE
+$(obj)/alloc.o: $(RUST_LIB_SRC)/alloc/src/lib.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_dep,rustc_library)
 
 $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 925ced8fdc61..e1be6c5e72a9 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,6 +2,7 @@
 
 //! String representations.
 
+use crate::alloc::vec_ext::VecExt;
 use alloc::alloc::AllocError;
 use alloc::vec::Vec;
 use core::fmt::{self, Write};
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index fc52bc41d3e7..f270c7b0cf34 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -66,7 +66,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
 
     append_crate(
         "alloc",
-        srctree / "rust" / "alloc" / "lib.rs",
+        sysroot_src / "alloc" / "src" / "lib.rs",
         ["core", "compiler_builtins"],
         cfg=crates_cfgs.get("alloc", []),
     )
-- 
2.34.1


