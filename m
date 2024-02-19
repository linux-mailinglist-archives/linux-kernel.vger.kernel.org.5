Return-Path: <linux-kernel+bounces-71595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C5E85A798
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC811F22E28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2BF3B1B2;
	Mon, 19 Feb 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d2qxBNZR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="owSaFPn1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84B3A260
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357206; cv=none; b=P59n4ZlIc76v/epdKU2cSce5sN/3iNVklM1grCQNYzkXfbsxWGD2p5DkO7q/+7jV7wdtAi6NE+jNw4MohFmv4E0EWnsyQnIWEa+hqnjJLRg00ZVBTK3UM3J8TfV0XjLv6BHJpyvOOYWvYPTnLSOHnNrdHHMPI5tWyHroyl62hpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357206; c=relaxed/simple;
	bh=AO+vzYiD2Z4LI7zbbqGTvVCPcLgWaBuHm2pmC2aRI4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=duynUCBrBeUrTJX3kRbYAFhXKhBRvdv4QCXiU+jx3c0Nz2xPzpNDGW85G1SHq20ieHtEU7ZDXN0h/4HkIS9aaj8Kts9tLwU4h2/FZQoFRYzZTfsIt9OiHRHQMoYOA44ZQKJYYIyj/fctwvwRYNt1LEsjRRPBPH6Faz07HokzS2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d2qxBNZR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=owSaFPn1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708357203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YgcJpPFNarJHeRkyGaRjyPHvVYb0xflkH2hUr0RoxxY=;
	b=d2qxBNZR5IFb2I4xtkO+ICSJgjOP6jKiTvleSapkUlA7WZzuoU3SaMg0XADjvzLjQhTbV/
	JJXOdvF10nioLLMTCllU5KlR8G7gjqPz5T39VuplCHH2sS5pnme3o0APjUhX0F7K84xRMg
	dTMyjG3Is6pbjC5LSlHXR+2DoUZlrFch6OgSyGvRbMw9kBJqGu2uDyMP8oE1LSJNApG0MD
	QgbFK619YAwU4aiGeWCygnN5yEs9hVBwasdiqo3R/8jg84q99++WLs4QCou9avyEdFe8PL
	ddUapHsIQpuV8SIhhQXFa8xtQvKzK6k+oRpnN8XP56N52qyQVR8RtQ0WPouBug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708357203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YgcJpPFNarJHeRkyGaRjyPHvVYb0xflkH2hUr0RoxxY=;
	b=owSaFPn1YQNNI1zsdryCykTkOwg1YMTQWBbhcCt0fgUEyXEk4M5RHhI7eUj1I+KTEH4v7t
	R14esfeOOPG4YaBA==
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 00/10] vdso: Misc cleanups and prevent code duplication
Date: Mon, 19 Feb 2024 16:39:29 +0100
Message-Id: <20240219153939.75719-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

the vdso related cleanup queue contains two parts:

- Patch 1-3: Misc cleanups related to a comment, a superfluous header
	     include and ifdeffery

- Patch 4-10: The union vdso_data_store is defined in seven
  	      architectures. Make this union available in a generic vdso
  	      header file to prevent code duplication and fix the
  	      architectures one by one to use the generic vdso_data_store.

Thanks,

	Anna-Maria


Anna-Maria Behnsen (10):
  vdso/helpers: Fix grammar in comments
  s390/vdso/data: Drop unnecessary header include
  csky/vdso: Remove superfluous ifdeffery
  vdso/arm: make union vdso_data_store available for all
  arm64/vdso: Use generic union vdso_data_store
  riscv/vdso: Use generic union vdso_data_store
  s390/vdso: Use generic union vdso_data_store
  loongarch/vdso: Use generic union vdso_data_store
  mips/vdso: Use generic union vdso_data_store
  csky/vdso: Use generic union vdso_data_store

 arch/arm/include/asm/elf.h           |  1 -
 arch/arm/include/asm/vdso_datapage.h | 26 --------------------------
 arch/arm/kernel/asm-offsets.c        |  4 +++-
 arch/arm/kernel/vdso.c               |  4 ----
 arch/arm64/kernel/vdso.c             |  5 +----
 arch/csky/include/asm/vdso.h         |  5 -----
 arch/csky/kernel/vdso.c              | 14 ++------------
 arch/loongarch/kernel/vdso.c         |  6 ++----
 arch/mips/include/asm/vdso.h         |  5 -----
 arch/mips/kernel/vdso.c              |  2 +-
 arch/riscv/kernel/vdso.c             |  8 +-------
 arch/s390/include/asm/vdso/data.h    |  1 -
 arch/s390/kernel/vdso.c              |  5 +----
 include/vdso/datapage.h              | 10 ++++++++++
 include/vdso/helpers.h               |  8 ++++----
 15 files changed, 25 insertions(+), 79 deletions(-)
 delete mode 100644 arch/arm/include/asm/vdso_datapage.h

-- 
2.39.2


