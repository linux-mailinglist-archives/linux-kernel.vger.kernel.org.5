Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4A27706E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjHDRPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjHDRPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:15:00 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C0A198B;
        Fri,  4 Aug 2023 10:14:55 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bcd51b8253so735079a34.3;
        Fri, 04 Aug 2023 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691169295; x=1691774095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x14eTXjE9ESJ3W86KNB02DEBmvHBG2F1228ijKBbEgI=;
        b=QcSAPpLpCr3RWCP7y8P4OwSPQjpwzqXibIMa0bFEpOpflHTDOihv5mjd3banm3Xkbg
         8VsonjJA+6s80799dz6n/occoZFnHOsk85JUr3uA5ukspFqG0p3Q/G+FKSRjInRny6j8
         +yHtHmVQ/JBA2EZquNoiuIRCvBs+Dk5n3Tmu0fshPu7RTFXxoqE2nIugDYgivj/905cg
         0+GiapAr5PkKWZ/iZ1JZv1PEKt2jSnFlJDIuAbzdVTdiHga4F/Kjqr0ySz7pXTZybVbW
         7zv89Gog5Jmu2HinH4IARSYS9sWcHCyvAtrSKF8klOQQ1/hp4niIwpc0EviLrJHf8h9R
         JAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691169295; x=1691774095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x14eTXjE9ESJ3W86KNB02DEBmvHBG2F1228ijKBbEgI=;
        b=cFsEWYCd4Ru7AvnyDps6BSdYoHGYKlPRYyN/zpVK9+GYhf2oP8U5Q2NkYh8ZpmRsbv
         sun7cJPfKnamyaVe4pJ706YkoRcN/PkojJi2TnsBfz3JaFQIBRPOpT5BgMfVLvEotXQv
         UG1AxqxF6xfRBfWUSZTB3CZ7t1632NQ1iy0Fe9mj4RmWCH7DFzo1I1nKZKkVUbFs981U
         hDBmTH9F8fCcUTqObNkmixKVI/QUJXn3+bW8Gb1qOenYmy+8ECUhpMt89Ir6aaiYa/px
         bcIxS51LwVXUt6xbPgjqrIZkV93VuDYn3Qc0UhBNRhPD6dHhouv2JPMbjT4NXly0Q56m
         KEjA==
X-Gm-Message-State: AOJu0YycvzrifzDwoc7/GDsZmPSwAfM5EUzmQ6WJK2uoVjLSmQ88Deb1
        1XrtmJG50DfcK4hP1RJJ+K0=
X-Google-Smtp-Source: AGHT+IGBL51DeYpgL+magEgmgYlhAJgIVl/dxnxpMVavBn0gVCBQUOsJsxhHan5HC4O+ZgtrVM3t2g==
X-Received: by 2002:a9d:7a5a:0:b0:6b7:5112:bc1a with SMTP id z26-20020a9d7a5a000000b006b75112bc1amr2375361otm.24.1691169294850;
        Fri, 04 Aug 2023 10:14:54 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id z26-20020a05683020da00b006b92c078d05sm1354942otq.31.2023.08.04.10.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 10:14:54 -0700 (PDT)
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
Date:   Fri,  4 Aug 2023 14:14:39 -0300
Message-ID: <20230804171448.54976-1-yakoyoku@gmail.com>
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

