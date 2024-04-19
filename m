Return-Path: <linux-kernel+bounces-151963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057C88AB64A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318301C20F04
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F3C83CC7;
	Fri, 19 Apr 2024 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aq8J2nHu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B638F87
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561150; cv=none; b=BJYlskogJ5ay0Sz77AA/J+SSP7YeDq5b+L5HSJ5s33XW8nk4g40HrLzkdB34sTxgPpzVM6JaX90Q/3QBcJ7ICqmwTDQT9VI3ZF0JhHCjSn2O3TGo4rrytqA0K33z7/yo/Uk+YC7s5Gc+Kndcs6dj5o8to46ozdJ6pqevcBrcs0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561150; c=relaxed/simple;
	bh=XuH3jqEO+LW4aW7N8To/cBoefZcwPCrSwEMJVoJvcJ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cuKyP7185ThFt0S+jfeFxvn2M0mhOLwb4qgAJ5S6g9GydQ6kQlhbWlqgEYYyfE5H10yE/RPkwZHdXa4NlVA73P50LD45ptV0VBg12fmJnm2UCHtZHM0pugnJeOPpsXhUMIzemx3Ug/b+wSXHaI6N2B9Kx98q0y42aHj0211lN1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aq8J2nHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ADD0C116B1;
	Fri, 19 Apr 2024 21:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713561150;
	bh=XuH3jqEO+LW4aW7N8To/cBoefZcwPCrSwEMJVoJvcJ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aq8J2nHu8HrWO4rwZg79iH9eIsgemR9PZA6CQKsniMWfGs1KzhNUoWG4At5vkWHbz
	 GrQpETv+faXlPGwoQPo4cZqAU/Yb7o7C8jzfa8oZ1p4yn9K3fvCusVa6Br1upaphgH
	 gimDhQATKExi8a7H7VOj2OjPN8R1yAY/Diy83cRxgjfkxXf/CXfBI4Dcej2qph84Yg
	 qq9qmhOriCGM+yVx6aZ+vMOSgnt+x35ya3Uj+CJY8vm4YCuBFk/tm9m+5jKEeoaEVW
	 boblIaTQFLaS1ol/tLbUQQgwkBXyPdM9iziYKwpE5Fu3qqB9gmdC//jEZnLk0GMZHg
	 7At/X/bEpDNAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 810C3C433E9;
	Fri, 19 Apr 2024 21:12:30 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <202404191315.2714F7D@keescook>
References: <202404191315.2714F7D@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202404191315.2714F7D@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.9-rc5
X-PR-Tracked-Commit-Id: f4626c12e4b538f757a73d08f4d86d564175b4f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d412262ccfd100218412b4b52d92d6a7bb043a4
Message-Id: <171356115052.4341.13165182575269962089.pr-tracker-bot@kernel.org>
Date: Fri, 19 Apr 2024 21:12:30 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Apr 2024 13:16:14 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d412262ccfd100218412b4b52d92d6a7bb043a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

