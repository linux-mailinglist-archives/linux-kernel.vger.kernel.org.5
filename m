Return-Path: <linux-kernel+bounces-151806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6848AB41B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E481F22F70
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DA6139CE8;
	Fri, 19 Apr 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4uZjPkt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A136F137927;
	Fri, 19 Apr 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546278; cv=none; b=SPmf6tMnbyJ7FmkxQVA9rdkaGakq32oZ825vFvA17yGRROdAlIzyigjns1BnHtS4H2RkS0J5v2tpQIXL0rxwrvfrwuEKhJ/qKYYe1/VgZoYwR2HyWXaGQAcgd14mrsRxLbYJJSNJYtHslbjH2Qu8X8yZfPaJrOl4dyDTQM1Hk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546278; c=relaxed/simple;
	bh=6OnBdmpBRIqKkqktj07pXUkV280WtoyoCPy63Ck9G3o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MayC52LK32Y+Iil/xByp4z+Q7S/7fz8gW8RbQem/SRGmxzOLOtbOyh/fVWILZxZ4QwnQjcjUtv3DNEoEdG0Dj1y2gpKPP3n2Sa6lk6AqcEX3B/N9NaDQyyzKpo3B6ZFALN89iFGKnPwnCSmoSu/Tfxaap7rpKqiHJDuTt06hJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4uZjPkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45411C3277B;
	Fri, 19 Apr 2024 17:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713546278;
	bh=6OnBdmpBRIqKkqktj07pXUkV280WtoyoCPy63Ck9G3o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W4uZjPktg8nXWEAayLJ6UVDyi3EobvfXMJA30S2jKJcOis+UzjmZZMr1E1cQnQXhq
	 w31hM7r1Mo0xmoM+5nVri/+JjVOlp9kY1VjY0beWWWRluyvVymu3HXXJ0825x4Ah7p
	 rv2rkuICZpNhEfKfzO8CbWhaH1WGaXfjYyqQ8JBEkgPF30fXhzQXuw4T0rJeczK3Os
	 W1PkZeXMnhbWyou//sZqCBQXIDunXjmOTnr27HTTfcGfjpqQAL+0zjHb2oe8Re6WMM
	 drb746vF7EOSOcZkK1uOCB27vFgZosFnXD4muJoH+TXqxjQN+Hhxln8+OuAJktJ6cE
	 kfGqHEZ0SQ/Bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A53DC433E9;
	Fri, 19 Apr 2024 17:04:38 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZiI7D+RjyM57l+PE@tuxmaker.boeblingen.de.ibm.com>
References: <ZiI7D+RjyM57l+PE@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZiI7D+RjyM57l+PE@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-4
X-PR-Tracked-Commit-Id: d111855ab7ffffc552f6a475259dc392f2319b6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cdb455946193bb7ad13df15333c7fe0054db6c3
Message-Id: <171354627823.5257.14582037398290239529.pr-tracker-bot@kernel.org>
Date: Fri, 19 Apr 2024 17:04:38 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Apr 2024 11:36:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cdb455946193bb7ad13df15333c7fe0054db6c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

