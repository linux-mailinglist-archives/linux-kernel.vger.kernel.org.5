Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD4279CAE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjILJCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjILJBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:01:34 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F13C10D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:25 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-31f87a56b46so1915265f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509283; x=1695114083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Om2Cn3Wg3jEi2eBnUxXdkE+0SAAFjVcdTV6CXbynWjo=;
        b=UMH31Aaa4mBVA7Syf2BxmkQ6xJ8tohTYwgsa9fXf1RT0ZTpdmfTeb4Lp6qVy9Vy6GN
         /+XJST0iRC5EGA1vrr43T0+lEdQZruKcCfsdwVlsYBKdV70qQBqGoNQGyS0xwfs+h1lB
         Tjlq1pepHisOZVjNXQiHA2a0sNu6rCa63V90NFxrTXrxADBXRU6azBaBO2LRlTI/WMiu
         Y9AieKcZKJodwKzQ+y9VWP1jbIOT3L1folqyUjpeQvGTY9ccj8hga3VjeGU+vDLaVHtA
         LYy5VHGrZohvJwhPavidZ2YOQv8NgQ8+2DUQanrp4m3x2xNZ7Rs+Y2Hz+rlPbWDVDgTY
         Z6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509283; x=1695114083;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Om2Cn3Wg3jEi2eBnUxXdkE+0SAAFjVcdTV6CXbynWjo=;
        b=Tn0bgFNV5kVZwiWvGum/N5H+S5iF6s+hlqag39gSEmZhEqMMFmKcI5rwddbn3VZwAJ
         jICLbV7tza/KyOLpvFF0h/qw/4moJmiZh9XPehOt/4hk4mthY3Yls5vV7GyXqjca7iLZ
         wXAxGc/0cvp2nVLPAaufDvWX1erqNPDzGg51D94P2JZQSt7QuCZKIg2yX+GySGD2dU9s
         VGkNeehQp1ksDKgbYZgWmJADwaOb6PsCjIeMgx2i+dPwJ1iLt3sL8ZLbd09KncR2M/ok
         l7l/o9xsRcGNKUPjBBrFsE9zIaOi+ZVpuKc0onA5Dkrlan6UTxRjGbyHI5wwIcqz1qb+
         6BUw==
X-Gm-Message-State: AOJu0YzjtVmiikzdhDhacOo047ws0qFdPs8favtVo8WQqbhKgoQJDgC4
        GKwx4ni8U5ZxI6Bs9LiHe2wsTSPc
X-Google-Smtp-Source: AGHT+IFlV1cfpOxh5HADBtaEpaYnpaKTI/Kysvfvx1KwDrWrD8DTXp/I88mfzwjsMIhnID61wzXJuHX2
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:156b:b0:31f:a664:f871 with SMTP id
 11-20020a056000156b00b0031fa664f871mr73257wrz.9.1694509283538; Tue, 12 Sep
 2023 02:01:23 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:00:51 +0000
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3609; i=ardb@kernel.org;
 h=from:subject; bh=oz3m2uvlkSUrxw/YtPHMIWaPsH7+dyN5FRl9/bT5Ino=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB47DyoeO7uD6knGdYcS3d+UWwzvaLy/RNb3AG3IyqO
 qkS5vK9o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzETZeRYc2+Lf3cYSyxtX0M
 042DLk8xeDB9v+Dmm35nTjyrfaHFGMjwV4x7ytIvetmlh9ovBKb+NRE3zln0LH5vzY8pa1/+Wzp dmwEA
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-17-ardb@google.com>
Subject: [PATCH v2 00/15] x86/boot: Rework PE header generation
From:   Ard Biesheuvel <ardb@google.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Now that the EFI stub boot flow no longer relies on memory that is
executable and writable at the same time, we can reorganize the PE/COFF
view of the kernel image and expose the decompressor binary's code and
r/o data as a .text section and data/bss as a .data section, using 4k
alignment and limited permissions.

Doing so is necessary for compatibility with hardening measures that are
being rolled out on x86 PCs built to run Windows (i.e., the majority of
them). The EFI boot environment that the Linux EFI stub executes in is
especially sensitive to safety issues, given that a vulnerability in the
loader of one OS can be abused to attack another.

In true x86 fashion, this is a lot more complicated than on other
architectures, which have implemented this code/data split with 4k
alignment from the beginning. The complicating factor here is that the
boot image consists of two different parts, which are stitched together
and fixed up using a special build tool.

After this series is applied, the only remaining task performed by the
build tool is generating the CRC-32. Even though this checksum is
usually wrong (given that distro kernels are signed for secure boot in a
way that corrupts the CRC), this feature is retained as we cannot be
sure that nobody is relying on this.

This supersedes the work proposed by Evgeniy last year, which did a
major rewrite of the build tool in order to clean it up, before updating
it to generate the new 4k aligned image layout. As this series proves,
the build tool is mostly unnecessary, and we have too many of those
already.

Changes since v1:
- drop patch that removed the CRC and the build tool
- do not use fixed setup_size but derive it in the setup.ld linker
  script
- reorganize the PE header so the .compat section only covers its
  payload and the padding that follows it
- add hpa's ack to patch #4

Cc: Evgeniy Baskov <baskov@ispras.ru>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Jones <pjones@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>

Ard Biesheuvel (15):
  x86/efi: Drop EFI stub .bss from .data section
  x86/efi: Disregard setup header of loaded image
  x86/efi: Drop alignment flags from PE section headers
  x86/boot: Remove the 'bugger off' message
  x86/boot: Omit compression buffer from PE/COFF image memory footprint
  x86/boot: Drop redundant code setting the root device
  x86/boot: Grab kernel_info offset from zoffset header directly
  x86/boot: Drop references to startup_64
  x86/boot: Set EFI handover offset directly in header asm
  x86/boot: Define setup size in linker script
  x86/boot: Derive file size from _edata symbol
  x86/boot: Construct PE/COFF .text section from assembler
  x86/boot: Drop PE/COFF .reloc section
  x86/boot: Split off PE/COFF .data section
  x86/boot: Increase section and file alignment to 4k/512

 arch/x86/boot/Makefile                  |   2 +-
 arch/x86/boot/compressed/vmlinux.lds.S  |   6 +-
 arch/x86/boot/header.S                  | 213 ++++++---------
 arch/x86/boot/setup.ld                  |  14 +-
 arch/x86/boot/tools/build.c             | 273 +-------------------
 drivers/firmware/efi/libstub/Makefile   |   7 -
 drivers/firmware/efi/libstub/x86-stub.c |  46 +---
 7 files changed, 114 insertions(+), 447 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog

