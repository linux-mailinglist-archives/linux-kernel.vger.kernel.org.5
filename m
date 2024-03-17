Return-Path: <linux-kernel+bounces-105522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C28B87DFAB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4133E1F211D9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E24B20DF7;
	Sun, 17 Mar 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiAdI0Iv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C01F932
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704059; cv=none; b=AliCfABwrIo2Y/apeidbYY34rPOPQSlz1LruISij4nsLwX1JEA+aWrXP46ypZeK3C/waflooaQgv3UOBoLTHyHmrIfKP3at5zsUxXRg8YQXwGdy6y7U1Qyvhr7eIdZrxCFM66eEcFsr/UCjHJsG8+R9CxAwLK2lwO9zYfJlXDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704059; c=relaxed/simple;
	bh=v+0LOXr9yW7Jacd9TtvHsmm5SrcxCf3rxt34THxBKK0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CAbPCnw+tmZml6CR8o0zcxHOTVIAk/P2VTvfmNHI4Pm0AN80Sd1lHJbLcpKHnA4B2hbAJV9TnZTIO/ZJHSAFsVt05e/LrWpQb60MuMfd8S22Iv/xl4kLC2l/OK7Ve87DAzdXtC171AjmwGP4O37s2QiHvfqfKK+GIwiu1ddylS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiAdI0Iv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28990C433C7;
	Sun, 17 Mar 2024 19:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710704059;
	bh=v+0LOXr9yW7Jacd9TtvHsmm5SrcxCf3rxt34THxBKK0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hiAdI0IvDzOz6kgq2uPHRfUWWMKtzXntHyG1YnnOllDqdw/cEW41kkO1R2NV1m/F6
	 S89SUxneJ2iRAuK0ryAY774dbu4jq1Dho+IKcY+YOkMTS7lXGuVzemECR24BMV0oBH
	 VtNfBCUg1C3YplJblB5IplDtWXbBZM/Y3B/NO22/zCAVjFehZxUP0Ueomk/ojzUgJy
	 BeBZ+RmOhZC72OpdbKfVPRRvtNjzxSnofLq2FrebNzywVn8TSGeWe+UnZ6c2IjeG4l
	 Nk9T6sO12xoV3lzBkC48gIs5jrOZ/g2A2L84MEyXvF8WFu9y7b4lnFQnsCJXskylfS
	 FQi1DLFmu69OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2245BD95060;
	Sun, 17 Mar 2024 19:34:19 +0000 (UTC)
Subject: Re: [GIT PULL] PCMCIA improvements for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfaZnUHu8LcLHGqF@shine.dominikbrodowski.net>
References: <ZfaZnUHu8LcLHGqF@shine.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfaZnUHu8LcLHGqF@shine.dominikbrodowski.net>
X-PR-Tracked-Remote: git@gitolite.kernel.org:/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.9-rc1
X-PR-Tracked-Commit-Id: ccae53aa8aa2d902242555638c5de104aab08879
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75e41d42cc7d3193b9018dca6ba8c5e5c0a5e729
Message-Id: <171070405913.21222.1255737562128404407.pr-tracker-bot@kernel.org>
Date: Sun, 17 Mar 2024 19:34:19 +0000
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Mar 2024 08:19:57 +0100:

> git@gitolite.kernel.org:/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75e41d42cc7d3193b9018dca6ba8c5e5c0a5e729

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

