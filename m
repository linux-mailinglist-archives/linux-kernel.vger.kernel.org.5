Return-Path: <linux-kernel+bounces-56403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3032D84C9C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1791C25DA2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B781B803;
	Wed,  7 Feb 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpqNoyH9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F88B1B7F2;
	Wed,  7 Feb 2024 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306061; cv=none; b=NSKbjxqA27JlG2yaxarpLXcjc81I+Iq8XrZHgIkF88O9Plyzi8d+vIR+UCG8cwHqEjljRkOlJMdZ4x6VP/vdJuv3274jO6JhmfGwdb7pyrkbvvBvFv0JKvDX5S+hpsW0oUU14VdUcumASsaB1QnF/io6zP3rzYeNxtjbsn7uSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306061; c=relaxed/simple;
	bh=H1sl80k3ks4bER//CcpRCH20GB92TBbZKpZ8tfvHCRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn0NEkFyNbkUz2cUqa5fASRahhwFjUIk9z221wiLCcwMvESTMdq3dh5rnrL/wsQ+TW6JGcQgaXnUDwnaWIjojcuFMiRCyVie1fCuO/Vt5B+JyXdouLp0wI1ALtSXGNo1UEDZRaCtFmtCcXagEYef5DM4VR12lAS1vt+sO6w23bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpqNoyH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C9AC433C7;
	Wed,  7 Feb 2024 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707306061;
	bh=H1sl80k3ks4bER//CcpRCH20GB92TBbZKpZ8tfvHCRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpqNoyH9udDuGP6IEPNWHgzkWkOJu3DjnMfAfGyFR2bHTs44LUmzCut84rYA3yT99
	 eVokpmu5tw8NAyFHGAW5X+aCC89e1UgVxyCzCRsAV/R/aoK9iDdIafpq4NuRmtwYBl
	 CVyu6wt6huT0W/BhDJrcW2GWHOAI1DayU6gqRF45MJGsYiqxdoFLZEO1URxb7pGWw7
	 yMEik05SvOSpw+Vo+386tHIyG8my9/mm7lwx/AdRtBSOlAjShHWhVJxZ4FkuP++xeR
	 CaAuwVepERMatZhPd8yR+D4qAc6wON5KEYDIcMeRYOsk4NZvN1U0/NImI6ZZnX93cN
	 EnwHfkzQcm9YA==
Date: Wed, 7 Feb 2024 11:40:56 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 9/9] net: fill in MODULE_DESCRIPTION()s for
 dsa_loop_bdinfo
Message-ID: <20240207114056.GE1297511@kernel.org>
References: <20240207101929.484681-1-leitao@debian.org>
 <20240207101929.484681-10-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207101929.484681-10-leitao@debian.org>

On Wed, Feb 07, 2024 at 02:19:28AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the DSA loopback fixed PHY module.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/dsa/dsa_loop_bdinfo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/dsa/dsa_loop_bdinfo.c b/drivers/net/dsa/dsa_loop_bdinfo.c
> index 237066d30704..fd412ae4e84b 100644
> --- a/drivers/net/dsa/dsa_loop_bdinfo.c
> +++ b/drivers/net/dsa/dsa_loop_bdinfo.c
> @@ -32,4 +32,5 @@ static int __init dsa_loop_bdinfo_init(void)
>  }
>  arch_initcall(dsa_loop_bdinfo_init)
>  
> +MODULE_DESCRIPTION("DSA loopback fixed PHY library");
>  MODULE_LICENSE("GPL");

Hi Breno,

I'm not sure, but perhaps something like "mock-up Ethernet switch"
is better than loopback.

I'm looking at NET_DSA_LOOP in drivers/net/dsa/Kconfig

