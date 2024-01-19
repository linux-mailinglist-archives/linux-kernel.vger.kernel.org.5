Return-Path: <linux-kernel+bounces-31099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 731628328D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23115286C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C14EB2D;
	Fri, 19 Jan 2024 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jefq628Z"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A5E4CB5A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664105; cv=none; b=ska2ZpRSFJQHx9JGHBmg5TRv32mydBxQPy6sof3c6S+61zufTPaJVI8jzVOpLh6Na4JueC32qguJSoMHmPZGPPEhW0A3/YNtj6dsSZ/QQ8iiHIfBb2ufdzKt7S0I41/bby2Xgy3VLqj9JgYfOnNey4SM3QI9nhEtNlRnYTSI0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664105; c=relaxed/simple;
	bh=uyL8bNC7ma/3HaOi4wx55XD8BQt4u5BR2EwRAhg1g2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=joCmFWBAp0hnDGUejbbVFDSfafYQwxh2bhXJTNaFP3NihtPLVkpMUXVTxELoxdZZPIf5eBG3VI92Ncfz+KGgpo0MFCx1tb3iNcel4JgHAwl5nzmh1IqYLvF78axpfvZ5mrgcasXBKc2hLRLF7fZRsCC9JrAAnHfZVzoN6SE7Jac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jefq628Z; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bf2c826a5aso31754339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705664102; x=1706268902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xp7UR5FVgwMPuq2WVimakycKIljY+vuuiyqjnbxZrlU=;
        b=jefq628ZKAHumFIqOyGHdQOU2q5aXnfyXP77e2CdPALfa+aNYuSztzCOGIcOTG9fro
         DUaLGze/nKQmnvR7jUk4vKY3OsqeKb4XW8tvInFiAofslqGwGSPxVuAYVnr2/i0/GNWf
         lpy2XAIg2omVWuZx+/gJBzRGNKcqnDnzhkNLpmB3fnMfHym7IWFS95v/v6sJBh7q9JGW
         MHxpo+wWdS5hkuT/G6hw4KnxLIS25FsvvtPo79UxXq8oJz/FDed3liIxZHV2/Wkz6WC2
         kAWZ9MW12iQ3T4awn4BolmvH2Rmu/EP+f3VOIpmdc4+VBLiBzaRp5magEonmcXlJ0QdD
         pSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705664102; x=1706268902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xp7UR5FVgwMPuq2WVimakycKIljY+vuuiyqjnbxZrlU=;
        b=d0jSa2+PXpknB7MqB4p/3/95KnxCOt7mHKHwZY1vuvVzOKrA1NvjSQUIvXYX5/GQ0L
         GzyXgcZFX28pLj/eVWy00aRzy0M0RYi8C7ZLqO1TNEb/Q6eAtpaAuH0PCpvS2W0VKxdW
         G435ghilKDelzVxSOwo+z/1J2qiqvfQImudz4E0s44yAp2M3QXX1/lsAY9ubD7yRQtHp
         Iq07LLsrnKLL1sqo9AIBmgVBV4RH/eY/GqNj47kocOWwi9npTNdnOAHqbncGCBjDon4Z
         xOwN8ZEfka+JhMJ3UPS/XfswKydDDpRNX+vCKJjdfPAISvkf7qY5jBRJqU1xkwkchtBv
         OmWQ==
X-Gm-Message-State: AOJu0YynmQLeSkpg0cX+sbhAqefEHU3rhIjSNuoxr4nRumjniT2LtrSU
	7tPJzniMY5C57OuGe4qwq8FyX3LoZLeslCXdgihM+caxNzdWceYWtRXdKKeN2JY=
X-Google-Smtp-Source: AGHT+IHhZC2U/hjG0mise1koTMiVKhIOk+6bnofKSdYFddaeNjsDxTHYd5Kh49hCXzNRa8H1IDwPPQ==
X-Received: by 2002:a92:2907:0:b0:361:9315:5356 with SMTP id l7-20020a922907000000b0036193155356mr2449028ilg.10.1705664101928;
        Fri, 19 Jan 2024 03:35:01 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id a5-20020a92a305000000b0036062f40c51sm5347302ili.71.2024.01.19.03.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:35:01 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 0/5] RISC-V SBI debug console extension support
Date: Fri, 19 Jan 2024 17:04:44 +0530
Message-Id: <20240119113449.492152-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI v2.0 specification is now frozen. The SBI v2.0 specification defines
SBI debug console (DBCN) extension which replaces the legacy SBI v0.1
functions sbi_console_putchar() and sbi_console_getchar().
(Refer v2.0-rc5 at https://github.com/riscv-non-isa/riscv-sbi-doc/releases)

This series adds support for SBI debug console (DBCN) extension in
Linux RISC-V.

To try these patches with KVM RISC-V, use KVMTOOL from the
riscv_zbx_zicntr_smstateen_condops_v1 branch at:
https://github.com/avpatel/kvmtool.git

These patches can also be found in the riscv_sbi_dbcn_v6 branch at:
https://github.com/avpatel/linux.git

Changes since v5:
 - Rebased on commit 9d1694dc91ce7b80bc96d6d8eaf1a1eca668d847
   ("Merge tag 'for-6.8/block-2024-01-18' of git://git.kernel.dk/linux")
 - Added Acked-by from GregKH in PATCH3 and PATCH4

Changes since v4:
 - Rebased on Linux-6.7-rc2
 - Addressed Drew's comments in PATCH2
 - Improved sbi_debug_console_write/read() to directly take virtual
   address of data so that virtual address to physical address
   conversion can be shared between tty/serial/earlycon-riscv-sbi.c
   and tty/hvc/hvc_riscv_sbi.c
 - Addressed Samuel's comments in PATCH3 and PATCH4

Changes since v3:
 - Rebased on Linux-6.7-rc1
 - Dropped PATCH1 to PATCH5 of v3 series since these were merged through
   KVM RISC-V tree for Linux-6.7
 - Used proper error code in PATCH1
 - Added new PATCH2 which add common SBI debug console helper functions
 - Updated PATCH3 and PATCH4 to use SBI debug console helper functions

Changes since v2:
 - Rebased on Linux-6.6-rc5
 - Handled page-crossing in PATCH7 of v2 series
 - Addressed Drew's comment in PATCH3 of v2 series
 - Added new PATCH5 to make get-reg-list test aware of SBI DBCN extension

Changes since v1:
 - Remove use of #ifdef from PATCH4 and PATCH5 of the v1 series
 - Improved commit description of PATCH3 in v1 series
 - Introduced new PATCH3 in this series to allow some SBI extensions
   (such as SBI DBCN) do to disabled by default so that older KVM user space
   work fine and newer KVM user space have to explicitly opt-in for emulating
   SBI DBCN.
 - Introduced new PATCH5 in this series which adds inline version of
   sbi_console_getchar() and sbi_console_putchar() for the case where
   CONFIG_RISCV_SBI_V01 is disabled.

Anup Patel (4):
  RISC-V: Add stubs for sbi_console_putchar/getchar()
  RISC-V: Add SBI debug console helper routines
  tty/serial: Add RISC-V SBI debug console based earlycon
  RISC-V: Enable SBI based earlycon support

Atish Patra (1):
  tty: Add SBI debug console support to HVC SBI driver

 arch/riscv/configs/defconfig            |  1 +
 arch/riscv/include/asm/sbi.h            | 10 ++++
 arch/riscv/kernel/sbi.c                 | 66 +++++++++++++++++++++++++
 drivers/tty/hvc/Kconfig                 |  2 +-
 drivers/tty/hvc/hvc_riscv_sbi.c         | 37 +++++++++++---
 drivers/tty/serial/Kconfig              |  2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c | 27 ++++++++--
 7 files changed, 133 insertions(+), 12 deletions(-)

-- 
2.34.1


