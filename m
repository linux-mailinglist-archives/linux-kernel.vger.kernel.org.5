Return-Path: <linux-kernel+bounces-90424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9D586FEF0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C2E1F25BEE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8973BB28;
	Mon,  4 Mar 2024 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDBqoGVS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C753A287;
	Mon,  4 Mar 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547645; cv=none; b=eqjP4r7i3t76GOpB9vzMMQCIxnbhqNOTbCYYgDLL9OR7/Jdf4iNLYNyh+3HP+nRr32pR8NDLhUjBiUh8RUQsTbRKaBLNTsp0fkL5oVe/rKlyI3RSpa90wJI3i0Izc8wuKuxykEgQlmtcxDTBWv28MnTCKbLsooj8xjAcLgwXv5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547645; c=relaxed/simple;
	bh=RnyaXHp34/XBiZ9fQ0M6N8Mmtv7MxUyjtJdBo/8gix8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RcF3jRPBSFQ3lKk0ObpFtwOhFaFj1cQ/B0Bn2u8XFzcoWgDu3wFoSxy9YbmDMMbL+YRFeavH6H/JP+f4d7Hj8H4W/3ZtV924eVUdCOiGVCrtQUPck12dnHu1kRANNAIioLfnxITRj8j8qOvkjo+ixmmbJTQRP+T1vy06cWwHwNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDBqoGVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA596C433F1;
	Mon,  4 Mar 2024 10:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709547644;
	bh=RnyaXHp34/XBiZ9fQ0M6N8Mmtv7MxUyjtJdBo/8gix8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UDBqoGVSVUsHD0E4nxPm9X4Im4TYQdH37AMFUJJ6Otf5CRz+B6ZubqaeARqVvUf+q
	 oYduAvZhNS1vD26ETK7cebs3bpT+g0zxPHccyi/DML3EHRVo2AkP21XRt0Y0xS/FGo
	 +xsI+fXNZr3m14WEJhyI89D5ctkYSpLNzAviFIKFsJztF/VmJ/RUAzboNA0ui2P49V
	 BrjgDl6harpyQNOGH8TS7xd6VDFWK2T4aIymq7D6MjmSUVoSygc4HlsvlwuR9s7KDN
	 Pma8M5+YQJYwIPr+SuW/JJlJY2SuRZg2Z1l/2bBXn8Tg4hGgSaRtORJuNTbK3PrbO2
	 5wVrtDrWOIa2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C80C6D9A4B9;
	Mon,  4 Mar 2024 10:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next] Octeontx2-af: Fix an issue in firmware shared data
 reserved space
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170954764481.3200.8588355582535112124.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 10:20:44 +0000
References: <20240301110314.29800-1-hkelam@marvell.com>
In-Reply-To: <20240301110314.29800-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
 naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 1 Mar 2024 16:33:14 +0530 you wrote:
> The last patch which added support to extend the firmware shared
> data to add channel data information has introduced a bug due to
> the reserved space not adjusted accordingly.
> 
> This patch fixes the issue and also adds BUILD_BUG to avoid this
> regression error.
> 
> [...]

Here is the summary with links:
  - [net-next] Octeontx2-af: Fix an issue in firmware shared data reserved space
    https://git.kernel.org/netdev/net-next/c/b8b85d048936

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



