Return-Path: <linux-kernel+bounces-58962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1234784EF40
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BF22845FF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC80DDD3;
	Fri,  9 Feb 2024 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHsfKKx/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133B4C6F;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448268; cv=none; b=XMCxseVqADzXgUep6PTFMhDa8ibxOvkUkwjZtSSkEG6Ngc/95UIRxJilLymCXcYDiluAaVraj7uGy5ajmI6OfkrEaPujN3qzeEdD3y9UTWyE5KQfylRhV4IOFPWs/01qf0GorKq16PDajPdzVRjb3y41r8Gqb7XynVi2pqLy6IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448268; c=relaxed/simple;
	bh=nDSwJmMJ2uuolYdgWkjq0EkHl0zZvUu2RDqequxfG+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MU+P29AlL1EiNVgf2pSC+MODaFa4XlJtpADTjmQJpQSZ2kwskJIM3fWHSNlJjqgP7Ew/o0MDtEGlL+0fTu9gZj6uYHC2rAiXbVZS7GeSVg8ZhrgLa/jXd7jIC/BKFZPrBeP1W1ayaCpjCnZjP2rKK2Zp8JS/YlhZEQ4NMKFAAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHsfKKx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65FE6C43601;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707448268;
	bh=nDSwJmMJ2uuolYdgWkjq0EkHl0zZvUu2RDqequxfG+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fHsfKKx/R1LhoXNJ5OOZyE3/OFt4Yvkvc5CrsYYvo/ooIs5PCH5dLBSsii+x3ia2G
	 emoQsvn1hnloF5+1lW3nIQMHF33oY6lWQv8me8RwjeNdH4odFybQZlTIVIu0U0pjv4
	 nGdmel1XJhq3PSGE1M8gOGttu65qTOOEJhgMBxtK7Nfri6/WJviqGecE73kSo1RfYu
	 nTRRmIMsnNDRxfTQ2G+6wbsnYfIXM66nbv2I6MV3kXuruj1imcmrotIoKTWOVgsAF+
	 W6qnsTZ6fJM2xzYBqCCaL7awEP8rMsGsCzrCKopMcomhFvPvJgFuqxDDcS8Sid+p0W
	 r/zh7fJoLN5Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E841E2F311;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] xirc2ps_cs: remove redundant assignment to variable
 okay, clean up freespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744826831.23533.786898690563333566.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 03:11:08 +0000
References: <20240205213643.1850420-1-colin.i.king@gmail.com>
In-Reply-To: <20240205213643.1850420-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Feb 2024 21:36:43 +0000 you wrote:
> The variable okay is being initialized with a value that is never
> read, it is being re-assigned later on. The initialization is
> redundant and can be removed.  Also clean up assignment to
> variable freespace using an assignment and mask operation.
> 
> Cleans up clang scan build warning:
> drivers/net/ethernet/xircom/xirc2ps_cs.c:1244:5: warning: Value stored
> to 'okay' is never read [deadcode.DeadStores]
> 
> [...]

Here is the summary with links:
  - [next] xirc2ps_cs: remove redundant assignment to variable okay, clean up freespace
    https://git.kernel.org/netdev/net-next/c/e084a1c1dff6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



