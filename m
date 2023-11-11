Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA767E86F2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 01:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345025AbjKKA3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 19:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbjKKA3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 19:29:38 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A893C39
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:29:35 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d0f945893so22003046d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699662575; x=1700267375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMe27PCpSGrpKy6akin6UXrBQxmCtSQz/w0mkm8+aO0=;
        b=ByWIc5KZlNlmBIPWwJcgT983Yq9tWUr/KFSiBxanH4vHTBB4WGPQMvsSgrgFr4s1WK
         CPkuT5sAeDsk6xRLNjHENt5wN1pxV7Zudq1O93U3MbiVyiKE/E7CRZzjAqXYAPcmGZ2D
         wQnHuSe4VbJhXZfJvPRAsKl8iSIQcbO9nKVhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699662575; x=1700267375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMe27PCpSGrpKy6akin6UXrBQxmCtSQz/w0mkm8+aO0=;
        b=TF+TLrxP16IRojHMvOmJssjYWFUECQPBb1LPav/UZPEe3J2fXAYLHxqOtIeDBXKEP3
         hQ0RtAVF8/9hHXbcz0iQ6s/6yoYQ9fPlxhuYI8QIuHaokA7moQlNg1m9OD5PNrsTPja7
         ImMflijbk/PXrbOl9zU91HEwtaVgcC3XRpFM81jlHWS7vRHQm2IM60DLdbtCuC899+Hm
         Kg438I4M4hCDCs9WjcibSArdl3mjnsHnc7j/RPtLj/QFSppxvV7VQU5qK8Fz4CkS0Qv4
         PWlzI22d9gxXRd1862VEPA7HVs4aLBtHDDFJf76sXCIquYbtsrHPztu+ydV59aTaHtAG
         IUCg==
X-Gm-Message-State: AOJu0YzLtG7uYPfFmhB+urnVd/i3gCii/GoYDlyRBFT0NqLxThxCqAtN
        cXbupdAEbC0rcVopfAx0VRHtYQ==
X-Google-Smtp-Source: AGHT+IE0a/VdrtgvwTmIbRQLeoUJHTOtRwQJiuZK5PAG5tzmD5AD8V4FRMa71Q4svxolT1LcdUmEbg==
X-Received: by 2002:ad4:4e6d:0:b0:670:ba7c:938d with SMTP id ec13-20020ad44e6d000000b00670ba7c938dmr1203791qvb.25.1699662575054;
        Fri, 10 Nov 2023 16:29:35 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5104:5a27:f95d:21d1])
        by smtp.gmail.com with ESMTPSA id l16-20020a056214029000b00677adcfd261sm55898qvv.89.2023.11.10.16.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 16:29:34 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     lkml <linux-kernel@vger.kernel.org>, Tom Rini <trini@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Simon Glass <sjg@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH v5 2/3] arm: boot: Move the single quotes for image name
Date:   Fri, 10 Nov 2023 17:28:01 -0700
Message-ID: <20231111002851.1293891-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231111002851.1293891-1-sjg@chromium.org>
References: <20231111002851.1293891-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quotes where UIMAGE_NAME is used, rather than where it is defined.
This allows the UIMAGE_NAME variable to be set by the user.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

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

