Return-Path: <linux-kernel+bounces-111860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD40E8871D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F59284E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EF25E3AF;
	Fri, 22 Mar 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZsr9lX3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E6C5FDA3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127768; cv=none; b=b6+i6qupz2mwhOJJxVipIXGQHQdPOxrKAcOpBDk8eWyax0bcFjaTzUdWpK+WbAeNDEQCJdQ+N+mhiaZXFuhYBFrG+Z+LgDpzy1By6QtLuL9Ut+lKnxqCLTEBgnvM8NyvKt+pTo44N7AbZelhVZl9kfPmtv+8lZbw0z1G6aflN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127768; c=relaxed/simple;
	bh=KwIUJHkrKfQtp3IB+nPkXq32Jbk8E8YTyFtCYisgCaY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=noJSvhPKC0+YconfOEokoHn5y+2qGhmTDPQV7YqFmzwYucs5lLM6D7Q7jRdcKX6aTyk5Ib11Ju0dw4dFQm5meYaMQoIY85G1efMtMUvyC751kPp2qM7GXLWu5K5dfgl1vPCHwkBSEl2U6JBy95sujmX4ys3GkugRhzFNwmO8qNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZsr9lX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E458C433C7;
	Fri, 22 Mar 2024 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711127768;
	bh=KwIUJHkrKfQtp3IB+nPkXq32Jbk8E8YTyFtCYisgCaY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BZsr9lX3GOolmXcYjZpWRCjRDEoMufzgvPcinr+hzETaHh/f6Ei1CBJiqtgG1PFOa
	 hsC0cJWSqyuBURF9SOcAdeUrfk0WRtgHlk+SwQWJQpGRmo+ECpOjIhfmoyGfdDahLc
	 svCsZ8cIMWtoCdAzrZ3+v2xsy9lrrBgpGXnQC9vRgsnP47dXQb7f2dtWu7q4i+g8OK
	 L1amPWr/+urn1nSGG11UCETGdHL97wGXHqn9Ucly4a039jblnTVeMhc90R0wuiAwPl
	 pbI8w/jSjj8Oo20u7VUo4haL7yp8V8NDWehvNbJ3sDj/++IQ9mnP78g6STx3ifjDLG
	 CHBUh7ZJEaD9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75F31D95056;
	Fri, 22 Mar 2024 17:16:08 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.9-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240322143154.BCA3FC43394@smtp.kernel.org>
References: <20240322143154.BCA3FC43394@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240322143154.BCA3FC43394@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.9-merge-window
X-PR-Tracked-Commit-Id: e4ead3cdfd798092288f3a06b405cf98ded6fa10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c826bd99ad9463f0f7f43738ee880bc1667a050
Message-Id: <171112776847.8613.2064788927042238809.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2024 17:16:08 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Mar 2024 14:31:43 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.9-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c826bd99ad9463f0f7f43738ee880bc1667a050

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

