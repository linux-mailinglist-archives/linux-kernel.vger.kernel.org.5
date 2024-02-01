Return-Path: <linux-kernel+bounces-48685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CC0845FC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7842298355
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7871985268;
	Thu,  1 Feb 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVVBQb7a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B512FB2A;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811792; cv=none; b=dvtAipUrPtw5UyRNek7rl1005DTcX6ltJH5RCLBKjt6SKTubPiX7ciKx+UBJ1SRHfjGnczhP0lAK10PzfyXrD1KXF60QvP7pEMo6d5Op9bQM9dflyKQ6ruyzGrxb9Ybn8krJN0Am8DgwRfhoKTvqdKpE0R/s7q0AyHWrjMreuag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811792; c=relaxed/simple;
	bh=yq+Z4M7zlzPMJLWLN9zuh/eHfYQwP+DCdiLxy1yA5MI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qSwqESwLSzMmnvT9FgYg1fbHevRoXqN7ZZDUh/9w/NiH6+dNgDZVA+RidGLozq0GeYHCrmkLEVNBIBjIvgsjrl+rOmKFHdowV7uYF/VIG+hG0kggYf3RBQgnuLE56mav5Z3CETXnQpmPKboRI4m4Fov5O6iTMA/4o4O/4HroUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVVBQb7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7668EC433C7;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706811792;
	bh=yq+Z4M7zlzPMJLWLN9zuh/eHfYQwP+DCdiLxy1yA5MI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CVVBQb7alxOrVgqjNfPoyvE2ZNeGf8Ozr4y7QfHOkFdcX40XfE589hxrKZKOHBIGV
	 renqucEft1x+uVVuAIlHE50gFbXZyskzejLiZykSwBXEAKPfnY1KjMdH0aK9+NflJ8
	 yiaeOr+9YsD5P73QM7AwMH283e5k3de+SJH6bNNqTNiPmTJpySEgZrYUAEyZKueP42
	 uWrhtzSwjNDZvaa6IheZHTLzL1tALOarJ199dnpoqRb9ag+tltC37qlSBZCAGMRNfg
	 FTQkqy501KWaGuXl1ZDCjdHuTgPJrYas1bvVEHSNPHDkg4L6CqiVOfUUvoi15eYKWh
	 fgfNKP2mPshgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60AD0C0C40E;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZbstBewmaIfrFocE@gondor.apana.org.au>
References: <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au> <ZbstBewmaIfrFocE@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZbstBewmaIfrFocE@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p2
X-PR-Tracked-Commit-Id: c5a2f74db71a849f3a60bc153d684d6d28a0c665
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a2514c0c61f7d4587071b96b4be7481350b5bc9
Message-Id: <170681179239.954.11799166338832524461.pr-tracker-bot@kernel.org>
Date: Thu, 01 Feb 2024 18:23:12 +0000
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 1 Feb 2024 13:32:53 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a2514c0c61f7d4587071b96b4be7481350b5bc9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

