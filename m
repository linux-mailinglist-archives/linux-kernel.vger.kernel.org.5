Return-Path: <linux-kernel+bounces-78998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFE5861BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773F42845F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF59145355;
	Fri, 23 Feb 2024 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml5CAwxR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854C1448F4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713846; cv=none; b=PnZUevuNe9+l4nEHQhGD4dBBXlUFcXkb6oLxQu8dhZoV0yntrnaeJfUWiYBbAjK3cxQn2NDxABfe96zF58l+w0fgqATOEs5t/7NrQPbHnlIlamCYw9acGqFXAeeymAuC5RW5TLiu4sCQ5XqpssYU39ycfE2EVD1kbjne8INqR+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713846; c=relaxed/simple;
	bh=9VmOs9YbPuVBWIrpxF9K9aSvP6D5gdEcGMiS7WpNNz8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TY/idfhr+c5mcAdXvZCzO7dvdhVmGrXiti17wF2ZmH3EUGAZB53NQM1gynN6AbTbUJxSyJRrJcVbx4D5vqPm0wmBtK2vid8rggmOQ4Y2EDw2x1X5YCoCTdgqpEVRG/PEpqxCHAugJea+NJvkEsvw0I65+S5zAZIrxLixuD4pQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml5CAwxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4134C43394;
	Fri, 23 Feb 2024 18:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713845;
	bh=9VmOs9YbPuVBWIrpxF9K9aSvP6D5gdEcGMiS7WpNNz8=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=ml5CAwxRaC+rTwlUOwamrlc3xtki38WKyx1yFQ8EGe7AM7V1EQ8reAVuWj9vZRzBe
	 lCA6y9RAilM6V6+jJd842C2fqGUdW8tbD91g70lSv2eGGX/dQK/2alIDHGSeZkmcYN
	 35JMVeyidWvkGiS9P3Rl90jHah/qHqm5nldJc01EcD7oZS2ZyWdwlCtczSSnM3vdE9
	 mziOZx3OpSTqJT1hP4D5GF7S5HySiVGMfZeIJqD2zdyEPk+dOcMG65nTo13xjrTKZ8
	 sjJL3Cx/T1sSQ0Ec88z7uRzavOOMdUx+tMriM+Ty6TTTOymtik1Uv5NluQ8U15PfR9
	 YyodnPhqIy1zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1B7DD990CB;
	Fri, 23 Feb 2024 18:44:05 +0000 (UTC)
Subject: Re: [GIT PULL] Arm and RISC-V SoC fixes for 6.8, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <04be5855-9b18-4ff0-8554-8b9d626a7845@app.fastmail.com>
References: <04be5855-9b18-4ff0-8554-8b9d626a7845@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lore.kernel.org>
X-PR-Tracked-Message-Id: <04be5855-9b18-4ff0-8554-8b9d626a7845@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git arm-fixes-6.8-2
X-PR-Tracked-Commit-Id: dcb8e53e339e534eecfd86fb21674d7eef7380eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e44baca779686425d0ca02491731b6d688c6711d
Message-Id: <170871384578.26987.6883523533721597550.pr-tracker-bot@kernel.org>
Date: Fri, 23 Feb 2024 18:44:05 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Feb 2024 18:00:07 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git arm-fixes-6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e44baca779686425d0ca02491731b6d688c6711d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

