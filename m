Return-Path: <linux-kernel+bounces-70487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCA7859885
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACFA2816EB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E8C71B49;
	Sun, 18 Feb 2024 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQL/DZ+S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB071B2D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708280529; cv=none; b=bfQGPA+ZfHpktbrfLtPaEMNwkfraj+gYXek2nItdCZ9E5dq6A3GxomxtuqnH2BaYOl4FFG8/Kh221esSh21pfJZPQaxOC90OhgOuzjB2VULRb1QXmLz0TX09F8yyUkp/TQxSoNJeaN4HaMDbFfEb6lTSYaLf2lEkQhydi7u/s1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708280529; c=relaxed/simple;
	bh=18GVbyY4f/WCG61biYyaJ73cZvtDIUscFsOIEEORVoc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Kw12Hyl3Gc3vExHn5Qy00yLnxhk/QlP5L1VY10L4LFtY8/QEvW5ro8uQLfMiAetZ7IO5SKLUghWU5a3u62PVIV2JtuVgt9oYhUz8fzsZWsbXa+YRiMmW1rGNxgGsdatTrbeRWS+6wrupt4XfEQRbi4ByRqtWHGgCAxbhSSNy9/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQL/DZ+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5796C43394;
	Sun, 18 Feb 2024 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708280528;
	bh=18GVbyY4f/WCG61biYyaJ73cZvtDIUscFsOIEEORVoc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tQL/DZ+SwHxbJ/ZMnCxZ6g/VQWFBl0OVZPp2fjP+RvxNeacyBlQE+LvCqferdt5jX
	 HzWQ7ygjOgVT5Sknd9eqaDz8NBjhwa9z/vlZgFk8af3lcZjEGuSMG4BoXLjXX7Puq0
	 b5NtsD5YD1NDNLZsIvGD42dKF6AFXuSmn7DtoUs6dvjdX20/oZ8Q0Z48ZkWpjPB9Dl
	 ugUYgE4z6NYTYlV8GEI61++2n48sVQksgXdqAQJUkWiHDBvHyRoG9ubEdjpC1tFWNx
	 RT5mV7pag8+ek2YGReploRr7szIPEXx6/HI7SuJutdQVzRRAYNPxKm30tt0LagP0zI
	 jvp65YQhkqRyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A89DFD8C976;
	Sun, 18 Feb 2024 18:22:08 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240218103837.GAZdHeLbPN7pXCkE3L@fat_crate.local>
References: <20240218103837.GAZdHeLbPN7pXCkE3L@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240218103837.GAZdHeLbPN7pXCkE3L@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq_urgent_for_v6.8_rc5
X-PR-Tracked-Commit-Id: af9acbfc2c4b72c378d0b9a2ee023ed01055d3e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cb7c32d60ad2dea48b7ac2845d86f10b0be089e
Message-Id: <170828052868.10456.10889864495015707515.pr-tracker-bot@kernel.org>
Date: Sun, 18 Feb 2024 18:22:08 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Feb 2024 11:38:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq_urgent_for_v6.8_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cb7c32d60ad2dea48b7ac2845d86f10b0be089e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

