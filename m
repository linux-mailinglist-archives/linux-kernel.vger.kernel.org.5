Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F89E7F228D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjKUAvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjKUAvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:51:48 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9F5D9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:51:43 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc3542e328so36888245ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700527902; x=1701132702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXATW3MRAQvsKRC4qmRrIvj298IUKOcYY6FTnTMN1Sw=;
        b=MVqxTnJ1S9NcieAjohMihQkMfhvZxRqgI9Lwb+V3UdMqyFErW70gsQXeI9Km4OJeie
         V41arsvSQM0KRiD32goydeB8yiXPnY0KvhTkFNzZs0LTLl4pvQdWAyjkphv/rOF4ODR+
         JbDp7VB2vd7lO5H5utNF16HX2FNjcSnVWeleokBeIH8aCAYtX0AAYlMHUq3xz866Q73J
         9ZZXZwmjFKVQhlJc327S5cEsT/hITulV9k+vA05BaebE7mdKf26MZOJGGVLS59eHqsGX
         mdy6eky9FBBi9IgfA0l8ZGwwDL2M43fSdSZORGaO/ObMPR2B405UyqjTUNgtX9HlfXz1
         xlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700527902; x=1701132702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXATW3MRAQvsKRC4qmRrIvj298IUKOcYY6FTnTMN1Sw=;
        b=hbZzLnTYEBc6uSSGRP5/njthcJVu7xherP/dJkL8JoCIqzH6JoXc+2Z7TyfgDfkmLU
         HbQtXDpwngmwkKI2Z+TQ1/Bp8cEWcdYDo+OfEGR4GmZRkHo9q/8N+dOBSzUOXWTni6Ny
         5JDzYZmb48205EFBQx0ZbZFbcspzbr4VMlP6GG0EC7vnMJ76oRL5fsuT6O+dG7gWOcdk
         /PcaTJk3k7qc/blN3lTZwDnXoOmBVRWZ6x/NsAczkjD+k7ef3xFarOFr1TjM1MiAzczb
         1gNq49reEgi8hqxrf22BZ3cRzMKk2HgrCA1T1KC+Nk+xqsJzv3yAcOFh75OHNSFtj0ft
         VwfA==
X-Gm-Message-State: AOJu0Yy0WXAZ+Pmj3nVjItIfsHFmoeCMHnPzjhVI7yCJyn43480UYa8d
        +ucpUJgMM3/3sdCOKVY7yqB2s84kxgE=
X-Google-Smtp-Source: AGHT+IGfNpCNiXrzSf3uWTS2IkEGmTSSD0ZsuvY6zBhuVDdu9PFZ0QbqGpcj0NT/aFbc1AwDoLWUWA==
X-Received: by 2002:a17:902:f54c:b0:1cf:63bb:82a6 with SMTP id h12-20020a170902f54c00b001cf63bb82a6mr3624158plf.65.1700527902224;
        Mon, 20 Nov 2023 16:51:42 -0800 (PST)
Received: from nickserv.taila7d40.ts.net (c-24-5-149-91.hsd1.ca.comcast.net. [24.5.149.91])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902ee8c00b001c74876f018sm6705936pld.18.2023.11.20.16.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:51:41 -0800 (PST)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yann Collet <cyan@meta.com>, Nick Terrell <terrelln@meta.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/2] zstd: import upstream v1.5.5
Date:   Mon, 20 Nov 2023 17:03:16 -0800
Message-ID: <20231121010318.524570-1-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@meta.com>

Import upstream zstd v1.5.5 to expose upstream's QAT integration.

The following changes since commit 77618db346455129424fadbbaec596a09feaf3bb:

  zstd: Fix array-index-out-of-bounds UBSAN warning (2023-11-14 17:12:52 -0800)

are also available in the Git repository at:

  https://github.com/terrelln/linux.git tags/2023-11-20-zstd-v1.5.5-v1

In addition to keeping the kernel's copy of zstd up to date, this update
was requested by Intel to expose upstream zstd's external match provider
API to the kernel, which allows QAT to accelerate the LZ match finding
stage.

The result of the series is that zstd is cleanly imported from the
tag v1.5.5-kernel [0], which is signed with upstream's signing key
EF8FE99528B52FFD [1]. Meaning that running this script creates no diff:

  export ZSTD=/path/to/repo/zstd/
  export LINUX=/path/to/repo/linux/
  cd "$ZSTD/contrib/linux-kernel"
  git checkout v1.5.5-kernel
  make import LINUX="$LINUX"

The first patch updates to v1.5.5 with three cherry picked backports
from the Linux kernel and the upstream dev branch. The second patch
negates a regression in decompression speed caused by the update.

The series has been tested on x86-64, and has been boot tested with a
zstd compressed kernel on i386 and aarch64. I benchmarked the series
on x86-64 with gcc-13.2.1 on an Intel i9-9900K by measuring the
performance of compressed filesystems read & writes. 

Component,	Level,	C. time delta,	size delta,	D. time delta
Btrfs    ,	    1,	        -1.5%,	     +0.0%,	        +1.8%
Btrfs    ,	    3,	        -5.8%,	     +0.0%,	        +3.2%
Btrfs    ,	    5,	        -5.7%,	     +0.0%,	        +0.0%
Btrfs    ,	    7,	        -6.5%,	     +0.0%,	        +0.4%
Btrfs    ,	    9,	        -6.9%,	     +0.0%,	        +1.5%
Squashfs ,	    1,	          N/A,	      0.0%,	        +1.0%

For levels 3 and above, there is a ~6% reduction in write+compression time.
There is also a small increase in read+decompression time.

If everything looks good, I will submit this patch set with the rest of my
tree in the v6.8 merge window.

[0] https://github.com/facebook/zstd/tree/v1.5.5-kernel
[1] https://keyserver.ubuntu.com/pks/lookup?search=EF8FE99528B52FFD&fingerprint=on&op=index

Nick Terrell (2):
  zstd: import upstream v1.5.5
  zstd: Backport Huffman speed improvement from upstream

 include/linux/zstd.h                          |    2 +-
 include/linux/zstd_errors.h                   |   23 +-
 include/linux/zstd_lib.h                      |  697 +++++--
 lib/zstd/Makefile                             |    2 +-
 lib/zstd/common/allocations.h                 |   56 +
 lib/zstd/common/bits.h                        |  149 ++
 lib/zstd/common/bitstream.h                   |   53 +-
 lib/zstd/common/compiler.h                    |   14 +-
 lib/zstd/common/cpu.h                         |    3 +-
 lib/zstd/common/debug.c                       |    3 +-
 lib/zstd/common/debug.h                       |    3 +-
 lib/zstd/common/entropy_common.c              |   42 +-
 lib/zstd/common/error_private.c               |   12 +-
 lib/zstd/common/error_private.h               |    3 +-
 lib/zstd/common/fse.h                         |   89 +-
 lib/zstd/common/fse_decompress.c              |   94 +-
 lib/zstd/common/huf.h                         |  222 +--
 lib/zstd/common/mem.h                         |    2 +-
 lib/zstd/common/portability_macros.h          |   26 +-
 lib/zstd/common/zstd_common.c                 |   38 +-
 lib/zstd/common/zstd_deps.h                   |   16 +-
 lib/zstd/common/zstd_internal.h               |   99 +-
 lib/zstd/compress/clevels.h                   |    3 +-
 lib/zstd/compress/fse_compress.c              |   59 +-
 lib/zstd/compress/hist.c                      |    3 +-
 lib/zstd/compress/hist.h                      |    3 +-
 lib/zstd/compress/huf_compress.c              |  372 ++--
 lib/zstd/compress/zstd_compress.c             | 1762 ++++++++++++-----
 lib/zstd/compress/zstd_compress_internal.h    |  333 +++-
 lib/zstd/compress/zstd_compress_literals.c    |  155 +-
 lib/zstd/compress/zstd_compress_literals.h    |   25 +-
 lib/zstd/compress/zstd_compress_sequences.c   |    7 +-
 lib/zstd/compress/zstd_compress_sequences.h   |    3 +-
 lib/zstd/compress/zstd_compress_superblock.c  |   47 +-
 lib/zstd/compress/zstd_compress_superblock.h  |    3 +-
 lib/zstd/compress/zstd_cwksp.h                |  149 +-
 lib/zstd/compress/zstd_double_fast.c          |  129 +-
 lib/zstd/compress/zstd_double_fast.h          |    6 +-
 lib/zstd/compress/zstd_fast.c                 |  582 ++++--
 lib/zstd/compress/zstd_fast.h                 |    6 +-
 lib/zstd/compress/zstd_lazy.c                 |  518 ++---
 lib/zstd/compress/zstd_lazy.h                 |    7 +-
 lib/zstd/compress/zstd_ldm.c                  |   11 +-
 lib/zstd/compress/zstd_ldm.h                  |    3 +-
 lib/zstd/compress/zstd_ldm_geartab.h          |    3 +-
 lib/zstd/compress/zstd_opt.c                  |  187 +-
 lib/zstd/compress/zstd_opt.h                  |    3 +-
 lib/zstd/decompress/huf_decompress.c          |  770 ++++---
 lib/zstd/decompress/zstd_ddict.c              |    9 +-
 lib/zstd/decompress/zstd_ddict.h              |    3 +-
 lib/zstd/decompress/zstd_decompress.c         |  261 ++-
 lib/zstd/decompress/zstd_decompress_block.c   |  283 ++-
 lib/zstd/decompress/zstd_decompress_block.h   |    8 +-
 .../decompress/zstd_decompress_internal.h     |    7 +-
 lib/zstd/decompress_sources.h                 |    2 +-
 lib/zstd/zstd_common_module.c                 |    5 +-
 lib/zstd/zstd_compress_module.c               |    2 +-
 lib/zstd/zstd_decompress_module.c             |    4 +-
 58 files changed, 4787 insertions(+), 2594 deletions(-)
 create mode 100644 lib/zstd/common/allocations.h
 create mode 100644 lib/zstd/common/bits.h

-- 
2.42.1

