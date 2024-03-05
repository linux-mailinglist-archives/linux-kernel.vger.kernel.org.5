Return-Path: <linux-kernel+bounces-92633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D003872335
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6305281240
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC14128366;
	Tue,  5 Mar 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Khw749nU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8B8564F;
	Tue,  5 Mar 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654012; cv=none; b=jPfel/zAOkwCgkYIu6iy3lFsL+bq572Y343xX44doN+F0z0mP34Yq/6+ZD1EXTdcIE13Alua1RJU+YLzbGeNJCumbUx4dbDddDZ/ApjNR55brqm4ij9n2GLqQO85FFuctlQJ87j5kT57NDaWyfQHysUUzWLYItoAwOM4HOU7Mpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654012; c=relaxed/simple;
	bh=rDlQjaD1UZ6PQYWdhuuIJijmsasCa9b3CU3BJCU2K+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXWLV+N3eqvCIer5SHtIuUh1iHl73DLMSeYEnsHAXB+gGkFPwM4+4jT4Bosy9ypTBqgSMKH3nsAZpxKI2YqLxidoFiHxccYQUqCq3yqycex7dbQIrYIIc5d0xWJIxEa1Zl9PHCLga7P+1V4RJCZLQuLL79+eL9Fknmk6GbH77Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Khw749nU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A751C433C7;
	Tue,  5 Mar 2024 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709654011;
	bh=rDlQjaD1UZ6PQYWdhuuIJijmsasCa9b3CU3BJCU2K+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Khw749nUIl454K1QP9BrQMHBNpLZVFa1Xxny2jK/zRVxjfETcHcHoYVFgJydkZIJj
	 wvh8iA0x2Os7kkoOZrvRg+1HKgz7brKpGNq3ScO70zmh9Sdj/0sWct8rfGMKGmhxKQ
	 2VjM3l05dCWjUykNUA6M0sWLEG/Q8xGPj1vlqytIF32oJcspH9rAGyee6qI3DMx8C7
	 Z86XNm019DDsCn19wd/wDU69KPdxque6+PoU9ZPbhrMWNkbzTR4WXPU9bNvbcDuJFC
	 Vxf1XdHQm0lZ6YBPFEie3X54PNtR+YbE+I5O7YA+BKNKj6rW1lM2M6NH9COU8FiePz
	 3zAwq/Y6rDXyw==
Date: Tue, 5 Mar 2024 15:53:27 +0000
From: Simon Horman <horms@kernel.org>
To: Zixuan Tan <tanzixuan.me@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] net: bridge: Replace deprecated build flag
 HAVE_JUMP_LABEL with CONFIG_JUMP_LABEL
Message-ID: <20240305155327.GA137768@kernel.org>
References: <CABwm_eRuL9UXanmTaC7U820=8GLAHHwWuFP=REOpECsPR+pPvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABwm_eRuL9UXanmTaC7U820=8GLAHHwWuFP=REOpECsPR+pPvg@mail.gmail.com>

+ Masahiro Yamada <masahiroy@kernel.org>

On Tue, Mar 05, 2024 at 10:42:04PM +0800, Zixuan Tan wrote:
> The build flag HAVE_JUMP_LABEL has been deprecated and removed in commit
>  e9666d10a567 ("jump_label: move 'asm goto' support test to Kconfig").
> It is no longer defined or used. The correct flag to use is CONFIG_JUMP_LABEL.
> 
> Fixes: 971502d77faa ("bridge: netfilter: unroll NF_HOOK helper in
> bridge input path")
> Signed-off-by: Zixuan Tan <tanzixuan.me@gmail.com>

This patch seems to be mangled somehow and doesn't apply.
However, I believe that the change described by it is correct.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/bridge/br_input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index f21097e73482..3700e47ff181 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -255,7 +255,7 @@ static int nf_hook_bridge_pre(struct sk_buff *skb,
> struct sk_buff **pskb)
>     int ret;
> 
>     net = dev_net(skb->dev);
> -#ifdef HAVE_JUMP_LABEL
> +#ifdef CONFIG_JUMP_LABEL
>     if (!static_key_false(&nf_hooks_needed[NFPROTO_BRIDGE][NF_BR_PRE_ROUTING]))
>         goto frame_finish;
>  #endif
> -- 
> 2.40.1

