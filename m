Return-Path: <linux-kernel+bounces-99728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B794F878C48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03101C213DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7F9BA28;
	Tue, 12 Mar 2024 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyf+f5SH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52A8F6D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207013; cv=none; b=d/UZhgyCJ7JpWm51xwwFtvRgfvyqmJ1V92CxYU3msEOK0zDIS+dsLng9DQSqO55yW6sCWJTKD9l9bNjBLr/JSIM7xhJnnzecnSFQAb6WJFeryOo4srW8DscYm/rQxyqn2kGfXJ3zQF7NpWbPyuDurBJTZZqINpbzEA6VsDy/nfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207013; c=relaxed/simple;
	bh=YtSd+/BEKM44qIWYd0Xa5hEd0HJeXXzTZjuEad+kucE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aBgV63MKu6tno9AV510oHDeGbYLDJq7ve7BTti2wfZIcfd6+NiNed9dXnZrv7hew1mLNFH7mwCv2Se9cn8qg5mGa3RdhwcZbm+EJzn4sULNVJboZ+0nCGXXc1wgHej/nXXB941PeGlj5ECVrjAFKCc8AEA/YVxw6Bm+crEyf+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyf+f5SH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BDE3C4166A;
	Tue, 12 Mar 2024 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710207013;
	bh=YtSd+/BEKM44qIWYd0Xa5hEd0HJeXXzTZjuEad+kucE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dyf+f5SHFE/sm8Z7xSPQ1+/YLVxcGwlHkJU+oQD9MIcLP1UCnNXQry/VgrGEEVUg2
	 4wg0TTUJ2SdGk+9AsDVAOlk0wIDTM+C+v2irrXs5A3DWy6MiPO4Zd5DBaqCHx2S3cu
	 gN+uNwHlWT7e5Fo+h5xHdcwFEQ4B7VUWbWMo6s/S6ZCXe4izp+XehSRC/Z4JEelBEE
	 otS6QJtGtvdzjH/rBRZIVZ+8Kvd8bansr1iyPXx76GsHu5rIW4v7dveTNN5YHraThy
	 W1CM0Afc63laKeqo+xbt4vnO4DCreGyDgUTpmqOTBZkJbFWAB7s5OK2us7zQuDmckc
	 FhmgiZNzzt1eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 155C1D95057;
	Tue, 12 Mar 2024 01:30:13 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311151909.GAZe8g7SqDKRcP4XrO@fat_crate.local>
References: <20240311151909.GAZe8g7SqDKRcP4XrO@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311151909.GAZe8g7SqDKRcP4XrO@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.9_rc1
X-PR-Tracked-Commit-Id: c0935fca6ba4799e5efc6daeee37887e84707d01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38b334fc767e44816be087b3ec5d84b1438b735f
Message-Id: <171020701308.888.13681917027737941321.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 01:30:13 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 16:19:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.9_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38b334fc767e44816be087b3ec5d84b1438b735f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

