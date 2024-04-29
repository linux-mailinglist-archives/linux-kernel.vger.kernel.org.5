Return-Path: <linux-kernel+bounces-162429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D4C8B5B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1DE1C2082E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982587BAE4;
	Mon, 29 Apr 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO1Lr8JK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90689468;
	Mon, 29 Apr 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400144; cv=none; b=eq6ycXxmTQVmNc4/zG53d9y/aZ38c0O6b7w0GQa6gltKXtFo6QeXLql3PWfdAqfbX6d8/CH6c9MWbNxoiC7zMmNT07ZB1FNB6lSGMm+hhb/bA5lnt0s/7vmyJUydCenaUsHcdeXR3rcqXWK0bDbv4u2Lb33+wTHrPmlv31ZtYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400144; c=relaxed/simple;
	bh=vuuOwM7T+XqaDUqJ/gHO8wY+etvNSA1mgu0PlzAtGVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwTVi/1xHJf8XxOiOSjAOwrG05PzwFwbWaCJUiKx+MOxNSXCl/aY31Do8+TTSBuBe5KfeQl46NRdEPeILqGSmiZkxkLDYVImCrszl4bn2ivc9xERjaLGc0oMNsoVQzobNLKuLD5yC/9kUkkXFKol/JIV6fYYGktbXitrhbEvjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO1Lr8JK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6237FC113CD;
	Mon, 29 Apr 2024 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714400144;
	bh=vuuOwM7T+XqaDUqJ/gHO8wY+etvNSA1mgu0PlzAtGVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kO1Lr8JKrRg+1o2So9meps8NArO/1498jgiMl20ww+6yVDH9bfKFg6Z7wywgh/hnd
	 61zLwEGVgwPzZyEnEJAJs8ERc3Gc2QwdxAdVNQx+55cYWa3LWhFb08dFScSczWIXpQ
	 VSspQb2UVfotl4v4riOsUIwqm0UrUaH1n4iqItMenNN5TrggvXaYMgdAfBKoMmj28f
	 CgmtkvDlVK/7qek5j+h8IeYTUPgCj3uRshSpod4pDb19f33CIu3Z8iV38yIRj4KorF
	 /hdzHNk2ZNKRNkiIGgpXeU8bOeXqX06EpbVW8qvJqiYLaLrd0iCpp7ORt4l0MaW71O
	 6BVFDvslnQYcQ==
Date: Mon, 29 Apr 2024 17:14:21 +0300
From: Mike Rapoport <rppt@kernel.org>
To: DaeRo Lee <skseofh@gmail.com>
Cc: robh@kernel.org, saravanak@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daero Lee <daero_le.lee@samsung.com>
Subject: Re: [PATCH] of: of_reserved_mem: clean-up reserved memory with no-map
Message-ID: <Zi-rPSnLX8zaueeY@kernel.org>
References: <20240428125505.434962-1-skseofh@gmail.com>
 <CAATEi5kd-XeZ359De36oLJeVvALsEM7oJ9zez_M=zivwrQw5yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAATEi5kd-XeZ359De36oLJeVvALsEM7oJ9zez_M=zivwrQw5yA@mail.gmail.com>

On Sun, Apr 28, 2024 at 10:10:17PM +0900, DaeRo Lee wrote:
> 2024년 4월 28일 (일) 오후 9:55, <skseofh@gmail.com>님이 작성:
> >
> > From: Daero Lee <daero_le.lee@samsung.com>
> >
> > In early_init_dt_reserve_memory we only add memory w/o no-map flag to
> > memblock.reserved. But we need to add memory w/ no-map flag to
> > memblock.reserved, because NOMAP and memblock.reserved are semantically
> > different.
> >
> > Signed-off-by: Daero Lee <daero_le.lee@samsung.com>
> > ---
> >  drivers/of/of_reserved_mem.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> > index 8236ecae2953..1c916da8adaf 100644
> > --- a/drivers/of/of_reserved_mem.c
> > +++ b/drivers/of/of_reserved_mem.c
> > @@ -91,7 +91,8 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
> >                     memblock_is_region_reserved(base, size))
> >                         return -EBUSY;
> >
> > -               return memblock_mark_nomap(base, size);
> > +               if (memblock_mark_nomap(base, size))
> > +                       return;
> Sorry. The return value is wrong.
> 
> Here is what I want to do:
> 
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -81,6 +81,7 @@ static void __init
> fdt_reserved_mem_save_node(unsigned long node, const char *un
>  static int __init early_init_dt_reserve_memory(phys_addr_t base,
>                                                phys_addr_t size, bool nomap)
>  {
> +       int err = 0;
>         if (nomap) {
>                 /*
>                  * If the memory is already reserved (by another region), we
> @@ -91,7 +92,10 @@ static int __init
> early_init_dt_reserve_memory(phys_addr_t base,
>                     memblock_is_region_reserved(base, size))
>                         return -EBUSY;
> 
> -               return memblock_mark_nomap(base, size);
> +
> +               err = memblock_mark_nomap(base, size);
> +               if (err)
> +                       return err;
>         }
>         return memblock_reserve(base, size);
>  }

Makes sense to me.

> Regards,
> DaeRo Lee

-- 
Sincerely yours,
Mike.

