Return-Path: <linux-kernel+bounces-19405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B43826C76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684FD2833A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8AF14296;
	Mon,  8 Jan 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAM5hlPJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B614265
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-557bfc7f7b4so778841a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 03:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704712845; x=1705317645; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jFZ/aY6YAF2a8QTh5nZNWh7zoJsse0NBjT30LEkRdxo=;
        b=EAM5hlPJjkwnhQyv6WEniawy0R7FpaL9JPX4evOvzaZoViJO8LfKbtWdlSiOKKgWuP
         iGBceQ3d9QgELY85GTgAwc1nU1H4W3VU0ZpjzOR9/h5iooHT1manG8u3vOkf0/r2ClkC
         tTPMm7SqSRBoWlzelo5hLic94PKjLn7NAwuNAM7gjCtFA4RrMgLUCTTjD5dn+mereMz3
         0drzEvhZjmySezuEL+ZboUSEx/uxreV2opCaA0TOt4eykvPenqM5PoPBsYbGlpe4k/Ud
         IyVLOkD7CDqut2X14iUf+ZsbFSHbp4WTjbZ4h98lzR38Orrk3P1GtwL5ce5vpwTQHPvO
         SPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704712845; x=1705317645;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFZ/aY6YAF2a8QTh5nZNWh7zoJsse0NBjT30LEkRdxo=;
        b=XwPHJDPa+4LaiLrgY/fPGN5viDT5uuauRKDDZxqT7oQmG/IqrQ/h+hEmAfK2+PY8Hm
         NN10/KwFaricp21ErZtNnZOdefJyEPvMh1FAmB2zsFzl7PhrV9gh4/78qihgcR0Yyt+E
         fw/0GS4IzwboyDX42wxj4rand7OPFyPXdW0d35khJXEgR9WS/d2IYgk5YQTJMprayVOs
         VvD3Pk+/x7ltCV6UZyfaClKGf/XcTHPad091ESTTXuRqlAWbJ0IYYfhvZaMvqdOmfOqw
         wdh3BqvTBiJtEt1DuXNZtkGZAaHcNvS5oess8eQlipcIYjSURRB+bR9dj6c/da+EAo2p
         8evQ==
X-Gm-Message-State: AOJu0YzLrTEbWuwE27bRi8DnBLErgqDob68MznM7yWzaxd0cCM1iH1tx
	n776K89XaywrywcJQQODiiwlqf4OZTs=
X-Google-Smtp-Source: AGHT+IHuO1PBjmJjN4yuiVpDJat+s2kWzzGCZwq0C8DA6Jbg9oqro/mR6GKDiA3wyH5Z4FtoPcnR/g==
X-Received: by 2002:a17:906:3bdb:b0:a26:cdae:e295 with SMTP id v27-20020a1709063bdb00b00a26cdaee295mr2887338ejf.74.1704712845331;
        Mon, 08 Jan 2024 03:20:45 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id t20-20020a170906609400b00a28badcf367sm3841208ejj.54.2024.01.08.03.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:20:44 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 12:20:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/cleanups for v6.8
Message-ID: <ZZvai7moEceR95bP@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/cleanups git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-01-08

   # HEAD: 54aa699e8094efb7d7675fefbc03dfce24f98456 arch/x86: Fix typos

x86/cleanups changes for v6.8:

 - A micro-optimization got misplaced as a cleanup:
    - Micro-optimize the asm code in secondary_startup_64_no_verify()

 - Change global variables to local
 - Add missing kernel-doc function parameter descriptions
 - Remove unused parameter from a macro
 - Remove obsolete Kconfig entry
 - Fix comments
 - Fix typos, mostly scripted, manually reviewed

 Thanks,

	Ingo

------------------>
Bjorn Helgaas (1):
      arch/x86: Fix typos

Borislav Petkov (AMD) (1):
      x86/mtrr: Document missing function parameters in kernel-doc

Lukas Bulwahn (1):
      x86/Kconfig: Remove obsolete config X86_32_SMP

Nikolay Borisov (1):
      x86/docs: Remove reference to syscall trampoline in PTI

Uros Bizjak (1):
      x86/head_64: Use TESTB instead of TESTL in secondary_startup_64_no_verify()

Yuntao Wang (2):
      x86/setup: Make relocated_ramdisk a local variable of relocate_initrd()
      x86/io: Remove the unused 'bw' parameter from the BUILDIO() macro


 Documentation/arch/x86/pti.rst               | 10 ++++------
 arch/x86/Kconfig                             |  4 ----
 arch/x86/boot/compressed/Makefile            |  2 +-
 arch/x86/boot/compressed/mem.c               |  2 +-
 arch/x86/coco/tdx/tdx.c                      |  2 +-
 arch/x86/crypto/aesni-intel_asm.S            |  2 +-
 arch/x86/crypto/aesni-intel_avx-x86_64.S     |  2 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    |  2 +-
 arch/x86/crypto/sha512-avx-asm.S             |  2 +-
 arch/x86/crypto/sha512-ssse3-asm.S           |  2 +-
 arch/x86/events/amd/brs.c                    |  2 +-
 arch/x86/events/amd/core.c                   |  2 +-
 arch/x86/events/intel/core.c                 |  2 +-
 arch/x86/hyperv/hv_apic.c                    |  2 +-
 arch/x86/hyperv/irqdomain.c                  |  2 +-
 arch/x86/hyperv/ivm.c                        |  2 +-
 arch/x86/include/asm/amd_nb.h                |  2 +-
 arch/x86/include/asm/extable_fixup_types.h   |  2 +-
 arch/x86/include/asm/fpu/types.h             |  2 +-
 arch/x86/include/asm/io.h                    |  8 ++++----
 arch/x86/include/asm/iosf_mbi.h              |  2 +-
 arch/x86/include/asm/kvm_host.h              |  2 +-
 arch/x86/include/asm/nospec-branch.h         |  4 ++--
 arch/x86/include/asm/pgtable_64.h            |  2 +-
 arch/x86/include/asm/setup.h                 |  2 --
 arch/x86/include/asm/uv/uv_hub.h             |  2 +-
 arch/x86/include/asm/vdso/gettimeofday.h     |  2 +-
 arch/x86/include/asm/xen/interface_64.h      |  2 +-
 arch/x86/include/uapi/asm/amd_hsmp.h         |  2 +-
 arch/x86/kernel/alternative.c                |  2 +-
 arch/x86/kernel/amd_gart_64.c                |  2 +-
 arch/x86/kernel/apic/Makefile                |  2 +-
 arch/x86/kernel/apic/apic.c                  |  2 +-
 arch/x86/kernel/apic/vector.c                |  4 ++--
 arch/x86/kernel/cpu/mtrr/generic.c           | 14 ++++++++++----
 arch/x86/kernel/cpu/sgx/ioctl.c              |  2 +-
 arch/x86/kernel/fpu/core.c                   |  2 +-
 arch/x86/kernel/head_64.S                    |  6 +++---
 arch/x86/kernel/hpet.c                       |  4 ++--
 arch/x86/kernel/kvm.c                        |  2 +-
 arch/x86/kernel/kvmclock.c                   |  2 +-
 arch/x86/kernel/ldt.c                        |  6 +++---
 arch/x86/kernel/process.c                    |  2 +-
 arch/x86/kernel/setup.c                      |  4 +---
 arch/x86/kernel/sev-shared.c                 |  2 +-
 arch/x86/kvm/cpuid.c                         |  2 +-
 arch/x86/kvm/mmu/mmu.c                       |  4 ++--
 arch/x86/kvm/mmu/tdp_iter.c                  |  2 +-
 arch/x86/kvm/svm/svm.c                       |  2 +-
 arch/x86/kvm/vmx/nested.c                    |  2 +-
 arch/x86/kvm/vmx/vmx.c                       |  2 +-
 arch/x86/kvm/x86.c                           |  6 +++---
 arch/x86/lib/delay.c                         |  2 +-
 arch/x86/mm/init_64.c                        |  6 +++---
 arch/x86/mm/pat/memtype.c                    |  2 +-
 arch/x86/mm/pat/set_memory.c                 |  4 ++--
 arch/x86/mm/pti.c                            |  2 +-
 arch/x86/mm/tlb.c                            |  2 +-
 arch/x86/net/bpf_jit_comp.c                  |  2 +-
 arch/x86/net/bpf_jit_comp32.c                |  2 +-
 arch/x86/platform/intel-quark/imr_selftest.c |  2 +-
 arch/x86/platform/pvh/head.S                 |  2 +-
 arch/x86/platform/uv/uv_nmi.c                |  2 +-
 arch/x86/platform/uv/uv_time.c               |  2 +-
 arch/x86/realmode/init.c                     |  2 +-
 arch/x86/xen/mmu_pv.c                        |  2 +-
 66 files changed, 92 insertions(+), 96 deletions(-)

