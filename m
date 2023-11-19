Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6947F06FD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjKSPCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSPCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:02:37 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03635E1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 07:02:34 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7a6889f33b9so131702239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 07:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700406153; x=1701010953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N51tl/zj6hx3y8C/i7pvWONxuVI4d2CkVjaNAa9KVfw=;
        b=KEzJhvN0vrEgKamwqdG9mDVInm4xSfTFPMFqyjZgwOisiumSyX8gix15ChoNUpIZJw
         DrtSJvpIScPxlikJbrLrSF8lipP4Tk5UXy7EwYvAZi4RDHiy8dAE90jxnZdK7HM1i9C8
         ydth7g3Joi5uMnmY81yhw8cIugvWy1p2GBjp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700406153; x=1701010953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N51tl/zj6hx3y8C/i7pvWONxuVI4d2CkVjaNAa9KVfw=;
        b=UyBYybvpaQlZn5veJwzAum2RvYktQ5LAYjc3R2MhxjYZK34IrMAQd0NwNZF3BPvLK7
         lSV5BIC+r46HiKA5xmzxX2l5a8qYs5Xvgk1MqnXlqGopsYiuYvOdVedML8e9UJljKK4O
         UUnznV148MfYtSk47K6X5KRTZTTVysANiImHyGviKBVqwuuv/p9VzoG7Y80MUHJs4Q4E
         hTEWJHYJnN+GFq1IjvPYRzUJIKdG2WjD6DabBf6LdderEaHnj0Gdt8Lrk+D1jiFT3XE6
         KM1FhsUquggFzd71syb11WX1cYCz8TQ0xIotGwr8hVbqN0cWTcMSWtljXw5kL8PdP1B+
         ZJnA==
X-Gm-Message-State: AOJu0Yw2iTRUfn+4w35NMsyRBi7FjBZ5WA+uPqCx+OjJJSjPrQsH3CTj
        lBTmpbmA8IvKq5z7dCV3A4d6k8fbh3kQyqjRyQJEhQ==
X-Google-Smtp-Source: AGHT+IHKjO+9V/Ov2s/qDvhWacbsJZSlSMrqQojB8Glj0ndNWo7mxL+WGv1jtXPHhdXCO+WYlSj6Lg==
X-Received: by 2002:a6b:c505:0:b0:7b0:aee5:f9c2 with SMTP id v5-20020a6bc505000000b007b0aee5f9c2mr3285969iof.14.1700406153095;
        Sun, 19 Nov 2023 07:02:33 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id w24-20020a056638379800b004665bec29d1sm79923jal.128.2023.11.19.07.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 07:02:32 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] arm64: Add a build target for Flat Image Tree
Date:   Sun, 19 Nov 2023 08:01:13 -0700
Message-ID: <20231119150229.634424-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
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

Flat Image Tree (FIT) is a widely used file format for packaging a
kernel and associated devicetree files[1]. It is not specific to any
one bootloader, as it is supported by U-Boot, coreboot, Linuxboot,
Tianocore and Barebox.

This series adds support for building a FIT as part of the kernel
build. This makes it easy to try out the kernel - just load the FIT
onto your tftp server and it will run automatically on any supported
arm64 board.

The script is written in Python, since it is easy to build a FIT using
the Python libfdt bindings. For now, no attempt is made to compress
files in parallel, so building the 900-odd files takes a while, about
6 seconds with my testing.

The series also includes a few minor clean-up patches.

[1] https://github.com/open-source-firmware/flat-image-tree

Changes in v6:
- Drop the unwanted .gz suffix

Changes in v5:
- Drop patch previously applied
- Correct compression rule which was broken in v4

Changes in v4:
- Use single quotes for UIMAGE_NAME

Changes in v3:
- Drop temporary file image.itk
- Drop patch 'Use double quotes for image name'
- Drop double quotes in use of UIMAGE_NAME
- Drop unnecessary CONFIG_EFI_ZBOOT condition for help
- Avoid hard-coding "arm64" for the DT architecture

Changes in v2:
- Drop patch previously applied
- Add .gitignore file
- Move fit rule to Makefile.lib using an intermediate file
- Drop dependency on CONFIG_EFI_ZBOOT
- Pick up .dtb files separately from the kernel
- Correct pylint too-many-args warning for write_kernel()
- Include the kernel image in the file count
- Add a pointer to the FIT spec and mention of its wide industry usage
- Mention the kernel version in the FIT description

Simon Glass (2):
  kbuild: arm64: Add BOOT_TARGETS variable
  arm64: boot: Support Flat Image Tree

 MAINTAINERS                |   7 +
 arch/arm64/Makefile        |   7 +-
 arch/arm64/boot/.gitignore |   1 +
 arch/arm64/boot/Makefile   |   6 +-
 scripts/Makefile.lib       |  13 ++
 scripts/make_fit.py        | 289 +++++++++++++++++++++++++++++++++++++
 6 files changed, 321 insertions(+), 2 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.43.0.rc0.421.g78406f8d94-goog

