Return-Path: <linux-kernel+bounces-43853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414C084198D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21A228802D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82125374D9;
	Tue, 30 Jan 2024 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApV4p7XT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BA36AF5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582969; cv=none; b=AV7dwiqMtiT3MXetnKJ2LH7vlBmiKax37fLiO8rf7fQ+xyFK1N1Okj48/DbxpSJVz9D+MhrDdsqmIdKIM3KHZ8xry9LriEK6kYaPAUvQ6bdOh2eGXgAosiB2nFOqprhwoIUw669jxDRUhGRsTSRtaEjiJYwfIH7Ons2G5pZpe2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582969; c=relaxed/simple;
	bh=+7fvEbT/eFafLqeM73nGlA5cI06z0JXVPei/AHdU+1o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mchu7cO1hMbbRKVs7mRdk9wZFm0mpQilZsMNbukRSmIGPHsT1wgsY7GiVi3vEuryBlZazyIfS9Qe92N5bmB9iPwCLOUC4cHY1CQ1wyO5Eel4hGeCprzA4B7NgS95QAQBMpHhWNDhPHTkaMxxMOX5BLznLnFbuwZ3hpI4WN3sI5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApV4p7XT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1E62C43390;
	Tue, 30 Jan 2024 02:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706582969;
	bh=+7fvEbT/eFafLqeM73nGlA5cI06z0JXVPei/AHdU+1o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ApV4p7XT6N6LCeOllJKYcayQiLhbv8fb0RpwRpxZz36hGwppAGHu20HGTkXFmgoYQ
	 Z87It4190BN+y62PPBsLmSSQ7XTHps4oMTtP8b5PMAhjZYPHXI5dNJBUtLaPcDEnBi
	 zHg4Ys+WasxWh7vQqv5GiypBe7+8htAOavoqjIIBeEDj4VFYuvA43cyTUy681Gct1V
	 c+Qx9xqpYQokDKb0g5SzsW/5jTzf0j9DKPJE5JO0G3Y23T8tJYXf7jKY+2SEbKxdLX
	 C05a2Fxq3r37+xXRImW5OZ9Qir6k/c5wX6E9+VfqbKuk4rZP8ZqkA0BD2SHziI7w2d
	 eKhVpuEqlfREA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C5F1C561EE;
	Tue, 30 Jan 2024 02:49:29 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <09ec99b3-f2f8-489c-9f96-48f727326ee3@oracle.com>
References: <09ec99b3-f2f8-489c-9f96-48f727326ee3@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <09ec99b3-f2f8-489c-9f96-48f727326ee3@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.8-rc3
X-PR-Tracked-Commit-Id: e42e29cc442395d62f1a8963ec2dfb700ba6a5d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 861c0981648f5b64c86fd028ee622096eb7af05a
Message-Id: <170658296957.4250.12706220941141808559.pr-tracker-bot@kernel.org>
Date: Tue, 30 Jan 2024 02:49:29 +0000
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>, Matthew Wilcox <willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Jan 2024 15:23:03 -0600:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/861c0981648f5b64c86fd028ee622096eb7af05a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

