Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B9F7706E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjHDRP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjHDRPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:15:23 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD87469C;
        Fri,  4 Aug 2023 10:15:21 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a1ebb85f99so1862285b6e.2;
        Fri, 04 Aug 2023 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691169320; x=1691774120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x14eTXjE9ESJ3W86KNB02DEBmvHBG2F1228ijKBbEgI=;
        b=AmAAVvzJY2ryyLXEcu8EfJbuSoJj312gZuM0yrAAjJYgH4BGEvTkqPw9/2ZL+7xOWU
         zYn4EQegMx1mopLXNah/jU/uKsK5oc3u43c/s2bXL1rSo4tCbjLfJ1rSgkeQaAFvZgOX
         0SXmWL13MoKmH65W9GVkzZVbkiZk8L0q8iCZM3icmGk2k9Qfk2OU/BaYWJ+Rug20IQ+h
         fgGCwJnbtvr8P8Q49impoq1KOCkOPTmvW+dE2SWnArBCj/Xxq8Zu3SPeREsjETwqzCUW
         Kf5+omXqQLpoIszdhbm85vXZGhZYrEVShirRC8b7oKDD86t6MubUZFhes9W3KPXc8olM
         Ay/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691169320; x=1691774120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x14eTXjE9ESJ3W86KNB02DEBmvHBG2F1228ijKBbEgI=;
        b=ZjhfSNltzFCyR63AJJsJKLTOd/PbXxjXgeomIpHY2D5YkxsGmr+EUgB6+sK+J7EgTo
         LoUe/OX7hcfUgXbCkMSIjdBLzu98AJXN3rCoy5q0PT3bLT+uxBT+vQ9GOwf8XXCGmNsp
         N1aibKEGhULd/qnMd+CyrZce5V1VZOIu54o3F3WNhHi3SXxkJ1LprTZYgTCsbsS2Q9GT
         61wA3dMOcv3BH4RJWJ/gUUnZgZOF/OG/ok3zuzvJEQ+v58xzefvES1jnrq5NCdj//pG8
         l1yClYWa9xlswoNMLAfnC3XxUYAP5HmllMYbqDMsMIJUIR3GNz1p6BWtPUVqlAtn5w+N
         tXng==
X-Gm-Message-State: AOJu0Yw6R1i4ztuELxR23NWt1kxX3GmCdDAKiVFd9Kc/vCw4WlBkBuRA
        wO7n0ox/jS0+bnVTrMppr9w=
X-Google-Smtp-Source: AGHT+IE28wNxh0Jvg039yaSdSejSrsyKYG9t0gMkmUlxzt12y4vrFOjLOiQeD3sDvJdPsjtp6Hc4yw==
X-Received: by 2002:a05:6808:248:b0:3a3:6244:2b0a with SMTP id m8-20020a056808024800b003a362442b0amr2944200oie.23.1691169320236;
        Fri, 04 Aug 2023 10:15:20 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id u37-20020a056808152500b003a77b3979b2sm856539oiw.26.2023.08.04.10.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 10:15:19 -0700 (PDT)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] scripts: generate_rust_analyzer: provide `cfg`s for `core` and `alloc`
Date:   Fri,  4 Aug 2023 14:15:08 -0300
Message-ID: <20230804171515.55052-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both `core` and `alloc` have their `cfgs` (such as `no_rc`) missing
in `rust-project.json`.

To remedy this, pass the flags to `generate_rust_analyzer.py` for
them to be added to a dictionary where each key corresponds to
a crate and each value to a list of `cfg`s. The dictionary is then
used to pass the `cfg`s to each crate in the generated file (for
`core` and `alloc` only).

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 rust/Makefile                     |  1 +
 scripts/generate_rust_analyzer.py | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index f7c9a6e54c85..e5173da3b682 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -374,6 +374,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 
 rust-analyzer:
 	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
+		--cfgs='core=$(core-cfgs)' --cfgs='alloc=$(alloc-cfgs)' \
 		$(abs_srctree) $(abs_objtree) \
 		$(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
 		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 848fa1ad92ba..fc52bc41d3e7 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -10,7 +10,15 @@ import os
 import pathlib
 import sys
 
-def generate_crates(srctree, objtree, sysroot_src, external_src):
+def args_crates_cfgs(cfgs):
+    crates_cfgs = {}
+    for cfg in cfgs:
+        crate, vals = cfg.split("=", 1)
+        crates_cfgs[crate] = vals.replace("--cfg", "").split()
+
+    return crates_cfgs
+
+def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     # Generate the configuration list.
     cfg = []
     with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
@@ -24,6 +32,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src):
     # Avoid O(n^2) iterations by keeping a map of indexes.
     crates = []
     crates_indexes = {}
+    crates_cfgs = args_crates_cfgs(cfgs)
 
     def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False):
         crates_indexes[display_name] = len(crates)
@@ -45,6 +54,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src):
         "core",
         sysroot_src / "core" / "src" / "lib.rs",
         [],
+        cfg=crates_cfgs.get("core", []),
         is_workspace_member=False,
     )
 
@@ -58,6 +68,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src):
         "alloc",
         srctree / "rust" / "alloc" / "lib.rs",
         ["core", "compiler_builtins"],
+        cfg=crates_cfgs.get("alloc", []),
     )
 
     append_crate(
@@ -131,6 +142,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src):
 def main():
     parser = argparse.ArgumentParser()
     parser.add_argument('--verbose', '-v', action='store_true')
+    parser.add_argument('--cfgs', action='append', default=[])
     parser.add_argument("srctree", type=pathlib.Path)
     parser.add_argument("objtree", type=pathlib.Path)
     parser.add_argument("sysroot_src", type=pathlib.Path)
@@ -143,7 +155,7 @@ def main():
     )
 
     rust_project = {
-        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree),
+        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree, args.cfgs),
         "sysroot_src": str(args.sysroot_src),
     }
 
-- 
2.41.0

