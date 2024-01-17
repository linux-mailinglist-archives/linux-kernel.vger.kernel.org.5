Return-Path: <linux-kernel+bounces-28477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEDB82FF06
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD281C2440D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A223BA4B;
	Wed, 17 Jan 2024 02:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LXOm7Z0t"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2479D2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 02:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460078; cv=none; b=t0EmP1ry5TcBL3NVt4gHpUkyeI8GudlpYFE+C6qu8FTZnDQEC1Jo9RN5GJ8r0iW2m6IcwT2T/1ip/BM4MAPFeOeBNihUyNVDHWFyrjpJ4y3w/xyAU0USQYdLEjuy98b6hr/3nKIG/hWTch6i9FZqvbP8qHI9BTS0HzePqu7CJtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460078; c=relaxed/simple;
	bh=W93XdAKoPAXGIl+AWcM9T4XvazvSTl8o1IPN58ULAuE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key; b=Wt9SdD2sHGZbHDMOz1XSB/EXiajO1Z3S5wyf3X9iAlPr2/1/5OTb4XfUyzDVE7u7lVyc5cyc2ch8jm+MsxD3lMPKdpphl234vTBpLbRfXOvWtJpQmBQWyJQMJJAKFjXGUAWn5rPUDmWQtnyfDAmyEgKa/UDg+gB9WOx/wA2oPs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LXOm7Z0t; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e0a64d94d1so2187643a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705460076; x=1706064876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPwaFGwJVXA165SJk4N6+fNaFaLuOX6/L3PIB61yMHc=;
        b=LXOm7Z0tm+Jt2WS4DDA9O7y+SfP8ur4ys/EsMnxSuzon13GEQgchxcStAkScen9YQJ
         dv2jATU0Xr1g004MzgwdukDRH+RAUCU2QwvLC+YfyeyJ+7y5rBy2l4TAlNHpUhKLsKQP
         Rqpaib9mcJRH3Ytn24/6pPvoy2hZE7re1Fe/cHcBFdBebelPVowZbFgAsarrbEvHv2J2
         11ypi7lx2tJOhnH9a252PRX8Is7kydvV1a0BhEJib3+gfjYPnqlnAZE3DuVqfRUGlFZg
         guLuS/DUlk5cuX9Zgvx31VEEz5v19qUE3csSMJwxyFveQQqb39PMbKDMpAw65maqAkWV
         HdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705460076; x=1706064876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPwaFGwJVXA165SJk4N6+fNaFaLuOX6/L3PIB61yMHc=;
        b=m+3uWKlIEfCVHTsjU1V3jBeKfygzq61ECy/JKbm1TlKRjjfehSbViYDo7lsUaEpht3
         OZpV8r8nwfNmfy/cOSWHwNkpS+Ewr7a7d9PNuuQUCCVcA14KDvdcbE4PA4M20zA5P3+H
         BaOYNl9oGkGTLGmNXQbftNIQJRsA8VpBXvI8MamITNt98epol+7wlM1jT76T+tzf3XEi
         xcwMI7/laP6qtku9Ie2S+Mx82y7PfJVGlHxLn7kI+YYRVDrbA5w0wOpsUf1g4US39Yad
         Vbl8yWAy2uq/3sMG6CEE8BIKSqHeE3SaqW9n7WlO2Yn4rwD51MKYVRnaJ7W45SnOXSvE
         hHAA==
X-Gm-Message-State: AOJu0Ywq0QHnUS71yOZ0JZC2pXxkMJGgFzohdtlpDqz0r8ePAxwLiVJy
	7xZ0tZdTtQ0mPxkHaF0pZJJVOgnmuoGwpg==
X-Google-Smtp-Source: AGHT+IG2W5nPmvH97IYcBVmrar6/f8At+4QvMr2HN81HHi6oDtpjNgquXeD30yYSxkgGR4doQp09Mg==
X-Received: by 2002:a05:6358:6f97:b0:175:c1b8:1e93 with SMTP id s23-20020a0563586f9700b00175c1b81e93mr5383301rwn.65.1705460075911;
        Tue, 16 Jan 2024 18:54:35 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id rs3-20020a17090b2b8300b0028ceafb9124sm12553531pjb.51.2024.01.16.18.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 18:54:35 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 16 Jan 2024 18:54:29 -0800
Subject: [PATCH v8 2/2] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-fencei-v8-2-43a42134f021@rivosinc.com>
References: <20240116-fencei-v8-0-43a42134f021@rivosinc.com>
In-Reply-To: <20240116-fencei-v8-0-43a42134f021@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705460071; l=4373;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=W93XdAKoPAXGIl+AWcM9T4XvazvSTl8o1IPN58ULAuE=;
 b=mbioW8hvb+fc9oAM1jsn3rFvzBIpUD5yFkmi25h07vFpa3+q1T19t+fxT6l+efMBjrYBI1ITp
 tzlAD9RklowD4E8uQqqmi0BM0GIZPSycHn6ejOQ4/T4iiEDD5FG76Ug
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Provide documentation that explains how to properly do CMODX in riscv.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 Documentation/arch/riscv/cmodx.rst | 96 ++++++++++++++++++++++++++++++++++++++
 Documentation/arch/riscv/index.rst |  1 +
 2 files changed, 97 insertions(+)

diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/riscv/cmodx.rst
new file mode 100644
index 000000000000..2ad46129d812
--- /dev/null
+++ b/Documentation/arch/riscv/cmodx.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================================================================
+Concurrent Modification and Execution of Instructions (CMODX) for RISC-V Linux
+==============================================================================
+
+CMODX is a programming technique where a program executes instructions that were
+modified by the program itself. Instruction storage and the instruction cache
+(icache) are not guaranteed to be synchronized on RISC-V hardware. Therefore, the
+program must enforce its own synchronization with the unprivileged fence.i
+instruction.
+
+However, the default Linux ABI prohibits the use of fence.i in userspace
+applications. At any point the scheduler may migrate a task onto a new hart. If
+migration occurs after the userspace synchronized the icache and instruction
+storage with fence.i, the icache will no longer be clean. This is due to the
+behavior of fence.i only affecting the hart that it is called on. Thus, the hart
+that the task has been migrated to may not have synchronized instruction storage
+and icache.
+
+There are two ways to solve this problem: use the riscv_flush_icache() syscall,
+or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl() and emit fence.i in
+userspace. The syscall performs a one-off icache flushing operation. The prctl
+changes the Linux ABI to allow userspace to emit icache flushing operations.
+
+As an aside, "deferred" icache flushes can sometimes be triggered in the kernel.
+At the time of writing, this only occurs during the riscv_flush_icache() syscall
+and when the kernel uses copy_to_user_page(). These deferred flushes happen only
+when the memory map being used by a hart changes. If the prctl() context caused
+an icache flush, this deferred icache flush will be skipped as it is redundant.
+Therefore, there will be no additional flush when using the riscv_flush_icache()
+syscall inside of the prctl() context.
+
+prctl() Interface
+---------------------
+
+Call prctl() with ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` as the first argument. The
+remaining arguments will be delegated to the riscv_set_icache_flush_ctx
+function detailed below.
+
+.. kernel-doc:: arch/riscv/mm/cacheflush.c
+	:identifiers: riscv_set_icache_flush_ctx
+
+Example usage:
+
+The following files are meant to be compiled and linked with each other. The
+modify_instruction() function replaces an add with 0 with an add with one,
+causing the instruction sequence in get_value() to change from returning a zero
+to returning a one.
+
+cmodx.c::
+
+	#include <stdio.h>
+	#include <sys/prctl.h>
+
+	extern int get_value();
+	extern void modify_instruction();
+
+	int main()
+	{
+		int value = get_value();
+		printf("Value before cmodx: %d\n", value);
+
+		// Call prctl before first fence.i is called inside modify_instruction
+		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_ON, PR_RISCV_CTX_SW_FENCEI, PR_RISCV_SCOPE_PER_PROCESS);
+		modify_instruction();
+
+		value = get_value();
+		printf("Value after cmodx: %d\n", value);
+		return 0;
+	}
+
+cmodx.S::
+
+	.option norvc
+
+	.text
+	.global modify_instruction
+	modify_instruction:
+	lw a0, new_insn
+	lui a5,%hi(old_insn)
+	sw  a0,%lo(old_insn)(a5)
+	fence.i
+	ret
+
+	.section modifiable, "awx"
+	.global get_value
+	get_value:
+	li a0, 0
+	old_insn:
+	addi a0, a0, 0
+	ret
+
+	.data
+	new_insn:
+	addi a0, a0, 1
diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/index.rst
index 4dab0cb4b900..eecf347ce849 100644
--- a/Documentation/arch/riscv/index.rst
+++ b/Documentation/arch/riscv/index.rst
@@ -13,6 +13,7 @@ RISC-V architecture
     patch-acceptance
     uabi
     vector
+    cmodx
 
     features
 

-- 
2.34.1


