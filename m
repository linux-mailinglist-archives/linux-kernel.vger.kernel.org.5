Return-Path: <linux-kernel+bounces-38883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D5B83C7BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9531F273E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DE7129A81;
	Thu, 25 Jan 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNadlyTj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81181292F0;
	Thu, 25 Jan 2024 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199554; cv=none; b=F0l/YkspZdH1/8vsXXHBIaAa9UyoxRyjPQX1O/LXq3W3uuHtOPNfERkHPyGKz/hww8QK5HI4WTcjt2S/lvKfpnHW3byZFLHX8v8aziWygEYu4H78BB3YJXsfVTJkjALQ66ZEO08zvnMPOcnfA9KstbZGRoZPEQsDqv1Q4hCz6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199554; c=relaxed/simple;
	bh=8tbd9J1L+yMyj8fzsk0GkL2j32nTCB7mGKmc36iSSsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US1oFLu0xH1WtyDNoTe2PaVwl1Ve6PtzGEl+MbZsEADSmFcjKWKwbxlCBMYJMhvbDTI1A8Va0eEQmb4vO7AIRxK0mxugF+RCnW5lJe4oCBccw3adyAKxq7cP7EXXrfTtOGrBISnxdKZmYnOYvsnbJ9xjuwKDOL6iU9yoZi9lKjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNadlyTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5980C433C7;
	Thu, 25 Jan 2024 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706199554;
	bh=8tbd9J1L+yMyj8fzsk0GkL2j32nTCB7mGKmc36iSSsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNadlyTjUCr+4tVYMsG05OiK0H6qg7GIMgXkusq8IrSrHO7QOypAtfCWrcelD17HW
	 /LPPMBR41J1doxkf+KXtEfpYnqFSVMGI/4Cwhw18sOgrQh+f8Y59SdXcs+4eIBWeUI
	 MvrA+oI6NNi3GEMfh42coRULv1nTX560miNOMkgteLjfFMwJWTbIJ7cUntC6FPkYDi
	 AfoLFQb8mn1Yq0jl3+VPSTR7A7UAhEgQHEOylD272yhUAuMBMYdIiwS4j6HL3r8rxs
	 HVqT8AVE7DSlePmdT23/m753AyAStku/I2QE0Oni6A2SkTTz4ztZHH47UIuEfcdhYa
	 X6OZd9MsSK46A==
Date: Thu, 25 Jan 2024 17:19:07 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2] ahci: add 43-bit DMA address quirk for ASMedia
 ASM1061 controllers
Message-ID: <ZbKJ++oBcTptpvlB@x1-carbon>
References: <ZbJ4Yfexzea2mQw8@wantstofly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbJ4Yfexzea2mQw8@wantstofly.org>

On Thu, Jan 25, 2024 at 05:04:01PM +0200, Lennert Buytenhek wrote:
> With one of the on-board ASM1061 AHCI controllers (1b21:0612) on an
> ASUSTeK Pro WS WRX80E-SAGE SE WIFI mainboard, a controller hang was
> observed that was immediately preceded by the following kernel
> messages:
> 
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: Using 64-bit DMA addresses
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00000 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00300 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00380 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00400 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00680 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00700 flags=0x0000]
> 
> The first message is produced by code in drivers/iommu/dma-iommu.c
> which is accompanied by the following comment that seems to apply:
> 
>         /*
>          * Try to use all the 32-bit PCI addresses first. The original SAC vs.
>          * DAC reasoning loses relevance with PCIe, but enough hardware and
>          * firmware bugs are still lurking out there that it's safest not to
>          * venture into the 64-bit space until necessary.
>          *
>          * If your device goes wrong after seeing the notice then likely either
>          * its driver is not setting DMA masks accurately, the hardware has
>          * some inherent bug in handling >32-bit addresses, or not all the
>          * expected address bits are wired up between the device and the IOMMU.
>          */
> 
> Asking the ASM1061 on a discrete PCIe card to DMA from I/O virtual
> address 0xffffffff00000000 produces the following I/O page faults:
> 
> [Tue Jan 23 21:31:55 2024] vfio-pci 0000:07:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000000 flags=0x0010]
> [Tue Jan 23 21:31:55 2024] vfio-pci 0000:07:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000500 flags=0x0010]
> 
> Note that the upper 21 bits of the logged DMA address are zero.  (When
> asking a different PCIe device in the same PCIe slot to DMA to the
> same I/O virtual address, we do see all the upper 32 bits of the DMA
> address as 1, so this is not an issue with the chipset or IOMMU
> configuration on the test system.)
> 
> Also, hacking libahci to always set the upper 21 bits of all DMA
> addresses to 1 produces no discernible effect on the behavior of the
> ASM1061, and mkfs/mount/scrub/etc work as without this hack.
> 
> This all strongly suggests that the ASM1061 has a 43 bit DMA address
> limit, and this commit therefore adds a quirk to deal with this limit.
> 
> This issue probably applies to (some of) the other supported ASMedia
> parts as well, but we limit it to the PCI IDs known to refer to
> ASM1061 parts, as that's the only part we know for sure to be affected
> by this issue at this point.
> 
> Link: https://lore.kernel.org/linux-ide/ZaZ2PIpEId-rl6jv@wantstofly.org/
> Signed-off-by: Lennert Buytenhek <kernel@wantstofly.org>
> ---

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.8-fixes

