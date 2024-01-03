Return-Path: <linux-kernel+bounces-15461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F7A822C4B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B741C23459
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FE718E3F;
	Wed,  3 Jan 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdTg4XXh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81C18E2D;
	Wed,  3 Jan 2024 11:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F0AEC433C9;
	Wed,  3 Jan 2024 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704282025;
	bh=zsibZlEo5bVVf4c/JcntcfAlVDV+oVQPpKDFkzd6BIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tdTg4XXhgHkuKnzJ08B/b52XRXhHNkzcJ1nCtFfc8NmY0mcSIlZtoc1cVGuS9+NiF
	 Bcw/F0JRZy6DH/SZ4TC4zVAZ00uxAcqGYvrWdNEluJvs1Of2gpUc2uk1PUNZeNciSW
	 GcF4u4TSSd1lrTndNaxhWw7ukw1xC1oNvvLSXZCrOLcS9iw0uZ9u1MrJiSgB+82Ax8
	 SI4FhivRgv8HyR4b2MkmnFUaFyxyWH44+f/+Wjv6S4PN9yWTFYGfPOPcnchRIJEKVx
	 v+X9Jjb/cH14Z8I1LlqlevbFuIqppjFNTlDu9+Dka+LqRM8iED7h2KH+h71RaRjcv/
	 pxXcvr/Q7ExeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 127EFC43168;
	Wed,  3 Jan 2024 11:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: Save and restore msg_namelen in sock_sendmsg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170428202507.24279.722670497373581017.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jan 2024 11:40:25 +0000
References: <20231221131230.2025000-1-marc.dionne@auristor.com>
In-Reply-To: <20231221131230.2025000-1-marc.dionne@auristor.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: netdev@vger.kernel.org, jrife@google.com, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 willemb@google.com, horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Dec 2023 09:12:30 -0400 you wrote:
> Commit 86a7e0b69bd5 ("net: prevent rewrite of msg_name in
> sock_sendmsg()") made sock_sendmsg save the incoming msg_name pointer
> and restore it before returning, to insulate the caller against
> msg_name being changed by the called code.  If the address length
> was also changed however, we may return with an inconsistent structure
> where the length doesn't match the address, and attempts to reuse it may
> lead to lost packets.
> 
> [...]

Here is the summary with links:
  - net: Save and restore msg_namelen in sock_sendmsg
    https://git.kernel.org/netdev/net/c/01b2885d9415

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



