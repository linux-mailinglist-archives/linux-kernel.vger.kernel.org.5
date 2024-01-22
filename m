Return-Path: <linux-kernel+bounces-32714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A86B835F47
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EF5287988
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DFF3A1C3;
	Mon, 22 Jan 2024 10:16:25 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640DC3A1A4;
	Mon, 22 Jan 2024 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918585; cv=none; b=MGe6d956o/Oss3QfthDwmUguDX+w4dFkxIxlpHc2OPqbzYmm6frSNwMcHJ4gZ4qM7W+tkXxDuxR5IoZo8Wb5Jono7+J8XR5rDQQRcoRJ9+SvFfbhaN1YWpaBqV5JLEzWyN1nL3WiSffCV86LKQiVjnwYO+rqmsryCaRw2AILmSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918585; c=relaxed/simple;
	bh=1Dwo0VFd2lDWrdTgmB3oDKY21taxrHZaV4UFr5vx1aU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThaDxoej2JzVvzlUGxP3/8AsySCafz95KBErRLhmSWX69h1yWZWjzt28Y9yqoXDQf+NlYxl93sL0yw74cFhhGnkAVlMkRELCr25ZcJ4S244aiEXnmbOHJAWLeLKMaSurqRx2k0e8LHzaKuggI1l1e1HiSpmi2s0OCp2Rdq+XEAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rRrLi-0000Sc-00; Mon, 22 Jan 2024 11:16:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id D35F7C0661; Mon, 22 Jan 2024 11:15:04 +0100 (CET)
Date: Mon, 22 Jan 2024 11:15:04 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: fw arc: Fix missing prototypes
Message-ID: <Za5AKJAk274LQA3h@alpha.franken.de>
References: <20240119133634.96420-1-tsbogend@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119133634.96420-1-tsbogend@alpha.franken.de>

On Fri, Jan 19, 2024 at 02:36:34PM +0100, Thomas Bogendoerfer wrote:
> Make ArcGetMemoryDescriptor() static since it's only needed internally.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/fw/arc/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/fw/arc/memory.c b/arch/mips/fw/arc/memory.c
> index 66188739f54d..fb78e6fd5de4 100644
> --- a/arch/mips/fw/arc/memory.c
> +++ b/arch/mips/fw/arc/memory.c
> @@ -37,7 +37,7 @@ static unsigned int nr_prom_mem __initdata;
>   */
>  #define ARC_PAGE_SHIFT	12
>  
> -struct linux_mdesc * __init ArcGetMemoryDescriptor(struct linux_mdesc *Current)
> +static struct linux_mdesc * __init ArcGetMemoryDescriptor(struct linux_mdesc *Current)
>  {
>  	return (struct linux_mdesc *) ARC_CALL1(get_mdesc, Current);
>  }
> -- 
> 2.35.3

applied to mips-fixes

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

