Return-Path: <linux-kernel+bounces-22752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F11A82A281
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA0428DD1C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8E953E3C;
	Wed, 10 Jan 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngjMnmh6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42952F83;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55250C43142;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704919126;
	bh=od8ATEcsWESiCSB7pkmppJARE/+9hRLv/g6UpS5J1BI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ngjMnmh6KIq+Y4E9lfDNs4V12CFmtM0n4RFqxnMxXMZNyZWobgMChWDqJ1uzBmVIr
	 tEgdLEw838EcIWzOg9aRS4CdwSdDIn+EhvLax8MuotmkKJTFAG3tzDMSCyyyoWq2GR
	 Lja5n2TQLBpis3SgdBbnyrLcNCgjeQZ5VUntfIwqrA9D7u4k3s2FMTD/dlSkwEOXIG
	 zcO2y6iJ8Q+aSgH2qk7m2JC2xogVvlbADxU2TDVhWQu27fSmcIxgzxSpSRXXjitxWc
	 H2RQ+lyY++F3nhEx+ybhwXN5fs4EciALyev8Ekxz4DNCHg5WNva5inSFo7OmdjZAyx
	 alPLSss0TiHJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 415BDDFC686;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
References: <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au> <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p1
X-PR-Tracked-Commit-Id: b8910630c967ffee582289451ddb5f9f19c26872
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cb552aa97843f24549ce808883494138471c16b
Message-Id: <170491912626.22036.12940633878070587625.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 20:38:46 +0000
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 06:17:32 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cb552aa97843f24549ce808883494138471c16b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

