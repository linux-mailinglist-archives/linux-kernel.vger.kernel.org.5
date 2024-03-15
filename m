Return-Path: <linux-kernel+bounces-104951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD74B87D66C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FA6283B33
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D6B54F89;
	Fri, 15 Mar 2024 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDt+BH49"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971D811CBD;
	Fri, 15 Mar 2024 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710539940; cv=none; b=LP5He3O7sgNSwqtTbykGulbvcWr63GNrYc9lQEpnMiJlupnjXVWfEw9JODIPWfpmwfV5wRaR90AT8cOB9HUlI8nYYjFgua4hyUp585r7jff1cfPtQM28bmnNAdTgMxEzAdseIrtwjBRfud9zcz7ni+UlLNtejbIAeAlUR7E+5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710539940; c=relaxed/simple;
	bh=8aZ+pmjWSb/0DZIDsIVsfKlFSg58+SNcPCdeb4HH3Jk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kA+f5u97UTuGzDf3Bol/mUk/GgvtCqBI5aD5AAbaqS3toOjrRaySEx+viVPFK5UV1fII8BxZTETvehmgdBnGwEZSNnbMQUNA9TPRadmv1AvuocRqodJXox48krlvhm2PH+n7fZ1Le+ikWc/0rvZV3f29PMtcV30av5B7L822GSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDt+BH49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77A3EC433C7;
	Fri, 15 Mar 2024 21:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710539940;
	bh=8aZ+pmjWSb/0DZIDsIVsfKlFSg58+SNcPCdeb4HH3Jk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kDt+BH490Z9I3RGlltHqZrhIZ2+YaLfsu7Y6rKwnpyn3bvf4noQNRryf4A5Q38H0l
	 9D49gzuib6AsaIFFJ30pDAebDBalz3hqDiHRd71o6pcjGe0H672J46u7GkDEuUjKFV
	 Nnc/W1cApZr/um0FA+ASxilZGyvkD/G57QlXFCRBc0vWzA1Sx9xlA8wWImmZZS56Cq
	 +4RXN88p8USi11lnsSpu8Iwm3V7rU9rlBScmr4hGrHasyxuvI0/PcZfBva54XK2Yxa
	 RD+KTtZs7w/AXSGuRTtsYgUbwRNEo8xbNP0yBnk+7+qkBzxn09nlSwv+Lwdh78Vhp7
	 578oM71LSSAeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F514D95060;
	Fri, 15 Mar 2024 21:59:00 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfO6zKtvp2jSO4vF@gondor.apana.org.au>
References: <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au> <ZfO6zKtvp2jSO4vF@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfO6zKtvp2jSO4vF@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.9-p1
X-PR-Tracked-Commit-Id: 6a8dbd71a70620c42d4fa82509204ba18231f28d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8e769961668ef56acabc67f040c58ed769c57e4
Message-Id: <171053994044.16900.13425460754107329710.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 21:59:00 +0000
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Mar 2024 11:04:44 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.9-p1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8e769961668ef56acabc67f040c58ed769c57e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

