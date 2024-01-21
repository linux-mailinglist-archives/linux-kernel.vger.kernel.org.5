Return-Path: <linux-kernel+bounces-31855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B123383357E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6134D1F21B29
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0E110A0D;
	Sat, 20 Jan 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LezmrqdD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159CF3C26;
	Sat, 20 Jan 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705771791; cv=none; b=mbJnEmOdCKwmZZryql/Q/X3TtZrdWe59vBieXWOF1DHloSGU7ZyNZqFxOdNiFJ3qMs8+nvPPtsZ6NktR3EdJJt/5liJamaj67A1+hBwEmZVqpQQwqupVemcMPZVZKmS8n8Rlmvu4Hv6TXqDLa8079dIEXSv8Wl/40hOCV1u57YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705771791; c=relaxed/simple;
	bh=CUVk+zvlKaq1O4Ki4Rprf7ShZwa75EhBTLogXcul3tc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n7azVJ6SyziXBWHYRTwILL93j7LKf2CtfyTx6wmFiplP+D4srj2UDV3BwaXqQJVX6jQo7b78X0wom+D6giqCT4YIe79eEtOqbmuSRUKdhWW/B9wDMUswqi5gPuYVC003kyqyIasmb9aA69idmzeUbw67auBJXu4E1dH2ooNyaRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LezmrqdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 782DDC433C7;
	Sat, 20 Jan 2024 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705771790;
	bh=CUVk+zvlKaq1O4Ki4Rprf7ShZwa75EhBTLogXcul3tc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LezmrqdDi/7t2PSgB9Vr5Y63PKP30KUzHGDqNYcyo23Sn3UGGyYYkFzDvHqj91FOv
	 3vYRU9EQCurJZHO0aHsUkx3EjZj209yafaX0iyUJ0daLEb6E3SH7rsq9uHj/oazcIm
	 9i+QKebOOmdQB3qXOxaxBt7Za4DYFx1rsRamWrrdogzYl0Rb/FK6fp7BdpOG/rqKwZ
	 lSUNPwyi7t+VRSjdKPMzt/h2eUVjenwqq73NryqYF4uW8B3guQhDoiR0oAqwCDofcB
	 hrZsMVT+UJe2Ey0OH7Kq4Ixwq56XTUVaBZr88eOkZgk9s0U0PkDLfdW5keYOB6eTij
	 XoZtm2VsHZ32A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68032D8C970;
	Sat, 20 Jan 2024 17:29:50 +0000 (UTC)
Subject: Re: [GIT PULL] One fbdev regression fix for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZasTWVn1lzY6oVym@carbonx1>
References: <ZasTWVn1lzY6oVym@carbonx1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZasTWVn1lzY6oVym@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.8-rc1-2
X-PR-Tracked-Commit-Id: 2bebc3cd48701607e38e8258ab9692de9b1a718b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1737ad4406a35f20eaae0e8079cc6ca6447e83a
Message-Id: <170577179041.28838.7145451632158218731.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jan 2024 17:29:50 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, Jens Axboe <axboe@kernel.dk>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Jan 2024 01:27:05 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.8-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1737ad4406a35f20eaae0e8079cc6ca6447e83a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

