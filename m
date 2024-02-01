Return-Path: <linux-kernel+bounces-48690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F4845FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C55299C8F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B0E127B55;
	Thu,  1 Feb 2024 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir5s0Dul"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD528526C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811793; cv=none; b=izaxQrbyQmiyf2E7z2LPYeuuXI66DQNXdRu/hHR3DV7xYfPJXHrlfHQe+bi6FV94XaKvXedzkFZmP0Zds+gp4j27z5iiE5s0EkNy4s4oHOge4liZWR43A/5HChqM3pojl81EE6UnvrKxK5845ZpO9Y5aAFPryssuzi2c1M55Nf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811793; c=relaxed/simple;
	bh=GPrSkG3Ls7sfIwv7gAnYyydNItQK+MVBD36mHIW9SZY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fFUtfNF8ZblfGs3HwyZ0G8Ko2E3Dd2i0iB1MjlqAkFFXcAp4PAhIyEax1+R5WhyPPn2ZBF4q5K+S/dV1SUGWy0yXJ+J6ASJg1pu/6+67CbYTiBXTe9D7IbUySgp7kxWaK4up2saEy18o94/KGGfiJywREgDB1xk0Loo51vLpPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir5s0Dul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E98BFC43330;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706811793;
	bh=GPrSkG3Ls7sfIwv7gAnYyydNItQK+MVBD36mHIW9SZY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ir5s0Duli0tZ73l7PVxQFpeFMztpmd8C4VJk8f3xIZJONfdLGyf1v3AADHVmAWr0D
	 xwrdAlR8Y3cR03sijB1vUdeqkYT43WgyvKoZmIRKPl76IJkdw5pf2avWI70AK5tvT2
	 EutAbGi0sx4VWvbZL4h0KM+ZLZwTJr+zyYGFWcyT1Xl9ngRj+kjl2h9SwK/P9xAhBC
	 NjYcVxMnsyw75fokZE/ZkNuHl6EHZ6KuYJ2ADaxPmlKpAPf43tYNi+1R43c547fK90
	 m3PWrgFS8PfEj7+SPZhMqnSDMWKM/pnwX1yhbKR4Ppo3biAO/yuI1SA5x1IRj8FEW1
	 SkpzV+e0vR8sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D467FE3237E;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <pcax5asgwo6x4mwrnxnwixfknqhovx7unjxe4txtpzab65dwcf@jm7552y2whzj>
References: <pcax5asgwo6x4mwrnxnwixfknqhovx7unjxe4txtpzab65dwcf@jm7552y2whzj>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pcax5asgwo6x4mwrnxnwixfknqhovx7unjxe4txtpzab65dwcf@jm7552y2whzj>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024020101
X-PR-Tracked-Commit-Id: 764ad6b02777d77dca3659ca490f0898aa593670
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c24e4e9e70822cf49955fc8174bc5efaa93d17f
Message-Id: <170681179286.954.2316197083056864713.pr-tracker-bot@kernel.org>
Date: Thu, 01 Feb 2024 18:23:12 +0000
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 1 Feb 2024 17:14:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024020101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c24e4e9e70822cf49955fc8174bc5efaa93d17f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

