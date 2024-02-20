Return-Path: <linux-kernel+bounces-73094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A185BD80
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551371F24A17
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3DC6A35C;
	Tue, 20 Feb 2024 13:48:53 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A3C6A34D;
	Tue, 20 Feb 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436933; cv=none; b=BUsz3cqLOyhXc2xhS8Skrp18Qy8vUaXKjemL7YV5X17Giq0ydKS1f1g6Dva1CVsj9VFfHD8H2EiboUVlTjbNjskLpecbvls01xhxyB8asZtDNFn5JMGnORNDvUBZwjk1ImSl+S4ys2I5ouoc2jkgzdDsySYYG8c2GytoIsX3zvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436933; c=relaxed/simple;
	bh=SiT20wtehEPRsqC5dEyX1J9e16e0CyE5AYMI3VsMc2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdofKwK8BE8qOL0uD7tQbp3JcWlU94UQnalOVoEpfRdt+8CUOvuzyqajm0qR25q2rAivkJtfw65MuKfIZt7l02jJlSVJEXphaEfcBBb3GPc68qX3JKL1XgsCffu027K6mViitNKpz3d6URfjt+pUEdvuehMeZEGwmPPLVXCeIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rcQUF-0007OW-00; Tue, 20 Feb 2024 14:48:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id F34C6C0832; Tue, 20 Feb 2024 14:39:14 +0100 (CET)
Date: Tue, 20 Feb 2024 14:39:14 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>
Subject: Re: [PATCH v2 0/4] MIPS: Cleanups to PCI related code
Message-ID: <ZdSrgqwuyEHUmgeq@alpha.franken.de>
References: <20240208120959.2513-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208120959.2513-1-ilpo.jarvinen@linux.intel.com>

On Thu, Feb 08, 2024 at 02:09:55PM +0200, Ilpo Järvinen wrote:
> Cleans up PCI related code.
> 
> v2:
> - Convert also return 0 -> return PCIBIOS_SUCCESSFUL
> 
> Ilpo Järvinen (4):
>   MIPS: lantiq: Remove unused function pointer variables
>   MIPS: ath79: Don't return PCIBIOS_* code from pcibios_enable_device()
>   MIPS: PCI: Return PCIBIOS_* from tx4927_pci_config_read/write()
>   MIPS: TXx9: Use PCI_SET_ERROR_RESPONSE()
> 
>  arch/mips/pci/fixup-ath79.c  |  2 +-
>  arch/mips/pci/fixup-lantiq.c |  9 ---------
>  arch/mips/pci/ops-tx4927.c   | 18 +++++++++++-------
>  3 files changed, 12 insertions(+), 17 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

