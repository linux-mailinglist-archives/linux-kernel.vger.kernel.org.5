Return-Path: <linux-kernel+bounces-103856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B13687C5C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C008BB21841
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AB91118D;
	Thu, 14 Mar 2024 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3zGp0vB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71310A2A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458036; cv=none; b=bxVqlAwXrYFkz825xRvb+ygfZpBOOl/yb76kRue/UF5otQ5LuQ3FZLJ8jPiWCAOSb2Xex/hucxxSnowfEly1Y1i8oqo354ZMN07cdztL+ypTI5+b967rT6kRmiqPiesOiAXK/GIoFBa3pXRZ2gSuyPmnuWsNwkWS5yZluzj+5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458036; c=relaxed/simple;
	bh=lQ5TTE4VzfVdom44iFw2fJDxbREJkOXy+tY5q5CzS4U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UdH3uAI9EN//4jw+RAcsbCt/VxdP1oLBNLJmE2dFuueroNTGbelhDSoIamtwHqvGc0PRRU8ADsa9YWR6V9JJaISJjtU/SpfAz8A7TRwPGiq4jKLHypDsi+SQUxLkNBP9sJPzkwRAKQhR6FLC6pAn/d74e3wrZNhMANIxpCRU3hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3zGp0vB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEDD6C433F1;
	Thu, 14 Mar 2024 23:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710458035;
	bh=lQ5TTE4VzfVdom44iFw2fJDxbREJkOXy+tY5q5CzS4U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S3zGp0vBB2tFvBmYq6x0kdrzAUnH6HsHnnSCQ0gVjtaYKiX//PZdNUbINXi+qMHI7
	 mmNvLjoduI2A1ux2vm03yws/MPAdYcAmE6dyqHTqS1UEQXXsB22fp9f4y3nYQhE5Zl
	 GL+M2JldCHaOWJ9B5KN41dm+eNDbYV1o52KtxxLDrAiIRRK8QA3YhHItAqpBG+lH1s
	 tQgYK1Kd76Kde6R3TwIs9k1/4Vbbz47wr8Z6vCjFmZ3MtTyfsnjMldvJkDL+GquviE
	 QjOqOeHX+sLZMlXK2n7wxVgeGEjfdn02bvVGAzlh71uwiIlyrgU+JJ7bGlpLzVwg76
	 ceSR6kFnWqIHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7908C595C3;
	Thu, 14 Mar 2024 23:13:55 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240313160018.2603344-1-catalin.marinas@arm.com>
References: <20240313160018.2603344-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240313160018.2603344-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: 1ef21fcd6a50f011680dbbd678c1bea8e3f67ab9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d75c6f40a03c97e1ecd683ae54e249abb9d922b
Message-Id: <171045803581.7563.14796132319187418866.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 23:13:55 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 16:00:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d75c6f40a03c97e1ecd683ae54e249abb9d922b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

