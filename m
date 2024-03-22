Return-Path: <linux-kernel+bounces-111630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631D886EC0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83F31F22379
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A751481BF;
	Fri, 22 Mar 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEYTZR9t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE943AB2;
	Fri, 22 Mar 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118207; cv=none; b=dbioPZBVpgRv9UYDIaKPR2mj6jSZBRoIjLX54tStnkUv9SIkjOiYse2pXAo4G8WC/QI6Q35LWSjQSrMQHO0ZHPBmWsq03blXc9F1FXm5leQyDWHnWqCO2Dn7l9RNPiq5LSjRuGEsGCFjYVArXHrqIjx4J8F6rkUtJf9C5M3t9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118207; c=relaxed/simple;
	bh=or1Gn+RA1pWhx4yqAzYUiva3aoBlbjp13O+FP9ZcQEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBCgrgsB3pu+VXGgVUuDZncfvXBO3n7d32Z3QtTCYE6gwnvh61zsBmkeUnBMi489n9zJsYx3r+NkW5cFrLaHt0k5N2Hv6/GyONthxc1z578JnZAE0j2B5wyo6C78h36nJ2453OI8EHjdpUIgpsFyKZyRApd2uA7aLGwDWqXrlfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEYTZR9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EECAC433C7;
	Fri, 22 Mar 2024 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711118207;
	bh=or1Gn+RA1pWhx4yqAzYUiva3aoBlbjp13O+FP9ZcQEc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FEYTZR9tWAPx6fRWZAUimt4zk6jDgFdDx9iLxPaP3Kk4ohMnHknF/r1F2PavKZ7kU
	 nKjucfS5J3TB2h4Q71q8SurP0HNVHyGhKcQ1FM0EIdSZesrzcODd9Iq6UI9TVJr6zS
	 aLH0cM9C4e5c/Qv3/jIEfC4bNyoKotapP25/RZQ26hHPPARfhlpSeuubBAFzQYla7J
	 O0CL+jWYVotEjaR4IP18e5iibEMmlbq+zAAdhrv2fuW4J+WpgxwovpN6gdliUzNhem
	 An07uYG91Gow+N/Lg1kggriwj+jRnRqyM/1PF8mrMRUqYesS0vbYdwZ7rnH4vW1TZH
	 5rElHpW4IbCKQ==
Message-ID: <f6c0bf7e-bd8f-49f4-abb0-df04fe0e4333@kernel.org>
Date: Fri, 22 Mar 2024 08:36:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv6: fib: hide unused 'pn' variable
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, YOSHIFUJI Hideaki
 <yoshfuji@linux-ipv6.org>, Ville Nuorvala <vnuorval@tcs.hut.fi>
Cc: Arnd Bergmann <arnd@arndb.de>, Kui-Feng Lee <thinker.li@gmail.com>,
 Breno Leitao <leitao@debian.org>, Kunwu Chan <chentao@kylinos.cn>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240322131746.904943-1-arnd@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240322131746.904943-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/24 7:14 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_IPV6_SUBTREES is disabled, the only user is hidden, causing
> a 'make W=1' warning:
> 
> net/ipv6/ip6_fib.c: In function 'fib6_add':
> net/ipv6/ip6_fib.c:1388:32: error: variable 'pn' set but not used [-Werror=unused-but-set-variable]
> 
> Add another #ifdef around the variable declaration, matching the other
> uses in this file.
> 
> Fixes: 66729e18df08 ("[IPV6] ROUTE: Make sure we have fn->leaf when adding a node on subtree.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/ipv6/ip6_fib.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: David Ahern <dsahern@kernel.org>


