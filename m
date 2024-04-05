Return-Path: <linux-kernel+bounces-133576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4232089A5E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27C92835EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF13F174ED4;
	Fri,  5 Apr 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUjykv6d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36799175552;
	Fri,  5 Apr 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351168; cv=none; b=s0CwCIYqWHO7sEgQC8ltMKGZLe2XAfpFZXGqngASImvJhUijbV+a9wxJp0VAY+uz54sFPHFgC7guIso8n8ntuZAFZXBT0Oq4E1Vi8qZG/WXhOe6dDDRVyLAPe6H/hehy0oezrcxG9BPQ77OhDUWZvwXAaqU+E63I+avffeBel14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351168; c=relaxed/simple;
	bh=Bcg9ucp6pmGwt1FAS48yt2WDc4knlbiqafFKjdXDd4U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RcE4IprtKReIM0lAA1a7lP9XMnBs/Y1RZAnwgUwGJfoXrvLLo957XDKETjkhyAXY4XVWoEx6KBinf0LM86tKvHJeQibvsThzMuWs/VAm2y+7RnMs1JKkMmIAvE9NY2IvTtoux0gh1fkd+MiLWgDKwzje1w+lRs5vxmphkF2+FWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUjykv6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17DCEC43390;
	Fri,  5 Apr 2024 21:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712351168;
	bh=Bcg9ucp6pmGwt1FAS48yt2WDc4knlbiqafFKjdXDd4U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PUjykv6d3s+NLox3SfeiVTr+3qJrH5lRU9yOXdEhBJ2zj+WqgsfQE7OQTfzJuw1fo
	 lZKpjzGN7DeE04K60tipW9nR2j+CPyo0zlKzlWJGVuyKZo7nnuY+Qy1jcZW0fvNUpB
	 E6zPu+ByGnWi9ySMQ3TZa35CEWqr1YlHPd9ikA6X6+LB33mN7Tp7CCpi3IWXqhlNCH
	 UcRNe4ktZFCbuxW3MgagBgthYDpZcABNHKVi0SDW9O9K8+Xf6MLKz+VZcbX+iiv3PZ
	 Qw67kSZi7B2ly7WXMXq7GNKZaj7iaJeIwtiXEFoyID8Xx7Tsr52BAHaXFK+mzfaMaY
	 34sR/kSWvnlPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CEE6D8A101;
	Fri,  5 Apr 2024 21:06:08 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zg/lXGhJwPcyDqk2@tuxmaker.boeblingen.de.ibm.com>
References: <Zg/lXGhJwPcyDqk2@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zg/lXGhJwPcyDqk2@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-3
X-PR-Tracked-Commit-Id: 378ca2d2ad410a1cd5690d06b46c5e2297f4c8c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50094473ec8176116f5108a6a56be2c804e05001
Message-Id: <171235116804.3156.857698947386605218.pr-tracker-bot@kernel.org>
Date: Fri, 05 Apr 2024 21:06:08 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Apr 2024 13:49:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50094473ec8176116f5108a6a56be2c804e05001

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

