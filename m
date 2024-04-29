Return-Path: <linux-kernel+bounces-162887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F728B61B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF403286159
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25C13B7A7;
	Mon, 29 Apr 2024 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOnlPp/0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3B813AA32;
	Mon, 29 Apr 2024 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417809; cv=none; b=QpMhsvvdjqO9AG0pQZJa7xPgGdgNtTGLdWwfkvXxci+IUW987bmDYW+Bi+CtKOT7ezK3+D41UlKpSdzQw8YEfVR8oahRpxGEeXlpgnF4JlmRRhLNZGSpGM0yqWNmiVIkaA9/yjo50DiH6AYd7cLWXEVPsrYhYfGWixN2tPKJRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417809; c=relaxed/simple;
	bh=7Z6qYhI5Trwqo9MHjeMgaQy7lxx2FGG+iuvgKY0yDd4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lEmujjYTWuM49gcix3Xseg0JTHhyc19+dEHEl6lTWyTwGbYw+Ed61MQ4qfNKcV6ZkypJ2gvP2tg6o7marK2YWScyNUtxeVMGWVRVC7OJhlpttOzfStC0OS/0U0JsFjdeWYpN/dVgFtNdhq4P+p1vWG68dQCWXya9/EG66CEbmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOnlPp/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4399C113CD;
	Mon, 29 Apr 2024 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714417808;
	bh=7Z6qYhI5Trwqo9MHjeMgaQy7lxx2FGG+iuvgKY0yDd4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DOnlPp/0g7qcHYebD/6aZe+8b6OhPm18KQJENH9L+iGbjZjw3WqprLM8cXpbHb6kK
	 Jg09lQQYRjq7gtm5KbzwVcHjYm7RTQUPEgV8EqkXz1IP5eoVTgGOzfGIwFTHInmIea
	 jQsDMwV+k+1YkRMKlGP3m92U/+nzlgDBANIgvITZDKs2eqgKpCu6++AmTunY3gL8dz
	 im6ha9PxCw6gom+oZLkLzPLneOac15aK5V1QFS8Ys2n/QZFmNtpgE9fSIA/wYYObrP
	 OwzxpRb6vIrWBnDq2nZn8difUFGR7NHQrchRyS/Dmk/B94CAXo2IL2npA9+cC2xFXa
	 OUXEAoRMSgD/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7B54E2D48A;
	Mon, 29 Apr 2024 19:10:08 +0000 (UTC)
Subject: Re: [GIT PULL] Bugfixes for Linux 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <230320fbf8c4a3fe3fcce24695aa4af65875bdf3.camel@hammerspace.com>
References: <230320fbf8c4a3fe3fcce24695aa4af65875bdf3.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <230320fbf8c4a3fe3fcce24695aa4af65875bdf3.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.9-2
X-PR-Tracked-Commit-Id: 24457f1be29f1e7042e50a7749f5c2dde8c433c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e4bc4bcae012c98964c3c2010debfbd9e5b229f
Message-Id: <171441780874.14808.6356000318708895546.pr-tracker-bot@kernel.org>
Date: Mon, 29 Apr 2024 19:10:08 +0000
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Apr 2024 18:59:26 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e4bc4bcae012c98964c3c2010debfbd9e5b229f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

