Return-Path: <linux-kernel+bounces-117692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD9C88AE7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DB12A1B14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2183818E1A;
	Mon, 25 Mar 2024 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trbfjCVh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D35E1BC26;
	Mon, 25 Mar 2024 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390705; cv=none; b=P/5zbKt8IrvBPnU5zJgekHqGShnVZv/KJTKr7Drb3R736EgmsViHOQ3w4eSsn06GknFAjZiGibhU+K0VB0jz8UZWbDZ6n/gsQtbGZ0zgD/W5yUB2JbreceXYQlVRKg4PI/vg3SR6jtVmIXo9wnJcv5oWxT3yt71OFhO229T5FXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390705; c=relaxed/simple;
	bh=Cy8SG3kgC5qh5bF6hshu0seExL8BhIOy/OqpHXkKNzU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jbqWHkcIDUDTiK2XlnmeLQCsU7E2Yu6tOTixqNz1jwlYp/5N+Q01x84+5N+gVOYnVGEwaWBg4zHrpyfI/+A4c0WlDqLnZO1DOSwO1B1GY2FDtGaQqaAnPz2FbNwbcoNeKrWY5OKK87tHHJDBiCC2zuVZ+IzXthREp9hsJEZziLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trbfjCVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9B20C433F1;
	Mon, 25 Mar 2024 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711390704;
	bh=Cy8SG3kgC5qh5bF6hshu0seExL8BhIOy/OqpHXkKNzU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=trbfjCVht9Nb+tVsjtZ2jtu2o8jYjqGsakyEhF5HjRD4Gw2WXtUlshRLVqMXC6bay
	 JsG/7lajxLURdu/Na/4dMQQFLqkdmYsV5ipytbdxHGCsj6+5EcEy8ffOzOf8k3RzB1
	 sAeBUMgzLePMEBFlIYfkKUrwoC5OJ+o1hqsprKnZCrcPEI8ZvuABgWdc9xuqNVDRvg
	 lo+vrF1MCFN2gwTARPEgsmw7jpe8cp4CirduOr+xydqrX1T1ZGLWVGPU4oKeRMqtmr
	 HJu5SQEOK6TcT/CNgJiZwVQgz8cSP/uZ3I4YP6fYLAF7Q87LPInrdNxZYipuUX/8VG
	 sMDNrsp+K/GYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0947D2D0E0;
	Mon, 25 Mar 2024 18:18:24 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZgFIP3x1w294DIxQ@gondor.apana.org.au>
References: <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
 <ZbstBewmaIfrFocE@gondor.apana.org.au> <ZgFIP3x1w294DIxQ@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZgFIP3x1w294DIxQ@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.9-p2
X-PR-Tracked-Commit-Id: 5a7e89d3315d1be86aff8a8bf849023cda6547f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 174fdc93a241af54772ae3e745ec719e9f6cebfc
Message-Id: <171139070490.16418.14798772464511355023.pr-tracker-bot@kernel.org>
Date: Mon, 25 Mar 2024 18:18:24 +0000
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 25 Mar 2024 17:47:43 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.9-p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/174fdc93a241af54772ae3e745ec719e9f6cebfc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

