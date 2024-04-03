Return-Path: <linux-kernel+bounces-128941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0F389621B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB1E1F2558A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA071B968;
	Wed,  3 Apr 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXQc5DHq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8DE134BD;
	Wed,  3 Apr 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108435; cv=none; b=U2XO7Re6St90XfkB3B6pxyEyp+rB+SXKnDwpw2kfvg9Tu0/+Xf6/FKrWz+gZaXUKrUVtYznspWvaUBaN1NNX37cM3g/fuXAa3CRA3bIM9G9Qo4duzHGHL/dC9L79OByqxEnJs0D4LfO2DaUeUibctQWL2ioIfUTmXRYdnsMG71E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108435; c=relaxed/simple;
	bh=0Guk15rTeTaTnMan0dmZnNapSaQTVXV+GiqMbsxmXPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pAPx7oGIayKBgPnDr2MW1GJvOGMp6nK+Mb7WGLm6dXVwtvoTCKenqL3WEHEqLkgBkDUhIHA4K6Va5nOKiVE21KaVnIKNeNerTmJ/nutCIOYdlaEGl2PqZY935+sVVjlS27BeazmjfcIsChcWcovaN7zRZqtIe3+Es4OzFrXdKmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXQc5DHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0F05C43330;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712108434;
	bh=0Guk15rTeTaTnMan0dmZnNapSaQTVXV+GiqMbsxmXPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fXQc5DHqHllgjJagFJQ9CHrsyuAjJ8i4CwpRCcDCdkI+Hvr6qfA6ohfw9dfsg66RW
	 6BPfxWIhrJ7y7k/kANA4M99cUC3kiB4hM7hxr+yEj/wfNdgOxjkjXO4Spqq7urBmVJ
	 kWVoSu013hG6YBVHAvtRP6BoN/SUZPAvoCl/olFVbqESRer6n31ki1QJ9AXwftvg5K
	 A5bCd0txXajbd1AiXCN9bvWSn9uwaRRkDCtDRSDuvSbggbz+WuRygOSAyj8fhRmKBR
	 9w+CKeUVYdD4WYU15pECicwdsBLURfZE4yE5eN9ilbW1pVHpPEd5nbLQhMn2HzNNK9
	 zn4DimxTtB9kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3438D8BD1C;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] caif: Use UTILITY_NAME_LENGTH instead of
 hard-coding 16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171210843486.14193.9711095226828920854.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 01:40:34 +0000
References: <8c1160501f69b64bb2d45ce9f26f746eec80ac77.1711787352.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <8c1160501f69b64bb2d45ce9f26f746eec80ac77.1711787352.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: rkannoth@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 Mar 2024 09:32:12 +0100 you wrote:
> UTILITY_NAME_LENGTH is 16. So better use the former when defining the
> 'utility_name' array. This makes the intent clearer when it is used around
> line 260.
> 
> While at it, declare variable in reverse xmas tree style.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] caif: Use UTILITY_NAME_LENGTH instead of hard-coding 16
    https://git.kernel.org/netdev/net-next/c/f9a4506438a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



