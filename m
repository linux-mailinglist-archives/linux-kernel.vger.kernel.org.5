Return-Path: <linux-kernel+bounces-150665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD348AA293
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB901C21148
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1DC17BB04;
	Thu, 18 Apr 2024 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKocv0xq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5FB17A93E;
	Thu, 18 Apr 2024 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713467674; cv=none; b=Wg2ddcxVhi+fJi0AwZtJM9D/w7+LPxdgebtrDjJx9NBipEpc39kIMuL9WtGz8F/0S5rDZg8pnpaeWnt7nZzLbSwo3yFTJLzDnR9lQ2CK82Yp6TAZdrssSJ3e5aen64aKP1V9DGvivNDDdRDbRI6Gcv7V/J6YjJBN+RMwzYkPwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713467674; c=relaxed/simple;
	bh=dGj0gJEA4iIpKJQAgppgHAuhoSOrW9+n427qFUKA9a8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Pn1EgQeokBUEXDP6OTYe/u7NlnqngyfGBFeME0I7/IL67X18qMZOxUYdtsViT3biOPfe6XZjR3LoqX0OBZgXPwST7dQi5MaYY2xWwp3vsbJSkKlr5C8atsR5ADa9bBTGBXEjsURe3UnXRBjuhNjhllo4fQ0Xz58FTGZUnopaTFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKocv0xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58A2FC113CC;
	Thu, 18 Apr 2024 19:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713467674;
	bh=dGj0gJEA4iIpKJQAgppgHAuhoSOrW9+n427qFUKA9a8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UKocv0xqH4cbNJa5Nrfehax2TiQRJWLIBCy5kAHQZwOfCAJtQHXM2/rWiVMo3Fxat
	 mfNRSScm2cWfEtpQb8Oaxo8+6grprJl2zcfyujYFujvHPcwPyKnj3pEqkOYqv/d3II
	 rYmatgz2KepYjrOCOW9+Zljb8RyX4Di5KawSIcWf/eLbE85E7fWmYz8DxTKlUIq6NB
	 BY6ifjSPCzA44ArZgNv8hmKtF+xs0SZ5R+4MmJdmnYDw3CcQJtX0b7eqzBTigQ6Gqb
	 mrQDsKexMGJr4h1W66F7z7NcWMEBEujPzC9mm1CelWgWacbvgSxZ+cqh0KUvUBBYNY
	 pfK9NbwbAuX9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48D55C4361A;
	Thu, 18 Apr 2024 19:14:34 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240418183142.3569793-1-kuba@kernel.org>
References: <20240418183142.3569793-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240418183142.3569793-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc5
X-PR-Tracked-Commit-Id: c24cd679b075b0e953ea167b0aa2b2d59e4eba7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7586c8501d090609c6eb1af6ba05e3ed68806c83
Message-Id: <171346767428.7721.10757428252894501018.pr-tracker-bot@kernel.org>
Date: Thu, 18 Apr 2024 19:14:34 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Apr 2024 11:31:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7586c8501d090609c6eb1af6ba05e3ed68806c83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

