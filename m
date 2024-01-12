Return-Path: <linux-kernel+bounces-24191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A8082B8C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2500C1F23D42
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2BFEBD;
	Fri, 12 Jan 2024 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlUSMRbN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713E7F3;
	Fri, 12 Jan 2024 00:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B73EC43390;
	Fri, 12 Jan 2024 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705020626;
	bh=x4AlHOozLQGojg/cmOKMm7tVTOPxtSzMv9L9W14jqec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nlUSMRbNXrJkBNWasVkKabBts30lfj2GieJTNWMKhS4xc1BujH2smfnFh0ERm5Tar
	 TPJZx0mQpaV39HAXHDTNAobJ/ThQoKCn6qOxpHYaTI1vrmwgCL/L2jdKSkh3xrPFgc
	 g8NY9MEjbhcfz7LGue8gabC0QjEx4RC3Oc0AsJ9sytDbm7QKo7LKGdj59FJ6M4+xph
	 I7CGZhyjKUt0B/dPEZ59k1ZfRv3hQuo9qfdca697keLaA8iXfcj8QTpwLDnxLcgONA
	 p0nwNPE1F9sKk3lnCkhXPTTx6sTWzGhPkK0ncydAxczH2zO+sROpjUZAYQ/obSdYUQ
	 GX/VKNXVZid6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 422D1D8C96C;
	Fri, 12 Jan 2024 00:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] rxrpc: Fix use of Don't Fragment flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502062626.22596.17492875562101334214.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 00:50:26 +0000
References: <1581852.1704813048@warthog.procyon.org.uk>
In-Reply-To: <1581852.1704813048@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-afs@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 09 Jan 2024 15:10:48 +0000 you wrote:
> rxrpc normally has the Don't Fragment flag set on the UDP packets it
> transmits, except when it has decided that DATA packets aren't getting
> through - in which case it turns it off just for the DATA transmissions.
> This can be a problem, however, for RESPONSE packets that convey
> authentication and crypto data from the client to the server as ticket may
> be larger than can fit in the MTU.
> 
> [...]

Here is the summary with links:
  - [net,v3] rxrpc: Fix use of Don't Fragment flag
    https://git.kernel.org/netdev/net/c/8722014311e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



