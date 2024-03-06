Return-Path: <linux-kernel+bounces-94271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C61873C57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D17288750
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B620613A864;
	Wed,  6 Mar 2024 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCQUGDL9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B65FB95;
	Wed,  6 Mar 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742811; cv=none; b=tA4v15+pV+YUpdrJRpvyQGkdlN8jFWLY/uA/YqkYqlHkCzcE3S6+IR3H61O/scGTlSNKvcl8TBN0581bJ11Hh2xPIwmruxiWTRiqxGYO9swUkoYDAZsqxNvjFJ4w6t7aya3QeY62b8S8bWmZtV0cBe7lHdrUEkCgQVLlKRcPcqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742811; c=relaxed/simple;
	bh=Vr6KDxunZg7woY+LkcERB3Zz9nRiyhqmmBka1T4UBdU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S1StA3/Fyayeo0jgYBSXrkKGueiPlSKaQ+ZjB7mWE/x/j9zuxVNhOWkrnxIhSvn9b4p3P9iqGIeNuIamweOE1NmOLliypPOfdB+n/In02a0ygxLB88b/jljRoBfDW/hqx5CRh4xrVSudhCPt2sXAAybbdWrnKS3IeR8zgoVaslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCQUGDL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D485BC433F1;
	Wed,  6 Mar 2024 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709742810;
	bh=Vr6KDxunZg7woY+LkcERB3Zz9nRiyhqmmBka1T4UBdU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MCQUGDL9yIPs/rIp+pMAdiifCMZJbYhs8jhuUEBSPM+qzFKa0SKxv3WuUZYpfx98/
	 83qRLI71AmDcwUiGKjZKb8KFIGZWkWFe8OYX908n/bxtjfDAdjZdRO1MnJQYE7VI6c
	 Ag4b1eASeM5/xvn3SUs/Njc6QVS17bTSgI1x0f6ALoFogVwYepWVN4I2ntrURghHCe
	 bmpNhL1e3MY8mcahlJu8VGCpESa+l7meK/Kp7UVl5qonvmMyDe4BjlYCvruGHWRdX6
	 V9BPwSOOQyLGdubLdDF5cBJz0ckDd2c+3cgBw2HjfuBAabZebmumaRwGam9sW2br35
	 mqyMdx6yjr2kA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2977D9A4B5;
	Wed,  6 Mar 2024 16:33:30 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zeg7vD6GeVHAxYWf@gondor.apana.org.au>
References: <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
 <ZbstBewmaIfrFocE@gondor.apana.org.au>
 <ZcRYwZHASH4Cv5Bn@gondor.apana.org.au>
 <ZdW+GCkO4s3MSeLX@gondor.apana.org.au>
 <Zd7p36CRWPsYhA2G@gondor.apana.org.au> <Zeg7vD6GeVHAxYWf@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zeg7vD6GeVHAxYWf@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p6
X-PR-Tracked-Commit-Id: c0afb6b88fbbc177fa322a835f874be217bffe45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09dcdbac54f4e60c917251fea98a69e46817fe27
Message-Id: <170974281078.18944.2200480847018841315.pr-tracker-bot@kernel.org>
Date: Wed, 06 Mar 2024 16:33:30 +0000
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 6 Mar 2024 17:47:40 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09dcdbac54f4e60c917251fea98a69e46817fe27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

