Return-Path: <linux-kernel+bounces-137811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A5E89E7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D5E283C98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1942524C;
	Wed, 10 Apr 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peqvizFg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032964A;
	Wed, 10 Apr 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712713829; cv=none; b=sVUYbyCciamlherocGTfNzYEISq0SL2x0m/12XACj75A/0bp8kJEgR/Rdiv1y9otNHAoYqDSVk5dd/aikOLgyJ6dwbdLRh3S83RUj1NxDbh137U74at9Fxy/Yd2T0qLTZn3A4zp28a8T3Yvqq51HR801tYv9FZaRtb1lrP62aIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712713829; c=relaxed/simple;
	bh=C7uzs+pRecO5vt0/mJMXKHRDYPy1ocmPRZF7qiuwzcU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I6I9wMoRqfxjRbPUDtN8POQlAEXScT9rBn8gE2oTwxbFVC1Un3MdPpZM05582edF6W2gFEh9bcNga5mMfdPdnzL/fachqlPS/BHa+NOEdjI4oUoq/ALBmtPo2vj7nzVrEeLcmHemlPv/sOULkoiK8Cvu10CKIIKweev7b8WRbqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peqvizFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCE9EC43390;
	Wed, 10 Apr 2024 01:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712713828;
	bh=C7uzs+pRecO5vt0/mJMXKHRDYPy1ocmPRZF7qiuwzcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=peqvizFg2+AZZ1hTZ+ii7ZBDykemh1OdN+i0jnc8+UX/RYNgE84XGWAdhntfxmJGZ
	 iToKsl2zFVXcgPYQ0x/WD8lCAlcAax+7bMePFOHubiGlomfppRX02XtONeyrl/pnNW
	 nvsqBvtd+XkEV+HegrWRVzG1eIYYE3+2+WwVPTNqMc79IgF6kuylBV4+4eiMf1Ubex
	 CTxAYiqHDGWXyPeilvolTQs4c2/JyaMFZQAdRori7S87lG5W9zM83oJkWVC9mrA8/6
	 M3SU5b38X8t2joqmoXxfh/Obm4NmJtYNTP8VINTcwqvxvomcx7uvSjL2VpHQFaRdbO
	 fWGb8n2paHimg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B830FC395F6;
	Wed, 10 Apr 2024 01:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] Minor cleanups to skb frag ref/unref
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171271382875.18237.12454972110569663249.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 01:50:28 +0000
References: <20240408153000.2152844-1-almasrymina@google.com>
In-Reply-To: <20240408153000.2152844-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ayush.sawal@chelsio.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dsahern@kernel.org, borisp@nvidia.com,
 john.fastabend@gmail.com, dtatulea@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Apr 2024 08:29:55 -0700 you wrote:
> v5:
> - Applied feedback from Eric to inline napi_pp_get_page().
> - Applied Reviewed-By's.
> 
> v4:
> - Rebased to net-next.
> - Clarified skb_shift() code change in commit message.
> - Use skb->pp_recycle in a couple of places where I previously hardcoded
>   'false'.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] net: make napi_frag_unref reuse skb_page_unref
    https://git.kernel.org/netdev/net-next/c/959fa5c188bf
  - [net-next,v5,2/3] net: mirror skb frag ref/unref helpers
    (no matching commit)
  - [net-next,v5,3/3] net: remove napi_frag_unref
    https://git.kernel.org/netdev/net-next/c/f58f3c956340

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



