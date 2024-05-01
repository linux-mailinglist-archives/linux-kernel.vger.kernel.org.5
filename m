Return-Path: <linux-kernel+bounces-165658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E51F8B8F23
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C2AEB21216
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5797712FF87;
	Wed,  1 May 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH+mO4SL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC21AAC4
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585286; cv=none; b=eNwcsjZERGQc4GMNPabFypIWXoGeLofKUNPVnkwnGvQRdiemJ8555x43T/eFwxWfroMZ1XsQRe/aIZMj9I5aDH+K/NwJ4T47zvOXkqLoPIgI7b6iWJCfltECmap6UPbUYMUSr9HqyqahqZ/f9CaJVBSdcK2bFePxnYTy3ogZ3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585286; c=relaxed/simple;
	bh=fYnlN8922Yzj143QTilX4qUfA8a7dGahSvmYcZLVEgQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=psE/gffCU2qwLeIOWwi6/CzcPUp86qia4KKp5Wpx+f2kXzQNmdQiSKwtBbTT52pT0tFGzwaFNrsuB/E7N8doTh8SIbIGWi26rKBN8yQZxzhiJ8Hyx48zKO3XEkj5H8/QYE/m+q8wkkwoYgAodkicDcb/ybSkb+NnKkmZGPLAARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH+mO4SL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F9F7C072AA;
	Wed,  1 May 2024 17:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714585286;
	bh=fYnlN8922Yzj143QTilX4qUfA8a7dGahSvmYcZLVEgQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lH+mO4SLI+a9i/hk6GRhjRJX/ahWZb127wGCxXJCJcvHWDxBXVEMR/t9AMZgpmofA
	 4eAATf7lejQFLfT43NNZNmOxFB9o3S1bKC273CAg8zmQ9TAS/m9k7dKAGoieSUW6Em
	 dxIozwJtb2MDrXlTiKjGU+fAtDkz9qWKv+V9I4c8uFhJ7YgaKDhnXL5GhcX6o8CPsh
	 vVdg6DMnMzZ11P4zhgu2doWLi+iQZIDhROpPOvhwHcHz32dN31qfiZC/ayNpmguaoQ
	 G999zY1C3as8YnvN0mKKMkqF2xZjX6cVjYb+G7ualzhom/4viTzLxN+k+4vl7g7mBK
	 lWtj3hYWllEYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2374EC433A2;
	Wed,  1 May 2024 17:41:26 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <0bab863fc734774982e9d6fb4ae70211.broonie@kernel.org>
References: <0bab863fc734774982e9d6fb4ae70211.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0bab863fc734774982e9d6fb4ae70211.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.9-rc6
X-PR-Tracked-Commit-Id: ff33132605c1a0acea59e4c523cb7c6fabe856b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0106679839f7c69632b3b9833c3268c316c0a9fc
Message-Id: <171458528613.29670.8652472263423820057.pr-tracker-bot@kernel.org>
Date: Wed, 01 May 2024 17:41:26 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 01 May 2024 23:08:04 +0900:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0106679839f7c69632b3b9833c3268c316c0a9fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

