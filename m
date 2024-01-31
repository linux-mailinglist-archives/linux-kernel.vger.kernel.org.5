Return-Path: <linux-kernel+bounces-46628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F83844231
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD52AB2A411
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB99D84A3A;
	Wed, 31 Jan 2024 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmbMOYqV"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A010384A34;
	Wed, 31 Jan 2024 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712610; cv=none; b=Q+kKwtPqzu8Bl/goJg5RrQTCqoPuk2W9bU466esW7DPbLhnCCmZqKNUCFClQkcMuHTf3Sk4Gf3Ca6LfNU4QP9llVXvr9fgvLFgBEnidMzLowfUSh5OnOpz7B41Z/VdOTnqC2GALNR1Ip9ffbN1dy8khi/RUKV7N2syj2A+EmAgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712610; c=relaxed/simple;
	bh=QVvydXuMo1O34KlKadybuE+xw5xzbjn4KfFQXWjGEgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pTvt14dnYnPyUcVWOA/VZcodLuR9EbgN+vkHVoykfUhVoa79PomSfFLZn5ra/ZqSiGcuoAldqohGnmibuUiEfCtuR4NGoNHBRhKrUJYNvwRlOmQjrFSvsf2sQ+roFGJbqqPb3AOaoYd+HAkHYOoHGC2k5Ja/gpYuqQ/oqcQ4Ruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmbMOYqV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3394bec856fso646960f8f.0;
        Wed, 31 Jan 2024 06:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706712607; x=1707317407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1YLIh2nVQJJCIilz81iyZeLDwXJ42HsJIqsijT+HGw=;
        b=ZmbMOYqVE7SDMLwFE+KEEGKRD3oRSOvanPrAhaKilBu2JZlr87E0MgrBvJ3ePsJZpc
         KDZc2JAY60k0GstM+hg5TkphLljiMl99VLFqFZ0e0m7tyA47bwoYwOMaNX9d3uZ1Dx1N
         NbAvlzxpZnHTb/6Hmq18SObYlInYrUfYSfg3mA6xHS+qJsNwmkhgz/zZPmL8o5P11M3o
         2nMEeBQIZ3tGVUCPCz9iIXORnxwA9VuVPwNzGq1iodcSCe8YRcH0aZol6ljTd80bxI14
         aAMvguiLDtS4tduBKTSE/I5seTlLe3W7VZMdQtRBmGKDKnvuGM9nQ07N7zMiAQxzsrCW
         7M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712607; x=1707317407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1YLIh2nVQJJCIilz81iyZeLDwXJ42HsJIqsijT+HGw=;
        b=cX8OiiY6GRgxwkWk0/rcpExrG6tWNiGvJ9YJf+eYPlVh1PabZ1DTtS3ywvnNZXOJ7U
         MtipQzS1+gW28SJIp92Su0pt3zH5VeKuqtsfZj/Wfrv9j1hi1e8rS4+vF+WbRDjZPC6S
         /zMyo8KyGXn1nJ4DqSmtIRE1m46tbwhlB0rznm/q7uX4X/N3f4uOHM6hOs586GxK5uS5
         RNL8tZsezM3EaTwdyYZhSllRc/RLhgQ+83ykz9/iaSbfdmBZzzERNrB+tWrFU79y21op
         uAXEztPRrC0RulD575v4hdfnX6/KIx+nXKANnmtTPEA7aBFz7mE01ovPv6Df2Paxxh4d
         i3Ew==
X-Gm-Message-State: AOJu0YxkFM48E1sMNxl1H8YBkkzpgXBg2KUrDDLGoj4DtIVpPT7iyQpU
	aj/EkbSpyPvkWWrKYsIFXIpLCIHvNFMqazRwVWFkVqpChKokx9JB
X-Google-Smtp-Source: AGHT+IF1ghLuZMInvOU4hSpQjCeevup4f1d0A02ll5lGsKhvvzHZpWEf5ue0F6K1TZzPHtX6RtGLrQ==
X-Received: by 2002:adf:e8c2:0:b0:33a:f277:8f6 with SMTP id k2-20020adfe8c2000000b0033af27708f6mr4479255wrn.14.1706712606529;
        Wed, 31 Jan 2024 06:50:06 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.8.91])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d4046000000b0033b0d049c71sm419265wrp.54.2024.01.31.06.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:01 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	corbet@lwn.net
Cc: mmaas@google.com,
	hboehm@google.com,
	striker@us.ibm.com,
	charlie@rivosinc.com,
	rehn@rivosinc.com,
	rdunlap@infradead.org,
	sorear@fastmail.com,
	linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v4 0/4] membarrier: riscv: Core serializing command
Date: Wed, 31 Jan 2024 15:49:32 +0100
Message-Id: <20240131144936.29190-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3 ([1]):
  - amend documentation

Changes since v2 ([2]):
  - amend inline comments
  - drop ARCH_HAS_MEMBARRIER, create membarrrier.rst

Changes since v1 ([3]):
  - add smp_mb() in switch_mm()
  - introduce ARCH_HAS_MEMBARRIER, amend documentation

Changes since RFC ([4]):
  - introduce prepare_sync_core_cmd()
  - fix nosmp builds

[1] https://lore.kernel.org/lkml/20240110145533.60234-1-parri.andrea@gmail.com/
[2] https://lore.kernel.org/lkml/20231211094414.8078-1-parri.andrea@gmail.com/
[3] https://lore.kernel.org/lkml/20231127103235.28442-1-parri.andrea@gmail.com/
[4] https://lore.kernel.org/lkml/20230803040111.5101-1-parri.andrea@gmail.com/

Andrea Parri (4):
  membarrier: riscv: Add full memory barrier in switch_mm()
  membarrier: Create Documentation/scheduler/membarrier.rst
  locking: Introduce prepare_sync_core_cmd()
  membarrier: riscv: Provide core serializing command

 .../membarrier-sync-core/arch-support.txt     | 18 ++++++-
 Documentation/scheduler/index.rst             |  1 +
 Documentation/scheduler/membarrier.rst        | 39 +++++++++++++++
 MAINTAINERS                                   |  4 +-
 arch/riscv/Kconfig                            |  4 ++
 arch/riscv/include/asm/membarrier.h           | 50 +++++++++++++++++++
 arch/riscv/include/asm/sync_core.h            | 29 +++++++++++
 arch/riscv/mm/context.c                       |  2 +
 include/linux/sync_core.h                     | 16 +++++-
 init/Kconfig                                  |  3 ++
 kernel/sched/core.c                           | 16 ++++--
 kernel/sched/membarrier.c                     | 13 +++--
 12 files changed, 185 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/scheduler/membarrier.rst
 create mode 100644 arch/riscv/include/asm/membarrier.h
 create mode 100644 arch/riscv/include/asm/sync_core.h

-- 
2.34.1


