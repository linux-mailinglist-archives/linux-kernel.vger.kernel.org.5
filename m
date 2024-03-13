Return-Path: <linux-kernel+bounces-102560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C453587B3DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019091C232BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C1B5D731;
	Wed, 13 Mar 2024 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soBvawwc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994A5EE81;
	Wed, 13 Mar 2024 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366458; cv=none; b=CREMkEOoY1At83dtlO0vqW+UoClxH5tBMop+fxoBkWD53HZ/xdn9dvbLpiAMRkg4KlAUyLIzaTvVYC3g/Jhr7GncqfDNcx9M1aYu86Iw8XFiR00H45tHFzA+73T6EUv4eAM682H4sdNMQZXMj7CASnCdZyxJgAz1D0+rarlg5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366458; c=relaxed/simple;
	bh=Njc7awr102MgdB0bB7M4uEQRCDQNI4yCe0vgClfOfMM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Z2mkZOiMpe3yWuqpRE/HhMh6R53GnO1o3tk03ngiUSlQTYwY8cH2UnVMa1sM2fqh3M8LufgW8MEdH9lPbxctfZUIxZeuyk2PBUdg2Ko6y3W4hL3GNM3wmm7BgtRxvzWe5kNSicJoJJDLugUyYoWSBigUJZq+OJ1NZPi84wPYuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soBvawwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51D8BC43399;
	Wed, 13 Mar 2024 21:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710366458;
	bh=Njc7awr102MgdB0bB7M4uEQRCDQNI4yCe0vgClfOfMM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=soBvawwceIclwDWqJi/SdxekvCzMovDUCiNsLxeC3+hD8aYR6tOs/5CcARJbNTt1u
	 Q6b+Nw8TRcq7vRl7e6k1DhzCnAzr+wQwxO2x3wa58ZZlh/R+NDQXmkkIkTgxSaDX1d
	 60wN39JmVvuoPmPZDnXlhrmLGK0iLE0YuMmWg/W/1ITwgcPZaUfui+Q5B1uIMhc70+
	 F6UV8mduUB8zO9Pl3IzXNaaARHv2uFr89YMOxpr1/1oYEVHwTUcOG4LWP03/3qb80j
	 NuOLagz+F3Mi6lygrwTNinL6Ti+HuI9srvXzMYi+xnUHcJ3/CCZEyUTrigptrvg1XP
	 RKCZ4mG/NOYtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E2D1D95054;
	Wed, 13 Mar 2024 21:47:38 +0000 (UTC)
Subject: Re: [GIT PULL] smb client fixes part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msG_j1vDKpvn=R5Gw9=uhi+JwHQcped4rm84bcmqKZEKw@mail.gmail.com>
References: <CAH2r5msG_j1vDKpvn=R5Gw9=uhi+JwHQcped4rm84bcmqKZEKw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msG_j1vDKpvn=R5Gw9=uhi+JwHQcped4rm84bcmqKZEKw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc-smb3-client-fixes-part1
X-PR-Tracked-Commit-Id: 3681fe1b0fee42da3d763fdb0aae62ea032aab86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 279d44ceb8a495d287ec563964f2ed04b0d53b0e
Message-Id: <171036645818.31875.15391705169023416498.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 21:47:38 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 17:20:30 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc-smb3-client-fixes-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/279d44ceb8a495d287ec563964f2ed04b0d53b0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

