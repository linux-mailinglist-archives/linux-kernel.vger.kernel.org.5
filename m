Return-Path: <linux-kernel+bounces-99727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456A3878C46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA207B21402
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A12A94B;
	Tue, 12 Mar 2024 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrEY8yvI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69BB79E1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207012; cv=none; b=dK4lxLw0+wmHN8RBNVpf8Eu9qLsnrmwMbu2w1xXp6QXu0V9a9WsY4Ieeo9Kt6yKajB5WvV2PizsBEKUQt8EZ94jjsdCmV08WmbbSVm5vHK+I6dvmmtv7Qw+2qAQzkQsb26/ENYJ6pMz4gD7XV6kPFwaEjtXuj8E4tf1qwbPJe+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207012; c=relaxed/simple;
	bh=dxCN+LL2UsS8m/RF+ROa7Klny90lXhezi+hwE5r5rpw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZkJSZWphrlHpf138GZIDM473gnGL0+pa2hi+qC2WHGfd3wlMsF5D6EEAQE+rRuQzTGgp06ToFE3Q+X5WAU8pCMfx6wW0XaQsM1EDGDgMvn55oowLG/kjYqYx9PDjP30PfDiy3dXK6+/1lYSw1W/sV5ugv9NrMqrFuaMS/z949gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrEY8yvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81EA2C43399;
	Tue, 12 Mar 2024 01:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710207012;
	bh=dxCN+LL2UsS8m/RF+ROa7Klny90lXhezi+hwE5r5rpw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nrEY8yvIQotz/vXEtmd+Dk2asXQ06hoc+pziXMQxik+woAdeq7K1x9UXRAUxKsrRy
	 oBbUMwHgkg299CealnlRtVxOpRK5lnFW3buh2kIKhRCxzW9jopPKvKcDTubJVRknsT
	 MWicE9sAYWOPInFAwLGWDLtkahNlU8TfS8pyC/oXIZo7nLhZan6oYpEy7eA/feWbDu
	 g1K9XZUbHekMjJyXZIH4ORJ2ZS8ipX1q4qJBVPNbADWBsSoP1xIW3VuQu3iH7WEU8U
	 XLTJRCwNAstw4bbuPqNM4ttTww9mbtShzyk7HUNEUayeyuWmP8FXy2P+kVaRXV11J0
	 3HEfctqTR6P5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DE3FD95056;
	Tue, 12 Mar 2024 01:30:12 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mtrr for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311085946.GAZe7IAmgi_z4j5rMW@fat_crate.local>
References: <20240311085946.GAZe7IAmgi_z4j5rMW@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311085946.GAZe7IAmgi_z4j5rMW@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mtrr_for_v6.9_rc1
X-PR-Tracked-Commit-Id: ffc92cf3db62443c626469ef160f9276f296f6c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfdb395a7cde12d83a623949ed029b0ab38d765b
Message-Id: <171020701244.888.932274798916398988.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 01:30:12 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 09:59:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mtrr_for_v6.9_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfdb395a7cde12d83a623949ed029b0ab38d765b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

