Return-Path: <linux-kernel+bounces-121995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C19688F079
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF429B24F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0771F1534E9;
	Wed, 27 Mar 2024 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1NBk2jF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33C1514F2;
	Wed, 27 Mar 2024 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572477; cv=none; b=LqlWe2EcWjF3h67xDboeGZ/HNyuMBmbkOFw5aInF41+KUFH+RdsA6okBSuw/UwQ0aPjAF5F7yB5X8pgMQBXOQOWEiORqj8D3Bp/jZPM5kCV4hVkcwBxSu+fvND8YXZe+w1QJAzlYqHXZDHmlldIJtv77y7ZbPtWzwRVHgG9H/Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572477; c=relaxed/simple;
	bh=EFAY5bh56sC+G2H0XIh4qxfh4ihghfNr9/ld3J4jM+0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G5QngOU5qa4PBHmeLOxktiHVQlnrgBr+mveu0CqBOjcYkTxcGM/bnJws2lI0s8ltAftKUEhk/E51yKHIPRJ8j/0sNH5HFoJcOiR09BRoV0W3NuCRHYTyzO6UUFXa8w9LTdqA1AGlC8uB2q0OD3vWY2tNHGY4xO1dGHdvnf8neK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1NBk2jF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F930C433C7;
	Wed, 27 Mar 2024 20:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711572477;
	bh=EFAY5bh56sC+G2H0XIh4qxfh4ihghfNr9/ld3J4jM+0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A1NBk2jFcu/iNnOWKMfZFksZmH7C+5eQAsAkLsS6tG7unS/jdMgdMlx1XANavWolD
	 6rAJV4R0ptR01Vdj7AbgGW91b4KzWcmi2kznQGRzkNRUGBvp/kXzRhvSv5TxigJov8
	 0SzsrBpY0UMymGuCSh8JJGww19b7h4qvG23qifIM18Kgen0uI5fDHDULbMfPq6FQZL
	 +yjhObCLP7JysSBiPFZsaUf7fO9itSpgqNZ+KxfTRkRjGKLPx20KUFeg+0EwzynrVZ
	 HqlWzLIyC2TTXjp859AewoRxjDZtC/XH5iJRpPrFUJpYXsx4Vw8ySQFblSC0TJgs2a
	 cRUHenZO1VyXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28EF2D2D0EB;
	Wed, 27 Mar 2024 20:47:57 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240327113214.f0200bec5624169a86371797@linux-foundation.org>
References: <20240327113214.f0200bec5624169a86371797@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240327113214.f0200bec5624169a86371797@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-03-27-11-25
X-PR-Tracked-Commit-Id: 32fbe5246582af4f611ccccee33fd6e559087252
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc189b8e6adbe113a6d4b3a7c5d0c9cd7febb3bb
Message-Id: <171157247715.7425.11482061633850243095.pr-tracker-bot@kernel.org>
Date: Wed, 27 Mar 2024 20:47:57 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Mar 2024 11:32:14 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-03-27-11-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc189b8e6adbe113a6d4b3a7c5d0c9cd7febb3bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

