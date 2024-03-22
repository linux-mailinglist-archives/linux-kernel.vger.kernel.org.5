Return-Path: <linux-kernel+bounces-112017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816D4887437
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2275D1F22FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390877F7ED;
	Fri, 22 Mar 2024 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0SaU+cr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743FA31A60;
	Fri, 22 Mar 2024 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711140232; cv=none; b=ERKESg7OTHe7DpXR//YBJVVJe6TPJFt7+yPGOVhsGbTRW1B4qElDWBZZfivQdMrz9JGwGpahW/fr3lFSFrkueoFVPOpPWffzAwzKcLxfw4HfhyoSbx3qR+Cn9XbiD93mql0Z2/NCEEDfIP6MRUr4ZWyUa6VCObm2inpWbRluLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711140232; c=relaxed/simple;
	bh=9xXyKvR2dyuI/8yaI/PrK+wxYOfOvJFkvIKZ1t4TN94=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ls25ECw+jpx1d/IU5bW+7DJ7VaKeH3oxMNX67rL1tEXv5MP8tKqlUac38dDh9Gzx6xJ20ZtL2mLqaxEt6PTTtycM1tR9O/mojj45e8OIc8YgorrQRBbgRFOTsba9iic7DfZu8OiVQTDCO9xcQyqwMHO5cZoTbkeMPVdAzvLOxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0SaU+cr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42553C433C7;
	Fri, 22 Mar 2024 20:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711140232;
	bh=9xXyKvR2dyuI/8yaI/PrK+wxYOfOvJFkvIKZ1t4TN94=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X0SaU+crQsUj96x4uvrxPYT51lROZW671ZJ79X3VvdpmxedXwTA0NBO+0avdJVxbw
	 cVdxgkQgwJu4ksCQYT+G6b1lRLyYSk0/aUK0DVb5MxRhJBaliW00WcTy3Ye6XMj/Px
	 1MmNap5LN+KoQm19ftz9WkZ9FZJ92+XvvpflAJFLvbWmvTbVJeaoGJ60rcTRiUvCQP
	 FNnbcIlPV6oZZEjSjdh91MzEQKAQJ/zXdy9JFQhRww+Nz8lOzUAveoIq5KVnSlQiXS
	 7s0z4Q67fQ6kwMi9NMEn7HbW1JJEupFOCT6SokjUE1wU9vSBM/sEWgYf+/QdEnpN4K
	 iCXrNW8jvslHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39603D8BCE2;
	Fri, 22 Mar 2024 20:43:52 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI postmerge updates for the 6.8+ merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <3b789eacddd6265921be9da6e15257908f29b186.camel@HansenPartnership.com>
References: <3b789eacddd6265921be9da6e15257908f29b186.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3b789eacddd6265921be9da6e15257908f29b186.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: af180c0880f9df14be31807f0bb0fa6f0d34a943
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfa8f18691ed2e978e4dd51190569c434f93e268
Message-Id: <171114023222.4193.9247889856429393841.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2024 20:43:52 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Mar 2024 15:12:27 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfa8f18691ed2e978e4dd51190569c434f93e268

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

