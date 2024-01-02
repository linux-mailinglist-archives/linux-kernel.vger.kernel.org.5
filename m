Return-Path: <linux-kernel+bounces-14402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DD3821C92
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3F21C220B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01FAFBF5;
	Tue,  2 Jan 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et1pk75c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194FCFBE2;
	Tue,  2 Jan 2024 13:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 867F5C433C9;
	Tue,  2 Jan 2024 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704202227;
	bh=Vblnpl77YLwIntfxgREMrVtIplojtMngCNhj99g7qM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=et1pk75cD4O3Uo3Smf7k+nFGm1FKWjjjFEcIrKHvUFjacBYbyppU/Amv+uKc+kMwS
	 ay1tkG8MF6EtUm1sw2e9Pv9KAUce7ZeGwJ3Xy35Z9wrBBpX40VfSK3FAAn9yTNSBN3
	 rqI29dv6zz/hqZnWn6wj79p2yLR91AHqZc10aqAfv5mfgTZp7NRq4Kd6BEi/clXXE8
	 /MV80psaMneppMTjczyANcT0+3tJgDHNpat4+Ix56MB15Eh3rkaU8g6+gH7NSEf6vQ
	 1vC+uHC4uhu8urtGDuGXuDeFx6cNzAtMDVkApA88zERlp4XN7eyJrkeFkUIOfZDPTO
	 4NhL52R8FYebw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C0B0DCB6D1;
	Tue,  2 Jan 2024 13:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170420222743.17440.3588891639926250517.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 13:30:27 +0000
References: <20231221231901.67003-1-jthinz@mailbox.tu-berlin.de>
In-Reply-To: <20231221231901.67003-1-jthinz@mailbox.tu-berlin.de>
To: =?utf-8?q?J=C3=B6rn-Thorben_Hinz_=3Cjthinz=40mailbox=2Etu-berlin=2Ede=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 deepa.kernel@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Dec 2023 00:19:01 +0100 you wrote:
> Commit 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW") added the new
> socket option SO_TIMESTAMPING_NEW. Setting the option is handled in
> sk_setsockopt(), querying it was not handled in sk_getsockopt(), though.
> 
> Following remarks on an earlier submission of this patch, keep the old
> behavior of getsockopt(SO_TIMESTAMPING_OLD) which returns the active
> flags even if they actually have been set through SO_TIMESTAMPING_NEW.
> 
> [...]

Here is the summary with links:
  - [net] net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)
    https://git.kernel.org/netdev/net/c/7f6ca95d16b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



