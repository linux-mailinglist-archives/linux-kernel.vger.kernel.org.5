Return-Path: <linux-kernel+bounces-22380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEF0829CED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972B9281AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614B4BA8F;
	Wed, 10 Jan 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCb0wLcz"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6120FD;
	Wed, 10 Jan 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso931711566b.0;
        Wed, 10 Jan 2024 06:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704898561; x=1705503361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT2eSHWPMa0CfkUYcyephB76FUQGzAdMqHMJhGcnqGg=;
        b=lCb0wLczBNn5sxiqtBNUhHVj2vGxeFyLnH1AG2Nw954aIIJ0CAGybPDJbHoJ6BNk0+
         IlAsJuy7JHvOWOWmb+c5WEcscIrm94j0Z081UHPJagvq2bfQzHbBDhqagFrWc6Wk2bBt
         KVyy8IzUDRIM2mVduZL5lde8baDOdxUVL14tHZht4a00fwteexmD901aR68U6PtkM3Qt
         ELUyRsnql0w1Dp3AmesQEUe0AtKzsT7OWmhl5dGmzk2Qa6XNYaZtszJGCOslTHJz9t0o
         5rjHNKCc0H3J0GdmZ5Lx1aUbABZCW1ROFsBw+CoLBQ6au3bbyGWl5eEG5zHIfbjhsGzx
         9Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898561; x=1705503361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZT2eSHWPMa0CfkUYcyephB76FUQGzAdMqHMJhGcnqGg=;
        b=jMeNHiAFaVx+PSHgWMSc2sYDkWRO1Rzx04zH4YIY4MdQvKXKI/0cXYoZk4sFwIOoMC
         If3peo2eIfVGpkZxkB87SxLw0XmgILlNaN2MdQNJ8D9uvD/LyNhLMDkx1O1CCWtkAfRb
         tYAvdJfylQnW8oatx9+fr96MkOp6I1B8t594u+UIR5yiz+M+CpBGfa1EDa90lg0I5Eha
         kFIr0oqi5rhI1FQ6C9Wb7Pu0KGdbmSN/B94WCF1T/bq8wB108oy1EQYDXc52sNcjU0D6
         coyeNoOzIIH81CY+02AzPf1j4NUnsMq48q1rN99r60zoWl9BmqjSj0FKrUEO4GGyC202
         Oc7w==
X-Gm-Message-State: AOJu0YxbUbj6EdgERQsfuUq30FX5AvU2XyoBmhqyhZPy1gFNpSmY1oCU
	jUyOUoadgmK1/jO/j+3ZGOM=
X-Google-Smtp-Source: AGHT+IHrjyyhLlNqwU8/0GdBQslEryV7QKCfwc4yBbC9sDbUDW7k3PCxt9OHW7khy/4PiPOl6+oPtQ==
X-Received: by 2002:a17:907:9307:b0:a2a:dc24:849 with SMTP id bu7-20020a170907930700b00a2adc240849mr226303ejc.43.1704898561190;
        Wed, 10 Jan 2024 06:56:01 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.29.12])
        by smtp.gmail.com with ESMTPSA id bm3-20020a170906c04300b00a2a4efe7d3dsm2161032ejb.79.2024.01.10.06.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:56:00 -0800 (PST)
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
	linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 0/4] membarrier: riscv: Core serializing command
Date: Wed, 10 Jan 2024 15:55:29 +0100
Message-Id: <20240110145533.60234-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2 ([1]):
  - amaned inline comments
  - drop ARCH_HAS_MEMBARRIER, create membarrrier.rst

Changes since v1 ([2]):
  - add smp_mb() in switch_mm()
  - introduce ARCH_HAS_MEMBARRIER, amend documentation

Changes since RFC ([3]):
  - introduce prepare_sync_core_cmd()
  - fix nosmp builds

[1] https://lore.kernel.org/lkml/20231211094414.8078-1-parri.andrea@gmail.com/
[2] https://lore.kernel.org/lkml/20231127103235.28442-1-parri.andrea@gmail.com/
[3] https://lore.kernel.org/lkml/20230803040111.5101-1-parri.andrea@gmail.com/

Andrea Parri (4):
  membarrier: riscv: Add full memory barrier in switch_mm()
  membarrier: Create Documentation/scheduler/membarrier.rst
  locking: Introduce prepare_sync_core_cmd()
  membarrier: riscv: Provide core serializing command

 .../membarrier-sync-core/arch-support.txt     | 18 ++++++-
 Documentation/scheduler/index.rst             |  1 +
 Documentation/scheduler/membarrier.rst        | 37 ++++++++++++++
 MAINTAINERS                                   |  4 +-
 arch/riscv/Kconfig                            |  4 ++
 arch/riscv/include/asm/membarrier.h           | 50 +++++++++++++++++++
 arch/riscv/include/asm/sync_core.h            | 29 +++++++++++
 arch/riscv/mm/context.c                       |  2 +
 include/linux/sync_core.h                     | 16 +++++-
 init/Kconfig                                  |  3 ++
 kernel/sched/core.c                           | 16 ++++--
 kernel/sched/membarrier.c                     | 13 +++--
 12 files changed, 183 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/scheduler/membarrier.rst
 create mode 100644 arch/riscv/include/asm/membarrier.h
 create mode 100644 arch/riscv/include/asm/sync_core.h

-- 
2.34.1


