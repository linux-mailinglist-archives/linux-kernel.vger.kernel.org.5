Return-Path: <linux-kernel+bounces-98703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F059877E23
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E60CB217C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CA4199AD;
	Mon, 11 Mar 2024 10:34:18 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F429424
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153257; cv=none; b=HJ2nu7Fsy7k0GI4/kpcpY9mWhhlcBIoUlLDqz/Lf/zAdEsoylFjTy9xrMTVZulkM4re4z4agGb0v2SjmMbRJI/lkUuLuCuAHulxfD17VPm+BCmQEsRtneRh54ef4/Bf/sRpGHKsN4RZyiWwNCdmtjeyMtYU39LR+/Xpc6V6nXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153257; c=relaxed/simple;
	bh=oFMEHOkWMFDCGZTROsbokvN1VVNCxaDVvm72nFgHgf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEB2srPP++H66wJmTPExhrX7lxYLWMLzDhmm2D0ASWl9sEU/ibhogICNYrkgfqZTt8FUAsWL+GKfmJhw9IN7fmyIDiWV7G1W1w11x4jFIUm/il+QHtymO/v0OfAk6sw1c/LYVAJlu7yWoWxnB23GYnYb5L3mIkMjOd+TeSoxQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp66t1710153206tvsrkqhi
X-QQ-Originating-IP: jDdszq3cBpJ6hHvCms7l9LVCaUzQEZWphdXYf+ovwKs=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Mar 2024 18:33:25 +0800 (CST)
X-QQ-SSF: 01400000000000505000000A0000000
X-QQ-FEAT: 3uhoZqdeMHP0xN020+GHgFDnKhe/jnLul9KSBfqte4048DuSaJQfNTK3/MPBu
	KXyw3fhchtcLl3oOSfkTHSiX7ZOyHQFhVuzHDee9PxIgOjZfwvizbr9fk1xZlSh4HgfrIte
	no9dEAvoKMuCer8BmizSnYeISnZEggVNoU4MjnqbKIVR4DwDLueJoChFZqDUiwU7MQhQ6lW
	6B35Ge+hXXRZK/WEq10jrJhTejnzZ2xJYuCMrYbquwQeLTtcN5772yKMTnjzt3pFCkMd/kQ
	IlylnuBG+XHOmIhXitmBGNystnHx3eOpH11nyABSgRiUATSuQzoVDFYSEIyu7TXMdVKiWh8
	HNG2Ijz9DTOLimQVI5V289dDvnQOFJy4hEvGSyvAu4+/X+2uMnUrQFO2hs9iQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4919900436153969483
Date: Mon, 11 Mar 2024 18:33:25 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Calculate THREAD_SIZE from THREAD_SIZE_ORDER
Message-ID: <1971996240D01975+Ze7d9TQIq9AFG2Wr@centos8>
References: <20240304085455.125063-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304085455.125063-1-dawei.li@shingroup.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Geert,

On Mon, Mar 04, 2024 at 04:54:55PM +0800, Dawei Li wrote:
> Current THREAD_SIZE_OERDER implementatin is not generic for common case.
> 
> Improve it by:
> - Define THREAD_SIZE_ORDER by specific platform configs.
> - Calculate THREAD_SIZE by THREAD_SIZE_ORDER.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
> 
> V1 -> V2:
> - Remove ilog2().
> - Calculate THREAD_SIZE by THREAD_SIZE_ORDER.
> 
> V1:
> https://lore.kernel.org/lkml/20240228085824.74639-1-dawei.li@shingroup.cn/
> 
>  arch/m68k/include/asm/thread_info.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/thread_info.h b/arch/m68k/include/asm/thread_info.h
> index 31be2ad999ca..3e31adbddc75 100644
> --- a/arch/m68k/include/asm/thread_info.h
> +++ b/arch/m68k/include/asm/thread_info.h
> @@ -12,14 +12,15 @@
>   */
>  #if PAGE_SHIFT < 13
>  #ifdef CONFIG_4KSTACKS
> -#define THREAD_SIZE	4096
> +#define THREAD_SIZE_ORDER	0
>  #else
> -#define THREAD_SIZE	8192
> +#define THREAD_SIZE_ORDER	1
>  #endif
>  #else
> -#define THREAD_SIZE	PAGE_SIZE
> +#define THREAD_SIZE_ORDER	0
>  #endif
> -#define THREAD_SIZE_ORDER	((THREAD_SIZE / PAGE_SIZE) - 1)
> +
> +#define THREAD_SIZE	(PAGE_SIZE << THREAD_SIZE_ORDER)
>  
>  #ifndef __ASSEMBLY__
>  

Sorry to bother, but any comments on this version?

I know it's awkward cuz it's in middle of merge window, sorry for that.

Thanks,

    Dawei

> -- 
> 2.27.0
> 

