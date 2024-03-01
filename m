Return-Path: <linux-kernel+bounces-89069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E91C86EA30
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B23B2518D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649073D56A;
	Fri,  1 Mar 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiKvjeFN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C223C496
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324247; cv=none; b=tjKgyvxRyIjtTVodxXXVAr3RXBkNFCcZRIHMst16EKVfPAwSO0rYnfPYaltETq+a/1O5OvX6e+spE8L7ro6FfUgWo/ykQKnu6gcWbynDPWvPejSU0kKXBLYusRHbY0MyJV+7PiKxJCkakbuz4VDo3KVJExiqdegTH/i5vn2CF0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324247; c=relaxed/simple;
	bh=27nAsfKkN5QgVJi10ar8ahVY2TuiLh1yRVuX8/hFlC0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NveKmghZ6iVdnETIzuWtee369E1R1p9ow0HXzljIy/imYnJ/gkY1JZ1WpXgBFt9uQjq8FLGaQaZ2eUeGpK6SGhI+ieL+1f3tVBKcRs+fdVW6/MIZFCDM2ZzT3HKYM9L4SV3KBs/S+5mOzlkjMhefWubToRIybznAlaXeGl7t8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiKvjeFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25D9DC433F1;
	Fri,  1 Mar 2024 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709324247;
	bh=27nAsfKkN5QgVJi10ar8ahVY2TuiLh1yRVuX8/hFlC0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hiKvjeFNIOtSpivRbhl7HyNzItjjgT8LKqnOnv4/W8btpUIhoNLpox7Xv6shEnMj7
	 kMs41gn3VlrIikyWvUKe+LLZdcrXH5ksFrHzXRU1T57gbSiO4PDqesqV3vQ3dJJEtZ
	 q0S3ktSj9g6+1DYbUPjZkJ4FF/W23miV6zOqouxonhSWLzRJMLmrCwjX1RHYR6YOZy
	 pX6c62E107v2p+03ZEMC6UrC+WSQrcaMlneXG+1/tp7ayYBX5F0w93VB2YeUcKdumJ
	 bBaUD0mXyV8HPJbJem2rU6Nb+3fFXC4DHFI+SL9LkdfeNtBK901cDcvwd+V94mJiFc
	 YImvY6DiO4WBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14F89C595D1;
	Fri,  1 Mar 2024 20:17:27 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240301093627.14516d10f02a5ba9116e9702@kernel.org>
References: <20240301093627.14516d10f02a5ba9116e9702@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240301093627.14516d10f02a5ba9116e9702@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.8-rc5
X-PR-Tracked-Commit-Id: 6572786006fa96ad2c35bb31757f1f861298093b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 161671a6ebeecdab36ee4b8a6330d99b0f772412
Message-Id: <170932424708.25962.7151798524871533820.pr-tracker-bot@kernel.org>
Date: Fri, 01 Mar 2024 20:17:27 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Mar 2024 09:36:27 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/161671a6ebeecdab36ee4b8a6330d99b0f772412

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

