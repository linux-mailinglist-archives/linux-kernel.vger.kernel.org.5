Return-Path: <linux-kernel+bounces-103654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A9F87C27C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896671F2288F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB6875819;
	Thu, 14 Mar 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/0zjVCh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937475807
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440433; cv=none; b=kMQaiJqqjWJ84kvRXJteIWGPDB3qAZoMmv/vI6t/QWwQ8mLGdLiTKh/r07pYO4pmwIXw8zcgJr5m2Cbbpnk1YYWZZR48RegAM0JWt+TTTFvwa8w0K/l0qrTwE4lHGsdbUsHYHxU7YW2GDxg93fS/loOt5RAhSpX6n8VVbECeh7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440433; c=relaxed/simple;
	bh=m82UAD4/E0SjwzkGeBeEkT6IA9OA9w3WygILYIJ8a68=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MnY4Q8+nY3pue1SdShS2XzAc/n2I4vYsK5UV05pNVuy6+LhBdK7QkFJfg8lHnikYQQ1Lcn99YeGBF4m+s8jzoAPnuckwFSiKAXXjA31v5R2dYdcqbnB+WpCID0O7PZwghtWqiBATO4km1spw4jhjhR50EFrqBnf/Bb+49+6xSQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/0zjVCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C197C43390;
	Thu, 14 Mar 2024 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440433;
	bh=m82UAD4/E0SjwzkGeBeEkT6IA9OA9w3WygILYIJ8a68=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R/0zjVChnhU0F0I9Jl51TSWIDZSYzYA96NE3+y/JykbMdivjS/fR8bBt/13DGiv9g
	 RP5hAZr1w+dBdzlD9+aQTp62FOfeD5vVdSxZ0pGSkoxRaA888qdBSd/pZwblgUx0Rd
	 mKmxqt7IjNdsKANRr0KlYdYMRXA1+0jMGT5LPENtNSrEFtP1zbcooIdV/aJ8NiclE2
	 HqA85vt/VYx9S6zEW527NwjyQ8enjg/TiUzAag575mPdd86CBxwkogt0S194Biqy+X
	 1DXRaeEGb499GfLSwbn2P2/oOvd6n0JEGeTDRzVJShnuK6levvHYg5bbl4DVRvk8ME
	 YZIITWi1c9eyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 247BBD84BAA;
	Thu, 14 Mar 2024 18:20:33 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.9 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2403132132240.20263@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2403132132240.20263@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2403132132240.20263@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024031301
X-PR-Tracked-Commit-Id: 0db18cd824f781584a880653e65a0cfd38f060ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e78a6c0d3e02e4cf881dc84c5127e9990f939d6
Message-Id: <171044043314.24196.2315264988931951283.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 18:20:33 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 21:37:37 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024031301

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e78a6c0d3e02e4cf881dc84c5127e9990f939d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

