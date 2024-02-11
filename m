Return-Path: <linux-kernel+bounces-60936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AA8850B57
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2722B1C22114
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157765F480;
	Sun, 11 Feb 2024 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TreQmj7t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D25DF21
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707681618; cv=none; b=CxDaA6xesKpzodoaRZsPlc+xZtajTpUEO2MBJm+hS/T0N+rDJxUjkR7VMxpiwXcNXW2z+hbQO5W2wAbPuHGvGKyIMTpkMSSDEpz6YHQmIwocuu94JLK7qYetUEpYlPX76TNT0c3Aylvm5xSx3evpoDN6QfYeTA1u2Q9ks7YeSEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707681618; c=relaxed/simple;
	bh=2so5A9ZfUQP3hyZ2izGD+3p5TA0tHXiAIV/l08tVFuo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZAXoPF/okc37FmsxHoIjI2MkeyqOEUpvdvN8vg2iqa8IhgYuYuWBtbN9oBVLpxKn2d3da9SLK2ULhib600Ckje3XqfoJPkgvvNfyJUY8gOI4uEdu3nHxPQS7H1EBH5/hga5AXEo1wqOl4oPxM1yn9z5t94IW69N6x8lGxAs2G1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TreQmj7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5B76C433F1;
	Sun, 11 Feb 2024 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707681617;
	bh=2so5A9ZfUQP3hyZ2izGD+3p5TA0tHXiAIV/l08tVFuo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TreQmj7tzgDe9i/r2BWfa0B5msd0a/UrKitim9+JbFfIh2NDDdkcxVmIzxzr8rY3U
	 /N2Z/D4Ivls3vRSVKTWrbwtWjQlK7e7zujS40gNajqeQ/6UC1MyFqoNuZhl3YIUw/c
	 Rnn6wTpjsTk9pD76EuDznsx6Xd5zm76vcjGjQTrpOY9Q57jgWD3FXYxyfVSgquTsZW
	 lGIJIVnv7DNB4WcDFQH4tlwDUGyYAaZv4E/caUQqo8Te+cBP7JszfND4oQN1+nqdDh
	 9tG8+TsB46nPrKLNleVEEmM7YJ25uWqbERFkqidwfaSOoWMZ/pfFUguumZzlPnVMAw
	 RUmcR7HA9L3RQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8EA0C04E32;
	Sun, 11 Feb 2024 20:00:17 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240211104144.GAZcikaNw7Luaj4XZy@fat_crate.local>
References: <20240211104144.GAZcikaNw7Luaj4XZy@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240211104144.GAZcikaNw7Luaj4XZy@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc4
X-PR-Tracked-Commit-Id: f6a1892585cd19e63c4ef2334e26cd536d5b678d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c021e191cf3da2fea766d784546f4c5acbfcd137
Message-Id: <170768161774.6576.11765993551613751114.pr-tracker-bot@kernel.org>
Date: Sun, 11 Feb 2024 20:00:17 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 11 Feb 2024 11:41:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c021e191cf3da2fea766d784546f4c5acbfcd137

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

