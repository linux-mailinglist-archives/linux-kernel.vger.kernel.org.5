Return-Path: <linux-kernel+bounces-48688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0339845FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C37F1F2A5B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C959582C7D;
	Thu,  1 Feb 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlyC8lRf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7B84FCE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811793; cv=none; b=Jfalnf9MdwFpCOzZJNwNEag3lagPwBdBIBmYi4XgrW0ptLOWqnGYxk8eN3sqdENcGlRyq9nxDhhg3kJZEIrBRZouwD17ZoCZTtoDSU2BkJsbK7bUo2M7dH+yJTyo5bokaMhwJcWp9oNnICEEHqY+ulR/IdkbWKy++FxjT9vYSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811793; c=relaxed/simple;
	bh=UtXi70KcWzJtSnrH72bBEWSP1mr3AYZ8UzvIB8leSyc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mylW+xKIDHKPKWVe1LZ0t198bfVWg1pOrPb23U2Mu6xj8M7vmOZlP65SYfJb+3S5aX096k6ihbLvKfdXAY9xB6LIFjD+CUqej12UE6LvlMtasb5wjO2BMlHVnVqB0nNnCPsiZLIM+DEpJnkUVEFAX02zTIbrC49xm9Lb6ufw/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlyC8lRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86738C43390;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706811792;
	bh=UtXi70KcWzJtSnrH72bBEWSP1mr3AYZ8UzvIB8leSyc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RlyC8lRf8y5bCpAM0r+JkSqHHAgFWO1epHZ6gDWg94kdCWBKMU6MHnz1NeXSbDekp
	 uaVhGNtuvXC/Hn210QsfIt4sDaP3TlhWPi/0oWD5qI/PgdOMq+bh1m4ecqbwsWRCUI
	 BvAnHVA6UovPv9Gsyo1P2yLZYYcSdgcsbWyUA+r2xN/ravay8iu5yAIaAfgrO01eDL
	 z6KzkZo6DT3J2AcWbt4gTWoEfkHe3WzGw25+9ZvLpzPWhaxK7rXqsvnjdV9hBlnKgg
	 /zb9OzF7pswIYkCM6Msqaywd/br7dfSI5MS0I+9odns2oOpAk8hOLgzQ6PoOBE1GBN
	 nrAmn23mRVl8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72007D8C97B;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240201120546.1645CC43394@smtp.kernel.org>
References: <20240201120546.1645CC43394@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240201120546.1645CC43394@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.8-rc2
X-PR-Tracked-Commit-Id: a3fa9838e8140584a6f338e8516f2b05d3bea812
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b561d10019214fc0a0c38254e71859db2cd760b
Message-Id: <170681179246.954.3648364431229180959.pr-tracker-bot@kernel.org>
Date: Thu, 01 Feb 2024 18:23:12 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 01 Feb 2024 12:05:37 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b561d10019214fc0a0c38254e71859db2cd760b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

