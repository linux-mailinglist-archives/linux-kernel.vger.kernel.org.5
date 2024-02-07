Return-Path: <linux-kernel+bounces-56726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4556384CE32
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C478BB2887C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFC88004C;
	Wed,  7 Feb 2024 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJUiHIBC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECF47FBCA;
	Wed,  7 Feb 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320247; cv=none; b=sUrjOoaxIZPZPCImpofd64oMTjneZKcHq6KMizS+179fRYLzboZ47Vy5mXPLWsX2bjd03yzD4HpzROgV4w+yHkAbhcHZq9vTl4jcUpmt6NC/N5Gq5YSAcnk7YAK3omptIp0ddNh2IltEXCcidmegFE1lJG3shglXkkKsX1c0vcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320247; c=relaxed/simple;
	bh=XodJEfutm0W0+2qJbkGvyawSd4Fz0q9TDZ4Cyn1nWyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaJZKUUdRLNP9emZ6euRdb1aPhFsSGjsvo06qJEcJHgz2lRqrAv9NaVd3uxzUqkvostDexscwWqCLl6YmPloXVcz5SXQl/c+quzga1POnMmmfrBZD+U2sKi80gvyzdI30QGKi5bNoVFxLrgvgEDnLC4nl5ZdVt6xs0EyX6RCw3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJUiHIBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A06C433F1;
	Wed,  7 Feb 2024 15:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707320246;
	bh=XodJEfutm0W0+2qJbkGvyawSd4Fz0q9TDZ4Cyn1nWyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fJUiHIBCxZBINqWFcg2kyA5C8Znll4xRAhITser88J5MPSqVufVdNcxoDgFh42Jna
	 WWgGiAr1UQcBy0Q7+FOYICVfiYPYPhDPeAJA7cDcGujLobHrcua59p8thpGtMzPNUp
	 QE3mLjC7gmxHwqiZo96/Cx1VSoPCR5XYpz81KrSqHVlekht/runDD1B7i5xZJ9ekni
	 CeVmS74Jq43x0S2dO1yvawpKuo5xQjNRbILpL/6IFxWyHo3M/wjJplkFL/woDWwmvx
	 XeYxRVPOcvxXyNspO4crgCPyjz35ZtqswIM4GshaQKQRklXAbktk18yLWy01Vnt9gn
	 ie8wp2iYJgP6g==
Date: Wed, 7 Feb 2024 07:37:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 andrew@lunn.ch
Subject: Re: [PATCH net v2 7/9] net: fill in MODULE_DESCRIPTION()s for
 net/sched
Message-ID: <20240207073725.4e70235e@kernel.org>
In-Reply-To: <20240207101929.484681-8-leitao@debian.org>
References: <20240207101929.484681-1-leitao@debian.org>
	<20240207101929.484681-8-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 02:19:26 -0800 Breno Leitao wrote:
> --- a/net/sched/em_canid.c
> +++ b/net/sched/em_canid.c
> @@ -222,6 +222,7 @@ static void __exit exit_em_canid(void)
>  	tcf_em_unregister(&em_canid_ops);
>  }
>  
> +MODULE_DESCRIPTION("CAN Identifier comparison network helpers");

That sounds like it as library for any code, but it's TC extended match.
Jamal, any suggestion for a good name template for em_ ?

