Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225E1772085
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjHGLQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjHGLPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:15:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD192684;
        Mon,  7 Aug 2023 04:14:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68783004143so2969639b3a.2;
        Mon, 07 Aug 2023 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691406813; x=1692011613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbHv3wvRcvM75BkSn4zM3JPIA0eKalklIcdZaiMIV1Y=;
        b=UWiLYD69U/Ptu1IqP/NqT9pb/7DkkiWX1cUe2kV04iEBjPOM2p/QSjE2mc70FuQsPA
         I6Xto/Zk8ZHdmeKqABoppPi5SAWcnpfTOdOTjiI9oSaTImVPdubQHPDpw0Pkx7IKtKc0
         lAMcMbO5S+RYePUcw0D41vIS5cEU2PVMRyGTR25m4d1gOpfW54ffpnStaQeLJfY4t5SU
         S6WYE89u97HmU/rUNdIVim4amJxUnOZoKU4nlLz8DbFS2GShyWQWb6PAhwUztt7UFMZx
         L/wJ2u0XRJrOmJSetW2f+jcRT/xhog5fLx4XxKJiMAt8UKX3KMV1gcJvnNowy2UQwvEr
         3NGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406813; x=1692011613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbHv3wvRcvM75BkSn4zM3JPIA0eKalklIcdZaiMIV1Y=;
        b=jHb9uE+z1UAVbJONQ6oMPDMo0L6gKj6+agR3E6xGAokqLhRUwpwVuwXw0CPGbcXREV
         tunbhm+E+GR5ISDzzXYgy0sL0HD196VmeyhxEu1LhFqdw1Wv1tlJe8mFYR/skmoWVR82
         k1mgj0Q5XWxVUKBcdfA5IOEYZCMpdxt463CvqxKIMcmjxDd2ZHhgnye0jHIJmPqnEMUK
         Vpp6y9M43402sDE8ZtHKhoctE1PoEur5IfVxM7xq51WH/yOF+vUTZcwHi5ghYPjKsdv7
         qwGUbbXlujQOM7r8qDoEH+WSVwn1LypHkNn5NnFMfWB9WfFCyQ1xAaH8CwyQ1lW93O1F
         hv6A==
X-Gm-Message-State: AOJu0Yzz7KJnXidB2wiyMnr042vd/E6YUwUBb08iccZSGRbLDhIRjAe1
        q1iqSkQO1fei4CCoHalTW/g=
X-Google-Smtp-Source: AGHT+IEskgGrBWYJ6PO6WkImYpM8S+918p7wYiwq3v4Owtm78MeN/hL58EHQJMCVSDyWZbuEfZDtyg==
X-Received: by 2002:a05:6a21:8187:b0:137:bc72:9c08 with SMTP id pd7-20020a056a21818700b00137bc729c08mr7722973pzb.16.1691406812946;
        Mon, 07 Aug 2023 04:13:32 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id 4-20020aa79144000000b00660d80087a8sm5939173pfi.187.2023.08.07.04.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:13:32 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v8 8/8] kbuild: modinst: do modules_install step by step
Date:   Mon,  7 Aug 2023 16:43:16 +0530
Message-ID: <20230807111316.315836-9-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807111316.315836-1-yesshedi@gmail.com>
References: <20230807111316.315836-1-yesshedi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently Makefile.modinst does three tasks on each module built:
- Install modules
- Sign modules
- Compress modules

All the above tasks happen from a single place.

This patch divides this task further and uses a different makefile for
each task.
Signing module logic is completely refactored and everything happens
from a shell script now.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/Makefile.compress |  53 +++++++++++++++++++
 scripts/Makefile.install  |  66 +++++++++++++++++++++++
 scripts/Makefile.modinst  | 108 +++-----------------------------------
 scripts/Makefile.sign     |  37 +++++++++++++
 scripts/signfile.sh       |  24 +++++++++
 5 files changed, 188 insertions(+), 100 deletions(-)
 create mode 100644 scripts/Makefile.compress
 create mode 100644 scripts/Makefile.install
 create mode 100644 scripts/Makefile.sign
 create mode 100755 scripts/signfile.sh

diff --git a/scripts/Makefile.compress b/scripts/Makefile.compress
new file mode 100644
index 000000000000..35d337ac9b6c
--- /dev/null
+++ b/scripts/Makefile.compress
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Compressing modules
+# ==========================================================================
+
+PHONY := __modcompress
+__modcompress:
+
+include include/config/auto.conf
+include $(srctree)/scripts/Kbuild.include
+
+modules := $(call read-file, $(MODORDER))
+
+ifeq ($(KBUILD_EXTMOD),)
+dst := $(MODLIB)/kernel
+else
+INSTALL_MOD_DIR ?= updates
+dst := $(MODLIB)/$(INSTALL_MOD_DIR)
+endif
+
+suffix-y				:=
+suffix-$(CONFIG_MODULE_COMPRESS_GZIP)	:= .gz
+suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:= .xz
+suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)	:= .zst
+
+modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
+
+__modcompress: $(modules)
+	@:
+
+#
+# Compression
+#
+quiet_cmd_gzip = GZIP    $@
+      cmd_gzip = $(KGZIP) -n -f $<
+quiet_cmd_xz = XZ      $@
+      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
+quiet_cmd_zstd = ZSTD    $@
+      cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
+
+$(dst)/%.ko.gz: $(dst)/%.ko FORCE
+	$(call cmd,gzip)
+
+$(dst)/%.ko.xz: $(dst)/%.ko FORCE
+	$(call cmd,xz)
+
+$(dst)/%.ko.zst: $(dst)/%.ko FORCE
+	$(call cmd,zstd)
+
+PHONY += FORCE
+FORCE:
+
+.PHONY: $(PHONY)
diff --git a/scripts/Makefile.install b/scripts/Makefile.install
new file mode 100644
index 000000000000..40c496cb99dc
--- /dev/null
+++ b/scripts/Makefile.install
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Installing modules
+# ==========================================================================
+
+PHONY := __modinstall
+__modinstall:
+
+include include/config/auto.conf
+include $(srctree)/scripts/Kbuild.include
+
+modules := $(call read-file, $(MODORDER))
+
+ifeq ($(KBUILD_EXTMOD),)
+dst := $(MODLIB)/kernel
+else
+INSTALL_MOD_DIR ?= updates
+dst := $(MODLIB)/$(INSTALL_MOD_DIR)
+endif
+
+$(foreach x, % :, $(if $(findstring $x, $(dst)), \
+	$(error module installation path cannot contain '$x')))
+
+modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
+
+__modinstall: $(modules)
+	@:
+
+#
+# Installation
+#
+quiet_cmd_install = INSTALL $@
+      cmd_install = mkdir -p $(dir $@); cp $< $@
+
+# Strip
+#
+# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after they
+# are installed. If INSTALL_MOD_STRIP is '1', then the default option
+# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be used
+# as the options to the strip command.
+ifdef INSTALL_MOD_STRIP
+
+ifeq ($(INSTALL_MOD_STRIP),1)
+strip-option := --strip-debug
+else
+strip-option := $(INSTALL_MOD_STRIP)
+endif
+
+quiet_cmd_strip = STRIP   $@
+      cmd_strip = $(STRIP) $(strip-option) $@
+
+else
+
+quiet_cmd_strip =
+      cmd_strip = :
+
+endif
+
+$(dst)/%.ko: $(extmod_prefix)%.ko FORCE
+	$(call cmd,install)
+	$(call cmd,strip)
+
+PHONY += FORCE
+FORCE:
+
+.PHONY: $(PHONY)
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index e94ac9afe17a..fc9cd7638ea5 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -1,119 +1,27 @@
 # SPDX-License-Identifier: GPL-2.0
 # ==========================================================================
-# Installing modules
+# Install, Sign & Compress modules
 # ==========================================================================
 
-PHONY := __modinst
-__modinst:
-
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
-modules := $(call read-file, $(MODORDER))
-
-ifeq ($(KBUILD_EXTMOD),)
-dst := $(MODLIB)/kernel
-else
-INSTALL_MOD_DIR ?= updates
-dst := $(MODLIB)/$(INSTALL_MOD_DIR)
-endif
-
-$(foreach x, % :, $(if $(findstring $x, $(dst)), \
-	$(error module installation path cannot contain '$x')))
-
-suffix-y				:=
-suffix-$(CONFIG_MODULE_COMPRESS_GZIP)	:= .gz
-suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:= .xz
-suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)	:= .zst
-
-modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
-
-__modinst: $(modules)
-	@:
-
-#
-# Installation
-#
-quiet_cmd_install = INSTALL $@
-      cmd_install = mkdir -p $(dir $@); cp $< $@
-
-# Strip
-#
-# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after they
-# are installed. If INSTALL_MOD_STRIP is '1', then the default option
-# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be used
-# as the options to the strip command.
-ifdef INSTALL_MOD_STRIP
-
-ifeq ($(INSTALL_MOD_STRIP),1)
-strip-option := --strip-debug
-else
-strip-option := $(INSTALL_MOD_STRIP)
-endif
-
-quiet_cmd_strip = STRIP   $@
-      cmd_strip = $(STRIP) $(strip-option) $@
-
-else
-
-quiet_cmd_strip =
-      cmd_strip = :
-
-endif
-
-#
-# Signing
-# Don't stop modules_install even if we can't sign external modules.
-#
-ifeq ($(CONFIG_MODULE_SIG_ALL),y)
-ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
-sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CONFIG_MODULE_SIG_KEY)
-else
-sig-key := $(CONFIG_MODULE_SIG_KEY)
-endif
-quiet_cmd_sign = SIGN    $@
-      cmd_sign = scripts/sign-file -a "$(CONFIG_MODULE_SIG_HASH)" \
-				   -i "$(sig-key)" \
-				   -x certs/signing_key.x509 $@ \
-                 $(if $(KBUILD_EXTMOD),|| true)
-else
-quiet_cmd_sign :=
-      cmd_sign := :
-endif
+PHONY := __modinst
 
 ifeq ($(modules_sign_only),)
 
-$(dst)/%.ko: $(extmod_prefix)%.ko FORCE
-	$(call cmd,install)
-	$(call cmd,strip)
-	$(call cmd,sign)
+__modinst: FORCE
+	$(MAKE) -f scripts/Makefile.install
+	$(MAKE) -f scripts/Makefile.sign
+	$(MAKE) -f scripts/Makefile.compress
 
 else
 
-$(dst)/%.ko: FORCE
-	$(call cmd,sign)
+__modinst: FORCE
+	$(MAKE) -f scripts/Makefile.sign
 
 endif
 
-#
-# Compression
-#
-quiet_cmd_gzip = GZIP    $@
-      cmd_gzip = $(KGZIP) -n -f $<
-quiet_cmd_xz = XZ      $@
-      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
-quiet_cmd_zstd = ZSTD    $@
-      cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
-
-$(dst)/%.ko.gz: $(dst)/%.ko FORCE
-	$(call cmd,gzip)
-
-$(dst)/%.ko.xz: $(dst)/%.ko FORCE
-	$(call cmd,xz)
-
-$(dst)/%.ko.zst: $(dst)/%.ko FORCE
-	$(call cmd,zstd)
-
 PHONY += FORCE
 FORCE:
 
diff --git a/scripts/Makefile.sign b/scripts/Makefile.sign
new file mode 100644
index 000000000000..d6b242b16657
--- /dev/null
+++ b/scripts/Makefile.sign
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Signing modules
+# ==========================================================================
+
+PHONY := __modsign
+__modsign:
+
+include include/config/auto.conf
+include $(srctree)/scripts/Kbuild.include
+
+#
+# Signing
+# Don't stop modules_install even if we can't sign external modules.
+#
+ifeq ($(CONFIG_MODULE_SIG_ALL),y)
+ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
+sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CONFIG_MODULE_SIG_KEY)
+else
+sig-key := $(CONFIG_MODULE_SIG_KEY)
+endif
+quiet_cmd_sign = SIGNING ALL MODULES ...
+      cmd_sign = $(CONFIG_SHELL) $(srctree)/scripts/signfile.sh \
+					 "$(CONFIG_MODULE_SIG_HASH)" \
+					 "$(sig-key)"
+else
+quiet_cmd_sign :=
+      cmd_sign := :
+endif
+
+__modsign: FORCE
+	$(call cmd,sign)
+
+PHONY += FORCE
+FORCE:
+
+.PHONY: $(PHONY)
diff --git a/scripts/signfile.sh b/scripts/signfile.sh
new file mode 100755
index 000000000000..b2b58bfbd5ba
--- /dev/null
+++ b/scripts/signfile.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# A sign-file wrapper used by scripts/Makefile.sign
+
+#set -x
+
+if test $# -ne 2; then
+	echo "Usage: $0 <hash-algo> <sign-key>" >&2
+	exit 1
+fi
+
+SIG_HASH="$1"
+SIG_KEY="$2"
+
+MODULES_PATH="${INSTALL_MOD_PATH}/lib/modules/${KERNELRELEASE}"
+
+find "${MODULES_PATH}" -name *.ko -type f -print0 | \
+	xargs -r -0 -P$(nproc) -x -n32 sh -c "\
+${srctree}/scripts/sign-file \
+-a \"${SIG_HASH}\" \
+-i \"${SIG_KEY}\" \
+-x ${srctree}/certs/signing_key.x509 \
+-b \$@ \$0"
-- 
2.41.0

