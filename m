Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8685A7E10CB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjKDTm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjKDTm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:42:28 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF45194
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 12:42:25 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a93b7fedc8so133383639f.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699126945; x=1699731745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S2OX4Eo9v+rQhNr2FvX3vObjPM79OTe5nhhahXKdqeM=;
        b=gIhvPfN612sqHt9n+BtGcBEKdgFNyiucLKuALO0Nhsxc0Dx4LQh5XnWLv8R6KM6+9A
         c6MEU7cI14dPHrtejyVKjiNPsFoTZIDTwhd4oz/UqK3QIyH10ZnGK8hWVjeE2spc/sfq
         XeDznr2gszvITrrnOeSTvQix6W4cZ60umurAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699126945; x=1699731745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2OX4Eo9v+rQhNr2FvX3vObjPM79OTe5nhhahXKdqeM=;
        b=OZibqrNoR1T6klT3ulSh7phk57X68S6UYrs7QXfR36XCn2M9261wnSlVIsw1Aojltj
         jfZkMKJaeIEJ0pgSHDvwgcQ/LurwMuNc6G8C6Vgb3Zy88vvgbjMzJ34HHKItjnyo6bXr
         eFYgwD5XK/mCKXN145jHoFtdtcKFFCFrBXqz/+WkydBi7J1WWKrGEZjYjiKYle1sG8Bq
         P5i2eI6Wwxve78/wQEpT/1z/7yr6SQz4Gzl4TIGXgmYOSfqJi8ju8owZY/JquWOXSNUj
         +9GwMjv34GhHFBaZIEE+GSHdBrFvAawLRl2ySZwKRAZ67Hxj2olPn3q90IudXrZQGr2b
         3FMA==
X-Gm-Message-State: AOJu0YxKXr0Okvk9ZyuKY3v5QBl+dSBRa+lWsTsNoRLyZdzqfyrkjsmS
        CkzTBSkMmBJZeSTOe8wZLGE03g==
X-Google-Smtp-Source: AGHT+IEQmOlHpL29TdFXJFPMr5evJiymQwNEjalBxAKtB6JFDUpkecBI6UNYhrYY+8vXDuE77TuE4Q==
X-Received: by 2002:a05:6602:3419:b0:7a9:4b18:4c89 with SMTP id n25-20020a056602341900b007a94b184c89mr31619795ioz.6.1699126945152;
        Sat, 04 Nov 2023 12:42:25 -0700 (PDT)
Received: from sjg1.united_club.lax.united.com (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id o4-20020a6b5a04000000b0079fbb834232sm1293318iob.19.2023.11.04.12.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 12:42:24 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: Add a build target for Flat Image Tree
Date:   Sat,  4 Nov 2023 13:42:01 -0600
Message-ID: <20231104194207.3370542-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v2:
- Split double-quote change out into its own patch
- Drop patch previously applied
- Add .gitignore file
- Move fit rule to Makefile.lib using an intermediate file
- Drop dependency on CONFIG_EFI_ZBOOT
- Pick up .dtb files separately from the kernel
- Correct pylint to-many-args warning for write_kernel()
- Include the kernel image in the file count
- Add a pointer to the FIT spec and mention of its wide industry usage
- Mention the kernel version in the FIT description

Simon Glass (3):
  kbuild: arm64: Add BOOT_TARGETS variable
  arm: boot: Use double quotes for image name
  arm64: boot: Support Flat Image Tree

 MAINTAINERS                |   7 +
 arch/arm64/Makefile        |   7 +-
 arch/arm64/boot/.gitignore |   2 +
 arch/arm64/boot/Makefile   |   9 +-
 scripts/Makefile.lib       |  20 ++-
 scripts/make_fit.py        | 288 +++++++++++++++++++++++++++++++++++++
 6 files changed, 329 insertions(+), 4 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.42.0.869.gea05f2083d-goog

