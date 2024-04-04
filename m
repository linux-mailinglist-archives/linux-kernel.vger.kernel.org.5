Return-Path: <linux-kernel+bounces-132258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CC389921E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D81F1C21D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6FC13C682;
	Thu,  4 Apr 2024 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzVuvSlN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA700130A7F;
	Thu,  4 Apr 2024 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712273463; cv=none; b=BOWF/bDi0/81JWH5umwnoFZDurS8+FbVrget/i5gW4RU6FQI1GGguZsAzHrpHAvpb4Cd/C8yH8faXtVJFECeLUc8xrAvWpRIZXI05W3940Kj04XTttQaI51v0hM/pLBTSyT5eAB0/FKHIV1Lp+XBbn9B/yjU9SKxJy+A8kS3QzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712273463; c=relaxed/simple;
	bh=ORiMOgrFpQGapGq1G1FCEF8WFgKf18pW8LDpbLkwOls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BQF7+0ma5D3kpBxVMls/EFVmBnJ020tH5FwOsBlKp8kgqjeq1l2DfYcRsB7bTEeCWVUkH5tuUMnVDKnJtqu9zzO9X23l+LgTLJrvN2y/ttMnK1I3yRPFHrjLzGdxOOfIK1rxKxcWwOMa/MPz/0NuT5EJA9FyAludH5xJ7ActNAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzVuvSlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 416FBC433F1;
	Thu,  4 Apr 2024 23:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712273463;
	bh=ORiMOgrFpQGapGq1G1FCEF8WFgKf18pW8LDpbLkwOls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bzVuvSlNch7/ETvg3z832y1lhjZPSRXF2FeUSP6Q9q1LqkxxfUNGJ4MPrg0hH80oF
	 tMCvg/UyVlaV3NjTbch3sWGqebTUksUc3Eh8M7jqYUaz64ox3v+qC6MiGeCPo/e05y
	 57HAuQZI/mbVoF6nN5wKOK/0p1LlK9qLdiyRFw7i0YIlO1bA7d87cZUIUE9Qcv9eFe
	 s9mP72bs6XqjXYbEWeeTzuNm0CTgZqBcOtYwdLvkXT376gVRBJ7EUoadNhtn1/KbX/
	 DJGmUuIbdSPO+QSMRQmctuP7HQBTYd7qC2yldyWjhDP5i7wsnG1xBkp0TeK6VKCOph
	 24lW8I0Qxmi2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 306E3C395F6;
	Thu,  4 Apr 2024 23:31:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.9-rc3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171227346319.15041.81356387766911820.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 23:31:03 +0000
References: <20240404211803.2089033-1-kuba@kernel.org>
In-Reply-To: <20240404211803.2089033-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu,  4 Apr 2024 14:18:03 -0700 you wrote:
> Hi Linus!
> 
> The following changes since commit 50108c352db70405b3d71d8099d0b3adc3b3352c:
> 
>   Merge tag 'net-6.9-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-03-28 13:09:37 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.9-rc3
    https://git.kernel.org/netdev/net/c/c88b9b4cde17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



