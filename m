Return-Path: <linux-kernel+bounces-117864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5858588B098
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7C52C568B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0695A53360;
	Mon, 25 Mar 2024 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0p3DrmI"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0735380C;
	Mon, 25 Mar 2024 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396506; cv=none; b=nvVLRwv1ZNrpHovQ6iyzSbCNBfLGJIibLvZCOQbZuOZ9I5qpwSH1tBm/NPhpRaVJxUAJ6gXuDkZfDNRnXL0akH019Q8e1ihWwutSPH36QtCUQQwBdlk0ClJdvGf/iBdZhNhTBKiyt9yvIKvBAtIeh+zhU0M9MGSmDDMSlWr3tsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396506; c=relaxed/simple;
	bh=OrjXBc+Ej3btNQHkW29NX0jhQieT71i+zd3LEpT985A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KZn9GEJSOb6/9dWZU6EoC7Li9TIjMtyQFsgsowbtvvA0KGRD4XZDWYviSf+ymurLqzwkE+tDH4RSFTajDjtp/RjHF1AupJAKc8ANmib362+VcGkQhx7wmAbgOyYeirugrOyl4ePHMc5AEG1bnKfl/NAqMNd6dvTKCJNQGrVUWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0p3DrmI; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cedfc32250so2951074a12.0;
        Mon, 25 Mar 2024 12:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711396504; x=1712001304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxbzCkmhA605FVaRF+hdQbFGmiVT4nrxS60su9KT43s=;
        b=Y0p3DrmIVKTmUzu7H854yR+g5o4Pda8s3xjnYOaJ2hwBreK/b0xAGUVMvhbrC7bmSN
         oAI9sGKbZEkESdZpcVua8ws/ecXkhIT6X4Yx8Sd9ukugyGkVjEYW3sYeVx3GGqdfkbSJ
         NZ7EpCoW1xiLIMhaM1hqEihwWPFvdEVgnL1i8ep/cOXA/cPnvhGnMK/QjFQ4kFqJjJnF
         FI0Ood53TSSdyDqT7FAoUQSkMbXcyoZutVh8oqzkCKsCeVBnR3z+TcTcNrUfl5LMW5lq
         ZT1K5Zw/hhQYKw6B/80zMM5pkqewJtrfr4o9Bb7IyxmUy1nfbNAmB/J89BvBJIQqRrhd
         uAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396504; x=1712001304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxbzCkmhA605FVaRF+hdQbFGmiVT4nrxS60su9KT43s=;
        b=uwSwoD268b8qz081FbuLdfa27H8biJ7ScSMFC+gVMLDRMeC+oB8B4IHSWpDGS5xn+4
         nFR+gOpC0QdJd4y7O/2pJvYAxpW8M6sFXYj4/cN+B5ldMU7mgTHoQ+UtdJgwl7uFkJY3
         SHNerpR8sZKxGTWxaNbs3XsVS3yOka2XMnedwibo3tVwPpeecZIYO1OQ+YTAUCH4H6EL
         dnrJULOIUFvLoE6yZ/MfcUJo3+2xpPKUkNKhWsSao7OHVtH/togzMNj61NNs2nqAhTQJ
         UGxhXtdKzJGggeEsUk1snYQgrs7JUbkPLOxO7qK0sUgsCcVNWQwwaZKYyhgSE7QCM9dJ
         /rIA==
X-Forwarded-Encrypted: i=1; AJvYcCVmx37AeU1IoXjLsDxI5NsieObm00n65zyQ62l2rhrESQJ5HhIwGsJUp9HccmV7RRuc4WvBspA+jcYZagZDyqdF70wcjcuK2SLNa+1k
X-Gm-Message-State: AOJu0Yy7xwFAY62Zz2snCm3My7fRAt60uPfT0icOhX6bCag3Y4ydDqP9
	LMV55/mDTuvRcRNyaGXufhYqg/dIrmQI/P5+E1LWEIwfYkAAoxj3oAOaD5Be
X-Google-Smtp-Source: AGHT+IG7dfs/1hYiK89y41K34aLnB3+L5OwOmtcHTReN6KkF8HQY6xKW1WqGLlkQFThCf4h6EKSXzA==
X-Received: by 2002:a05:6a21:628:b0:1a3:a0a2:bff3 with SMTP id ll40-20020a056a21062800b001a3a0a2bff3mr6127241pzb.27.1711396503910;
        Mon, 25 Mar 2024 12:55:03 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id q1-20020a170902dac100b001e06c1eee22sm5099585plx.74.2024.03.25.12.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:55:03 -0700 (PDT)
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
Subject: [PATCH 03/10] kbuild: use the upstream `alloc` crate
Date: Mon, 25 Mar 2024 16:54:11 -0300
Message-Id: <20240325195418.166013-4-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325195418.166013-1-wedsonaf@gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com>
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
index 925ced8fdc61..183748328d43 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,6 +2,7 @@
 
 //! String representations.
 
+use crate::alloc::vecext::VecExt;
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


