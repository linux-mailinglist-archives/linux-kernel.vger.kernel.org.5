Return-Path: <linux-kernel+bounces-120225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A64D588D49A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE0ACB22841
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE022EFD;
	Wed, 27 Mar 2024 02:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdkdCsvy"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45A23765;
	Wed, 27 Mar 2024 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506967; cv=none; b=elviScFVJyeXsTs5oT3391Zz1ZI5gx0UbWPurgGw60huCML88A2abn7+QHyQ1nUE1kXZCjw3fxdj9Ojt4NyHQeL1wZQEocT1NrjTrp58GEth6uJEOGBgdEpksjY6jjvXluAwcn7ZqVT9ac3u35pXxzTveSeP8XeCb4DTfpbMy6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506967; c=relaxed/simple;
	bh=7wD4DM+4/wzThQxX9DjrVUP87VCiEPT5n1Fjkm+x31E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GUwjY4vYOqKE84hFPQOsvv5qtjSq8Slnu6EPQVEbUt5lf4bAT8RU3QrA/7HhsF+tcLUFsM+6Uyc5XHmyv+zBYvM6XUCHuU9kJFEjjexd0ceAXTKo//EyabCPP2s6yf91+fHW/GbB9X7DnB4NSlpgIWCxC2/XJ7NFMIczl7XR03o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdkdCsvy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a0292c4df5so4270439a91.0;
        Tue, 26 Mar 2024 19:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711506965; x=1712111765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ7ZlPJAei2sngbAQRg4mA5E6Q2U7TFS5UlJWvZjxqs=;
        b=RdkdCsvyZFru7jR7MsJkd365Q9QIr0Bw0H7M9a/ch3pMWhsMXuA1f/c8JKplnL6ay4
         +ck/ijmIreUHVD3ZhmDFl45mNGRy88ISTz/YGF0glqiQWRgXl0oIojUKJXBU7b7qjFzg
         yBqotflrIxmmuRcNXPs7BQrSVuA+xZxa+s1G21nypJOENqYrmKXJ457GVyXcWQ/qP/vA
         cldXAOkjrMZqDR6wg2ruEFeDqy9x5rvBLieOjXm+mgGyqhRP+jPITrEKIMBVGNQadfQS
         n9h6bNiw+QaMjiFmaKqKUvNFfRmDvVTbZs3suONYMeey4AQpSzKzMfDeeQIIxtddX/25
         oZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506965; x=1712111765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQ7ZlPJAei2sngbAQRg4mA5E6Q2U7TFS5UlJWvZjxqs=;
        b=sW3h+sOIIt1l8WRxYmLpnE5hVcA+jsJ6roa7/hpoAj8h2fDX6zHbZPXkcW889AVzZy
         ULC1OjA+Aav4wsCZtDdGHpxiHMpLJFbPxDYbVMNdQkpnl7oTLqN78Sn5QT6vUhutJsRl
         ZBxkeElNqp8jLUgvHjOZJwynVXOUd6NsApiws1jvu7cnVbLHetifIKzfKNAiDOtnbz/t
         W3DnioRlvrgX8Nf94WxwUF1t+dGIRTMryXUnaQWzhnQLc++mitQQqC2+hZP8sbkZUDgK
         /RDCLd6pQcZDYvpTPTXCclY9qaxYWC3YcLoA4N+LVC9gjaMaE7i5uvgXqT1CdjbjzQwF
         BPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaFWoqIK94fUbLUNVqS+/vqZYOvS1hH/1ZUMYlL+duJ4FYAiQ/whgc7JpoOnh4XMrb4Mvco90ydk/UgJy6ovqIt/hlte57BfZ5Ix/f
X-Gm-Message-State: AOJu0YzKj3lnKhDcxktR1U00yGO1qrYFyTPFNxyzyaEW9p2AlBihVcF/
	T7VqMlg+D9b4gMWIA1WL6gHWuk7MDXm+dHat0XE0H9ddvE0Kdj5/QacFZd1/
X-Google-Smtp-Source: AGHT+IEoJIjv2zM0t7CuTJ8eCRCoVAfh3GqOnH39zBCcYOD3DN0m6YXtS/cqfHRCbDNFqAjL+02YMA==
X-Received: by 2002:a17:90b:4f42:b0:2a1:2506:b937 with SMTP id pj2-20020a17090b4f4200b002a12506b937mr331891pjb.23.1711506964800;
        Tue, 26 Mar 2024 19:36:04 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id l20-20020a17090a409400b0029b2e5bc1b9sm347441pjg.23.2024.03.26.19.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:36:04 -0700 (PDT)
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
Subject: [PATCH v2 03/10] kbuild: use the upstream `alloc` crate
Date: Tue, 26 Mar 2024 23:35:24 -0300
Message-Id: <20240327023531.187880-4-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327023531.187880-1-wedsonaf@gmail.com>
References: <20240327023531.187880-1-wedsonaf@gmail.com>
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
index a78fcf4004b0..fcb26b53880b 100644
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
@@ -444,7 +434,7 @@ $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
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


