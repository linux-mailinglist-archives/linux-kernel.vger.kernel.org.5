Return-Path: <linux-kernel+bounces-99730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC6A878C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A088A1C211E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BBABE4E;
	Tue, 12 Mar 2024 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6PUwYuh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DE10E6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207013; cv=none; b=sgfUjrzXovX1fj7xNyP7szc3St9PRriZB09AnL0vus7jr4oWSI57mAuk4YdyHPPksaoqHDNDSGW4neQaexnRMUJsRYx+96lKN8TO/b0/24O4fYUKHNF2TJls5xE1tLY4M0KZcvQJY1WpZuFOL4aqHecdgdbzgBF+q+XA2nh/8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207013; c=relaxed/simple;
	bh=BZfQK2u05DYEUEQr2PWd5mTCSQ1kHWFQMyrpxxeIbL8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UNYBG01qZYMhJS9dgCtuZaVYM+ss71r15flDF/Y8vgaszwK2VCX0n4QdPzkCrJg4eZWjMUkIYqKGfe+Fuj79ZnALhDEPukG2CeWIWUkNT03tgG3aNjHtLmWiLotD8vDkMDBxY2QlV/9q/ktsKFJbKeOOLW5wcOJdT0RXxxVx8oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6PUwYuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67AD3C43601;
	Tue, 12 Mar 2024 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710207013;
	bh=BZfQK2u05DYEUEQr2PWd5mTCSQ1kHWFQMyrpxxeIbL8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T6PUwYuhSTrrgp8vQ9iNDoZUXEQpkhIrNaTx2Wg5lJdgskSut1h0aDvCShJwCiG6F
	 UDwBXloaKTMYuB1dsh5BZPaSefV8Gc8GcBmL8lX+bQn9fi+A3HBcUKxJDlO7Q8se5m
	 RKhvsfhm2QJx/pUHInO/xqTtf69I9yneOBsUe15gIxWQdYaRmWCIug8E153lrSa51f
	 9gAVz8zDJrQ+yz/pL8FCRNkkwkmgjQ6W+x9znXCQWFj9r651/6ouJz9oYGfQDf68mI
	 s+EMMCKmFWrWLqUQMP9KivBpLrIcnhk4J328bDiAF9nX4mOM/4aiHFzmJey6n3Nu/D
	 tDWnUtNbvGurw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 551C5D95055;
	Tue, 12 Mar 2024 01:30:13 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311165617.GAZe83sS8q6IWRhLhz@fat_crate.local>
References: <20240311165617.GAZe83sS8q6IWRhLhz@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311165617.GAZe83sS8q6IWRhLhz@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.9_rc1
X-PR-Tracked-Commit-Id: d54e56f31a34fa38fcb5e91df609f9633419a79a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f75619a721d5149d9a947f2177d3cffc473fbb7
Message-Id: <171020701334.888.95609539208677252.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 01:30:13 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 17:56:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.9_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f75619a721d5149d9a947f2177d3cffc473fbb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

