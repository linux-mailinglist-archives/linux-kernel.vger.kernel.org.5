Return-Path: <linux-kernel+bounces-15047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176468226A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F7283EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52801798F;
	Wed,  3 Jan 2024 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1BTa+pMj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA921798A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=BYEWv3AU3ZH/3rwF7R0TMgwo/es+rhv2a2chPii19T0=; b=1BTa+pMjpVtvGbWVOsZM2u/FtO
	C6/Crq5DNuO3aQNPEfPCmAslemL3ssX2D0EOZeoECDuY6XHgcKMCBTJfjO4IX7fTKEAWE+QdIHea+
	3LKTx5uzAAORSzaanYOazKxRQMjiSqYnURfR4egyD+akYUH9pwjYV6zzXlVXjgQOlv7oVaY+RuFSp
	kWdOWhb7Ty6YO+a6+BIjxdnRqwbEnRwBkTz6a6HSnKOdF06lOrEFZEApLPTGjAWdlQPtwk2O4mEor
	S6vaYFm8pvPB26ddPAv2szP1wc6Z1y4GiFsE0HCq7HtGwSMZ47IYQdMBiO0zTtPp1O1QvMQSl4XYN
	xS4k8SSw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rKqOp-009W40-0s;
	Wed, 03 Jan 2024 01:50:27 +0000
Message-ID: <f8c72e04-687d-488c-a14d-c6574601028c@infradead.org>
Date: Tue, 2 Jan 2024 17:50:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/arm64: Fix typos
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240103004059.1758712-1-helgaas@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103004059.1758712-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/2/24 16:40, Bjorn Helgaas wrote:
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
> 

> diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
> index ffb7ab695213..1bc86a8529e1 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
> @@ -4,7 +4,7 @@
>   *
>   * SA8155P is an automotive variant of SM8150, with some minor changes.
>   * Most notably, the RPMhPD setup differs: MMCX and LCX/LMX rails are gone,
> - * though the cmd-db doesn't reflect that and access attemps result in a bite.
> + * though the cmd-db doesn't reflect that and access attempts result in a bite.

bite, eh?

>   */
>  
>  #include "sm8150.dtsi"


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
#Randy

