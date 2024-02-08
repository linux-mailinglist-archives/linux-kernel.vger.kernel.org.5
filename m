Return-Path: <linux-kernel+bounces-57512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA7184DA0A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56AFE1F22DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B4367E8C;
	Thu,  8 Feb 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTuNtlv3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C867E62;
	Thu,  8 Feb 2024 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373494; cv=none; b=ZtcFH0yVsnE8dkTl6yiYXeZCDbUg/nS3gR/ExDLZ7SyX7ItcYmRpe4dfHI25bENRgOq85kXcDKpq2CeHX57LoDzgHEqAvL2fWSZJ6pmVuAZIGBTqaDbfgSuh2WxPLbXZbXI6PqWNi32Fyt1dgpij1Yp8aXEmUfaerJ797YN+A+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373494; c=relaxed/simple;
	bh=zKCRSzu6ZtgBskxMCJ9lk+uCKfnoGkffnWSpHPTbmQE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KsFGlBSKPhU9LR0L0TUZD83RUk84TXPP1Q70PzYS9EAgHd1Yy6GKBHcw4FIuqrSEq/rcuFyTnB/PhKmxmQP8MWsduqwUtOEQiVtMDHZsbXYcgz97/nC9+yeXfnDZL0EBLwrI3Bl5MxSnAaV3BszFsy7RJHjtY4dCQeuP6DRhB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTuNtlv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A0A5C433F1;
	Thu,  8 Feb 2024 06:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707373494;
	bh=zKCRSzu6ZtgBskxMCJ9lk+uCKfnoGkffnWSpHPTbmQE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fTuNtlv3BK0Nz25zWZntV7J/9g3ThkRD7uleoP2WichORSTXub94de91ZcuSbYVmp
	 ARecsJslHu+1xssZTEDUWMGn+zuQPVYFicNvd59WiBaU8x6ZdhMdXV/HKqEjmL4Kyl
	 21gmE7+hAaTCOi15gBhNUCsfUWUr6VR59x9ZQGkvfjPNYVqLbr2eIdP0UxuG8pumLl
	 SCUvpJkHgNUtzvZ8iUceUWQaG6+IH+RHNfHIhfSwAUcjuQF+xzmo7VTit8wFhCrfPf
	 faODzd2xQDLTAgeT1BQUL/DZJ1CHsBP1+6w0LpUSoTi82hzabkFL8xkhf/hc4RqjsS
	 Qh1fJr6MfGChA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA10DE2F2F0;
	Thu,  8 Feb 2024 06:24:53 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZcRYwZHASH4Cv5Bn@gondor.apana.org.au>
References: <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
 <ZbstBewmaIfrFocE@gondor.apana.org.au> <ZcRYwZHASH4Cv5Bn@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZcRYwZHASH4Cv5Bn@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p3
X-PR-Tracked-Commit-Id: 24c890dd712f6345e382256cae8c97abb0406b70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 047371968ffc470769f541d6933e262dc7085456
Message-Id: <170737349395.17177.17226412952261483547.pr-tracker-bot@kernel.org>
Date: Thu, 08 Feb 2024 06:24:53 +0000
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 8 Feb 2024 12:29:53 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/047371968ffc470769f541d6933e262dc7085456

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

