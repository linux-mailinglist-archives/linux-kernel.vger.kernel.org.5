Return-Path: <linux-kernel+bounces-99725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA76878C44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA9D1F222AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDB18BF3;
	Tue, 12 Mar 2024 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3h6o386"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1E79D2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207012; cv=none; b=GuI0H/2HfblJUNP6EcUgGoITJQQXXqd6rIkNSqfBB4n59SGnyzQBvfSPZagupxqeRbfvEkmjAAol2xLLsV7PMCt1IEXBMCC+dclzazHUZPokgZf7CuBcJVXkjzmESpMnb2Q5c9yVOEJt0+HT5O3WSI0HaffWuQY8/lq3QOV3KiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207012; c=relaxed/simple;
	bh=TZFet7s+FAZljU179zBrI6Yymkp2vNeal9OncSDt2mM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y81/Y1hqQZP2gujYL5jT1RkOLkFOej5bIZVIgZr6DYEg+fVRuyOckvvHdW8KCOqJwUWiDrQ4IDBl5YKfhIwxYFm68rGrjEsSGtgz6ZM3BC+HYTNyuszE13EAVXf5CoZtBECKchLjfl2Q3UXAx2Eg0LXQn6T7k0aZ8Rm8Zg9n6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3h6o386; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F133C433F1;
	Tue, 12 Mar 2024 01:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710207012;
	bh=TZFet7s+FAZljU179zBrI6Yymkp2vNeal9OncSDt2mM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L3h6o386C/xfoFV1MJXh3nFlCWtBc2i8SIbfK/sTh1ry3ycvSLYdjzoDqiv7Lzpa/
	 9Sqiyu6sdQ9EaJLih8wS7nB9UjY6m+cQHWUhV1ZGPdpvGtCtx2mZwv0p+SHXRVL3y0
	 /zJpKqgZJe2+jszTpLITFF6jqtyUbjM+n26ONoeRhjA5IX5Ru+z41oEYCOXnpABqP/
	 v9/nfTzoMJb38sJhS9nlmyHDZfArFZh7itEdj8PdCapJvPQfK49yFM5c/el0reXbWB
	 OUduPNjHiM65fidp5YXrEErU2Qpd5hWlXfONE+sDPy8M8zW5yrAlIY5/ccPdRcGgOL
	 k4bFqY4Lvxrhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A873D95055;
	Tue, 12 Mar 2024 01:30:12 +0000 (UTC)
Subject: Re: [GIT PULL] ras/core for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311085011.GAZe7Fw40LPs6_T1cR@fat_crate.local>
References: <20240311085011.GAZe7Fw40LPs6_T1cR@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311085011.GAZe7Fw40LPs6_T1cR@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.9_rc1
X-PR-Tracked-Commit-Id: a6a789165bbdb506b784f53b7467dbe0210494ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8941ce52b708cfd520994e65760a2fa6a646dfb
Message-Id: <171020701216.888.15142520032767181690.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 01:30:12 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 09:50:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.9_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8941ce52b708cfd520994e65760a2fa6a646dfb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

