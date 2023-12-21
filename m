Return-Path: <linux-kernel+bounces-8425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E184881B6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E09F28924A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B3E745CD;
	Thu, 21 Dec 2023 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iplUKz3+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7E56E2A1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d97b7c8efdso180847b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703163965; x=1703768765; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+JuPQ8wqNJlzJagstC7ldl3dtxeJYdR1Fvwuzn2zf0=;
        b=iplUKz3+zQcfMeyQMO8Y9loBTzLdNZqEdpDyazs+MV+GPR4gY/BIjBj2y7qTE2fPmV
         HgQcXqTL4gff6A34X0/xg8uDNeR8Hn5Bkm2qF2U3Z0/ONbdD53hI+wk+JqQ5toW+EqqY
         RU8ZwSNpIJxX7cLrCWs29e0NFI2ndzr55/63JmOGS9vfz/+yRd12dqZphx8BS57wI9Ji
         lz9wzu1UJ+6XACApXDMRFIeBNGJ+FnP2CGJWpQHVa3gyiZ2bxb3dahKhEIHvCRWnz4xJ
         B3GoHRkzRXEBHn68zbXw/PT7Nhdww3fcAds00SBQ3Hkbq4VCI/XYrxN2n5IN46LnYzT6
         ZmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703163965; x=1703768765;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+JuPQ8wqNJlzJagstC7ldl3dtxeJYdR1Fvwuzn2zf0=;
        b=FoKCCW7cFsi5aZWuGyBg1KQ3/NzSB/7YzBiAXOyl73ZZpFiPyjM1adbBBl/+tZYatM
         +dQ8Gn47myt1PC/AXofsp+WE0SwnIXYmv90ze4JfBCiz0KMgXviZH5CvcXfmv9HjXD/I
         2/9U+TfsNfphpIQYxMiVzWG7QBfHwygEZMFVQnvV6LUMl5rbC8/07ozH4dYLhGaxJyPT
         oljqNAiFd9prY0ZUEHK8tZqfTFEXqrru1qmlKZ/1nw/3PPb4rC3/QA668iYV3kY8K2Nr
         Zp+yBhX6Jt2BaWB+InfB88wdWs3Q51fRkIy1ZlmCIOZ2w8mBEa+zqn63MMGIba8HKiwa
         A5ag==
X-Gm-Message-State: AOJu0Yy2bjKblXu2NK4xgCCSUZM1+lvviARppKUrHiBv3oXi3hz+LLYm
	MR9D/Z2QS6H5W0BHI81w56M=
X-Google-Smtp-Source: AGHT+IHy7BDWEANLiGAImZQLqW1L1FrUfcyW89dxfgSoRdp/XfgRewLLnqOMWdZvV7yq1pzZCQwpXA==
X-Received: by 2002:a05:6a00:982:b0:6d8:1493:5a89 with SMTP id u2-20020a056a00098200b006d814935a89mr5469741pfg.59.1703163964996;
        Thu, 21 Dec 2023 05:06:04 -0800 (PST)
Received: from ruipeng-ThinkCentre-M730e-N010.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006d97eaba6cesm289326pfh.21.2023.12.21.05.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 05:06:04 -0800 (PST)
From: Ruipeng Qi <ruipengqi7@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Cc: zalbassam@google.com,
	dianders@chromium.org,
	mark.rutland@arm.com,
	lecopzer.chen@mediatek.com,
	maz@kernel.org,
	arnd@arndb.de,
	yury.norov@gmail.com,
	brauner@kernel.org,
	mcgrof@kernel.org,
	maninder1.s@samsung.com,
	michael.christie@oracle.com,
	samitolvanen@google.com,
	linux-arm-kernel@lists.infradead.org,
	qiruipeng@lixiang.com
Subject: [RFC PATCH 0/7] osdump: Add one new os minidump module
Date: Thu, 21 Dec 2023 21:05:55 +0800
Message-Id: <20231221130555.32551-1-ruipengqi7@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: qiruipeng <qiruipeng@lixiang.com>

Osdump is a new crash dumping solution aiming at specific embedded
devices within automotive or Industrial.
 - limited memory.
 - reboot as soon as possible when system fault.

In order to reduce dump file size and speed up dump process, it has the
following features:
 - no userspace memory, just designed for solving os issues.
 - no const data, such as text segment
 - dump core os data only.
   - bss, data segments which alloc static.
   - dynamic data
     - slub data for little size data.
     - some large size data.
 - compress dump data to reduce dump file size.

consist of large massive of uncontinuous data,so use binary data format
directly.

reasemble a standard elf format file with dump file and vmlinux, and
then parse it with crash tool.

Signed-off-by: qiruipeng <qiruipeng@lixiang.com>

qiruipeng (7):
  [RFC PATCH 1/7] osdump: Add one new os minidump module
  [RFC PATCH 2/7] osdump: reuse some code from crash_core to get
    vmcoreinfo
  [RFC PATCH 3/7] doc: Add osdump guide
  [RFC PATCH 4/7] dt-bindings: reserved-memory: Support osdump module
  [RFC PATCH 5/7] sched: access to runqueues by function
  [RFC PATCH 6/7] mm/slub: make slab data more observable
  [RFC PATCH 7/7] panic: invoke osdump when panic

 Documentation/admin-guide/index.rst           |   1 +
 Documentation/admin-guide/osdump.rst          |  94 +++
 .../bindings/reserved-memory/osdump.yaml      |  45 ++
 arch/arm64/Kconfig                            | 169 +++++
 arch/arm64/kernel/Makefile                    |   1 +
 drivers/of/platform.c                         |   1 +
 include/linux/buildid.h                       |   3 +-
 include/linux/osdump.h                        |   7 +
 kernel/Makefile                               |   2 +
 kernel/crash_core_mini.c                      | 275 ++++++++
 kernel/osdump/Makefile                        |   1 +
 kernel/osdump/compr.c                         | 252 ++++++++
 kernel/osdump/core.c                          | 608 ++++++++++++++++++
 kernel/osdump/extern.h                        |  13 +
 kernel/osdump/inode.c                         |  77 +++
 kernel/osdump/internal.h                      |  95 +++
 kernel/panic.c                                |   7 +
 kernel/printk/printk.c                        |   2 +-
 kernel/sched/core.c                           |   8 +
 lib/buildid.c                                 |   3 +-
 mm/slab.h                                     |   2 +
 mm/slub.c                                     |  38 +-
 22 files changed, 1700 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/osdump.rst
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/osdump.yaml
 create mode 100644 include/linux/osdump.h
 create mode 100644 kernel/crash_core_mini.c
 create mode 100644 kernel/osdump/Makefile
 create mode 100644 kernel/osdump/compr.c
 create mode 100644 kernel/osdump/core.c
 create mode 100644 kernel/osdump/extern.h
 create mode 100644 kernel/osdump/inode.c
 create mode 100644 kernel/osdump/internal.h

-- 
2.17.1


