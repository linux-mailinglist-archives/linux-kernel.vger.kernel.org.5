Return-Path: <linux-kernel+bounces-69987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795A885915C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED1E9B21DF2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6EC7E585;
	Sat, 17 Feb 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgwa8Vf9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C2E7E0E9;
	Sat, 17 Feb 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708191610; cv=none; b=snWLVTLIK4EbIvydQEC1AOehGVIlqr2lPUHa6MqvnHj3J9EmASbue5dG/ygOWBEkFR4LjSzFeoqMdMSJVWhE+d0kR6VNIIyf2UeBu2sjfWEJN/ZaCiK0xuR/YmtpY1noYSH6nDf5+jwMcF9pgGyIrPAV0xHVMJce3JIIa2xVz3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708191610; c=relaxed/simple;
	bh=yoLdkazXlbGrb4N+FDikp7PQWXhIyfggyDKa9NmV3I4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G2eVLMWHnlBbUMHTPpl4I8K5q4Iswlw6YOGfp1t4Lou81TdHguPVgdjBHhndYJQqbtHPb6e5WRj0JPHw24TLUif4vus40P1zzSJEQmMTQxmrw6BoWSfX/BvldhsprgJ2ymoVGSBhg5epCDfkzgH1RmqttCMjYnunXt9+aagaSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgwa8Vf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4D69C433C7;
	Sat, 17 Feb 2024 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708191609;
	bh=yoLdkazXlbGrb4N+FDikp7PQWXhIyfggyDKa9NmV3I4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kgwa8Vf9KxIU/yGDG3r4FvvFV0zAoA7CuSIuRhJxoxc7TIE7niILJ47QkOIDNOfmO
	 uSgoSlQCxGOIgtyr9CO/K1gCz6TVTtNk5vTP8G/r/Y8lSJvux73m0mYDBzN5YaTYkK
	 ziyNUGX7h/zi9y5S/C7/BdfSBmvdhWN6QXTM+1XyGhPvK4Py7FvMBroYJnRHl5LAzN
	 vm9gLVmgmt9HLle4xVOp7IewBjJkvdCDj1CAWhg5aW2bB+uOsfXDlltcRbatS2M0fp
	 r3Q8XdX6Pq/rfn3M/u0QnYisfZpEyPnNf0ciV2Dn7CgmvN5FLnvZZkCvi57qMmZOdV
	 kBUbnnt5L1BxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8109D8C968;
	Sat, 17 Feb 2024 17:40:09 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZdDNNg5Gsxf2uQKh@kroah.com>
References: <ZdDNNg5Gsxf2uQKh@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZdDNNg5Gsxf2uQKh@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc5
X-PR-Tracked-Commit-Id: 7be50f2e8f20fc2299069b28dea59a28e3abe20a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b2981b2270d7b9be6c15f80d5c4b838ad93ceef
Message-Id: <170819160968.11002.15824753923318986505.pr-tracker-bot@kernel.org>
Date: Sat, 17 Feb 2024 17:40:09 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 17 Feb 2024 16:13:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b2981b2270d7b9be6c15f80d5c4b838ad93ceef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

