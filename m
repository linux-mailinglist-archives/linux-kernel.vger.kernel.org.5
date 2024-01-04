Return-Path: <linux-kernel+bounces-16158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856BC8239E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0861C24B8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BF5A29;
	Thu,  4 Jan 2024 00:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K9u3fPtn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67BB367;
	Thu,  4 Jan 2024 00:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=PvvTbXmhAMvAx3EvwpM5Mlo58bbnIBsDOArf3j3dpaY=; b=K9u3fPtnJoKjaIQNMPo96hioTS
	An0hLOUXAlOm8o33qWjFsmq4l6KiJwovLr9vijbN/Th6lVBc854Og3qofgwEpYmvKoblxzQfd2vEp
	TAZivYFjNmbS8fDYbvoxOb/Fe1TG2uhM9yOuc3+lx2+wz8J7q1BS2jdAH5Y/+M9oRu+blYY3wpcV6
	UIj0N782nJhvmlZqh15o6WXHwjSmtkvyxkmDrLkyAzdd63AOFM9zcBIWj66beTEO2VIEP2umm2QcY
	lEuG1s+2dx5tyR2AMEZGdllFwAzyfyJqRVqGhxfsp2AJFUP/aJ8hqXFayE42xVvTk2h4ry4Cp8CTS
	7sBVFKFA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLC2D-00CWjL-14;
	Thu, 04 Jan 2024 00:56:33 +0000
Message-ID: <6de5f186-87ec-469f-8383-5e7b1f0b0657@infradead.org>
Date: Wed, 3 Jan 2024 16:56:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] MIPS: Fix typos
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-mips@vger.kernel.org
References: <20240103231605.1801364-1-helgaas@kernel.org>
 <20240103231605.1801364-7-helgaas@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103231605.1801364-7-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/24 15:16, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos, most reported by "codespell arch/mips".  Only touches comments,
> no code changes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-mips@vger.kernel.org
> ---
>  arch/mips/bcm47xx/buttons.c                            | 6 +++---
>  arch/mips/bcm63xx/clk.c                                | 4 ++--
>  arch/mips/boot/compressed/dbg.c                        | 2 +-
>  arch/mips/boot/elf2ecoff.c                             | 2 +-
>  arch/mips/cavium-octeon/csrc-octeon.c                  | 2 +-
>  arch/mips/cavium-octeon/executive/cvmx-boot-vector.c   | 2 +-
>  arch/mips/cavium-octeon/executive/cvmx-bootmem.c       | 2 +-
>  arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c     | 4 ++--
>  arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c   | 2 +-
>  arch/mips/cavium-octeon/executive/cvmx-pko.c           | 2 +-
>  arch/mips/cavium-octeon/octeon-platform.c              | 2 +-
>  arch/mips/fw/arc/promlib.c                             | 6 +++---
>  arch/mips/include/asm/debug.h                          | 2 +-
>  arch/mips/include/asm/io.h                             | 4 ++--
>  arch/mips/include/asm/mach-au1x00/au1000_dma.h         | 2 +-
>  arch/mips/include/asm/mach-au1x00/gpio-au1000.h        | 2 +-
>  arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h  | 2 +-
>  arch/mips/include/asm/mach-loongson64/loongson_hwmon.h | 2 +-
>  arch/mips/include/asm/mach-loongson64/loongson_regs.h  | 2 +-
>  arch/mips/include/asm/mach-malta/spaces.h              | 4 ++--
>  arch/mips/include/asm/mips-boards/bonito64.h           | 2 +-
>  arch/mips/include/asm/mips-cpc.h                       | 2 +-
>  arch/mips/include/asm/mipsregs.h                       | 4 ++--
>  arch/mips/include/asm/octeon/cvmx-bootinfo.h           | 2 +-
>  arch/mips/include/asm/octeon/cvmx-cmd-queue.h          | 6 +++---
>  arch/mips/include/asm/octeon/cvmx-pko.h                | 2 +-
>  arch/mips/include/asm/octeon/cvmx-pow.h                | 4 ++--
>  arch/mips/include/asm/octeon/octeon-model.h            | 4 ++--
>  arch/mips/include/asm/page.h                           | 2 +-
>  arch/mips/include/asm/pci.h                            | 2 +-
>  arch/mips/include/asm/pgtable-bits.h                   | 2 +-
>  arch/mips/include/asm/sgi/mc.h                         | 2 +-
>  arch/mips/include/asm/sn/klconfig.h                    | 2 +-
>  arch/mips/include/asm/sync.h                           | 2 +-
>  arch/mips/include/asm/thread_info.h                    | 2 +-
>  arch/mips/include/asm/timex.h                          | 2 +-
>  arch/mips/include/asm/vdso/vdso.h                      | 2 +-
>  arch/mips/include/uapi/asm/mman.h                      | 2 +-
>  arch/mips/include/uapi/asm/msgbuf.h                    | 2 +-
>  arch/mips/kernel/cpu-probe.c                           | 2 +-
>  arch/mips/kernel/kprobes.c                             | 2 +-
>  arch/mips/kernel/relocate.c                            | 2 +-
>  arch/mips/kernel/relocate_kernel.S                     | 2 +-
>  arch/mips/kernel/setup.c                               | 2 +-
>  arch/mips/kernel/signal.c                              | 2 +-
>  arch/mips/kernel/traps.c                               | 2 +-
>  arch/mips/kernel/vpe.c                                 | 4 ++--
>  arch/mips/kvm/emulate.c                                | 2 +-
>  arch/mips/loongson2ef/common/platform.c                | 2 +-
>  arch/mips/loongson64/smp.c                             | 2 +-
>  arch/mips/mm/c-r4k.c                                   | 2 +-
>  arch/mips/mm/cex-gen.S                                 | 2 +-
>  arch/mips/mm/tlb-r3k.c                                 | 2 +-
>  arch/mips/mm/tlb-r4k.c                                 | 2 +-
>  arch/mips/mm/tlbex.c                                   | 4 ++--
>  arch/mips/net/bpf_jit_comp32.c                         | 2 +-
>  arch/mips/pci/ops-loongson2.c                          | 2 +-
>  arch/mips/pci/pci-alchemy.c                            | 2 +-
>  arch/mips/pci/pci-ar2315.c                             | 2 +-
>  arch/mips/pci/pci-lantiq.c                             | 2 +-
>  arch/mips/pci/pci-octeon.c                             | 2 +-
>  arch/mips/pci/pci-xtalk-bridge.c                       | 2 +-
>  arch/mips/pci/pcie-octeon.c                            | 2 +-
>  arch/mips/ralink/mt7621.c                              | 2 +-
>  arch/mips/txx9/generic/pci.c                           | 2 +-
>  65 files changed, 80 insertions(+), 80 deletions(-)

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
#Randy

