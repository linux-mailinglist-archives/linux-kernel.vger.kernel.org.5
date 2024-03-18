Return-Path: <linux-kernel+bounces-106565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26AD87F058
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF4C282012
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F657887;
	Mon, 18 Mar 2024 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIp1g4XN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6357881
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789678; cv=none; b=FJZtTfjTLX6zoiCO8qf6gjzXcp6daG08P9SmCtMqL0gnx5xG/RuC2ArB5ifE7PEcTAB23yBtqQdNC9i/1XEHVUiRY1B+p6//NyRUtDQ71iIXUTijsb7qSKqUcBSS0aXVZD1bmcw/spVWMBG43cWUG931PDHzMZErZFyWlq+MLTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789678; c=relaxed/simple;
	bh=jjtbHMlq2RBk4POjZ3Q4hQPW2sWuY9zYox2ybK6TpHc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OxSMfgz+rwNbtxDwSY+ZOzuWYSh2obpWS3zj5HdM8WOJ/8OjmpP5zARDlpSJCAAPeO3boC6Esgmf8NQXutvWkKC+97IZyaFrM3zrTW+3/YCjs2FSXQ/cy/JlvRadHYdtSqnNZr5zAXQMkxcHGz10LQEQpvcKqZ6BXuoD+1a5aG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIp1g4XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89199C433C7;
	Mon, 18 Mar 2024 19:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710789678;
	bh=jjtbHMlq2RBk4POjZ3Q4hQPW2sWuY9zYox2ybK6TpHc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KIp1g4XNa4FGTYTZ9hqNOIgm09JuhMZytSPjWV+f4lG+WyCj078M83b3szs3zkzC1
	 434PVqd87eXhFaTv4JcmYN43NSvt2JJyj22vU7lzHTN+entRUOI9CHGEkfQ818fDiT
	 DcttANSiGGmBGNw/usKSIbej/yTqDBcauqvxSqji5EbQWzhEgMiL815mBkCMmpEHCT
	 WFGot4TzgDDwx/88vw/Qlre8rjBcQQLqLNwhGtaGGt0U/cO0rKVFjFBZA6UwyK3nv3
	 95ZChntokLl8kcJSAd3k7SbQ8Y4WJEf3YSFuxQXFbKsb6L6MakfsBTO9q0rEQdBiId
	 HfilIplAqzJzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A2FE17B6474;
	Mon, 18 Mar 2024 19:21:18 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs update for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfiBt0gRe_Elp7hE@google.com>
References: <ZfiBt0gRe_Elp7hE@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfiBt0gRe_Elp7hE@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.9-rc1
X-PR-Tracked-Commit-Id: eb70d5a6c932d9d23f4bb3e7b83782c21ac4b064
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5d9ab85ebf3a42d5127ffdedf9094325465e852
Message-Id: <171078967849.17817.6127983227768532199.pr-tracker-bot@kernel.org>
Date: Mon, 18 Mar 2024 19:21:18 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Mar 2024 11:02:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5d9ab85ebf3a42d5127ffdedf9094325465e852

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

