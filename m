Return-Path: <linux-kernel+bounces-7065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D981A12D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B71B223C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C57B3B28B;
	Wed, 20 Dec 2023 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8rcmbsP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C33AC3A;
	Wed, 20 Dec 2023 14:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D93C433C9;
	Wed, 20 Dec 2023 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703082847;
	bh=41quJ9B/Oz6jQoPktZ6U8rZMIvvzNB3ljXVrZ23V5YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8rcmbsPOEOqfWS0i+q1CrU11T55QLB4YIizoU3/004XJQodh85CeyTsLbGRGcCrQ
	 bQGZtXQluK2fld+DVQtBAhK4RVWDWXVd4Jkc9u/myze41Y/0QvSObtWmZDJbrNmNNF
	 V1TCNoYEZ8Z3vETbDOUnSO7TJZOUqMu67hhC6OOwRQWcKMj9CiTUNN41NWGINguzUu
	 95VsZ92ww+WoZ34zryXTP9Xe5A4lXCcSzKNhiGr3IpCEiv3021wJuAc39N8V7MYsuR
	 ovH6YIf8jD51lHg5yR+cKAP2D38lSP8AB4isFMWlz8uki//CFLiTXoJGpYQXcofY/P
	 rgeF3JKrxagVw==
Date: Wed, 20 Dec 2023 15:34:01 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Sapozhnikov <alsp705@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: fddi: skfp: Uninitialized data
Message-ID: <20231220143401.GH882741@kernel.org>
References: <20231219100819.17426-1-alsp705@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219100819.17426-1-alsp705@gmail.com>

On Tue, Dec 19, 2023 at 01:08:19PM +0300, Alexander Sapozhnikov wrote:
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>

Hi,

I think that more explanation is required regarding the problem
this solves and how it might affect users.

> ---
>  drivers/net/fddi/skfp/pmf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/fddi/skfp/pmf.c b/drivers/net/fddi/skfp/pmf.c
> index 563fb7f0b327..3f24fbd82a73 100644
> --- a/drivers/net/fddi/skfp/pmf.c
> +++ b/drivers/net/fddi/skfp/pmf.c
> @@ -1084,7 +1084,7 @@ static int smt_set_para(struct s_smc *smc, struct smt_para *pa, int index,
>  	int		path ;
>  	int		port ;
>  	SK_LOC_DECL(u_char,byte_val) ;
> -	SK_LOC_DECL(u_short,word_val) ;
> +	SK_LOC_DECL(u_short, word_val) = 0 ;
>  	SK_LOC_DECL(u_long,long_val) ;
>  
>  	mac = index - INDEX_MAC ;
> -- 
> 2.40.1
> 
> 

