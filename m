Return-Path: <linux-kernel+bounces-128943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DBB89621C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B794282E66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1471BC53;
	Wed,  3 Apr 2024 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmQrQzJ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CCB15491;
	Wed,  3 Apr 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108435; cv=none; b=jNejiR4Nsl3HAIYuJes1DNFFmw4PrF+EEW1gfBl5ESeuC0NjGMAg0NQL7vG3Z0xEG05p+tcjbRjqkpiGQIMdesMu/bb0itW7ZC5/B+RgkRzgZUjHtbEqiMgCdGG7y4Ku2v2Pg6+61VQ6HqKvFWq8F9Pa0qip0YDWWfAO8Ix/uwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108435; c=relaxed/simple;
	bh=PnfFkAtq+kYoDUuoqH9ov0mIK+LroF3jkGYMhtBgEDk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Prq3Y1LM+SOJxezv4WHBBDrPhGj7YrAi0ZgNxRKJGI+fgPijkvrxJq+ZvRwc36SKsMiJmoEyFYPscVRXdDjIzmoIVrQU3M9Gk3AzIzUowXNeO9N1TysUbZmMQvF71vSoPBWQg2l8IXwJsTetRxTjX5nWBrUaT8/ptGdDF+4+MIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmQrQzJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D607AC433B2;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712108434;
	bh=PnfFkAtq+kYoDUuoqH9ov0mIK+LroF3jkGYMhtBgEDk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nmQrQzJ1ehcIQlPA3DCYl+kcxvnaFaGVdmbaIfzjKOsGU00usDRz7RNZBS6GzImd1
	 Ghh3qz0miLZKo3OijTHdWKEQrDwDWxRiia5RMT0fmaQdB3vRZ6gfzW8Ss6kdyhMY0a
	 2QkWdFi62sRg4E6cGJ5LT9YV4hh+CkXIDP1jyVOIwmbeYStkwammnGaDqZg1IbpWIk
	 c+/0Mfu1ewaFnLCu6JM9iKTI0EWlj+SWSIBHOSqYFMMQD7OHJWUhG2B7PNgU0yhZnG
	 xOXFDYLza5g/wxFOi8+7nZJpqvTfV9ZeuiW7WLVzJ8EkyjdzrIxsWQMp57wCnCGFw2
	 tDUPywsGxtlqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB05FD8BD1E;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] page_pool: allow direct bulk recycling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171210843482.14193.13072464299514068706.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 01:40:34 +0000
References: <20240329165507.3240110-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240329165507.3240110-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lorenzo@kernel.org, toke@redhat.com,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 17:55:05 +0100 you wrote:
> Previously, there was no reliable way to check whether it's safe to use
> direct PP cache. The drivers were passing @allow_direct to the PP
> recycling functions and that was it. Bulk recycling is used by
> xdp_return_frame_bulk() on .ndo_xdp_xmit() frames completion where
> the page origin is unknown, thus the direct recycling has never been
> tried.
> Now that we have at least 2 ways of checking if we're allowed to perform
> direct recycling -- pool->p.napi (Jakub) and pool->cpuid (Lorenzo), we
> can use them when doing bulk recycling as well. Just move that logic
> from the skb core to the PP core and call it before
> __page_pool_put_page() every time @allow_direct is false.
> Under high .ndo_xdp_xmit() traffic load, the win is 2-3% Pps assuming
> the sending driver uses xdp_return_frame_bulk() on Tx completion.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] page_pool: check for PP direct cache locality later
    https://git.kernel.org/netdev/net-next/c/4a96a4e807c3
  - [net-next,2/2] page_pool: try direct bulk recycling
    https://git.kernel.org/netdev/net-next/c/39806b96c89a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



