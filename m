Return-Path: <linux-kernel+bounces-43852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2C484198C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA42288134
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E07D374CC;
	Tue, 30 Jan 2024 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpBu9UtS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4236AE9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582969; cv=none; b=qAQztLAvD+9v3tfj1sv1AsL9NU/lbSG8SiIOFLqw1XVxW8m1vbM+nYyPum1B6X51yDK/dhYqBb9gtvK9V6AfLyQZ53fY4mBoRfDVs2RQpu3DDevsnTVDA5+xzGYasf9TG1hK5Utzimwmb+QFKi6tBihmAlHyMIZMOdvgOpIZkSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582969; c=relaxed/simple;
	bh=Q2GrjSGvPfppUxH8vBKAbHVg37hPss0vHYy7b6wpRUM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gr2W+DfXeuMVNsPIIDqXV8X/UUMV9erDLdP+LWckyewMJn274SssrEHPNvjlDN1k0EKwFIqDLeQkz0AePzQ+tsJCrDW+PsOJMCT77HWBSsUWFQtBJAaNve2hqrsx1TdIjVkrt56JQSPNxx3aCteJKQETGuQusGcM/2OUi5dQkfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpBu9UtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8421CC433C7;
	Tue, 30 Jan 2024 02:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706582969;
	bh=Q2GrjSGvPfppUxH8vBKAbHVg37hPss0vHYy7b6wpRUM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VpBu9UtS5SXymzPHd/8lRF118iYXZonP2FW/qxEIFziB9wxmJLaHzz0BQZdmBUP+y
	 RjKyrFHH0FFW8RaNn6fxC8yvEVEfELEbZ9bUYknyJ9NWiiBJ5BkBsrZ9hCdtpyh311
	 wXx1JWlKGBggrIcqxpIjebl+gF5Hb/+kCpFcsrE1vpqUhkFTFMfhPspthSm00Dkda8
	 pFxAGk/LGkAs7G9Fsmv8qm9mPQH+BYK3BI4Y/BqrjwgpW8m3FC+sDdso1WflP1iYQV
	 PUIgIy5B8+4Yrlkbsv0+lcxGwXJTbGRJ0sR1uYzXc0SgzsbZ+dF1DWFBzZ0+Y3PzfU
	 4T4nWIZL7S4PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FD0CC43153;
	Tue, 30 Jan 2024 02:49:29 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: A couple of fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240128223151.2dad6599@rorschach.local.home>
References: <20240128223151.2dad6599@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240128223151.2dad6599@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8-rc1-2
X-PR-Tracked-Commit-Id: 29142dc92c37d3259a33aef15b03e6ee25b0d188
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b7bd05bebfcd3d369272d41ef32a379708ec933
Message-Id: <170658296944.4250.12829009277775047810.pr-tracker-bot@kernel.org>
Date: Tue, 30 Jan 2024 02:49:29 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Jan 2024 22:31:51 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b7bd05bebfcd3d369272d41ef32a379708ec933

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

