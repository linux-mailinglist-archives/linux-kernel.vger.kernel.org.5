Return-Path: <linux-kernel+bounces-74618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093E785D6FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA9AB222E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E205E405C6;
	Wed, 21 Feb 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeEmx1Lt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE3C481AD;
	Wed, 21 Feb 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515029; cv=none; b=amLlAiQFQDjYWzaGD5sY3s3k0OMA2m3r5XTkSyjfO6v+NTl8rN2JvXljYrn++cyKyc6WFGUjO1Qvv4KROLsuETFv3vss5ra4/MgJZ5Eq5p6UmYuVpGEdX6WTYa9vguqGv2XbLCDj6JsgEbcvHYVifx5il3KCUm806M8QXUsUfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515029; c=relaxed/simple;
	bh=q8iei6SJEoGcWw/7HaWMNBq0PFhJeMnbU+3HGyo+ceU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KZF9PfNWEbVDTSvVxLYRVnDBEJAKLwy87sqi7AtTJXWxFBtCuoZ6raQ3xH3VaPQECSmRTe2+rzanJkOzECHfEa1oShQv2loD7r8DLLnxgXFpNRi02Jq5yH9jtK1pLZKA4nrxMsDhMSAu2NmZYEfYxPpRIOkDhmdyzFmiozCaS78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeEmx1Lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0B9CC43399;
	Wed, 21 Feb 2024 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708515028;
	bh=q8iei6SJEoGcWw/7HaWMNBq0PFhJeMnbU+3HGyo+ceU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZeEmx1Lt17ZmCBXIfLwYqoPlVRUzxDYqKjGqccNA04uP1GTpLAD61F3H+j6XkjqYf
	 FkyXVH2bd58gZrvlKbylH7s4u94MtXf6YDfSrStFxru2WNchKMkLiHrXxxZRNgcR8F
	 tGILumeBvBz73LOvgcMwjMhEyitrglC54HlPaDJ915GIKcd9SavTIYaF/lxL6g7Qc1
	 P5nGdQWWnm8o1YaPLUyBOjGn5BWBJzCSXVO2QZ0vF46q8XIgfu+ShBhfp01IHz9Y2F
	 OP9/OG7i+2ZWIg78InbXBBEaM24Vuq/6HfIQ5qav/bXWbsDwXiuF1x0LWX5jktN30K
	 nA1pNuTHQEvtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E25FD84BBC;
	Wed, 21 Feb 2024 11:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/dummy: Move stats allocation to core
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170851502857.15341.15517644108152469413.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 11:30:28 +0000
References: <20240219134328.1066787-1-leitao@debian.org>
In-Reply-To: <20240219134328.1066787-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 19 Feb 2024 05:43:28 -0800 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core instead
> of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next] net/dummy: Move stats allocation to core
    https://git.kernel.org/netdev/net-next/c/a381690dd842

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



