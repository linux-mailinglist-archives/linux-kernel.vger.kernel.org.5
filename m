Return-Path: <linux-kernel+bounces-39220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D483CD04
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24418B24BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F2A137C59;
	Thu, 25 Jan 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGCcI0Bm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9C137C3E;
	Thu, 25 Jan 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212811; cv=none; b=JapEOJ8Iy+MOZZ4LpNE6DvSnc0Dai8HGDipgBSsr45zwefmTV2Bri7Zq6bZOP6NvqsG6coZHaNwrA4uKwdEtIjTMlrxjhcXrHF6XEiIF47vy6WZma65HDw4qnCY3ah66SDjhEj1C79Yy1obwACjhRoz/H1/8dAkMOZSfTwqNEYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212811; c=relaxed/simple;
	bh=Kxm8V6t/PeTOIvlqgsWF/2GfC4i1upW1boNCKEIh7tk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mKqfT8BsIMRXpe3cRGJtaggOCLJr7qwvgvUf4KoD/WAMhTK5a3A6JdkdohRVZj75DV/ft89kqcyFLozN1luVR+sfPArVS96uf/O8sC+asiIs5GVloMLbWitLQ81do2rIwrFqmDo7cu9kKRzvF7VTpGkqQbq+FIQSInz5TmPK9TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGCcI0Bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C89E9C433C7;
	Thu, 25 Jan 2024 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706212810;
	bh=Kxm8V6t/PeTOIvlqgsWF/2GfC4i1upW1boNCKEIh7tk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RGCcI0Bmr4iY1EWjXrr4rddB6A5S2PV4lo7rW8Ee6XC8Qdd3EV9/N2HhMUOGClwSX
	 9sc2Y9Ck/hEJLRhqgvBTPp8/SYGlo+dIkN5oKIJLmwfotBGiALF++5ThlPK7dx4PdB
	 uJUfnTQr+nFzO7PFqDODFFkzwQVQ7CZiEjvAkX3pL29YUCFqdIgodvxfENwOFWvnpe
	 hwX/tDIEtZo5gGhYQyiYvAWowdqECySf14Fxybe9PHtACG+ikYGSgslWCkw8azxKuK
	 onQSB1vBOCE+rG/1q2jIH1wCLBncsImTVO0LF/Mx25+ZK78iKaqqM/UTtz/woWN2nS
	 i0Qxwgyo7zgbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8040DFF766;
	Thu, 25 Jan 2024 20:00:10 +0000 (UTC)
Subject: Re: [GIT PULL] RCU regression fix for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240124224319.GA36728@neeraj.linux>
References: <20240124224319.GA36728@neeraj.linux>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240124224319.GA36728@neeraj.linux>
X-PR-Tracked-Remote: https://github.com/neeraju/linux.git tags/urgent-rcu.2024.01.24a
X-PR-Tracked-Commit-Id: e787644caf7628ad3269c1fbd321c3255cf51710
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cb9871f8160a4789189701eda5af582f3414e55
Message-Id: <170621281074.19358.17573023952352026516.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jan 2024 20:00:10 +0000
To: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org, mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org, neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jan 2024 04:13:19 +0530:

> https://github.com/neeraju/linux.git tags/urgent-rcu.2024.01.24a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cb9871f8160a4789189701eda5af582f3414e55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

