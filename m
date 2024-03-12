Return-Path: <linux-kernel+bounces-100881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD05879E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1009B240E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2A144054;
	Tue, 12 Mar 2024 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOi4Xo3o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7EB144026
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282264; cv=none; b=d9vcOEWrBtM8DkH70EyLi/mmUF4ZrUILH0jvaukSuj6GgHFdhITn6joT5BihWLy/ffeMd/kq7QpNKerD9CBe1KGF1n3m0L6jAuxrp/VxE+JGA3lNsOlAAtz7oAB44OALy2UYh1R3PCh4giZUEn+JRYa7CzB/+H3Ek9reVap87nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282264; c=relaxed/simple;
	bh=3+oBRZg5KHc6y+aLanvARhNI+NO+sh2OCwM3St5HcZY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FHHyZW4yTNA0Bq+xPJozGc3C+BVWdrz2PBJrTwoW1BGwOPn4yN4su1Q3+IsaB/T0Yt3PPkYVOnAU6DgNNQL3PIYME7DqFYvhF4dB3XB5k/bHTGniZenzx3Oqoeb7pInt+uZlTs2vL067gksmIT1tGclJ2vp3Y9v2J2bCNodJDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOi4Xo3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD573C43394;
	Tue, 12 Mar 2024 22:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282264;
	bh=3+oBRZg5KHc6y+aLanvARhNI+NO+sh2OCwM3St5HcZY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZOi4Xo3oaB+rowUFy+TAUhYUkPpKep8/EeTJoRF/5CH/KbH+GhRmHE4sqhxrtNzLU
	 GY1y7ytY5PCLQ60F5MJMuABkI8AsIhVIAzw4PtgZPZjdPQnjmUWLLb/qdliq2yUwZp
	 hCCjVWACagWKrTPEdNo3T4SsENN1zNr9LOseWCziEvdeHva2FnHrVYZrLadul2tvs5
	 YARDwnyTx16jQWno3y+kZF8EsW+jbtWCeAJd3z0fkY7ELb1ZRo0eHRjjqoTokEV/3e
	 WBaoRf2cqPySaMIpAcHw3h9VikaC48lbybyRevpEc+9G2HNA1pa/Htuq84RUdCNWGj
	 19NbXJYw5fj6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B44AD95053;
	Tue, 12 Mar 2024 22:24:24 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202403111640.68D9B74844@keescook>
References: <202403111640.68D9B74844@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202403111640.68D9B74844@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.9-rc1
X-PR-Tracked-Commit-Id: 56af94aace8a0489fb1a32fd6f1cf0c548fe3911
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f1a2774098bfdc54f9c94901665ddd81ecbb3cc
Message-Id: <171028226463.16151.3121027669035437870.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:24 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, kernel test robot <oliver.sang@intel.com>, Mark Brown <broonie@kernel.org>, Terry Tritton <terry.tritton@linaro.org>, Tycho Andersen <tandersen@netflix.com>, Will Drewry <wad@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 16:41:24 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f1a2774098bfdc54f9c94901665ddd81ecbb3cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

