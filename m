Return-Path: <linux-kernel+bounces-143827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71BD8A3DE7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B87DB20D02
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3895F45C1C;
	Sat, 13 Apr 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PReBAQ8T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24F3398A;
	Sat, 13 Apr 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713028363; cv=none; b=iGh+1MFXPZUvZyvHrxLB0M5BQCZUhcM/HAlw5BsfRY2wCT6jIApJBG9tkd/EhYe4G9dJWqmZOU0nCnXQZ4lury/pO//ZgOrDolmaqo5ks1Tn9MsPfLtCPtqPOTbOWDnVIlx1lDwfF8hxqttjTU1ZBKczoOBzcjN9nyJc1gnaZag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713028363; c=relaxed/simple;
	bh=62lEtTo+NlHmnn2skMS9rgrEZrk0eCcSml0dWLo2qLw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ROQ8Rkp+qF0mVeO9BIKulEcxVng73C2q44n4CCMcKVNvIwVPpK7wsDwhNL4JBzGuu3LZWgY948l2nM8U6niRImbX0cpEAWXUX5iVuFTJDwyY4SOPvh9ZbIy05FyRr/J60kk51k5XWtMQA+crtRvmWgaCAHlLNAxeyP4pZjBafOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PReBAQ8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B076C2BD11;
	Sat, 13 Apr 2024 17:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713028363;
	bh=62lEtTo+NlHmnn2skMS9rgrEZrk0eCcSml0dWLo2qLw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PReBAQ8TDG66v5HGxLxtTrTkTu/lmgVBDK/Kb8W6XrYV7Z1nvxApK1GRq8JxxxDZW
	 kDbN/N+pThzZSxUsMrUyzfuLXvMWQf3eZB2LHv7P57kN/NhFdlX0lymlMEUL2VERTs
	 3dWo62i2gdrlOoUDGk2YiVvQUxoyz3U6YKGM1mKen89rX+xcdTg4rehxNuyek8b+wK
	 ch0+rUoCC2/aHg2kjNbANaej97JPOmTv+vInOLsUUTdlyMDV2MznpbPySGzmz2+U84
	 4nxpqIFv2qVK0vrhAOqarlBH4Z2BBYUnGN8//WgNlafxMgLYlNtN9xy1FYNJBWTAQ/
	 ZiUWwn8Oz+n/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00C3DDF7856;
	Sat, 13 Apr 2024 17:12:43 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msxJ8sZuc45wo9UYyaRNN1k0-=hgjOzyGxAvM+6OQUx6Q@mail.gmail.com>
References: <CAH2r5msxJ8sZuc45wo9UYyaRNN1k0-=hgjOzyGxAvM+6OQUx6Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msxJ8sZuc45wo9UYyaRNN1k0-=hgjOzyGxAvM+6OQUx6Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/v6.9-rc3-SMB3-client-fixes
X-PR-Tracked-Commit-Id: 35f834265e0dc78b003aa0d1af65cafb89666b76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa4022cb73613543512a49ef6ab5a59ff5361159
Message-Id: <171302836299.7440.515413250809908923.pr-tracker-bot@kernel.org>
Date: Sat, 13 Apr 2024 17:12:42 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 13 Apr 2024 04:18:07 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/v6.9-rc3-SMB3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa4022cb73613543512a49ef6ab5a59ff5361159

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

