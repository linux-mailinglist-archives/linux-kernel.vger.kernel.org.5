Return-Path: <linux-kernel+bounces-67609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B283856E07
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54411F268EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD10513AA3B;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2Ov6Xw0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF3813A88F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026607; cv=none; b=VkiyhwG19EyCazrtZkCae5ttNMwIpYJdbnF6Ff6/00Bkk7ZNy7Ft4qb9YyO38HOPYaaHc/b+aR7qgVVJt/WcNHmY/KpESJT7ojYVkBcaVXTySugVIkrO8piQhO7ar45VcGFQHPwLYha+lRBSiOFPWO9OSHRinlK9Ouk1Ad+lDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026607; c=relaxed/simple;
	bh=cXTMNDubim9LYKv9Kiqjf8qDYPWBI1ollBQsHsTAzk4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nylfOOifdI5v/2aF6WDLupNXavUlSlE7NEZ6FV8x0UHjRh84ir77mVVO89P0A99F4JmkgdQ9IOCFMS3FxlgCVx0unFzhQD5P4rlMtFy6JY8/M1krRWKr66JvOFdKaOfdTrZgYdjcdHX2j9wCELLRJYTWv2V7OdWqoiIEDUt7m/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2Ov6Xw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1CEAC433F1;
	Thu, 15 Feb 2024 19:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708026606;
	bh=cXTMNDubim9LYKv9Kiqjf8qDYPWBI1ollBQsHsTAzk4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u2Ov6Xw0aRr80hEjrvLMZsfntzb6dpQYp/y2JzOHc23RfeRz21NJX59ax67GLM6Zn
	 28Cfd2KWyAGcuggN6a2h53Am6GYLNhegMiAN9vpBRstUy39bI1XYDcf9tgCWhWEhpM
	 fsvUR55sEA8qLVqADtxLYKFENgIYjd+tfGVl28ZlOP5hfc58P6uTd19AIX61vPirGm
	 q8sND2sMYxF1PKk8iacplLwVUm2+l9y9avN/13GqHN0MifQBObBH+Twmw/wUjiGwE2
	 TioNzf9DHqFzO+vxt8YIjl7jH0omHuXf9tVmyz2DTsVfGUboCzoAG86GOVdTxmlUAq
	 lAjUC3GuYH5vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF0F0DC9A0B;
	Thu, 15 Feb 2024 19:50:06 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240215133859.2FADBC433F1@smtp.kernel.org>
References: <20240215133859.2FADBC433F1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240215133859.2FADBC433F1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.8-rc4
X-PR-Tracked-Commit-Id: 2f0dbb24f78a333433a2b875c0b76bf55c119cd4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c460834f6034e0b614f644694c226b55037c056
Message-Id: <170802660677.17476.15258465721898523621.pr-tracker-bot@kernel.org>
Date: Thu, 15 Feb 2024 19:50:06 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Feb 2024 13:38:44 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c460834f6034e0b614f644694c226b55037c056

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

