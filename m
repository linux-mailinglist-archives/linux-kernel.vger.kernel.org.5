Return-Path: <linux-kernel+bounces-163295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7332D8B68AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA30283592
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2671429A;
	Tue, 30 Apr 2024 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gecyBftA"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E06125CC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447778; cv=none; b=ZKZXHaBbsGGOkUz7HHRVGY4Wl2qguteTtOKw7BnwB4Du3xwAarzdA2EP2uZ12xVh7HcmPUhNRucl4X97lvSkHuV2jW4KinVcogXC3Sw2R5jqR9nfvyUP1V+/c2NREIOBk+eROkYc3BQL5v0p2p1IqzajFmUa39l1cUoXY1R+ua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447778; c=relaxed/simple;
	bh=Q7cRxE+187pu+rKFG2ATfFSh2S0Gw+uGrNv77tLjkys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFy5NA5qP3si7RptiynBSm1bJ2RtEH1PqUdh/6MAi/BTWk0894VuTizKfXfWTGguH4cA0EE69e060stlUdrp3nWePPibTBXNNKy5TcvBq6OSGBEF1+2zjWzvdpKl1P0Nig14mMd1gzIygZoXuYI14R/6O4jrViVJLoN+GEuoHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gecyBftA; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 23:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714447775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrUtKxErsS7+nLErBpaeHAEAODEPjDyd0aA2QyiBd6k=;
	b=gecyBftAKHXeKJbp1xfPU4oFrLp1w8ZLX+xXQYrmVA0tuojQYA/ySmUCh67K6MGieNZGLG
	TuxGQLp8LAijTqt/68wihmCXOZPwLdo/GmbRo2GZlFoQbrdNieVWOcYBg3LvTUNpEmEQGw
	Rb7upmQ9FJUdMYdlAU+ptWJtE9D1qKw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] bcachefs: Correct the FS_IOC_GETFLAGS to
 FS_IOC32_GETFLAGS in bch2_compat_fs_ioctl()
Message-ID: <penqmxyjpw5jukmqbmsrjbvqxhugrhbk6gruie4pjdoacah5zr@atcvnu6ogksv>
References: <20240430032744.943468-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430032744.943468-1-youling.tang@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 30, 2024 at 11:27:44AM +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> It should be FS_IOC32_GETFLAGS instead of FS_IOC_GETFLAGS in
> compat ioctl.

Do we by chance have a test for this?

> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  fs/bcachefs/fs-ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
> index 3dc8630ff9fe..205a323ffc6d 100644
> --- a/fs/bcachefs/fs-ioctl.c
> +++ b/fs/bcachefs/fs-ioctl.c
> @@ -548,7 +548,7 @@ long bch2_compat_fs_ioctl(struct file *file, unsigned cmd, unsigned long arg)
>  {
>  	/* These are just misnamed, they actually get/put from/to user an int */
>  	switch (cmd) {
> -	case FS_IOC_GETFLAGS:
> +	case FS_IOC32_GETFLAGS:
>  		cmd = FS_IOC_GETFLAGS;
>  		break;
>  	case FS_IOC32_SETFLAGS:
> -- 
> 2.34.1
> 

