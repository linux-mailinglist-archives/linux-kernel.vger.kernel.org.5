Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3E17D7D99
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344393AbjJZH1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjJZH1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:27:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549E01AB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:27:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1caa7597af9so4191925ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698305266; x=1698910066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTwZx3oM2k52vN4dFBT99PYUWHkrvjvdxEhL3D6GWJ0=;
        b=oQhwfqDtff9r9446746OsT707+BlU1WPXH1N0wR8+HWWCf7Go1KHwJAEnk6TRek56O
         rAkcZXqySJZGhJhCEFG/n+1THLBxYaUwgYUWP5zVQfoANhtxLHzP6KisdmLjwVDHpWZ5
         z8nn1idSeQy6h3rSBx8WpS63kKQWLvuOYscAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698305266; x=1698910066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTwZx3oM2k52vN4dFBT99PYUWHkrvjvdxEhL3D6GWJ0=;
        b=aRwScYtnD064U15KPodgxX1NrO7I3f3+RkLLbAwyeacDewKoVqtbm66Kl3+X3gXy2p
         1jcD64NitPHZoxaLT4x6pNoXV/st814dNmxvUs3anlJLfhWFt8V2s4zNg2GfjEONU7yE
         FduoaRZlslPkSDJAh+N7xXtBsr3ANeQ8D2zXG6GRqDpgORJ6ZcpHBWIEIetN0M3HMKWl
         G8KziJNawXnLmiplWefuFzdtHLEZoaKYlBVCSfz+0O9wk4Q1Z+6k/RE84e0Cb2l0M3JN
         zGo0sTXPlHpquxRxWrcbHkV57z1SQKxASkxEQNUpiGzH/0gWl6OqGh6lrl9yrpaMHVSI
         97Rg==
X-Gm-Message-State: AOJu0YxFjapC5ZeRojSPURiLgc8/KzxqNpzvYTKjm2420j/9gALPwP0d
        fDuViuYctyDYYnGNTvHyJAO38A==
X-Google-Smtp-Source: AGHT+IESAAwq7rAUPMREBmZ6wjGQZPRao0krbTSghCrCp+7VkHSUuu7/MSZv4fKt+xYoabpzNXl+YA==
X-Received: by 2002:a17:902:ce92:b0:1c9:e774:58e1 with SMTP id f18-20020a170902ce9200b001c9e77458e1mr17515487plg.8.1698305265723;
        Thu, 26 Oct 2023 00:27:45 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b001b7cbc5871csm10294023plf.53.2023.10.26.00.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:27:45 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Simon Glass <sjg@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kbuild: Correct missing architecture-specific hyphens
Date:   Thu, 26 Oct 2023 20:26:23 +1300
Message-ID: <20231026072628.4115527-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231026072628.4115527-1-sjg@chromium.org>
References: <20231026072628.4115527-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These should add a hyphen to indicate that it makes a adjective. Fix
them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 690cde550acd..b63796e6f94a 100644
--- a/Makefile
+++ b/Makefile
@@ -675,7 +675,7 @@ ifdef config-build
 # *config targets only - make sure prerequisites are updated, and descend
 # in scripts/kconfig to make the *config target
 
-# Read arch specific Makefile to set KBUILD_DEFCONFIG as needed.
+# Read arch-specific Makefile to set KBUILD_DEFCONFIG as needed.
 # KBUILD_DEFCONFIG may point out an alternative default configuration
 # used for 'make defconfig'
 include $(srctree)/arch/$(SRCARCH)/Makefile
@@ -689,7 +689,7 @@ config: outputmakefile scripts_basic FORCE
 
 else #!config-build
 # ===========================================================================
-# Build targets only - this includes vmlinux, arch specific targets, clean
+# Build targets only - this includes vmlinux, arch-specific targets, clean
 # targets and others. In general all targets except *config targets.
 
 # If building an external module we do not care about the all: rule
@@ -1637,9 +1637,9 @@ help:
 	@echo  'Documentation targets:'
 	@$(MAKE) -f $(srctree)/Documentation/Makefile dochelp
 	@echo  ''
-	@echo  'Architecture specific targets ($(SRCARCH)):'
+	@echo  'Architecture-specific targets ($(SRCARCH)):'
 	@$(or $(archhelp),\
-		echo '  No architecture specific help defined for $(SRCARCH)')
+		echo '  No architecture-specific help defined for $(SRCARCH)')
 	@echo  ''
 	@$(if $(boards), \
 		$(foreach b, $(boards), \
@@ -1681,7 +1681,7 @@ help-boards: $(help-board-dirs)
 boards-per-dir = $(sort $(notdir $(wildcard $(srctree)/arch/$(SRCARCH)/configs/$*/*_defconfig)))
 
 $(help-board-dirs): help-%:
-	@echo  'Architecture specific targets ($(SRCARCH) $*):'
+	@echo  'Architecture-specific targets ($(SRCARCH) $*):'
 	@$(if $(boards-per-dir), \
 		$(foreach b, $(boards-per-dir), \
 		printf "  %-24s - Build for %s\\n" $*/$(b) $(subst _defconfig,,$(b));) \
-- 
2.42.0.758.gaed0368e0e-goog

