Return-Path: <linux-kernel+bounces-106114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE66B87E953
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195181C212AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFE2381B8;
	Mon, 18 Mar 2024 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTXpFpBb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18598E541;
	Mon, 18 Mar 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765030; cv=none; b=ff3D6fITVINSYcVjKpwLYzJn+mra7unluahK7xZIXrMJbTt3jLAuAwlXtE0WFrQ4BS4IK90FUgy47l4opmsmmQ398BjolKRt4rGXGUqf33zt41NXAzCe/yeauGBx1grezt8bKgO0QpmioDkqPB1jj82tiapiAoL+MBNE0fN61/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765030; c=relaxed/simple;
	bh=36ja+Yq1JirPAML1+Wef8HAUWUwbpkCVgvscAQY+a5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hKsH5t1g136rIeQv6c0Z5AGll9a7Ynr2lg6W6+Pjodw6te3Ve3/AZul/Wl1nJ2INLRoc4IPYQgW0/ouTGlBrqbO45qC/+X+WoEtW4USi6cfJWJ6QtNq/VRyJrTYE6AIZy4ZdsGeERXG6NGRCYXRd5HPK2RDW1N1wjVNfduK3l2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTXpFpBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A88DDC43394;
	Mon, 18 Mar 2024 12:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710765029;
	bh=36ja+Yq1JirPAML1+Wef8HAUWUwbpkCVgvscAQY+a5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZTXpFpBb43hdi0OWHvU0rlFUzLE6Z6D/xtuL/ooKv/p852AM5LtPa8ym+Z7ZqwKYM
	 sddvh0YPbjOCYO+EuDR5TZmku9+uG77Ix/4t7tJdyUvq8wvS4u4l6nMu48XaPINRAw
	 p1ZrpuMdTIWbX0I9bk4n7HtOhzs3f25ZwEZMSTSC9nA+hPTLHzEUAdTXdGUYdm0iFG
	 6xc2YEtn0OYDoETG7RX9Dvvec/lKR1hSNxfbud/aRfGaJw5ew2PCJPuyNn1wnfzfYI
	 9YPhyd1l59MS6HyUAeRC4WxNeeJHQW3cNW2zS3dWgX+UdWWFmIhMTap1KJFJbi+Sdu
	 nt4gil9Z8Al5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96D31D84BB3;
	Mon, 18 Mar 2024 12:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: veth: ability to toggle GRO and XDP
 independently
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171076502961.32045.6145861941709920995.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 12:30:29 +0000
References: <20240313183759.87923-1-ignat@cloudflare.com>
In-Reply-To: <20240313183759.87923-1-ignat@cloudflare.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Mar 2024 19:37:57 +0100 you wrote:
> It is rather confusing that GRO is automatically enabled, when an XDP program
> is attached to a veth interface. Moreover, it is not possible to disable GRO
> on a veth, if an XDP program is attached (which might be desirable in some use
> cases).
> 
> Make GRO and XDP independent for a veth interface. udpgro_fwd
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: veth: do not manipulate GRO when using XDP
    https://git.kernel.org/netdev/net/c/d7db7775ea2e
  - [net,v3,2/2] selftests: net: veth: test the ability to independently manipulate GRO and XDP
    https://git.kernel.org/netdev/net/c/ba5a6476e386

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



