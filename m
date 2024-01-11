Return-Path: <linux-kernel+bounces-22974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7383E82A5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A81F245A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693F2106;
	Thu, 11 Jan 2024 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWzUs2fJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C60010FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83C27C43390;
	Thu, 11 Jan 2024 02:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704939846;
	bh=ejh3QJNf6tGgnQWiyJb1xyIKINpT2RhuSi5f2y/RmoM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bWzUs2fJ+A+IcY/sxgpD4IHEYDtv9ZWU8sBQffsTf86ITHh9IXSp6nJOrwkghte92
	 Oc6E5W7bjRYS3NeKchyKeztYJihhpCDHfZOlQTyxQwr3RjLv2nxNeIz3RTlrcfn4Pw
	 ax1/0H15m6ZpzQ3rU5ugaWb/HyVEzizXu6ZzY9cJGfmOwALLaWTGGiVw9wmfz1jf6F
	 zgat+D1ZfVjqtjQCuEtky/4pEmp1BUJokvhtRkntQFfZQuuofA50UklLQn/1FRWeXm
	 BjigepiwjU/4nvZq40CsXJlTX/PLhrfKe6B3CqVKcMN4ER6Js6lGjgnUD4l+Dvx4ik
	 vflxYZEOu1w1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7008CD8C96F;
	Thu, 11 Jan 2024 02:24:06 +0000 (UTC)
Subject: Re: [GIT PULL] header cleanups for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ualbkbj75ulsbwbjuphntw7ztb45r2q7iysvxvklmyv5ndnvh7@zxr56mv33vyv>
References: <ualbkbj75ulsbwbjuphntw7ztb45r2q7iysvxvklmyv5ndnvh7@zxr56mv33vyv>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ualbkbj75ulsbwbjuphntw7ztb45r2q7iysvxvklmyv5ndnvh7@zxr56mv33vyv>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/header_cleanup-2024-01-10
X-PR-Tracked-Commit-Id: 1e2f2d31997a9496f99e2b43255d6a48b06fbcc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78273df7f646f8daf2604ec714bea0897cd03aae
Message-Id: <170493984645.10151.5723951748883335656.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 02:24:06 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Boqun Feng <boqun.feng@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, Will Drewry <wad@chromium.org>, Suren Baghdasaryan <surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 16:19:17 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/header_cleanup-2024-01-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78273df7f646f8daf2604ec714bea0897cd03aae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

