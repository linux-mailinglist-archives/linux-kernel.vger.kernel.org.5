Return-Path: <linux-kernel+bounces-16516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92159823F93
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9273F1C23DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6C720DEA;
	Thu,  4 Jan 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSRlgEJM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544020DD2;
	Thu,  4 Jan 2024 10:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 052C7C433C8;
	Thu,  4 Jan 2024 10:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704364825;
	bh=6oI12NMbe/1rEbrvLoyow+9X0g3eqLOdvU7TaSCJ+Jk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DSRlgEJMaNqNS+tzJHL/uYglWAuP268K7VXW671BW+1EenFooF6QYAo110wknci4M
	 k52J7BEsY73cNTcKxr7VHWgkCZtruRozkDLsUDtGYDrn1uVzTlJ8ANceub0mJRYEqf
	 TBMIDfIqqOi0WupFanf5yfVjdlfgKxTwNrCczdu460aB8BCf0w8jhWkeHxU32yhGWM
	 YKCBkbCIurd8SRku4bQlC3EL8IfmU6Yup0k6nsePNwv2NsQ0bTXBrdu4XGG46KtFJN
	 LuYWCbQ1Jt4qSX7MMUk33W0rMOdLirGFPlyCPz1eA+qfciyiCqxeaJgOhhfjPDOyVG
	 HY8tkcMf40m+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5A09C3959F;
	Thu,  4 Jan 2024 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-af: Always configure NIX TX link credits based
 on max frame size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170436482487.2302.15098697644202320061.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 10:40:24 +0000
References: <20240102095643.25296-1-naveenm@marvell.com>
In-Reply-To: <20240102095643.25296-1-naveenm@marvell.com>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, ndabilpuram@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 2 Jan 2024 15:26:43 +0530 you wrote:
> Currently the NIX TX link credits are initialized based on the max frame
> size that can be transmitted on a link but when the MTU is changed, the
> NIX TX link credits are reprogrammed by the SW based on the new MTU value.
> Since SMQ max packet length is programmed to max frame size by default,
> there is a chance that NIX TX may stall while sending a max frame sized
> packet on the link with insufficient credits to send the packet all at
> once. This patch avoids stall issue by not changing the link credits
> dynamically when the MTU is changed.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Always configure NIX TX link credits based on max frame size
    https://git.kernel.org/netdev/net/c/a0d9528f6daf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



