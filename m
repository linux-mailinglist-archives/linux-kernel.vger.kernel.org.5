Return-Path: <linux-kernel+bounces-30615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0735832213
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871E328858C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F28D2E3F8;
	Thu, 18 Jan 2024 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLBnBAQ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ACE28E36
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618911; cv=none; b=P+LbBngspXT7/UUaHfKR858nhFpZHIztEMbeNfrBVTY2c54mFI0XSwfSpBbdSZoFJEXX0uryHNSNABATN78BoO+rBsOByfKcjX5I1UU027pPOy/ffQ2ypqUdduMrCpHwENq4vEKtDKWhG4YnJxXnYLYv2s4vBAR5hE2+pFdwBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618911; c=relaxed/simple;
	bh=zH1SirWlTrS9Y3xgFfXhvuMA1kF6bRVSvQKUnmTC1/s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rbepWSc0bSZ5SVwJ8QdXI9a7e/dqd5Wbzj9v5T74U4wMCr2Cm6qgMWYBMGqrQhjG6HbZAQ3a7TWcS1O25t/EvkA/ykjEjeiiZH+kM+4Z5uYeWb1/x5z9ePxETBzc724q0a8wBcwGZ2ydMR9AnDTOGVYYnGT2qz/uM4T3TnIdMiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLBnBAQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6B27C43390;
	Thu, 18 Jan 2024 23:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705618910;
	bh=zH1SirWlTrS9Y3xgFfXhvuMA1kF6bRVSvQKUnmTC1/s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LLBnBAQ7yuul887W64+1DKG76FOiHggbb1VcWAWHHbnwnV1Xs6Mp0kWMYrqoXSy1i
	 ey1qL3E08IxGgPiWnuzSHm0Rut0v1iq/zS2+rHasZyF52GY2jxz/A2PGEpdUPXfGcT
	 /Bm9X4Pajp7rIqUlGGZopgMWmNinJCza6FjlrgNzcxFMQmdIdvjzBOJ+yu8hZVleZ5
	 yiTaU4h/ChG6JGGouVd0HEuyXeJMe7b5ktdG3XEN8Ybs9ky3QGGz8J0TIdYgmCjbAc
	 cKBFue0Hq/US5a7/xdB58qbQrrOPwj2zk1aMdp+y8b+y/y2T4mOgMQFCk7fY6UWPXU
	 jDmbqWzzSq8RQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2FD1DFC697;
	Thu, 18 Jan 2024 23:01:50 +0000 (UTC)
Subject: Re: [GIT PULL] probes update for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240110002328.7adb07c24ff0b28c271e6099@kernel.org>
References: <20240110002328.7adb07c24ff0b28c271e6099@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240110002328.7adb07c24ff0b28c271e6099@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.8
X-PR-Tracked-Commit-Id: 9c556b7c3f520d42c435c0d78b25c719c060f8a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b890ad456b16a5b45e7f86d9708d7248e73d0f8
Message-Id: <170561891066.14039.6885093888227373408.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 23:01:50 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Naveen N Rao <naveen@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 00:23:28 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b890ad456b16a5b45e7f86d9708d7248e73d0f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

