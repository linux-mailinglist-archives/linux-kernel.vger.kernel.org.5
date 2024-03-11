Return-Path: <linux-kernel+bounces-99629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD5878AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0798828240C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE059B41;
	Mon, 11 Mar 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RArk/vXu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB858232;
	Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197437; cv=none; b=CIa/9f48ETC//fRSbUe17p5ANnpqEDRZhV3R6h8/SWFYb/9w6sd0kDeiM2KXA9Ti1qu6yUJ/kLoYzdG+9YzVZkg8IjH30hTRW+rDzfv520D/ZyjIMsHnWzMJOSbRk8VTMz5QGOUB/9CeeUgoDfp4imA68NpFMf3W+/TLVXK5kUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197437; c=relaxed/simple;
	bh=SwBp3ZhQJSp+P7adHQ28kdWsJHcYyFbAwOo23z1wCRY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bOM9IQfmcPWulXcNiztBAwAIg2Eep/VULLOVFvGxk9xlyvff63r/HxhE/zOcNDdzGnl73ZMrFa6j9SGCSca83/zms1zFQxRIiucUAiyQP+BRgyaJmN07ZifYFBdv9SIEC/3RELPFb7TUl4r7d5EMUmeMWdrdSpBumA9su0mS8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RArk/vXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 304C9C433F1;
	Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710197437;
	bh=SwBp3ZhQJSp+P7adHQ28kdWsJHcYyFbAwOo23z1wCRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RArk/vXuRpbdqMKJpPvoLOCIUosnqsxegjRK8e21/QxgMtueu0LGCXSDAx/sWAbJw
	 tnsqpn3lzcBnd8sjt274rewXRI1HgjiJsqNTyokNAttyqvde9VMSej3mzFvcKaz5k+
	 CkX/7OH0f8+lah4gZL1w1EMPQdp47qzpmXtugRREmp+4PAk7oZMu4hGUFx5IHzQoBt
	 yovzXHSiQOYcfvrWNuPvXoLgSwoXpG/J68eqWB3Fw7NlDN/6JbWWo0ks6T28rHi9os
	 lyBnAV+rzTE1VUxw+CZYhAHgQ4+axJ8InDuePSSy2Zl3K40zmf2loJcCiNE7YeSxay
	 Xt5wf0XDbsmWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18E03D95056;
	Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ipv6: exthdrs: get rid of ipv6_skb_net()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019743709.8733.699769528649770638.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 22:50:37 +0000
References: <20240308185343.39272-1-justin.iurman@uliege.be>
In-Reply-To: <20240308185343.39272-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 19:53:43 +0100 you wrote:
> Get rid of ipv6_skb_net() which is only used in ipv6_hop_ioam().
> 
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>  net/ipv6/exthdrs.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Here is the summary with links:
  - [net-next] net: ipv6: exthdrs: get rid of ipv6_skb_net()
    https://git.kernel.org/netdev/net-next/c/fcac05daa7ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



