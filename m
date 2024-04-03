Return-Path: <linux-kernel+bounces-128911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB268961CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5861C22682
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C23F17C73;
	Wed,  3 Apr 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcFDyErx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2746101EE;
	Wed,  3 Apr 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106627; cv=none; b=PFGBsOrfH319zFj34qRUFDmmOpJ5ItWM6aum9Fju0VcRpeLUNXHAaiLAs0x92ch6qTqNqLqmBbQXZOQUlm+nXT1jn7phiFpmYPSzYgF4Jgb0WKCpEnoqXxalmWsN9sFy7HXOjGrp+BC7UgxUUgUcbBvi+zMc84jH2zrm/FQCnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106627; c=relaxed/simple;
	bh=6R+jUnyz2+y+hPbGs7voORqnWJIakb6nMaNT0Qn4hfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IG7FIr+LTNP+R7JHKaxvPWcRGLNffFsX3Y1ahdJALEszWPXbYmQ53Sl9v02x2fNSlWUEb69LprussqkTX62rBu6u+nOboy68lRTWpTnlHzAcQgExz7W/Vekjw8ldNRlZdDh8Lyqpx/kD0tg2hUOuqrmIK7k8QHip8++fI0Y0WKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcFDyErx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7A07C43601;
	Wed,  3 Apr 2024 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712106627;
	bh=6R+jUnyz2+y+hPbGs7voORqnWJIakb6nMaNT0Qn4hfw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BcFDyErxgfhqfZMb4Gh4EQxLmxqMwhivRwPgTGflGShrawooxzJOre/dCy+FRExal
	 3+K33JLJwkcykIP12oGHs4X7108txvRu9UXlBOewZlNa3jWGQL5ebO983wRKAKVVEg
	 x2QOjXOnkPXODD5+PFRqeG8j3AX+CdC74pJzjfyivuO2f2D5ZEyK/Y4/mzbUzPMBn/
	 gyIiZMGXp7SvlpcNpDyqv8+UKoLsSdVSHn2W20KrX5z4d52LYQj6qnQppt3CQ1IW6X
	 Fa0XfO9VvzEgRSSli9dQ9ewjJlos6KEwgFiPHG+si0ispzGVDHGxW3CRn97cdj9UeE
	 VOX7xbnl/AVfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E290D9A155;
	Wed,  3 Apr 2024 01:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] nfp: Avoid -Wflex-array-member-not-at-end warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171210662764.30217.3683603150178258009.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 01:10:27 +0000
References: <ZgYWlkxdrrieDYIu@neat>
In-Reply-To: <ZgYWlkxdrrieDYIu@neat>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: louis.peens@corigine.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 19:17:10 -0600 you wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There is currently an object (`tl`), at the beginning of multiple
> structures, that contains a flexible structure (`struct nfp_dump_tl`),
> for example:
> 
> [...]

Here is the summary with links:
  - [next] nfp: Avoid -Wflex-array-member-not-at-end warnings
    https://git.kernel.org/netdev/net-next/c/d88cabfd9abc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



