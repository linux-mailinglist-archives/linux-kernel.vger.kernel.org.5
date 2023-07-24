Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E09875FFD7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjGXTc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjGXTc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:32:27 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ECD10E4;
        Mon, 24 Jul 2023 12:32:25 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7653bd3ff2fso509104385a.3;
        Mon, 24 Jul 2023 12:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690227145; x=1690831945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snIuRlpqRdn7Uzqe0GJNOw+a8Zw/s3ZtXUk/2L64uAA=;
        b=XS3En4NWsbn2269FsI0rV4mQu0mpvsZqv1sHFbxOZ8qE7B2ebcEVMm64pQ210AFFJ7
         we9MVpX7s0bZrbJKAszufkjlHTibLPnpho+EReW9ly/ZbbDGF9OV5Bp3412bDxD+AW/m
         JtohP8jw1frt4OZrI9ERfTTmhj8E4KFQ34FWx+R9LA58c0ImWffIjuY+n7AyMEhI3JaX
         6iILO/Bf2cmlUQEm3EhdcA15gEQ/i6q43DnrMnAuct7KB2Gxv9bzmVjMpp/ocgY+ibhu
         psV6jyhh4is0xrHXEDyj+4JCXLenF3Zfefs8B2Iiyg4pusXY9KBBLdfuZPJmK+G8MFI0
         g2Sw==
X-Gm-Message-State: ABy/qLYeghk3k4iYojCDCC2m6c26gPnQXgmG4/iuxvNZcOPnzLZt9CFO
        MgWpXGq6z4GUAEihXpvfI/Q=
X-Google-Smtp-Source: APBJJlGX6E7tIF2IevxuDF8AY7Ip2Kl11BPrppogixZjAKcFqjVa5GBZSecZ4Os5uhXP2ETzOwU9HQ==
X-Received: by 2002:a05:620a:248c:b0:76c:4d4c:7942 with SMTP id i12-20020a05620a248c00b0076c4d4c7942mr919919qkn.21.1690227144448;
        Mon, 24 Jul 2023 12:32:24 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:199:8930:2c90:cb9e:b154:73dc])
        by smtp.gmail.com with ESMTPSA id u11-20020a0cdd0b000000b00636d2482dd4sm3749283qvk.17.2023.07.24.12.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 12:32:24 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        workflows@vger.kernel.org (open list:DOCUMENTATION PROCESS),
        rust-for-linux@vger.kernel.org (open list:RUST)
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: [RFC PATCH] rework top page and organize toc on the sidebar
Date:   Mon, 24 Jul 2023 22:31:16 +0300
Message-ID: <20230724193118.2204673-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Template {{ toctree(maxdepth=3) }} in
Documentation/sphinx/templates/kernel-toc.html
uses directives toctree and doesn't use sections on the top page
Documentation/index.rst
to generate expandable toc on the sidebar.

BTW, other template {{ toc }} uses only sections, and doesn't
use directives toctree.

Summary of changes:
- split top page index.rst to several pages
- convert sections of Documentation/index.rst to hierarchical toctree
- vertical bars '|' add empty lines

Benefits:
- collapsed toc is just seven short lines length
- toc is expandable

References:
- https://www.sphinx-doc.org/en/master/development/templating.html#toctree
- https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-toctree
- https://www.sphinx-doc.org/en/master/development/templating.html#toc
- https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections
- https://sphinx-rtd-theme.readthedocs.io/

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/development.rst  | 19 +++++++++
 Documentation/index.rst        | 78 +++++++++-------------------------
 Documentation/internal-api.rst | 12 ++++++
 Documentation/low-level.rst    | 24 +++++++++++
 Documentation/process/main.rst | 16 +++++++
 Documentation/user.rst         | 21 +++++++++
 6 files changed, 112 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/development.rst
 create mode 100644 Documentation/internal-api.rst
 create mode 100644 Documentation/low-level.rst
 create mode 100644 Documentation/process/main.rst
 create mode 100644 Documentation/user.rst

diff --git a/Documentation/development.rst b/Documentation/development.rst
new file mode 100644
index 000000000000..8d8eea6d4491
--- /dev/null
+++ b/Documentation/development.rst
@@ -0,0 +1,19 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Development processes
+=====================
+
+Various other manuals with useful information for all kernel developers.
+
+.. toctree::
+   :maxdepth: 1
+
+   process/license-rules
+   doc-guide/index
+   dev-tools/index
+   dev-tools/testing-overview
+   kernel-hacking/index
+   trace/index
+   fault-injection/index
+   livepatch/index
+   rust/index
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9dfdc826618c..3c0efebba9e9 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -13,94 +13,56 @@ documents into a coherent whole.  Please note that improvements to the
 documentation are welcome; join the linux-doc list at vger.kernel.org if
 you want to help out.
 
-Working with the development community
-======================================
+|
 
 The essential guides for interacting with the kernel's development
-community and getting your work upstream.
+community and getting your work upstream:
 
 .. toctree::
-   :maxdepth: 1
-
-   process/development-process
-   process/submitting-patches
-   Code of conduct <process/code-of-conduct>
-   maintainer/index
-   All development-process docs <process/index>
+   :maxdepth: 2
 
+   process/main
 
-Internal API manuals
-====================
+|
 
 Manuals for use by developers working to interface with the rest of the
-kernel.
+kernel:
 
 .. toctree::
-   :maxdepth: 1
+   :maxdepth: 2
 
-   core-api/index
-   driver-api/index
-   subsystem-apis
-   Locking in the kernel <locking/index>
+   internal-api
 
-Development tools and processes
-===============================
+|
 
-Various other manuals with useful information for all kernel developers.
+Various other manuals with useful information for all kernel developers:
 
 .. toctree::
-   :maxdepth: 1
-
-   process/license-rules
-   doc-guide/index
-   dev-tools/index
-   dev-tools/testing-overview
-   kernel-hacking/index
-   trace/index
-   fault-injection/index
-   livepatch/index
-   rust/index
+   :maxdepth: 2
 
+   development
 
-User-oriented documentation
-===========================
+|
 
 The following manuals are written for *users* of the kernel — those who are
 trying to get it to work optimally on a given system and application
-developers seeking information on the kernel's user-space APIs.
+developers seeking information on the kernel's user-space APIs:
 
 .. toctree::
-   :maxdepth: 1
-
-   admin-guide/index
-   The kernel build system <kbuild/index>
-   admin-guide/reporting-issues.rst
-   User-space tools <tools/index>
-   userspace-api/index
-
-See also: the `Linux man pages <https://www.kernel.org/doc/man-pages/>`_,
-which are kept separately from the kernel's own documentation.
-
-Firmware-related documentation
-==============================
-The following holds information on the kernel's expectations regarding the
-platform firmwares.
-
-.. toctree::
-   :maxdepth: 1
+   :maxdepth: 2
 
-   firmware-guide/index
-   devicetree/index
+   user
 
+|
 
-Architecture-specific documentation
-===================================
+Low level heardware depended documentation:
 
 .. toctree::
    :maxdepth: 2
 
-   arch/index
+   low-level
 
+|
 
 Other documentation
 ===================
diff --git a/Documentation/internal-api.rst b/Documentation/internal-api.rst
new file mode 100644
index 000000000000..c4aa757cbca7
--- /dev/null
+++ b/Documentation/internal-api.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Internal API manuals
+====================
+
+.. toctree::
+   :maxdepth: 1
+
+   core-api/index
+   driver-api/index
+   subsystem-apis
+   Locking in the kernel <locking/index>
diff --git a/Documentation/low-level.rst b/Documentation/low-level.rst
new file mode 100644
index 000000000000..4288633b37af
--- /dev/null
+++ b/Documentation/low-level.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Low level
+=========
+
+Firmware-related documentation
+------------------------------
+The following holds information on the kernel's expectations regarding the
+platform firmwares.
+
+.. toctree::
+   :maxdepth: 1
+
+   firmware-guide/index
+   devicetree/index
+
+
+Architecture-specific documentation
+-----------------------------------
+
+.. toctree::
+   :maxdepth: 2
+
+   arch/index
diff --git a/Documentation/process/main.rst b/Documentation/process/main.rst
new file mode 100644
index 000000000000..732dab311d6d
--- /dev/null
+++ b/Documentation/process/main.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Community
+=========
+
+Working with the development community
+
+
+.. toctree::
+   :maxdepth: 1
+
+   development-process
+   submitting-patches
+   Code of conduct <code-of-conduct>
+   ../maintainer/index
+   All development-process docs <../process/index>
diff --git a/Documentation/user.rst b/Documentation/user.rst
new file mode 100644
index 000000000000..22151edc5bcc
--- /dev/null
+++ b/Documentation/user.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+User-oriented documentation
+===========================
+
+The following manuals are written for *users* of the kernel — those who are
+trying to get it to work optimally on a given system and application
+developers seeking information on the kernel's user-space APIs.
+
+.. toctree::
+   :maxdepth: 1
+
+   admin-guide/index
+   The kernel build system <kbuild/index>
+   admin-guide/reporting-issues.rst
+   User-space tools <tools/index>
+   userspace-api/index
+
+See also: the `Linux man pages <https://www.kernel.org/doc/man-pages/>`_,
+which are kept separately from the kernel's own documentation.
+
-- 
2.41.0

