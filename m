Return-Path: <linux-kernel+bounces-120015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674588D025
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118B232354F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DE413D889;
	Tue, 26 Mar 2024 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUEtjmOV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDEB7353B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488967; cv=none; b=n4RXXNu2qa2S3KzFqs0lCH1kmqVQ/ZGKNlvtR4l6uR4kJi+NCkfLeTyKY8mbWE655uf9rb7QTKn7u6wLNTb8iLvq1M1XUb31ulHD9F+1+Rzbs2ZWp/0w2/tRqVQkxoj6rg7ZWGuPdYiiI8ZFB8aR/X4eXWZvhflSi9PCzB+ucnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488967; c=relaxed/simple;
	bh=wUi5WLiYeDP/idZVEsH8AO76Sz41Wi+jnQBsY4CesPA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LwO2td9UtPV+953+unDmQ/aUYgakITw1EHM1wR5RjmXiTTEBvqoTAfnWf4L9NQxHp+7EmSYjK0brQFT4Rmv0A5Fd08PeJIcTL4qZHiiRhuT/59/SZJ3wto1OO/5Pyv2qqZq4K3aGm4pr2qiGgTELCNZ4NIO0r63kulHn2btOlm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUEtjmOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17AF4C433C7;
	Tue, 26 Mar 2024 21:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711488967;
	bh=wUi5WLiYeDP/idZVEsH8AO76Sz41Wi+jnQBsY4CesPA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KUEtjmOV+HMckpj+GK06GJuVa540e7GvUMDV3VQxCdqWRQ0Qb7/5qchlPjzy8nEcp
	 GAimZCYox2WerI4RVGUaH3UfDfIPrVlW0zCClyz+A1VLjxMZnugSgO7Gt6bTxJdzTA
	 a+xUAlWnrgstXjqMTDSz2W70dUIooXHTe9/R2UKlvMyFaSTJU2gtObQMhCNF/Hyt10
	 te58G7pa+Mf20WIFk2Ar1Og626L71gvH65BFDmsMAIf1Qf2AKxcYYEbf/IpULfbkRk
	 ei92H6kl488t92qOaGVC7hJLdLlMXqR2YCzd766lJQFU/NGv7SbWcb7vabobhg82z3
	 Rbl1b534QsN+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B741D2D0EC;
	Tue, 26 Mar 2024 21:36:07 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZgLq7uQzrzY1_C6M@alley>
References: <ZgLq7uQzrzY1_C6M@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZgLq7uQzrzY1_C6M@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.9-rc2
X-PR-Tracked-Commit-Id: 8076972468584d4a21dab9aa50e388b3ea9ad8c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7033999ecd7b8cf9ea59265035a0150961e023ee
Message-Id: <171148896703.26753.14083507997428722355.pr-tracker-bot@kernel.org>
Date: Tue, 26 Mar 2024 21:36:07 +0000
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 26 Mar 2024 16:34:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7033999ecd7b8cf9ea59265035a0150961e023ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

