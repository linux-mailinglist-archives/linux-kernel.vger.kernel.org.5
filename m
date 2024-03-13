Return-Path: <linux-kernel+bounces-101093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4E787A233
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541C71F216A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDD812E7D;
	Wed, 13 Mar 2024 04:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZaCPw8j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87F12E5C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710303121; cv=none; b=Fc/JlDN/qt6gELat9JB7rAi4OjZyPnJ3soalh5ny5DHKhCakCTWJ0r3CfzfKxyuaR1LSQPxs1Tp7q9V9zqkD/y+9FVa0V2UhVF0i7eO3bsPtuIB4WVKmzRGC0dwE5bKeleMPU/VonLYJzd7T+j6bFBgbv6FAg642w5HiDDmT3Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710303121; c=relaxed/simple;
	bh=vphBGAbNRYAS0ya7ch1JSh2Dwx8gexHZRYe7d0Z5HxU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L+fV/xVke5A/OOc86Ng2IxND8Ut0vRAgYawI98btlTcol1oU3dHwakXkah4HeJtOlBzLtPnfQDUkHQZkjUcohn7wF8RA7KZbzHC/e5qH6EBuoRbYks0agbaC37G2F4iyOF1KwzOzPXbb9FJUEm7AEWxJHzBfztUhwVd88Vv9FvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZaCPw8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FC38C433F1;
	Wed, 13 Mar 2024 04:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710303121;
	bh=vphBGAbNRYAS0ya7ch1JSh2Dwx8gexHZRYe7d0Z5HxU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UZaCPw8j5s1Qgxv74Hvs5QfLT5Q0TLRSk1Ry1a+/xcC8cJgVZsWn9JLT/mypgFd+r
	 V9XAPAJEKn4PYLaqHyJ307Ef37WsPRX+MqCdP6aAl8B4WAlIUdqd9DQecnlr/IWGOf
	 CdX0+v/+M2uE9nJIC5ZhFweLYEj9TSoCEea10a9tNOrp2zQcJk9vu4NKyEvHCKoRS3
	 XUIuJpmdZBvCUqdFVWDz/wSm9/xll4MUDEZzFp9nawx6BM+De5NHUzMb0Aivjz2hUq
	 ME3P3CY5QPRyvMYNbUyrCWY3THqb3NM2rUurMGYTn/1mgFgQ2v8+78coYp6d3C7NuF
	 uKA5XMh04wNUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DE07D95054;
	Wed, 13 Mar 2024 04:12:01 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfBswbsqObB4H73_@alley>
References: <ZfBswbsqObB4H73_@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfBswbsqObB4H73_@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.9
X-PR-Tracked-Commit-Id: 7412dc6d55eed6b76180e40ac3601412ebde29bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0546776ad3f332e215cebc0b063ba4351971cca
Message-Id: <171030312111.24236.15262035091384915588.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 04:12:01 +0000
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 15:54:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0546776ad3f332e215cebc0b063ba4351971cca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

