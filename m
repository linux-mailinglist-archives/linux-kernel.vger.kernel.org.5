Return-Path: <linux-kernel+bounces-15832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 909C3823412
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 342D4B23534
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA81C68E;
	Wed,  3 Jan 2024 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfggN9kK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8B1C683
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC7EC433C7;
	Wed,  3 Jan 2024 18:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704305025;
	bh=a4K2VWj3u7JRyre9+JlkYDAmdFDWh8WsCwWxtjZX3EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfggN9kKCCLmoYM1LxFFq3RTJlHyHMKvJ8uzJsguFuJ4PruSBKBnOL4zdKAOtXXL1
	 wC68zN9NlaDYvnFn5RnZngtLidlv8wmesljjdox5jeKSIrZMDySP4GJdL22LZd8gha
	 NX6Gvr0K0pUOJ6+HkkpT4O5Ru7DmU2fmOt14yXrntkVnmoBExCkV7e6HJPwmrYlsCI
	 zMnplHFBdeuXNIR9JZlQR2uDcWX7VWS8+WD9s5Z4k47kCLzPRt7bzV4on7aQddH+Bp
	 xOrZL8YgxJXbysh3m8Ek1rpcbRRPlQ7EUDmGqRoOzzwjmj645pTfKrtnDUE/AzIo1q
	 W+RWi+1sCfJ/g==
Date: Wed, 3 Jan 2024 18:03:41 +0000
From: Will Deacon <will@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] arch/arm64: Fix typos
Message-ID: <20240103180341.GA6200@willie-the-truck>
References: <20240103004059.1758712-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103004059.1758712-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hey Bjorn,

On Tue, Jan 02, 2024 at 06:40:59PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos, most reported by "codespell arch/arm64".  Only touches comments,
> no code changes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/arm64/Kconfig                                         | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts | 2 +-
>  arch/arm64/boot/dts/apm/apm-shadowcat.dtsi                 | 2 +-
>  arch/arm64/boot/dts/apm/apm-storm.dtsi                     | 2 +-
>  arch/arm64/boot/dts/exynos/exynos7.dtsi                    | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi             | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts        | 2 +-
>  arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi           | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi                      | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi   | 2 +-
>  arch/arm64/boot/dts/qcom/sa8155p.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                 | 4 ++--
>  arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts           | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi      | 2 +-
>  arch/arm64/boot/dts/renesas/draak.dtsi                     | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts        | 2 +-
>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                 | 2 +-
>  arch/arm64/include/asm/assembler.h                         | 4 ++--
>  arch/arm64/include/asm/cpufeature.h                        | 4 ++--
>  arch/arm64/include/asm/kvm_hyp.h                           | 2 +-
>  arch/arm64/include/asm/pgtable.h                           | 2 +-
>  arch/arm64/include/asm/suspend.h                           | 2 +-
>  arch/arm64/include/asm/traps.h                             | 4 ++--
>  arch/arm64/kernel/acpi.c                                   | 2 +-
>  arch/arm64/kernel/cpufeature.c                             | 6 +++---
>  arch/arm64/kernel/entry-common.c                           | 2 +-
>  arch/arm64/kernel/entry-ftrace.S                           | 2 +-
>  arch/arm64/kernel/entry.S                                  | 2 +-
>  arch/arm64/kernel/ftrace.c                                 | 2 +-
>  arch/arm64/kernel/machine_kexec.c                          | 2 +-
>  arch/arm64/kernel/probes/uprobes.c                         | 2 +-
>  arch/arm64/kernel/sdei.c                                   | 2 +-
>  arch/arm64/kernel/smp.c                                    | 2 +-
>  arch/arm64/kernel/traps.c                                  | 2 +-
>  arch/arm64/kvm/arch_timer.c                                | 2 +-
>  arch/arm64/kvm/fpsimd.c                                    | 2 +-
>  arch/arm64/kvm/hyp/nvhe/host.S                             | 2 +-
>  arch/arm64/kvm/hyp/nvhe/mm.c                               | 4 ++--
>  arch/arm64/kvm/inject_fault.c                              | 2 +-
>  arch/arm64/kvm/vgic/vgic-init.c                            | 2 +-
>  arch/arm64/kvm/vgic/vgic-its.c                             | 4 ++--
>  41 files changed, 50 insertions(+), 50 deletions(-)

The maintenance of stuff under arch/arm64/ is distributed between a few
different trees, so I think you'll need to split this into separate
patches if you want to see it merged. Otherwise, it's going to lead to
painful cross-tree conflicts and I suspect it would just get dropped
seeing as it's not critical functionality.

The good news is that scripts/get_maintainer.pl knows about these trees
and, looking quickly at this diffstat, you probably just want
devicetree, kvmarm and me+Catalin.

Cheers,

Will

