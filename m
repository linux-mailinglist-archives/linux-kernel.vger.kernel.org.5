Return-Path: <linux-kernel+bounces-144331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993478A44B7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0951C2107B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D73136E38;
	Sun, 14 Apr 2024 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksLg1zTi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B01369BD
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120483; cv=none; b=X8Q/mmZPl1iX4yNUf90AXpvIPT0W6pIzIT9UT9DfqL5yf9Yyn7QAr6QKPRNNRFFbub+g/SkcsDU97nFnpFRD7l//sbn+//oX09AVxwouUkhdx0IVURa4NUsAEZ1dee3x6yM6g+eioehPB2gjcBZYql70I6oTdyPPLUERgqfSblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120483; c=relaxed/simple;
	bh=GzNRMipCjBlRuQL7Z029VSp1r7Kp39LRdWlhSEtaS7I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=R/EvARKLcrgxtqZqYL2+SQKE+HEjGxwTV+ZJFdbyD1X6S1NbpNBnPWaBwEb30H8eSDRp3JTGfeScTP5fOid12CzdehQUR6A87tGCIWXmsWoglZv9WkaStbJsYCy4ig682t/40ZuSn71jzPKLXNVBqy4wV+yJMQK4Si5Zkt83j4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksLg1zTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DD15C4AF0B;
	Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120483;
	bh=GzNRMipCjBlRuQL7Z029VSp1r7Kp39LRdWlhSEtaS7I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ksLg1zTixKJoh6oWJewGLayR2Z4jJVPOXq20UP1lHzFB0kbi+Ofo5AcMuU6Hl2fCq
	 5OdicnQPBR0dZzkBqf4AmEpV0E0FVInFIA3ieQjs32eOkxxPqz5r8hAyqcJ0mJi1wG
	 fqRbNKpHGjPXOUkV/+eTRUBBeNRBfvrMVoDS/rzl6u17EriMqhPxHzhC/i4D5iIOiy
	 xEQ05upaxe446QgP5ZuxRVPIKMjZOGXB3DeuS1gSvm96t5XSOWOw6PN+J6k5zbWZJy
	 S6gARVLkA3KxPck7O2kzeAR/MNpyWeZwKOodQCWUAZzIIcZSBrWvpCSQODJWJV0tQw
	 z+FHztZRBiX/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E868C43140;
	Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhuTDmtgtUEuJaae@gmail.com>
References: <ZhuTDmtgtUEuJaae@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZhuTDmtgtUEuJaae@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-04-14
X-PR-Tracked-Commit-Id: dec8ced871e17eea46f097542dd074d022be4bd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1505c47e78a4d4837e2c72b2d5f51e821689349
Message-Id: <171312048357.2589.16214416884748396534.pr-tracker-bot@kernel.org>
Date: Sun, 14 Apr 2024 18:48:03 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Apr 2024 10:25:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-04-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1505c47e78a4d4837e2c72b2d5f51e821689349

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

