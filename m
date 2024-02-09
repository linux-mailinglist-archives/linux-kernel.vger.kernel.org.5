Return-Path: <linux-kernel+bounces-59831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3364B84FC3E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9711F22AE3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC186126;
	Fri,  9 Feb 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIoLZ3O8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171D584A2E;
	Fri,  9 Feb 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504383; cv=none; b=Q1CiQmuN47HrGeMv1ThYf4X362jdrdRLE7EQ01KHbPhRW6Pah3Z9eQXArkSdSTTL8MFpTW2Wfup5kAK3E6/za/moAiQQeWjaffwL+/gNZI4V3j4WG/A5DM14F3+uydDDfXNkIhL+PiGvs2ikdR87gabAxx+oMD3N0rZT9iJT/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504383; c=relaxed/simple;
	bh=21GVvSyssdPkDuB5I5wVgNGIIIXTJP3ZhVI6r1UTgL4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VzH3OXRPxRtcZfEzO4TLiLqJCMBiyPzCrRs4+G1j3P+Sc4JfrNcMOxpwO8GEOcb5jgCnP8ebVgqkFRDj09+L/FvJz8WOe3I6Ath0apmKcES7rxBzRuPy7JHlePxyFpbuGJNg+QFnTjyl63WKII7UYGtRVy66ef4vQSMZODvnAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIoLZ3O8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E222AC433F1;
	Fri,  9 Feb 2024 18:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707504382;
	bh=21GVvSyssdPkDuB5I5wVgNGIIIXTJP3ZhVI6r1UTgL4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FIoLZ3O8Fv5IrrZjFJgGz8kn+dliXxwyj4uqwoUyv9/+j2JNoqOlB32ewFUvhk8uC
	 yKt1lRf6qQSvR9GFcRqEVwb4UNksS5FYBe92ZUWmOC50CETpD3wlrrbKd8VoWpRE7s
	 G28tK5IzNFNnWCEWRFRVNuUfBv6CHinIhrTFu7xZ838d4T18tm58gBDa5XnmVKuiYl
	 3ZlRSiHssV8U34Oo7UF8rYHxtgjQgwAuYUJRpI5KgsgFQBHBdghVFAn3+28Tfpe0kJ
	 NSxOzRfkssqwWRj3/bEIRhilSkDBkcCjlM+ZifRigADdETRywgPMF0nar5DkEr1osN
	 kVijmSpX4OPIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC564C41677;
	Fri,  9 Feb 2024 18:46:22 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240209124447.768859-1-ulf.hansson@linaro.org>
References: <20240209124447.768859-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240209124447.768859-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.8-rc2
X-PR-Tracked-Commit-Id: cc9432c4fb159a3913e0ce3173b8218cd5bad2e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb747bcc3611c7b3df6c8e5826f5003daeea6e9f
Message-Id: <170750438283.872.9640858363374581197.pr-tracker-bot@kernel.org>
Date: Fri, 09 Feb 2024 18:46:22 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  9 Feb 2024 13:44:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb747bcc3611c7b3df6c8e5826f5003daeea6e9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

