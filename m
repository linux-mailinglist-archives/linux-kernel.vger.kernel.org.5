Return-Path: <linux-kernel+bounces-133551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5888589A572
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F581F23259
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEA5173348;
	Fri,  5 Apr 2024 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfnNPVcS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32A5D905;
	Fri,  5 Apr 2024 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347812; cv=none; b=WJeAy9bSFvUbRPhSKehX8X0h7HQ0qN2pIVSK44il4r2JIG9kVGRDVZba+sEbJ3VOBwTLmuQEakrvk7hUnhHb/qsR6wAOi5Dww6FnmkZe87gosHMAT+vVm40zvmKlpt8VDXfPWTBNnArniMhL6FnTGecNcpwl86hKtRE1Al6JwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347812; c=relaxed/simple;
	bh=eixQj+RaDJcraRyBM0MpNMJ8v2G0X21GcLL0rgpnwg4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GRdRmtdBz8g+OQF9RMaWelw8ArD5i0uv45CtiFmZHmSFezxkP0rglpbfjXHmdgifPBSVhQv14eaqm1TJS80QGJvGvFN9LdRE/N5DWqKgNMclzfVtqFOKHHHEzeyVkIbEHhP/z1G/gRIfTQ9CPTVTcVT9g1mFzDkZWT1yjaP2hxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfnNPVcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2340C433F1;
	Fri,  5 Apr 2024 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712347811;
	bh=eixQj+RaDJcraRyBM0MpNMJ8v2G0X21GcLL0rgpnwg4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jfnNPVcS+UTq1aHHFxrCTYWylOVCnRPgLDgsyAG6PmvTWWhZVKYq2aNe0In98eGHr
	 VfQ5rh8c/hqV+DOy3wl7MpywvyTTEM49TaFEkO1rxicGRf1cJxPuNkHXrxMcbGsgKK
	 N8t3s9jZG1iwFF+8P3cCNI/c1VGPYCuTc0sllQlv0fp4FVJ0TYWujFG7YvU4l3BEkI
	 sWcIL/8cIeGElUbTN3vCPWY+P1zixPZmLXcarUszrpDIG8t3d3n+/4mu+DXLtnz2D2
	 rN1S8CaRhAX0Ge7H6loVn5lm5vpegMqwHsIIntIfLzvirVzIfQNJ6BSCnPWmWwW35z
	 KmcalpzZGd0YQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D45F2D8A100;
	Fri,  5 Apr 2024 20:10:11 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <87v84wm6pw.wl-tiwai@suse.de>
References: <87v84wm6pw.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87v84wm6pw.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc3
X-PR-Tracked-Commit-Id: 100c85421b52e41269ada88f7d71a6b8a06c7a11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c42881d48c545b234fd8d82efca6b5bdc88700ec
Message-Id: <171234781186.2800.10286763266392831038.pr-tracker-bot@kernel.org>
Date: Fri, 05 Apr 2024 20:10:11 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Apr 2024 12:42:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c42881d48c545b234fd8d82efca6b5bdc88700ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

