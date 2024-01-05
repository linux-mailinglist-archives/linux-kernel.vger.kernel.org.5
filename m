Return-Path: <linux-kernel+bounces-17504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F15ED824E88
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663551F219F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986D91DFDE;
	Fri,  5 Jan 2024 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azYitYZN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854551DFC5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f2d44a6842so12081627b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 22:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704435099; x=1705039899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKDQ+5pnW68Nbi3B0uL1FG88vOkGBEVvuvzp5rUCPBU=;
        b=azYitYZN/P4YqYK+vjsl94vwoWWq9Itoc4/MaxN6TizaL73XGLXpS1oRrxHMab+3Mv
         6r39l5F4IdIAzNCkkGtIV0WjZHhzdWjRJS6RNLEduXJKFPeGVI4oSh3J/m3W0bW/jQEw
         uRLc/Uj7aELla0ENAb0C+ZSOdsDwSaASOyAagu1g1woxK57mmR8+OYGoCP8Bvrtn3xCr
         1nCoQoAn6OCV7OtlOTuKqao8Fpj2XVPsMYcr0F7jbW2DeHILcl1WhNl8dvbqDyzwc/OZ
         I+1p1sX2N8gI6msuvWBj+QmoPrHw1nLYYP1AKc8gPQcJSrYxWQ5zWuM/DBHl3RX1t4z3
         KQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704435099; x=1705039899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKDQ+5pnW68Nbi3B0uL1FG88vOkGBEVvuvzp5rUCPBU=;
        b=naaeRWsgu6uw0UeU1AdBXRYawadwvQajsM7sDG/7F+/x9VsjGNqfapCpcXcMGZz65u
         o2pMPWpn28H3f9ng7o/23wa3PVyjxGvnezFBdqmembWh8t2AzOe0jmCoowhp05STBsep
         xUuXQfkM7Ai/8gaHQo96iUd5/JEGGdqOYf8SXpkAYHAg8u1NchcwL0CONkM57lYWoehE
         aPAO4TB3Wx5GHCEppRzA6Bic9v7WV8U2UWm6S+dRhrQvTGDJUOebyTlR4ydI21XIHjeN
         XDsJ/vgTniJK6V2cqLQ6P2EZc9+8ka/ks2anEBDW1fwqpWbT2+1vbGaEFv58XCZ20q9l
         j+YQ==
X-Gm-Message-State: AOJu0YzG8pzA1bbnpB3kSpg0/WFEyjTG4FYvgcN04BD5OeitAhRw06yB
	3jfIV5C5T5l8j7JpjSQGkik=
X-Google-Smtp-Source: AGHT+IGXjI7ARK/zF18CPRzdfa7R/9+ll3ePFJmEzHKpOD0J1ujIZANn5sTiFN5ovJskj1Es16K0Zg==
X-Received: by 2002:a81:5456:0:b0:5e8:45c5:a6bf with SMTP id i83-20020a815456000000b005e845c5a6bfmr1648912ywb.32.1704435099542;
        Thu, 04 Jan 2024 22:11:39 -0800 (PST)
Received: from localhost ([185.215.181.31])
        by smtp.gmail.com with ESMTPSA id w67-20020a816246000000b005ee92416510sm415589ywb.43.2024.01.04.22.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 22:11:39 -0800 (PST)
From: Kevin Martin <kevinmbecause@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Cc: Kevin Martin <kevinmbecause@gmail.com>
Subject: [PATCH v2 2/2] firmware_loader: Enable compressed files with EXTRA_FIRMWARE
Date: Fri,  5 Jan 2024 01:10:02 -0500
Message-ID: <cd370037f8c21dc851a2a33a07250459c9c98708.1704353568.git.kevinmbecause@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1704353568.git.kevinmbecause@gmail.com>
References: <cover.1704353568.git.kevinmbecause@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux-firmware packages on Gentoo, Fedora, Arch, and others
compress the firmware files. This works well with
CONFIG_FW_LOADER_COMPRESS but does not work with CONFIG_EXTRA_FIRMWARE.
This patch allows the build system to decompress firmware files
specified by CONFIG_EXTRA_FIRMWARE. Uncompressed files are used first,
then the compressed files are used.

The patch works by copying or decompressing the specified firmware files
into the build directory, then compiling them in from there. I would
prefer to not copy any uncompressed files, but I have not found a clean
way to do that.

Signed-off-by: Kevin Martin <kevinmbecause@gmail.com>
---
Changes in v2:
- Changed .gitignore to ignore all firmware files copied into the
directory.
- Fixed a tab.

 drivers/base/firmware_loader/Kconfig            |  5 ++++-
 drivers/base/firmware_loader/builtin/.gitignore |  5 ++++-
 drivers/base/firmware_loader/builtin/Makefile   | 16 ++++++++++++----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 5ca00e02f..b7a908bff 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -76,7 +76,10 @@ config EXTRA_FIRMWARE
 	  image since it combines both GPL and non-GPL work. You should
 	  consult a lawyer of your own before distributing such an image.
 
-	  NOTE: Compressed files are not supported in EXTRA_FIRMWARE.
+	  NOTE: Compressed files are supported by EXTRA_FIRMWARE. The build
+	  system will look for uncompressed files first then fall back to
+	  searching for compressed files in a similar way to
+	  CONFIG_FW_LOADER_COMPRESS.
 
 config EXTRA_FIRMWARE_DIR
 	string "Firmware blobs root directory"
diff --git a/drivers/base/firmware_loader/builtin/.gitignore b/drivers/base/firmware_loader/builtin/.gitignore
index 166f76b43..b3124ee78 100644
--- a/drivers/base/firmware_loader/builtin/.gitignore
+++ b/drivers/base/firmware_loader/builtin/.gitignore
@@ -1,2 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-*.gen.S
+*
+!.gitignore
+!Makefile
+!main.c
diff --git a/drivers/base/firmware_loader/builtin/Makefile b/drivers/base/firmware_loader/builtin/Makefile
index 6c067dedc..cc60eb441 100644
--- a/drivers/base/firmware_loader/builtin/Makefile
+++ b/drivers/base/firmware_loader/builtin/Makefile
@@ -20,7 +20,7 @@ filechk_fwbin = \
 	echo "    .section .rodata"				;\
 	echo "    .p2align 4"					;\
 	echo "_fw_$(FWSTR)_bin:"				;\
-	echo "    .incbin \"$(fwdir)/$(FWNAME)\""		;\
+	echo "    .incbin \"$(obj)/$(FWNAME)\""			;\
 	echo "_fw_end:"						;\
 	echo "    .section .rodata.str,\"aMS\",$(PROGBITS),1"	;\
 	echo "    .p2align $(ASM_ALIGN)"			;\
@@ -36,7 +36,15 @@ $(obj)/%.gen.S: FORCE
 	$(call filechk,fwbin)
 
 # The .o files depend on the binaries directly; the .S files don't.
-$(addprefix $(obj)/, $(firmware)): $(obj)/%.gen.o: $(fwdir)/%
+$(addprefix $(obj)/, $(firmware)): $(obj)/%.gen.o: $(obj)/%
 
-targets := $(patsubst $(obj)/%,%, \
-                                $(shell find $(obj) -name \*.gen.S 2>/dev/null))
+$(obj)/% : $(fwdir)/% FORCE
+	$(call if_changed,copy)
+
+$(obj)/% : $(fwdir)/%.xz FORCE
+	$(call if_changed,xzdec)
+
+$(obj)/% : $(fwdir)/%.zst FORCE
+	$(call if_changed,zstddec)
+
+targets := $(patsubst %.gen.o, %.gen.S, $(firmware)) $(CONFIG_EXTRA_FIRMWARE)
-- 
2.41.0


