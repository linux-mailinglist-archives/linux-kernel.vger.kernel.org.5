Return-Path: <linux-kernel+bounces-105523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F151387DFAC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7CB1F212B4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768F210E7;
	Sun, 17 Mar 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkmfXM5j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8471F93E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704059; cv=none; b=NIq19HAGZXzfpunymA6qauQi73TxurHdKtk4hcJGlIWYRaH1Cu+YaCR8HbHrH4ZbhSkslBKcT/KpmNL44r4fNRQndOQw9EUZJDBjlr6W48y+iGDOyz0gW2X63VvYh9SIAit4gkbnEFwzPsvx/K0xgnBlicyQZrNHAWS4BycVuxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704059; c=relaxed/simple;
	bh=FdaLFI/6AXtTwB3fsGcFMJfi5ouwy95YPsGawZou7fU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bngffFY02PLoQbbqjcD045PIJgyNhhKdyjeYmYosZrjqwqj9OZEI7fnIdZwLtcxB05G93ErQQHffvV52r6DF6AbAkaMh0D8ziMjOLUZeXKqIpX9wEidn4oe3kDPAA12PuKwIUWK7+E2xaycyq1+8U2rSevuwy9Eh+eYdpKainlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkmfXM5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5606CC433F1;
	Sun, 17 Mar 2024 19:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710704059;
	bh=FdaLFI/6AXtTwB3fsGcFMJfi5ouwy95YPsGawZou7fU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gkmfXM5j4ex+1R60XrIEgZXhhIIXVn8b+yYrj+mD6iLNqXrBkZwnGy0pmTfhiijnC
	 vhZ95sSZpu9HLnkDnr8HZAEvpMqyGOGNwSwBTlF4OdpVyW/QS7UOkk0lNXQoQUHdkM
	 M+f57W6KgpoeVHjWS57mBwTzp7Ae1KE1ecIKsUQZFB2fXUkkcsr6oV/rjxb4JbadDY
	 UIBWJFQhQ4hPXLnivm+VVuTPYulKOkZDKO/OsBCwclLlikQTlowJE1oBCuJoX4RR1O
	 ZN3URV7QlHZ6o7f7T92koZ+VgDLOBNA6kLiuoGqj9C9cOA9gI/jRVWw2a9EH2MR45d
	 wAJZm1KpLGcDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E607D95060;
	Sun, 17 Mar 2024 19:34:19 +0000 (UTC)
Subject: Re: [GIT PULL] timers fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfayMWuE2MgFHAGT@gmail.com>
References: <ZfayMWuE2MgFHAGT@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfayMWuE2MgFHAGT@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-03-17
X-PR-Tracked-Commit-Id: 4b6f4c5a67c07417bf29d896c76f513a4be07516
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8048ba24e1e678c595ceec76fed7c0c14f9cab1e
Message-Id: <171070405931.21222.3725533314503293522.pr-tracker-bot@kernel.org>
Date: Sun, 17 Mar 2024 19:34:19 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Frederic Weisbecker <frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Mar 2024 10:04:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-03-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8048ba24e1e678c595ceec76fed7c0c14f9cab1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

