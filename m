Return-Path: <linux-kernel+bounces-34065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 599308372CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D321F29AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543F43FB18;
	Mon, 22 Jan 2024 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+bANRH6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673C3EA97;
	Mon, 22 Jan 2024 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952503; cv=none; b=sBftZBUN3yfVP8frHT+4LHrXXa7P6xSgDNFKFEr3+V1cBbdqU93wxBG+c2GCE2fmf/CYpAGHSXGMYUg6dydAW82XnLDKMDCQef5I2YCcxbf1Uc3OoLQbMiUWXTdgXrpSvCgHCUk10fLOksV/7ir8Qm3IO+7dYyi77NDz67Oy08E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952503; c=relaxed/simple;
	bh=yScizP2sDx+pS8QpK8qbOEYIhEUG2MaHox3qNzgVoG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1ay0Cotr4gdroPf7DIM2HZksUJAbvDbjTiU03UVba1LuPk67tKTzVq8NKUD1xGNEP2tOhhMbaR4JsuRfmVhrNLRRhQhHND7D8LaG7UCkJSBAM4i7dCl6gzOej7Xz1V2Q4wSLQJTwQypRQfdhGBHAwoMTw2QGVZ0ApkTFXnvNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+bANRH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D67C433C7;
	Mon, 22 Jan 2024 19:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705952503;
	bh=yScizP2sDx+pS8QpK8qbOEYIhEUG2MaHox3qNzgVoG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W+bANRH6ifkrn9tiNwAwK1FJDPFKpI4Ri2wV7AY/SczuUnswcLtxUFmV6FMEiYv2F
	 KsijSmc9erMkjS9YayaQa8pUF3PRuVgyUfS4/LvqwidUlE1m+GGGS4hKF2IgXTE0Yj
	 bcRFVKezxvZQhSqjS1fYFwPuR85YNuK3HM8YeH/U4TaMx8WkmJsJWYXei+RzTWyJFO
	 69J7JXUylCfchCsfzJMx3uCHpnKIbXEboRYzcsRhgZXhAtuPydfPh6jKaFxaTE8gVl
	 7KywG6HlbfYb7onValDGcBBnwlPPt/D8wq2oitK1FkmriNEIOC1l+5X06TM93xqDmr
	 4YItRG+QCHvvQ==
Message-ID: <233ad4e5-4439-4c85-96e6-6d55ec2622ac@kernel.org>
Date: Mon, 22 Jan 2024 12:41:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next 2/2] net/ipv6: resolve warning in
 ip6_fib.c
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, weiwan@google.com, kuba@kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com, "open list:NETWORKING [IPv4/IPv6]"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240122181955.2391676-1-leitao@debian.org>
 <20240122181955.2391676-2-leitao@debian.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240122181955.2391676-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/24 11:19 AM, Breno Leitao wrote:
> In some configurations, the 'iter' variable in function
> fib6_repair_tree() is unused, resulting the following warning when
> compiled with W=1.
> 
>     net/ipv6/ip6_fib.c:1781:6: warning: variable 'iter' set but not used [-Wunused-but-set-variable]
>      1781 |         int iter = 0;
> 	  |             ^
> 
> It is unclear what is the advantage of this RT6_TRACE() macro[1], since
> users can control pr_debug() in runtime, which is better than at
> compilation time. pr_debug() has no overhead when disabled.
> 
> Remove the RT6_TRACE() in favor of simple pr_debug() helpers.
> 
> [1] Link: https://lore.kernel.org/all/ZZwSEJv2HgI0cD4J@gmail.com/
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/net/ip6_fib.h |  6 ------
>  net/ipv6/ip6_fib.c    | 15 +++++++++------
>  net/ipv6/route.c      |  8 ++++----
>  3 files changed, 13 insertions(+), 16 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



