Return-Path: <linux-kernel+bounces-41890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8570C83F938
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D13B21913
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72753C092;
	Sun, 28 Jan 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnymB792"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19632193
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706467642; cv=none; b=u/GGo+LTPFGD7vXUMt3oDVV0iHXOJhi6AII7O8f6FDEMN+8liljNoCFdNlo0qtxVGdv4SNkbtfr7ULrWorI19/H7S+biZQ7SbnfEIPPE7exQwdc5/KYCBgVBEXvdpS4Jqa4Fa5+n5WPY8gnlKHUee3EfaZ2Bps+LGB6tQu1osrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706467642; c=relaxed/simple;
	bh=HotOjLukXBJS5SjqYz51YGWyvGBKAvBROkqWrK3LfoQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Rezd1NCMfGMuDp13m4lVGnuvjil7fkQh+4s1CGG8gXY6aVx+cRxQOjFWrJM9hvwWpYW1To3kNvF2o9sHELg3f7+PGATnDriQzDK+jcyy/jgJMfvzqWFoabDZAflO4EiELCl5PNFTKoi8+gfWHBAsuExFHSV/eUsT4Xz7O2JKkKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnymB792; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96A1FC433C7;
	Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706467641;
	bh=HotOjLukXBJS5SjqYz51YGWyvGBKAvBROkqWrK3LfoQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jnymB792YwUP09us/U/aVKnrUmGraeC+PoaZiUx1V+QhPGVJoK+yoZchNk8YxR2e1
	 EHq5Fhg9yjfT4zgm47iwNbESOSTLmbgy9NiS6hHya7doWoCrp64fSZjTUu6K/OBnof
	 7m+/FvNP7vsWDn+F4W/8MKHgWL07KeUGZfL7xZIDHI/C5Nf8G/ySd/8Y+Ub2LPCYWf
	 8ubqedypBwArBHVC1MMJbrnD9Ll3ry/d4IRjswxYsY/OAC13ClTnA0raBzX/Ft/ENi
	 GLMJjhnR/7/JswwBwxLh/+ytL5abUOUO4+k58+gXxam9UY/6TJjxnBmCGYd4Wg1sSG
	 TTonXLszgTAzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D54CDFF767;
	Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240128101735.GAZbYpvzDZ-T5aIXm8@fat_crate.local>
References: <20240128101735.GAZbYpvzDZ-T5aIXm8@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240128101735.GAZbYpvzDZ-T5aIXm8@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.8_rc2
X-PR-Tracked-Commit-Id: 9a574ea9069be30b835a3da772c039993c43369b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90db544ebaf4325044402cdfecf1cf9247ca3ae6
Message-Id: <170646764150.17624.14921153125725673639.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jan 2024 18:47:21 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Jan 2024 11:17:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.8_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90db544ebaf4325044402cdfecf1cf9247ca3ae6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

