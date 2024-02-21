Return-Path: <linux-kernel+bounces-75179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D2A85E454
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05731F25AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5C1839EA;
	Wed, 21 Feb 2024 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwyVlMcV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5DD7F7EE;
	Wed, 21 Feb 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535836; cv=none; b=NfLKDLd+uwiGatKSYn9toh0/Q08gi/05ewkV57q+ydT/8FmrLNJVd618Nt86DdfVRjZuywuGOC3bgN1LoI6kHwpA2mSUVdDGCBiP4hH7AmGR5x4/UDaqYf7/PhJHUYdGdHEwKiuItDjyNKWoxNvvfdI4VFa4tJyg/Q5FPbSnyhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535836; c=relaxed/simple;
	bh=JwiH14TKp6qrOZUoyAYA5mrwT3ZYMBhepSoRS31Cqzc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ipQZIn7D7+OngiFmnq0M8DPmQw7514wwuxTGbkINDiHZiOcMFafmW4txHtRwtNWPXuVK4wsequwVX/ytUW5fMRdU6dRZZPIoZqHLYNLWZt/Uc2ekJ9VmXuCce7T3Nzn38VBFZ0KwrkBrf2MHXtkuYQqqDM4a499AxH06JckwzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwyVlMcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 032F7C43390;
	Wed, 21 Feb 2024 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708535836;
	bh=JwiH14TKp6qrOZUoyAYA5mrwT3ZYMBhepSoRS31Cqzc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dwyVlMcVl91aHTu6XXFW9i2Yit61Rnn39qm1dhCrbYa5te1+qNMOcLebPFwx0A3Ah
	 XjAshqEqYEMQiHakyXDiYzvDGbDW05U4aIsHI9NnDmjOf8jzGv0kacnCVaxEp+6FF7
	 wvUSVYMLlXxfJTFRDfc+3PRtPpUDEa09h2pCmh+1MX9/vh3I6K38yyTsqX3o90Cum4
	 JOxPhRNqpPaZC/v6+LeSgoeJaLQX/aRS6iAVzhMt7FhhKHhgmUkZJ40IIWdEYic37X
	 2rws1V7sPN+G95ixvVWcqxr/XR12GqS/LgSQvqFrKgTHy0R3O4hyLwPe/KrWYpR1wo
	 3Shy20xEL4Qfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2118D84BB9;
	Wed, 21 Feb 2024 17:17:15 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZdW+GCkO4s3MSeLX@gondor.apana.org.au>
References: <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
 <ZbstBewmaIfrFocE@gondor.apana.org.au>
 <ZcRYwZHASH4Cv5Bn@gondor.apana.org.au> <ZdW+GCkO4s3MSeLX@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZdW+GCkO4s3MSeLX@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p4
X-PR-Tracked-Commit-Id: c0ec2a712daf133d9996a8a1b7ee2d4996080363
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8be5a55b8e3f7eab8f36ceed2512f457f914318
Message-Id: <170853583590.5777.4297739383284707073.pr-tracker-bot@kernel.org>
Date: Wed, 21 Feb 2024 17:17:15 +0000
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 21 Feb 2024 17:10:48 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8be5a55b8e3f7eab8f36ceed2512f457f914318

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

