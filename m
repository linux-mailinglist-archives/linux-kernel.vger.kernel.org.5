Return-Path: <linux-kernel+bounces-161957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B848B53C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33801C2172E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8937922301;
	Mon, 29 Apr 2024 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Y7RXT/H5"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C5817C7B;
	Mon, 29 Apr 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381402; cv=none; b=ijorhmE6psPvO71vjd1PJSC9hODVQVBLSM/hKP87SkAZfAMWWGGopLPqswDQpTUd0QioN50oJoNlr2Z8uomxJaj2VwKGfv+Uh8nJqiWu/iIsE7BjMnvfcnTAX79/FzyhZvfk8zxMjzwO98io1a+WJtTecFmpkyHe049KbgZuN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381402; c=relaxed/simple;
	bh=nmHlQ40BSQ8r37RxBAI/Z1X2TZxivPy0Ez5p1n84H6I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kGvvj+kilJaI06hIqUDyP50lyhqnjl623G9EVpJig/5yOqRvEmFlZI0klNAkXvR3QBnO4lChEEKBxFttD5nITX5uuNA8vp7mJx066l/MCxIFrMwOSnKpFobb8GlnAU++7tjQXY9y6ym+2rY+U7lvDnjpofec7cA8qIOAkcKE2BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Y7RXT/H5; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S+uN3eDgJG1hN1gD7AH+fQKaBmd5QirMMoys0IiXUJY=; t=1714381399; x=1714986199; 
	b=Y7RXT/H5yyQJJex3G+KtfLKZDZ42nz6XyN9dSvyxlWKFepaz/Hy8LvMJqkO5MlwKUOmd1wOePdq
	SEaf1p5XsTOCObvvhWWbi/MBPg7JBpFQIQocIZGfkItflbj+08WDeHnMICg6G7MvJrcVsTPZ3N27m
	+psaqAnBpFRGEN7eB9il15Uq6p1oq2CaArP7KF3Te7wuMXn00UsW/1DCWPVq+hI0z/aLC1BGpTKoe
	vhgAryE5S6hNoW9Xfg1pBgfORtjJPERc+dyi0TDM3PVQcX0n7QMpGEChWmHdmqMRQc7Ogs1AyTmJp
	ZFaX7Nf9j3Loc6X9eqQLSjGJU3/X9zVg3uyw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s1Muq-00000003tTj-1ZSp; Mon, 29 Apr 2024 11:03:16 +0200
Received: from dynamic-077-191-138-057.77.191.pool.telefonica.de ([77.191.138.57] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s1Muq-00000001Rfd-0eXs; Mon, 29 Apr 2024 11:03:16 +0200
Message-ID: <6ba5b226dfcbae3d9c789bb6943089621b315d65.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: Call paging_init() earlier in the init sequence
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: akpm@linux-foundation.org, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, kernel@quicinc.com, Rob
 Herring <robh@kernel.org>
Date: Mon, 29 Apr 2024 11:03:15 +0200
In-Reply-To: <20240423233150.74302-1-quic_obabatun@quicinc.com>
References: <20240423233150.74302-1-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Oreoluwa,

On Tue, 2024-04-23 at 16:31 -0700, Oreoluwa Babatunde wrote:
> The unflatten_device_tree() function contains a call to
> memblock_alloc(). This is a problem because this allocation is done
> before any of the reserved memory is set aside in paging_init().
> This means that there is a possibility for memblock to allocate from
> any of the memory regions that are supposed to be set aside as reserved.
>=20
> Hence, move the call to paging_init() to be earlier in the init
> sequence so that the reserved memory regions are set aside before any
> allocations are done using memblock.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
> v2:
> - Added Rob Herrings Reviewed-by.
> - cc Andrew Morton to assist with merging this for sh architecture.
>   Similar change made for loongarch and openrisc in v1 have already
>   been merged.

Could you link the changes for references so I can have a look?

> v1:
> https://lore.kernel.org/all/1707524971-146908-4-git-send-email-quic_obaba=
tun@quicinc.com/
>=20
>  arch/sh/kernel/setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index 620e5cf8ae1e..98c8473e130d 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -322,6 +322,8 @@ void __init setup_arch(char **cmdline_p)
>  	/* Let earlyprintk output early console messages */
>  	sh_early_platform_driver_probe("earlyprintk", 1, 1);
> =20
> +	paging_init();
> +
>  #ifdef CONFIG_OF_EARLY_FLATTREE
>  #ifdef CONFIG_USE_BUILTIN_DTB
>  	unflatten_and_copy_device_tree();
> @@ -330,8 +332,6 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>  #endif
> =20
> -	paging_init();
> -
>  	/* Perform the machine specific initialisation */
>  	if (likely(sh_mv.mv_setup))
>  		sh_mv.mv_setup(cmdline_p);

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

