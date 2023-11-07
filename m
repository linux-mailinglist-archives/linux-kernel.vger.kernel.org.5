Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC867E4218
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjKGOte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjKGOt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:49:29 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C91B9E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:49:26 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35932aa21a3so21594495ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 06:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699368565; x=1699973365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaV9Hs3+cyYm1Gr06GB3mxSuR25FjGRVsz8hlTL4IWg=;
        b=SLmd6OCHmL8iRDmfLxrSNjWKgq6vGxWtl7F2tw6gso79aiPTjdeQBFiRACdYtEK+XX
         D8KUrIbt2KUrG2cle5XYYCPrchYUEi+a4O+G/VVgv5HO5TiOjtISjup8Clc7p2sPGjL0
         KprcU66nsERduVKk63Egh09S3TM6Xq//awjV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699368565; x=1699973365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaV9Hs3+cyYm1Gr06GB3mxSuR25FjGRVsz8hlTL4IWg=;
        b=SLv9VgG/hLD2yGe81oq1BRRGRC95knNpq1nsnwMJnmTW6ohND90F7Zgos2KvlLRGS5
         iEEHQlawccVFDALHfIDQ5uv+Yp638oxobRM3zZUfTcMJw0IFN7e4/6WQgWZfKPl6IFqi
         kpcwqTp12UyAJhc2nmpy1ZRUhxy4KuqSs6h+ydDXKtaNjZpuioAFAMGpmb7DKCCzG+1r
         i3PZpCuZ6o+TojLpgmhI5gm9jhO8yOJYzBUGJtR9uKMp2bX3p4Q7OHRpuOLEFerQce+R
         M+lGvyxSm2IzozFIglj6aE4exKSMz/YOSHZ7l7aiq3qLlpHGsW2A0gwgXrK5PbBpho3M
         dH6w==
X-Gm-Message-State: AOJu0Yx9tDwwryX3u3cX1k5RA4Ai8uwT1OJHFrVfbxJoawTF5UhnkR5m
        iOhHPDMFIg6ViTy/7kh4rXvcTwlBIHb6PifcbVndAQ==
X-Google-Smtp-Source: AGHT+IGnmEGYuVlxI7gvheK7jw/EXDkfYArur1P02yryv5K8v6LTdN1/sV0kFS+mgJRZO7Pv54ming==
X-Received: by 2002:a05:6e02:1c0e:b0:350:ef09:ff82 with SMTP id l14-20020a056e021c0e00b00350ef09ff82mr3481236ilh.24.1699368565654;
        Tue, 07 Nov 2023 06:49:25 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id b16-20020a05663801b000b0045a66a26208sm2815200jaq.128.2023.11.07.06.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 06:49:24 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] arm: boot: Move the single quotes for image name
Date:   Tue,  7 Nov 2023 07:48:50 -0700
Message-ID: <20231107144917.48304-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231107144917.48304-1-sjg@chromium.org>
References: <20231107144917.48304-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quotes where UIMAGE_NAME is used, rather than where it is defined.
This allows the UIMAGE_NAME variable to be set by the user.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add a patch to move the single quotes for image name

 scripts/Makefile.lib | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..1a965fe68e01 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -487,14 +487,14 @@ UIMAGE_OPTS-y ?=
 UIMAGE_TYPE ?= kernel
 UIMAGE_LOADADDR ?= arch_must_set_this
 UIMAGE_ENTRYADDR ?= $(UIMAGE_LOADADDR)
-UIMAGE_NAME ?= 'Linux-$(KERNELRELEASE)'
+UIMAGE_NAME ?= Linux-$(KERNELRELEASE)
 
 quiet_cmd_uimage = UIMAGE  $@
       cmd_uimage = $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
 			-C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
 			-T $(UIMAGE_TYPE) \
 			-a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
-			-n $(UIMAGE_NAME) -d $< $@
+			-n '$(UIMAGE_NAME)' -d $< $@
 
 # XZ
 # ---------------------------------------------------------------------------
-- 
2.42.0.869.gea05f2083d-goog

