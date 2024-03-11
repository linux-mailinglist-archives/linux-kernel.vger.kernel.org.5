Return-Path: <linux-kernel+bounces-99651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AA4878B70
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0290282411
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0938D58AC6;
	Mon, 11 Mar 2024 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PODTE+qe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF7A58AAC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199101; cv=none; b=px1tEgGdE2LvDeYdVoALmrUC7DR9nHpr1sZK3ETTkExlJKWKcYrUBSM/T9c4Nwd/NEskWgixdsAszhOUHLTaL9xf2pO9EvBEreUC7kA3rGMPL1yTBQ+/YEP4WefisP9LpJfeWGdKzA6Zu+ctbVhWPlcd1s7d31sFKH6UsT4J5b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199101; c=relaxed/simple;
	bh=u931zt/1RV/9tf8UgfjJcpDoxpvWgFRkBlyKurcM5Q0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QSf7gAklpOU/7GjGxxiIxVY7SCtxkAUnU51Be5Y2Ck77lMmznZLMKTdMR4GwxzSgYfwQ4R9fiIHX8cfZ+3fPZejb1pEDB8+bT2oArxuJJhRmqMxLeD8Pkr6QZIYw6aDog7O4WyHdMfduJGAKvj6DnHkZkIJfGPKMIotYri640R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PODTE+qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E37DC43390;
	Mon, 11 Mar 2024 23:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710199101;
	bh=u931zt/1RV/9tf8UgfjJcpDoxpvWgFRkBlyKurcM5Q0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PODTE+qeqsozozt4FuqDSzLmar1cHTkd+BqVraLZTLIIow3B5rwlLeF/QxMY4fu2F
	 5dQMVKsptCysTFCWgEetNe2R8pdZ+j3vNY15k+ObPet9osmJIWOD+3tDoSOiPnKmco
	 4hxN1Y9OQudHWaMa9eRhpF9gM/8I+Y7IfRzQ/4cYfGsVHZjWC1pAaVhdAk05qbvKzC
	 +udUibDqmystSFgnQxRGpu2pisIUCteFLrjP5tsWw2kmlYQQddkFGeohBfhsDOeYYY
	 J1/u5r+ZE049sb50wEYgIaidT4iTPTU/B0EGFujonS7sY9STyb2mZ8g3bkVxyIj+nE
	 evlcyJoMRUmLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B442D95056;
	Mon, 11 Mar 2024 23:18:21 +0000 (UTC)
Subject: Re: [GIT pull] x86/apic for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <171011362048.2468526.2240218025431476865.tglx@xen13>
References: <171011361246.2468526.10740060923051583953.tglx@xen13> <171011362048.2468526.2240218025431476865.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <171011362048.2468526.2240218025431476865.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2024-03-10
X-PR-Tracked-Commit-Id: f0551af021308a2a1163dc63d1f1bba3594208bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca7e917769121195bae45d4886f6e24efd6f99ae
Message-Id: <171019910104.25831.14096816328179355325.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 23:18:21 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 00:38:59 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2024-03-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca7e917769121195bae45d4886f6e24efd6f99ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

