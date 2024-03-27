Return-Path: <linux-kernel+bounces-121666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A65988EC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD1A1F2D051
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C778A14D708;
	Wed, 27 Mar 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lONJlwgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199BA1DFFB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559160; cv=none; b=RjnB+RHhsJ1yw71ClKyuhndmrYqViXSVCg4ad+AhAs82OcgddfmPwCzF9rVp2TYsHggliBwOQwQ3F2QK54tyF2q4PAbh6dYKKX1gkkBThyfRZeT4lq2ya4VV/JBN7ihygftR4d0ofZAz6e/qvFhG19meYRR/zB+CL6XsZOwum+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559160; c=relaxed/simple;
	bh=PX5ekgW0v/5+O+69JDtdAK8HL7LjQauRz0V5e0AGJJk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gBUTfmabaknOrloTfOba7dCquLI8WnY7tURDiNqcHu9ytDqP3M6EEbJccFJUjBFKHSG5+V+R9ETaozWIgDnwihmgPr0d1eBfOdEMN687PcXWD/9vt2smbqneV4TBHgzOu4i3TLB6O3ngMYBOJsY8rBWx5S8nrScSoTnZxWAyekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lONJlwgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A18ACC433F1;
	Wed, 27 Mar 2024 17:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559159;
	bh=PX5ekgW0v/5+O+69JDtdAK8HL7LjQauRz0V5e0AGJJk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lONJlwgkX6u5wyMCaUpVh7FlwqypMzp7SEidEgGxJqgOw0UT45jmmWQ6J/ZVJ9BNi
	 g/JDq1nXVzs6/QYoStIURjfp719+bpMRRzwTW/GlYoai3p1+onehQSZZUWznob6RmM
	 iXSKM9xD4ArrbeG46hKlaw/11oZp6JvW/IuJoL9g3UMbharss6/mLtZj7LeQgVVdG2
	 HXCCL9J++ZzKcq9qTB5BzVFpkAdbLXVXMI8DcgMgXD6M5XzLq4RQ9l/i2WUnYGjHvA
	 HLR1FBLnVQc4VTeF3v0xZGsmvSgSx5TJZFDr8YcJZrcg/UvnQuAtvZk+nzUzk96vLC
	 mUVG94EFLqucw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 977DDD2D0EB;
	Wed, 27 Mar 2024 17:05:59 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240327232335.c817e6f17b84328f462d9e57@kernel.org>
References: <20240327232335.c817e6f17b84328f462d9e57@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240327232335.c817e6f17b84328f462d9e57@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.9-rc1
X-PR-Tracked-Commit-Id: 0add699ad068d26e5b1da9ff28b15461fc4005df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 962490525cffee6270422206c9d5bdb12d472c2b
Message-Id: <171155915961.9372.15247500400674100206.pr-tracker-bot@kernel.org>
Date: Wed, 27 Mar 2024 17:05:59 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Mar 2024 23:23:35 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/962490525cffee6270422206c9d5bdb12d472c2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

