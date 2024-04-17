Return-Path: <linux-kernel+bounces-147797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3CC8A79CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5CA1F21EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B5079C8;
	Wed, 17 Apr 2024 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXAciEce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6EEEDF;
	Wed, 17 Apr 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313233; cv=none; b=VXQmeyct3y3N1YqKhsM6armezd66HwF2MekpBItK/DJjPH9w4DOUsrRZQGlJdwH16iC3iiE22H5v/pQpwZAVm2z007L9ypa6eDPviZ3xdhUG0Jn2CUfuvRWyvVMfN10TcJs5qbCb0k4JCiNCBa83IBLsRoF3BtbR2FoU0j7TurE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313233; c=relaxed/simple;
	bh=MuXir1a4HxUc5/elRkP4fSNYnpZOhVEyKYUO9DQGCVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q1Ty6YS6wzHB9HV3HE/NKNJKI2dFYN0OcJyFL2Cb+sAiNyW4UVDePpZYVXa6AsZRgsilEfiFBTLaKbSHLiVE/QXkmRiFMPdu8pebYXNQIc7JK2IkLu26rYeJhiSJFC+Po3dhVDElQqNdFkOXAHbdDV1gc5RHWznZkTGvwS3NDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXAciEce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95CB2C4AF07;
	Wed, 17 Apr 2024 00:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713313232;
	bh=MuXir1a4HxUc5/elRkP4fSNYnpZOhVEyKYUO9DQGCVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mXAciEceGxrBh+JjCwliKgOyglzZ57WUbPIFs8oGnZtPCu0fgjhgvAT9H4lBkzRTi
	 Xy0Q3TQpYRoQpSov6hOvCfWpO9wxsFUgVUJjGMJwf1qK1TS4CiLzlxOQJKzIb1Awik
	 LrOlc7o/jE+w5FlTiXNlnetilAKQg2mdQ5FWi8Kso6ru9sOuEo9Bef+Yjdq8rjLKHe
	 oCi8Z63jfsoUoEkVcCW429JsuiN0Fui4MgjHTZUP84DDsxef8I0yqtqIP4K4JKTNAK
	 JZANlh+/kysVxfuu4/pUln41Jhf52Wkyo9gMlfJz/Sd9OSiaReKpRLe+I6tKOUodT0
	 rKEax4oSSrdUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B7A0C395F3;
	Wed, 17 Apr 2024 00:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net/handshake: remove redundant assignment to variable
 ret
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171331323256.29224.18144970785462425420.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 00:20:32 +0000
References: <20240415100713.483399-1-colin.i.king@gmail.com>
In-Reply-To: <20240415100713.483399-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Apr 2024 11:07:13 +0100 you wrote:
> The variable is being assigned an value and then is being re-assigned
> a new value in the next statement. The assignment is redundant and can
> be removed.
> 
> Cleans up clang scan build warning:
> net/handshake/tlshd.c:216:2: warning: Value stored to 'ret' is never
> read [deadcode.DeadStores]
> 
> [...]

Here is the summary with links:
  - [next] net/handshake: remove redundant assignment to variable ret
    https://git.kernel.org/netdev/net-next/c/c2b640529ec7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



