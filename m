Return-Path: <linux-kernel+bounces-30497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A548B831F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81E11C232CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60F2E401;
	Thu, 18 Jan 2024 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG+azenK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE7A53;
	Thu, 18 Jan 2024 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605110; cv=none; b=jEKhfBFeaVqhbX6+V13PhznDub0RDX6F1nViqjFyP2e+4kdHRKZeV6WApFhsyEOXOKqOvfCuHoGlJjRI6oYKTbjXRtXm5aTrCYYjmrbHHlAeS/S2d0YA+uyDWkCybyHeovUcVGZ2jgP6R/N+xNKxMHvFE1n8uHV0dMRx5yVh5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605110; c=relaxed/simple;
	bh=CzGdsxbWfshAQQ1x1+6Iwwi7kLWw3u+Utd5pS0gHUvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4b52DCafq60TOeCF2ENL4C/EXWW/fZqPq4oN8Gp9RxaSEjlF6LTg0p/od2HylJVEY+1Ohh7stGrE5Dzm59r2ApW5/H5fjpimmT9gxeOcqEkRrvLm9kgAn7rgrUaUvkr5yNYjK5dUrXjaUGMc9lRbRNFUlxZUZj9ygV4nfZQ9+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG+azenK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB49C433F1;
	Thu, 18 Jan 2024 19:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705605110;
	bh=CzGdsxbWfshAQQ1x1+6Iwwi7kLWw3u+Utd5pS0gHUvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PG+azenKFTCrBS6VUA/0COoE3WL3pEpO8Q3dSfPnDnKNFFmrPMnQrW1Xsfgq/wY9E
	 vaAv4jdysU9lGrWF5wNfp5YTvX2fENcwWafE1ressJhz78AEaIl5JZQBU3H+4LCh8e
	 xRZnLaYK4r5AREkRyJufbT0IXMOXwpoZhUdGEiL8Eu2L80mFzYd6qXe+uQOn13AHJk
	 w71upUXFA7P+bmtsrBkhEUewveuzy+TDVbkPgB5nfRsBeV8xmLKFpuXrH2n8yEfOG9
	 aEs9pJ9CGuTO4PBIgca4yzShJZbFGf2IWWZbaLB9oNQcotGJcxDJLf0/B0lzOFZgse
	 7chD5R0wOPWIQ==
Date: Thu, 18 Jan 2024 12:11:48 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [GIT PULL]: dmaengine updates for v6.8
Message-ID: <20240118191148.GA3329935@dev-arch.thelio-3990X>
References: <ZalezMgxAVyu5WEE@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZalezMgxAVyu5WEE@matsya>

Hi Vinod,

On Thu, Jan 18, 2024 at 10:54:28PM +0530, Vinod Koul wrote:
> Heya Linus,
> 
> Last pull request for the night to receive the dmaengine subsystem
> updates containing one new driver, couple of device support (qualcomm,
> sf-pdma) and driver updates.
> 
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.8-rc1
> 
> for you to fetch changes up to 3d0b2176e04261ab4ac095ff2a17db077fc1e46d:
> 
>   dmaengine: xilinx: xdma: statify xdma_prep_interleaved_dma (2023-12-22 21:17:52 +0530)
> 
> ----------------------------------------------------------------
> dmaengine updates for v6.8
> 
>  New support:
>   - Loongson LS2X APB DMA controller
>   - sf-pdma: mpfs-pdma support
>   - Qualcomm X1E80100 GPI dma controller support
> 
>  Updates:
>   - Xilinx XDMA updates to support interleaved DMA transfers
>   - TI PSIL threads for AM62P and J722S and cfg register regions description
>   - axi-dmac Improving the cyclic DMA transfers
>   - Tegra Support dma-channel-mask property
>   - Remaining platform remove callback returning void conversions

<snip>

> Jan Kuliga (8):
>       dmaengine: xilinx: xdma: Get rid of unused code
>       dmaengine: xilinx: xdma: Add necessary macro definitions
>       dmaengine: xilinx: xdma: Ease dma_pool alignment requirements
>       dmaengine: xilinx: xdma: Rework xdma_terminate_all()
>       dmaengine: xilinx: xdma: Add error checking in xdma_channel_isr()
>       dmaengine: xilinx: xdma: Add transfer error reporting
>       dmaengine: xilinx: xdma: Prepare the introduction of interleaved DMA transfers
>       dmaengine: xilinx: xdma: Implement interleaved DMA transfers

This pull request appears to be missing some fixes for the clang
warnings introduced by this series, which will break the build with
CONFIG_WERROR=y:

https://lore.kernel.org/20231222-dma-xilinx-xdma-clang-fixes-v1-0-84a18ff184d2@kernel.org/

Cheers,
Nathan

