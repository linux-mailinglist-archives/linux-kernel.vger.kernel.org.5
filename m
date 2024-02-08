Return-Path: <linux-kernel+bounces-57361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BAF84D781
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE884B2280F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934EF14008;
	Thu,  8 Feb 2024 01:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQfiLZm+"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8A1E885;
	Thu,  8 Feb 2024 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707355367; cv=none; b=Ql5okxs05ajiHhMbGH54CMN7FimPw3Bnkc1MmSxDs6IKi0A6GKse1xpS8zZEt/A6YKaAb4/kdjIUtrZllR37vTbV7hOwfD3e41hudW0r9TD0Kot+83RJie9keC57pdbqnfgkf4nPr9AsKcTk96lwE7Yqvy0Z2RBBL30yY2ccnOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707355367; c=relaxed/simple;
	bh=Mm/LoXa3RB6B+MBL36Ib2qcdqqwIv2prBEiaoLJuQyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4ZEgQwcln9V/XbV764RRyn6UzVxH1K9ncOu8N3Ers0QGN8Zfc0Ui+snvWMCjQE6sC/btrnW+Ui40Sd3usCOPQVk+QKn1uSDRicubb+DmhZh5vn4OWw2xFbZ3rkJtsUEOtPRfwK/cfO4dSZ/HRu/dK6l8n/t4T8gPhZkmkhgbq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQfiLZm+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fff96d5daso11033105e9.0;
        Wed, 07 Feb 2024 17:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707355364; x=1707960164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kY0vgVMAWXvg6WdX7kWSrpFxwM9nLTP4P22qdJFLKnI=;
        b=bQfiLZm+TdFQLcpy42UK2WTzX89N5f51/pRxA7ks9cwgLooPAf+l54dBFIP3KaNqzI
         m0jB15nN+oLpEjDV+1okw9RrUNNQSNd6xfDSBrqZcuwqePsjoT+6DldUx1v0+VF9YacP
         MAtvixIYMjW5pSoJ9+W8HZ5ejrN8db4Opb/L3f2K15z6LWu9pUvrJqjMOp0UPeop5jlF
         6rSN6/FhiuB/MWD6iHz/CWb6G/yp9rmtqaVFsg1jopdJBpVyrQO4+haD76nO6t5/AcsM
         zeGk+8cxYebh3m6dPtiYFew7ArizslIU6mTQf0yoKsZuGr1oHzmBmVrVVyl9gJGBgTMu
         8LDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707355364; x=1707960164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kY0vgVMAWXvg6WdX7kWSrpFxwM9nLTP4P22qdJFLKnI=;
        b=axScRmMLwOEqCMRwj11a3KruajbjdGeyd4sYJNq1yOeQZUMj37+lP2Z0B1nQP7BCAu
         lLd5qc2GhgiY7MtZag0nwg4CgdjPPmPOsSqDFYXlXMqb4IT+zRTubgEJ/Br41YQ0rnid
         8/jkWdbhY+IBdnaV6PgFdN7t89jvouWj8oFeybddtmjdrNGx9q5yAzmj14oV+/4qxVbJ
         uM3+eeCiUTxekzJiUpg+z6sHs8olKcLE+cGvdTMeERTAq0xsXVASwwSUxlSTPwmEXTZ7
         pS92pvrLqzxA5aJKcNxvecUWiqhIStFYa9Si9I28EZH1CsYsiO5Y3ke4t+okSVUA89Ii
         9CsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPA64jQcowbr1okFhUwEHC6GBUKFfWX6J0CU1GImGVrxLQPd7iZP/q1VxKqQIyTzRWEigVzaCm4rn3NN32GKLOLvdPMurKrO/o0LpmgGNHzEBsL9Oz2Vsgxki8OlWUzGohYbbWHJE5HxRl
X-Gm-Message-State: AOJu0Yypz1/eeHUe/n4Wauhk7Tl17KHtwwpL4NYEhx/0/Mcwa6NGDgVS
	A+TOoboPCm79XTNNFHnzfToKRTsYQOlQkrugKFbDqU1ngCQ5ei2x
X-Google-Smtp-Source: AGHT+IGQfyAOB5pdzwLmMMlKecAQ7P88fZJEisR2tHxtc6hmhm0dZ/Fy4VcF+TPqRRA4nSh9MQJrCw==
X-Received: by 2002:a05:600c:3543:b0:40f:c1fc:e5b6 with SMTP id i3-20020a05600c354300b0040fc1fce5b6mr5694924wmq.38.1707355364099;
        Wed, 07 Feb 2024 17:22:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1eHQPE5BUroa8741BQMtqOa6Q3Ltc5RSdH3ErtrGeYLe8Xm6pGHsUedrwe1B8tYW8NHtdJ5Tio6FyolPLSS6AH46OVd1PmvzbQrhn8/qcjAoGyY4NSXVZAMV33WFicA0tbE/4fqACx4qSvJLZMDWZu6aYBguC+HjQdfgZZ5Fho50GpVVDLSt2/p5eSal/z7XlF5BVuksvA+1DDGsT6He2M2DnZXAmdThDH7nGz67NPFOUEcN750jA8KKbl7/p3/dAxbHThD9eJqyJwU8eK418Kv/1+uXQil4qoZSmPn1zL39LxlLOaUgM4p+nL2mCyOAtc2pG0Vc200Mc9b7sJrEw9J9YnfOcG04Su6q6zcrYFDu3CQ==
Received: from node-04.shui.grid ([31.94.24.68])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b0040ebf603a89sm161866wmq.11.2024.02.07.17.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 17:22:43 -0800 (PST)
From: Yuxuan Shui <yshuiv7@gmail.com>
To: llvm@lists.linux.dev
Cc: masahiroy@kernel.org,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	linux-kbuild@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH] kbuild: Fix building with LLVM on NixOS
Date: Thu,  8 Feb 2024 01:20:58 +0000
Message-ID: <20240208012057.2754421-2-yshuiv7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NixOS is designed to have immutable packages, and explicit dependencies.
It allows multiple different versions of the same shared library to
co-exist in its file system.

Each application built with Nix, the NixOS package manager, will have
paths to its dependency shared libraries hardcoded into its executable,
this includes the dynamic linker. To achieve this, Nix adds a
--dynamic-linker linker flag when building any application.

This isn't a problem if the kernel is built with ld.bfd, because ld.bfd
ignores the --dynamic-linker flag when the resulting binary doesn't have
a DT_NEEDED entry. However, ld.lld respects --dynamic-linker
unconditionally, which breaks linking in several cases.

This commit adds an explicit --no-dynamic-linker flag which overrides
the flag added by Nix.

Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
---
 Makefile                      | 3 +++
 arch/x86/boot/Makefile        | 2 +-
 arch/x86/realmode/rm/Makefile | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a171eafce2a3b..10ed19caecb1b 100644
--- a/Makefile
+++ b/Makefile
@@ -531,6 +531,9 @@ RUSTFLAGS_KERNEL =
 AFLAGS_KERNEL	=
 LDFLAGS_vmlinux =
 
+LDFLAGS_MODULE += --no-dynamic-linker
+LDFLAGS_vmlinux += --no-dynamic-linker
+
 # Use USERINCLUDE when you must reference the UAPI directories only.
 USERINCLUDE    := \
 		-I$(srctree)/arch/$(SRCARCH)/include/uapi \
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 3cece19b74732..390a4604166eb 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -102,7 +102,7 @@ $(obj)/zoffset.h: $(obj)/compressed/vmlinux FORCE
 AFLAGS_header.o += -I$(objtree)/$(obj)
 $(obj)/header.o: $(obj)/zoffset.h
 
-LDFLAGS_setup.elf	:= -m elf_i386 -z noexecstack -T
+LDFLAGS_setup.elf	:= --no-dynamic-linker -m elf_i386 -z noexecstack -T
 $(obj)/setup.elf: $(src)/setup.ld $(SETUP_OBJS) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index f614009d3e4e2..4b42006d9ce02 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -50,7 +50,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
 targets += realmode.lds
 $(obj)/realmode.lds: $(obj)/pasyms.h
 
-LDFLAGS_realmode.elf := -m elf_i386 --emit-relocs -T
+LDFLAGS_realmode.elf := --no-dynamic-linker -m elf_i386 --emit-relocs -T
 CPPFLAGS_realmode.lds += -P -C -I$(objtree)/$(obj)
 
 targets += realmode.elf
-- 
2.43.0


