Return-Path: <linux-kernel+bounces-76734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECFB85FBB5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FED0B245AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA78D14A4E5;
	Thu, 22 Feb 2024 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALJmU1DO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BC91474BF;
	Thu, 22 Feb 2024 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613926; cv=none; b=BHK1H79zU3h/t8ZKPGe30FuEnnMevkxhOe/1v0jBTI52Z0+sf5BfTj+FgwcZafJgj61ZS1HQ8VqFz01Ehx9f+jO2Xqiwn7NWZtzzWetctuoSJNUqd1ZmZU+eoN8eicDg0K0bjMBOreayYrkwNUak2Ar8NZ7yszKUFnO+1okw+DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613926; c=relaxed/simple;
	bh=sU70cMz1yfymjOqSB1LBgx6TJXTSzu9SGscJYJXAATw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li2ieQXzRF6EGwbsdN6Me5CSJ7UNf83yRszFE7r/Dto4NCYEzOuC/xohawTmWIpXfRus7t9l46Wpj7apP8jPbabdjAj5HoMCm8NSViRf/Uge8zYgwEf5r/Ohic3cFKlWEShlQnieC3+gE8vZHPE9Wp+GbVGgBUBZjE1Vc9AtI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALJmU1DO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9FCC433C7;
	Thu, 22 Feb 2024 14:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708613925;
	bh=sU70cMz1yfymjOqSB1LBgx6TJXTSzu9SGscJYJXAATw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALJmU1DOFbaEnQAP2l/WnjDpdmPh9P9A8yzVVGUqxm/iULpw25DtYbnepbDpWljFZ
	 nswvWaUHszQQImYnnozcHN9TXtv7vvg+8ZH0YLQUPKGE4c31fqInZgIvjvDrY5c+fc
	 snVVhKsccDTX3G7XNGYsQI37fEDXcJOYXNW6h2rINqWe8xtxO+fiC+X37fKi39EoEN
	 BUbAPzY25/QUo0NGzGDJOVr8cL1+DUyIBOogA6NswC6d5bmreGJfo9yzvbMKG8Zv4e
	 JdAbvGJOV9nDODKeK8G74ENKRxKHXX3sTLFwezHpfTQ3jG0w81qMBb9EC2/lzhwcGS
	 GHldtfp9zRtUQ==
Date: Thu, 22 Feb 2024 15:58:39 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Lennert Buytenhek <kernel@wantstofly.org>, dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 19/23] ahci: add 43-bit DMA address quirk for
 ASMedia ASM1061 controllers
Message-ID: <ZddhH_NIP17azp6i@fedora>
References: <20240202183926.540467-1-sashal@kernel.org>
 <20240202183926.540467-19-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202183926.540467-19-sashal@kernel.org>

Hello Sasha,

On Fri, Feb 02, 2024 at 01:39:15PM -0500, Sasha Levin wrote:
> From: Lennert Buytenhek <kernel@wantstofly.org>
> 
> [ Upstream commit 20730e9b277873deeb6637339edcba64468f3da3 ]
> 
> With one of the on-board ASM1061 AHCI controllers (1b21:0612) on an
> ASUSTeK Pro WS WRX80E-SAGE SE WIFI mainboard, a controller hang was
> observed that was immediately preceded by the following kernel
> messages:
> 
> ahci 0000:28:00.0: Using 64-bit DMA addresses
> ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00000 flags=0x0000]
> ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00300 flags=0x0000]
> ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00380 flags=0x0000]
> ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00400 flags=0x0000]
> ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00680 flags=0x0000]
> ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00700 flags=0x0000]
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
> vfio-pci 0000:07:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000000 flags=0x0010]
> vfio-pci 0000:07:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000500 flags=0x0010]
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
> [cassel: drop date from error messages in commit log]
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

I still don't see this commit in stable/linux-6.7.y branch?

Nor in:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git

What am I missing?

($subject had this patch marked as AUTOSEL, so I would have assumed that
it should have been merged by now, since this was 20 days ago.)


This patch in $subject is needed for another follow up patch which
failed to be backported because $subject patch is not in stable/linux-6.7.y:
https://lore.kernel.org/stable/2024021945-jockey-spending-9e68@gregkh/

(The follup up patch had CC: stable tag, but the patch in $subject
unfortunately forgot to add CC: stable tag.)

Could you please help to get both:
20730e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers")
and
51af8f255bda ("ahci: Extend ASM1061 43-bit DMA address quirk to other ASM106x parts")

backported to kernel 6.6 and 6.7.

No need to backport to older kernels, as this problem was first exposed by:
791c2b17fb40 ("iommu: Optimise PCI SAC address trick")
which started to put devices into >4GB DMA address range.


Kind regards,
Niklas

