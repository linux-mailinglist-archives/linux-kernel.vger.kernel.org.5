Return-Path: <linux-kernel+bounces-98301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6E887781A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E17B20C00
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEB739FD7;
	Sun, 10 Mar 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOr3RHT0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83214200DD
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710097212; cv=none; b=MywvwdO1XLTDyJoyCX3PcFf0yU1LIL+4kIM+RUpTpdyeD6e+abHkHy3eauJ5eaJvSAccEHiTjNvFrsog/pYgp91fkgGafGAhIfPkzG/SH52soiyGyP1qsN7zJ/zswqfT9E+SNzSluActGsNXyN+SYcr3iVZ8GiUBoaTU9KbxyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710097212; c=relaxed/simple;
	bh=mws3O+zwbV20WACkLl4oNyMPTlhsM6xeJNNlt6LZxQc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FDMAVnNKJf/XFptgdwnHAQ3u11m/Pa8LVn8JXzfQGbOUO2mkBGZ/BkPi3QUHNEb/jxjW0dnBB81SQqclYBszvlK1MSTsak1XeHtGxFQY4EKjrTuCZ5KAYc3TeMiRR97RD6ExwIEqK8GmNiXYVsliC/TpI0x+qlb1d7z/2IgoAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOr3RHT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 523E4C433F1;
	Sun, 10 Mar 2024 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710097212;
	bh=mws3O+zwbV20WACkLl4oNyMPTlhsM6xeJNNlt6LZxQc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eOr3RHT0lBNd72+CDg4YAE4AHTsVde8+hCnQ0gQze4Oos/N3k9xGuTnoHZ4+qcq2I
	 AWQgCqjSWXye2GT7vd+rtsvzxVVpcBLo8Cbyuwun7gG08TVFlci+gSbKZAJoxIL+Wl
	 oQsbGgANAYZkbhfZkt60nnCDJukiUwrl135ipy9hff0Ksh+MuiEhbnbED7eNWGvA+h
	 KXcPtOGfLHr5+WhoVArrpoB1AcTDEMl21cmmtAPbyC+zTNuROdcOgfl0jJeP/6Vv2C
	 RxwBZZcX0PCsA42vGj4gd+CGuJ3Pzy3dFd9eh+epbtiK/zGv5xX5uhwUrrCWUzQvcG
	 ktsAaPEes37AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BB03C04D3F;
	Sun, 10 Mar 2024 19:00:12 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240310125217.3f829bd5@rorschach.local.home>
References: <20240310125217.3f829bd5@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240310125217.3f829bd5@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ring-buffer-v6.8-rc7
X-PR-Tracked-Commit-Id: e5d7c1916562f0e856eb3d6f569629fcd535fed2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa4b851b4ad632dc673627f38a8a552547568a2c
Message-Id: <171009721216.15660.1022172657437488101.pr-tracker-bot@kernel.org>
Date: Sun, 10 Mar 2024 19:00:12 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 10 Mar 2024 12:52:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ring-buffer-v6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa4b851b4ad632dc673627f38a8a552547568a2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

