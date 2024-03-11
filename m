Return-Path: <linux-kernel+bounces-99480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B95187890D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56149281B82
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C1C54FB1;
	Mon, 11 Mar 2024 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDXH/5lF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E14206B;
	Mon, 11 Mar 2024 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186186; cv=none; b=BfNSMseAHftJH9/CRnz7jixk31J27cIxm18EEFDzZ8QQcY6LU1RSOEvXi1rzQnyIZO15LzhPlihUjwMCOe5vQ3gs98appCO0ihjoTLZX6tWOxFAf8Sbfmz4VHzNMLXA1oXVVEnoChnWwIXsqh+AG6oId/JR/uXUTQgi3X9qhDXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186186; c=relaxed/simple;
	bh=SuUSpI0dwge9nF3GM7YhSPavNs9THfhjBvqrBiwj2Qc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bHw0rzb+uodjfGey9LKPj7s2mXPDEG+rJZ4JmLrivmj4rcGJqTRCT+kq4XMlQSwAOsllL7KgK35QM7MHcpUExIRJH8mdLA5XlpWvGbUpKhAS08F9EuimRiCfFRKr8pfcN3MehUm/Yol7nNJZtvfVcoPQkwVOBDzBZebmoR6DCd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDXH/5lF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0FD1C433F1;
	Mon, 11 Mar 2024 19:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710186186;
	bh=SuUSpI0dwge9nF3GM7YhSPavNs9THfhjBvqrBiwj2Qc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cDXH/5lFV/nZzypvpoupi+vxZ0R75zFgzaeKA5FqkaPNX2eggTqZ1/+uzb42/Mgf2
	 tkNusEvgQ+8g2jZvgrESXEMi3t0SJDxKi1QkbpWYWTvtWmsMgEUDprZF2pS2rGBABc
	 Zv3VLZg5DW/cAQNE7N7ofblEjznYPSAM6rh9xY5EbNTEWJeO0QlTjpYlysfO21fovD
	 sHpK5+HO5CScwQWWufjQGYNgOlp1hYT0CWwgmll+F05KDS8P9584XCxtb1CSLDVvLx
	 Ur57PhDgl+URBg2bNa7U7jFl6Rn4D++4SBQPASr0VrGWXtNUKMg5qfrM/BMfxTfzdj
	 +jWO6HGJ1m7Kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DCFED95057;
	Mon, 11 Mar 2024 19:43:06 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZetHwrCb0KXE0xFI@tardis>
References: <ZetHwrCb0KXE0xFI@tardis>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZetHwrCb0KXE0xFI@tardis>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git tags/rcu.next.v6.9
X-PR-Tracked-Commit-Id: 3add00be5fe5810d7aa5ec3af8b6a245ef33144b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5a3878c947ceef7b6ab68fdc093f3848059842c
Message-Id: <171018618657.28701.7287849092739336264.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 19:43:06 +0000
To: Boqun Feng <boqun.feng@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org, mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org, neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com, frederic@kernel.org, bigeasy@linutronix.de, anna-maria@linutronix.de, chenzhongjin@huawei.com, yangjihong1@huawei.com, rostedt@goodmis.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Mar 2024 09:15:46 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git tags/rcu.next.v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5a3878c947ceef7b6ab68fdc093f3848059842c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

