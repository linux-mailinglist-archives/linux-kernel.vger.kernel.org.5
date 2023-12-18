Return-Path: <linux-kernel+bounces-3579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90597816E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A7DB20E11
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7517D61B;
	Mon, 18 Dec 2023 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCt5WFjg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0031DDCA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a236add9eadso7383566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702903238; x=1703508038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EUfZwZ1aGk370OXeJ4obFyQ2HhdCpWDzg+xPB3oJksw=;
        b=wCt5WFjg5+uaASsxa1sYZbIVL7gnjEI7dtgOj9tWCEUE5WeANF81tKgK9OVT2kWrfg
         A/V2VpyJp56A/oYETwDgyZJ9cWgLRPpBzKVyjLKdGXfyUImZOY5znSitBd7789nB+3+4
         azP2dRcwvrxJ5fWbgfGQa5WJrV5KcweMPuz0zpCF9DTKWxeREURuCQTpyG95ehv+5Php
         uZ62mXcgaT7UG2fG597yk/WUky/epcgXeVXopNtwh+nG1C1Kn564NnKfZmkFoqvI5LGy
         4kY/lGzEq0VI2QJyT4dSX/DwetNWoxF77twwyaQdB37IRye92cE/DLR7H6quKNnVmyjr
         04hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702903238; x=1703508038;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUfZwZ1aGk370OXeJ4obFyQ2HhdCpWDzg+xPB3oJksw=;
        b=kJK5Tr/xwOx7tFLqD+yPBMa7gojSr7yDFEATfPebbqRdBlMarR1hCehZfCru/iMjpk
         q0xKLsvnraia+3jCSuOh3NWJ2syxNPCjtbkhYjXM3lokK5w5k3m7BOOOm7+XKgFcr1N0
         e6BQWtOMzPAp5QcuOYw2kYA19ekVGqtZuolgzMyMnlnxOhSuJJHgELBBMNq+b09K7lvr
         Wx8tYgnpVuQtLo/uTt9s9uKYS8C6LMtp4x857s5DvN3zADAuXnEknlABdKITgk9jChYa
         J+tlGHq+VvzwsdP5RRycPCe36DbJUDx7nfvbW+rkpGK0d1VhIGr2ABo1krN14KFmwiSu
         G8Aw==
X-Gm-Message-State: AOJu0YwxIAdoI96hcHoNOBxsFsMgxJsjeDBsCzCk2E4sPVyC++OxLR88
	foNn6Zigmna0VziisINp2KlnEJMheDw=
X-Google-Smtp-Source: AGHT+IFE6A4qeRh+S8jUZ9rLK1b7RIRtSBKXdYO0y2fnC73qZIcU6ekHkIZw5pAYRt6WpybOTq0RvComm0E=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:9a3f:c8e7:1395:806e])
 (user=glider job=sendgmr) by 2002:a17:906:3c4e:b0:a23:6717:639a with SMTP id
 i14-20020a1709063c4e00b00a236717639amr2183ejg.8.1702903237824; Mon, 18 Dec
 2023 04:40:37 -0800 (PST)
Date: Mon, 18 Dec 2023 13:40:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218124033.551770-1-glider@google.com>
Subject: [PATCH v10-mte 0/7] Implement MTE tag compression for swapped pages
From: Alexander Potapenko <glider@google.com>
To: glider@google.com, catalin.marinas@arm.com, will@kernel.org, 
	pcc@google.com, andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com, 
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk, yury.norov@gmail.com, 
	alexandru.elisei@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"

Currently, when MTE pages are swapped out, the tags are kept in the
memory, occupying PAGE_SIZE/32 bytes per page. This is especially
problematic for devices that use zram-backed in-memory swap, because
tags stored uncompressed in the heap effectively reduce the available
amount of swap memory.

The RLE-based algorithm suggested by Evgenii Stepanov and implemented in
this patch series is able to efficiently compress fixed-size tag buffers,
resulting in practical compression ratio of 2x. In many cases it is
possible to store the compressed data in 63-bit Xarray values, resulting
in no extra memory allocations.

To implement compression/decompression, we also extend <linux/bitmap.h>
with methods to read/write bit values at arbitrary places in the map.

This patch series depends on "lib/bitmap: add bitmap_{read,write}()"
(https://lore.kernel.org/linux-arm-kernel/20231030153210.139512-1-glider@google.com/T/)
that is mailed separately.

v11-mte:
 - address Yury's comments

v10-mte:
 - add the bitmap_read()/bitmap_write() patches
   (https://lore.kernel.org/lkml/20231109151106.2385155-1-glider@google.com/)
   back to this series
 - add Acked-by: tags to MTE patches

v9:
 - split off the stats collection code into a separate patch in the
   series (as suggested by Yury Norov)

v8:
 - split off the bitmap_read()/bitmap_write() series
 - simplified the compression logic (only compress data if it fits into
   a pointer)

v7:
 - fixed comments by Yury Norov, Andy Shevchenko, Rasmus Villemoes
 - added perf tests for bitmap_read()/bitmap_write()
 - more efficient bitmap_write() implementation (meant to be sent in v5)

v6:
 - fixed comments by Yury Norov
 - fixed handling of sizes divisible by MTE_GRANULES_PER_PAGE / 2
   (caught while testing on a real device)

v5:
 - fixed comments by Andy Shevchenko, Catalin Marinas, and Yury Norov
 - added support for 16K- and 64K pages
 - more efficient bitmap_write() implementation

v4:
 - fixed a bunch of comments by Andy Shevchenko and Yury Norov
 - added Documentation/arch/arm64/mte-tag-compression.rst

v3:
 - as suggested by Andy Shevchenko, use
   bitmap_get_value()/bitmap_set_value() written by Syed Nayyar Waris
 - switched to unsigned long to reduce typecasts
 - simplified the compression code

v2:
 - as suggested by Yuri Norov, replace the poorly implemented struct
   bitq with <linux/bitmap.h>


Alexander Potapenko (6):
  lib/test_bitmap: add tests for bitmap_{read,write}()
  lib/test_bitmap: use pr_info() for non-error messages
  arm64: mte: implement CONFIG_ARM64_MTE_COMP
  arm64: mte: add a test for MTE tags compression
  arm64: mte: add compression support to mteswap.c
  arm64: mte: implement CONFIG_ARM64_MTE_SWAP_STATS

Syed Nayyar Waris (1):
  lib/bitmap: add bitmap_{read,write}()

 Documentation/arch/arm64/index.rst            |   1 +
 .../arch/arm64/mte-tag-compression.rst        | 166 ++++++++
 arch/arm64/Kconfig                            |  37 ++
 arch/arm64/include/asm/mtecomp.h              |  39 ++
 arch/arm64/mm/Makefile                        |   2 +
 arch/arm64/mm/mtecomp.c                       | 260 +++++++++++++
 arch/arm64/mm/mtecomp.h                       |  12 +
 arch/arm64/mm/mteswap.c                       | 110 +++++-
 arch/arm64/mm/test_mtecomp.c                  | 364 ++++++++++++++++++
 include/linux/bitmap.h                        |  77 ++++
 lib/test_bitmap.c                             | 185 ++++++++-
 11 files changed, 1240 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/arch/arm64/mte-tag-compression.rst
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c
 create mode 100644 arch/arm64/mm/mtecomp.h
 create mode 100644 arch/arm64/mm/test_mtecomp.c

-- 
2.43.0.472.g3155946c3a-goog


