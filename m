Return-Path: <linux-kernel+bounces-50569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28983847AE7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FF51C209AD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E66485923;
	Fri,  2 Feb 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIw3x7Uy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C7839FB;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907621; cv=none; b=WJzu39KvE8Pf5/9T82D8CU7HSh25Imluz6khDo2tKqlWrFH41gAwzeQUV4C3ry1jHJwG1ZADFk0yrynqNn98g2tmkOu3Nt1fjX5VSnE9wIMw0mKqEJwlMWgTjPuHIXYYHQGyPlIFuuuq1+ihSLX3e5gN3ddMhda+sMIDExKoeVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907621; c=relaxed/simple;
	bh=YRDvb2k1AvxV1RkhHR/9uyavzodGHNcvx9zSGUOqHY4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CPlNqRqyqtCf/EOGHUuc+GpwCLX4zAmjL3c2hI2RvqasII8p2eMMtGrMAiC2rHegKLuICHENKGv1uLoGbFnuAxMGilclwsXW/gnhSL38CqOC0SXsuiHXCCo/wdxsQk7aR0fW1NPVW90zhJRdP0ujhD5UWUvdcFSRyuA0v2Tt8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIw3x7Uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D3B2C433C7;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907621;
	bh=YRDvb2k1AvxV1RkhHR/9uyavzodGHNcvx9zSGUOqHY4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pIw3x7UyqXsEDlds9KWslJ8OgOcNrr52nls25VtAn3DZw290Uri41Dt+Gd9oRrOsf
	 pUdwdf0RiMUf+qiFNDNwrb0S+vVl8ZxCr8K+G1RZN8tguGvHyWwCuaHOC9gtJyLlp4
	 tvoARoFgXNSMCiwaOOuplhxomFq6Ul3LAVOO5Lp/5APP57cEQfpBontfXjxUE3Jl9s
	 Ua/YkRvs9Ag/I60A4VV9psiHWJ1Q315L23o9veAD+lhn5Gbygb2c1Rs8uE/EcRINEt
	 aotb7enFEnSVL6vgsw16osWJEmzom26l6iVTrnR++e8dDojJWXqZSm0ymK+bqwwW2N
	 E3fjvNUw/WjyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11E56D8C978;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.8-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <h5ljtaj5ytq3mdvcqrjak5dq7lrabcl33kx435k7jrufxuapkg@hrnhnok2dwzp>
References: <h5ljtaj5ytq3mdvcqrjak5dq7lrabcl33kx435k7jrufxuapkg@hrnhnok2dwzp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <h5ljtaj5ytq3mdvcqrjak5dq7lrabcl33kx435k7jrufxuapkg@hrnhnok2dwzp>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.8-rc
X-PR-Tracked-Commit-Id: d0266d7ab1618482d58015d67a5220e590333298
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79837a7c0f4236fa898b948db4c1c978e21175aa
Message-Id: <170690762106.8980.1795815062463460104.pr-tracker-bot@kernel.org>
Date: Fri, 02 Feb 2024 21:00:21 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 1 Feb 2024 22:39:32 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.8-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79837a7c0f4236fa898b948db4c1c978e21175aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

