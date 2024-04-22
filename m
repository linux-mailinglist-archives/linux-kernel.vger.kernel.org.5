Return-Path: <linux-kernel+bounces-153786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5DF8AD31C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305641F22054
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD40153BE2;
	Mon, 22 Apr 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpxuaeYP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D0153BCD;
	Mon, 22 Apr 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805739; cv=none; b=muGrlU62UkmwibRzMuK1YM/ipIK6oI+Qc4pIPwOnBRDd8vRSc2Ln4ffkkCrpCfH/wGj/cd52hvsEvv7TvWjyqT8cDVM8wbz0AzXEQ7pUeG0dIYMoOtLDumo4zF+hDxS90Nza5C3Um4FyqHad89ZLpv7523FvzNq/BP2lKYuJemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805739; c=relaxed/simple;
	bh=x9HobTdnWLZJFyX1tDHq4pvUAAi7hENLILUN2xNFpd4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=T8k3bcCVyMMctP5l4cjllhe4ETMiJbfsbZ5H3Bys3cCq5pYVB0QX7nuiLCvKlmc7DTUvLBf+eNV4DsSIJfDHxHfcfUxNyZMR0CklXW6pmVYcKMEyxyXFNBMRh1tjU6ZjduJE/i+ksxV9elCr2EdHswJJk7iuNOx4MmMGfBr2gcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpxuaeYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0BE6C32781;
	Mon, 22 Apr 2024 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713805738;
	bh=x9HobTdnWLZJFyX1tDHq4pvUAAi7hENLILUN2xNFpd4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jpxuaeYPtIg6R3pe78OZbZFi6GK6KD9j8R/Ua5+O7H6hRZQVCEfpv7oefSwMZ4I7q
	 6Q9S7kX9X24rO5Q1cKZmrQLiAd9VVNCjnW7fwm5KYKmtw/ab22iNgOAHT7gFThbw1H
	 Honn8t9iju9V3u7iYUSS0xqlUqdJy1WKAsAkbUeMuMO+6/IUUIUsMIan8Wki25JEPT
	 d7byA8jBibk1aIj2X9jfFr8QsfO2BTN2D6lB6J7W5XBFT4l0yFFHbtq1gzXZb3tmcg
	 qyeyetGUxgbjmPbdxaKKTlkSEgi/7OnT7onwyaikwvtFc5PcGMS2Za3C7GcToWtGJy
	 OmG7xPo2e06pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C62B3C433A2;
	Mon, 22 Apr 2024 17:08:58 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <87le5530xk.fsf@meer.lwn.net>
References: <87le5530xk.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87le5530xk.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.9-fixes2
X-PR-Tracked-Commit-Id: 8d939ae349343b55984ea821164e2be526d48cd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d2008430ce87061c9cefd4f83daf2d5bb323a96
Message-Id: <171380573880.25457.17886683186401293703.pr-tracker-bot@kernel.org>
Date: Mon, 22 Apr 2024 17:08:58 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Apr 2024 08:51:51 -0600:

> git://git.lwn.net/linux.git tags/docs-6.9-fixes2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d2008430ce87061c9cefd4f83daf2d5bb323a96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

