Return-Path: <linux-kernel+bounces-85461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C79086B660
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AAF286F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E27D15DBC4;
	Wed, 28 Feb 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsRHcIGc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B215DBA1;
	Wed, 28 Feb 2024 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142517; cv=none; b=GcMHrxdMHtmBUTFLzGpamca5SNTTKCWwF816G76w+OvfJoJGzGRltQgY2TP/QqD23gP6iIHfmmG870Mo5DWYH5/JSKdNlnFmWS4BfHn52/MvNyMugnqMpZyA3NlpD9SWBVp9pmntUOo7sbUl220WB/wFbokpCo1u0ITxadd+3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142517; c=relaxed/simple;
	bh=2Oje7CGM1hgPJmNAI7zzuUGkldEK2oywfpDOQdcjuMc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ze52sM71ysSgKXa6jPOz0uL4ny0lsP1LKtoR1CjPWmn/Aqj0PBsQn9ZDd7ZHWy9IPwf60tdcObxbxACebNSIGKVaLV/TH4N/2W0SZLhCKboETeu0baIca2r9i+jNDSOyT50zqrJZwscKAraXcssZtggPI+7v6WHD8gL13xxm+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsRHcIGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BA4AC433C7;
	Wed, 28 Feb 2024 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709142517;
	bh=2Oje7CGM1hgPJmNAI7zzuUGkldEK2oywfpDOQdcjuMc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bsRHcIGciK+/R5/6GLKIQ37FWlUbdinv/4glBtVoHynJZdDlH59gbMafb+v4ZMxNg
	 bNg/QQqTC8yJCSEmauTezsyrZEDlY35KNWT7+9M3DyD+0nfSrsxyWkDe27e2/3Qvi+
	 oXdgpPoIgaj4dYhLjedj3vjKyAzzbMSxX3oMhPi3wSfS1ogZ4tc7yQmRpnKTBlxnPY
	 SfJyfy78WshGeLn0j5/r8hWwwufj32Fph4bB+ULFMp9TWlubDkh/gP64+NsXcQawXc
	 ih5xgajgP6pu36uxifH/EtIlGXyiPl438DXFjONSinru4BQUgHzr4QlOrF44716oMS
	 +MylQBsS/l+rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 766A3C395F1;
	Wed, 28 Feb 2024 17:48:37 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zd7p36CRWPsYhA2G@gondor.apana.org.au>
References: <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
 <ZbstBewmaIfrFocE@gondor.apana.org.au>
 <ZcRYwZHASH4Cv5Bn@gondor.apana.org.au>
 <ZdW+GCkO4s3MSeLX@gondor.apana.org.au> <Zd7p36CRWPsYhA2G@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zd7p36CRWPsYhA2G@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p5
X-PR-Tracked-Commit-Id: 1c0cf6d19690141002889d72622b90fc01562ce4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e326df53af0021f48a481ce9d489efda636c2dc6
Message-Id: <170914251746.18601.9535622620660987702.pr-tracker-bot@kernel.org>
Date: Wed, 28 Feb 2024 17:48:37 +0000
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 28 Feb 2024 16:07:59 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e326df53af0021f48a481ce9d489efda636c2dc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

