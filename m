Return-Path: <linux-kernel+bounces-133402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F8889A34A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C224C2815B2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D090D171E78;
	Fri,  5 Apr 2024 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHq3ToVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C314171E65;
	Fri,  5 Apr 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336990; cv=none; b=D+lHC3PR59XXSBR/FqAf24eyjaYVouicUeTlXply7DuwSZvQuMiRdk8oF20IS3Jih9S+2y5iihqZsRPJrN9Pf2C3JwYkwC7F0AXX0QyG9jmu70jYcJXpnTpvIdm1dAaMLILbMZseT6GhvYclDok/OZWdg6PhCrvLNYL5bUbrbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336990; c=relaxed/simple;
	bh=nyi9LPRLu+f9gHNnqRO8TiiZrbt1uR929ka6BE145M4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=isWzQX/+OziBQ+v6auoRMPhs/IvnB7ysL9KWlhMMh+2FE7XS51GtJwYcu5ZuVKY8dUOUzN9odjGc68GuApCUCVfFawbgwoqK2Tl9SdsnUXdlt64VcIsoQTyeaRb1uIylp/0uVTNKEpwlmta+1zVY4mbS6tOHA5uz7BY1q6nZZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHq3ToVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FBBDC433C7;
	Fri,  5 Apr 2024 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712336989;
	bh=nyi9LPRLu+f9gHNnqRO8TiiZrbt1uR929ka6BE145M4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iHq3ToVwCnDp71k70oiSNtmEQCQ0g5XW36QjXdlYvmEh9gNtkN4PEBhxYrcfaUOZ+
	 sY3tEYkShO9LntNOmKSV8mTYhgnd19Lcd/zvlNvl4+21WxLyhMYuXe7KCH7Ti36L+u
	 bF4VwSqsebVUY74CvpFxfshCzn6k6AFWY53GqTsdYJh2Ev3rN9heUyZQFBlOjjzDeu
	 k4j/meqZgMy9jTQ9GeGG9BYCxhqwO9ktw4XZ2AC3GzN+Bfoi18rsIQkc4E9rvWrOdb
	 jkq84FDS9m1KeMDOA/tee3sA/PDrcQdnyoeAbuZKcZsdvO2X83ghQdCXsQahyMpo+S
	 eWgJmx8ZPMNzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C3CEC395F6;
	Fri,  5 Apr 2024 17:09:49 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240405-vfs-fixes-3b957d5fde0f@brauner>
References: <20240405-vfs-fixes-3b957d5fde0f@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240405-vfs-fixes-3b957d5fde0f@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9-rc3.fixes
X-PR-Tracked-Commit-Id: caeb4b0a11b3393e43f7fa8e0a5a18462acc66bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fae02687777ad80c1299c684f7f814c542103fa6
Message-Id: <171233698949.9463.315904001646824846.pr-tracker-bot@kernel.org>
Date: Fri, 05 Apr 2024 17:09:49 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Apr 2024 13:22:56 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9-rc3.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fae02687777ad80c1299c684f7f814c542103fa6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

