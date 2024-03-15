Return-Path: <linux-kernel+bounces-104884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9F887D503
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0BE28347C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D215917BCC;
	Fri, 15 Mar 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr5xBmtG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA3917BA8;
	Fri, 15 Mar 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535050; cv=none; b=riHX9dKY6K0bCSyrob8xhTqK16swbvnnlNsSvEJp5pDkwXEQfNZua73Macnfwuu1S4Gl3QAS+JMBuakbVYv4i+1i5f52899Nl38bcsKIYH7muZIt0VzP3Zc5oJpIpfoHOH9IAtqzyadca90rtYVyzrwY4pFbQp/FEVL262x+2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535050; c=relaxed/simple;
	bh=8Q1mPRLX86FE6c0B8wAMHgs52bt5VdQ+A3BkKY7uRIo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QMn3i741iuK7Qr41cioval2fczuKddhTQOYqS56F/aAv6Bk7oYMUQVMrOeqJpZnLJqn32Ne/Bw/HZt4OJUPCGeEUcx+BLcwIr+MouqmuIN9s/GAPuVJ3RQRihh4FjesgKHAFj8ym2AlyKIzXNUw7J+93UOk80bN6YxtNMj7IjWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr5xBmtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE3F7C433F1;
	Fri, 15 Mar 2024 20:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535050;
	bh=8Q1mPRLX86FE6c0B8wAMHgs52bt5VdQ+A3BkKY7uRIo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cr5xBmtG6IVU8rmEywKXXz+8riokamBByMdnRHGZpq5F77CQxXeVoWh9vSdIutsYc
	 Us5oGMOS/+5mbvspUD1Mt4XFNMcIAUctUf54v7AfMYzprL4p3mPbjhv3ihw2B9f/ZW
	 prGhUvV4Iyjb3Wmea3lt/Q+5I1xrux0EItDscEwmx32+pkQF7H3o2665OX70JHLmCB
	 Q9kpUzzvS3Jx3zt83vUYmKCfi/W3DMJSg9K9EUm9HBKvXDBAhspFQXXiqkZXv9lchz
	 A+GUSvLOK0Ty9WAAnrISV2A7MIKRSp14nqy+dyx4jvUUAoNeXNaNMy5qo2whOkXmKA
	 l0tl9urNVU8Yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E35DFD95060;
	Fri, 15 Mar 2024 20:37:29 +0000 (UTC)
Subject: Re: [GIT PULL] sparc updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <784e533e-bd89-44fa-a966-b8104309565e@gaisler.com>
References: <784e533e-bd89-44fa-a966-b8104309565e@gaisler.com>
X-PR-Tracked-List-Id: <sparclinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <784e533e-bd89-44fa-a966-b8104309565e@gaisler.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.9-tag1
X-PR-Tracked-Commit-Id: 84b76d05828a1909e20d0f66553b876b801f98c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a2fbffcbfcb60378626e5d4144a6ff43f3b6776
Message-Id: <171053504991.29375.8340980384472017990.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 20:37:29 +0000
To: Andreas Larsson <andreas@gaisler.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Mar 2024 12:44:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.9-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a2fbffcbfcb60378626e5d4144a6ff43f3b6776

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

