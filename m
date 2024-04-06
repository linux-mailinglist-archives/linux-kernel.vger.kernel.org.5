Return-Path: <linux-kernel+bounces-133739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C4F89A7EF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F67B234F8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F364125DC;
	Sat,  6 Apr 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ6z4G2Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F51D29E
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712363344; cv=none; b=ruNw05wJ/5sRqeepkmN20GQqTeiEpsTZ2LpGWZJpyhT3ldy9UCQui8+eOLY9YFlMfunr2Gn3al0/nCezAXRKRYmxrLrDI5QJLn/zigaZC4kyr1+nlWDjXg+GWARmAVK6kO4sns/ZMexrsdykqQ0l2I/3sb676KDobP1NpC1TJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712363344; c=relaxed/simple;
	bh=DRWpmJVoz15NjEHzGghpq6C7wN1eW4jIpcQxAO9nTvY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mXJ1v5gKh8fIWIgrDciAnLBuGBD2YA9YLqJcjixpQoUkHBE7paA2o6brfBAFzPntotRWR6taBpujTn3f7nrMtU7ayAuooO9bvTDWRT0xdpmsxJcmUR+I93MvURpBj28g244HT/ZfLjrS6nZT+oAvk/C1clSpr6lCa1gbu7ozYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ6z4G2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A930C433C7;
	Sat,  6 Apr 2024 00:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712363344;
	bh=DRWpmJVoz15NjEHzGghpq6C7wN1eW4jIpcQxAO9nTvY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CZ6z4G2ZsZq0ovy+DkUG7v1a6OHSe0pSoFW9oIQSpF9HZy9WsYGZ1/r1JrE2bFkrE
	 4c5rgu8iE8insXrAa64oItGIKmQGMcrNm7ZcIFoTAjAYdSTk4uJTfoZmLA4JXDVf6m
	 ++MdNcb5rpSXqnUoCordWPdrHYAPaSEmux9tnR6e4b03YrmG7NCg0sxCO3ARiv4GRs
	 BFxDZufjSPiJvTqbm2tjtFMKf9xihzwPqGKhkAakzXP4sWTUZQbgOLmAtnrbUBW9o9
	 LRFM8ozl25VWZzyRBZ0PzdFuoVtMEu9PFXIYS5IP+2vw7LoXuGv7hnwEYkDOq5XTeB
	 5zi7d0jxa3Sjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19494D8A100;
	Sat,  6 Apr 2024 00:29:04 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240405222035.306A2C433C7@smtp.kernel.org>
References: <20240405222035.306A2C433C7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240405222035.306A2C433C7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.9-rc2
X-PR-Tracked-Commit-Id: eaa03486d932572dfd1c5f64f9dfebe572ad88c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6bec447a82fdc20966b6129fb51bff46a16ef6e
Message-Id: <171236334410.12657.222142785991687183.pr-tracker-bot@kernel.org>
Date: Sat, 06 Apr 2024 00:29:04 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Apr 2024 23:20:26 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6bec447a82fdc20966b6129fb51bff46a16ef6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

