Return-Path: <linux-kernel+bounces-106394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E91F87EDE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927AC1C21EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2555780;
	Mon, 18 Mar 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqwPfiPC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6F54FAF;
	Mon, 18 Mar 2024 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780482; cv=none; b=tHBgP0I1J/Rz0BvqnWVF7f5MZjbGSSuGQmHFLkufCO4k7ZMQLyLHkVyjzuuXJyCuV7LQmtI42FdDN2DzIpRLYTcoHrmO1kmIsS5fzJ5u0CMJ+GVzTtCcZ603q0arftfmhTZShp1k74dCTi/WKnahYkU69yYn/gNnMDgrNmQ83M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780482; c=relaxed/simple;
	bh=vfTFXZYjTA8bpLJRP7X1KpbKhb3MrGmYIoOfnukVcqs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jZNoHdVJCCcRwPSlVJJmVJDf7p5o1m+m66FkwPC86oaNmebxWG9Dx4hwG9IYm5orhSKcDD0Ad1dPnv+7KymcdOMfDuhva9D4qyzIJZuM2+plY7xgCwfzfB6Teoj7ml079sqNKuV5nC7GCgGuw5GfnIzADMStzRJgX/xyN+p+hPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqwPfiPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21F76C433C7;
	Mon, 18 Mar 2024 16:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710780482;
	bh=vfTFXZYjTA8bpLJRP7X1KpbKhb3MrGmYIoOfnukVcqs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oqwPfiPCdRKHGmVABK4N8hudXaY+VeREpprAroMLAtsL4pPco+hSW8KxIYv4rRSCd
	 222oUUSHwblKQJLfIB4ZgxaboWatupVWnVqFjR4RLP8rJRBELncjfAl4iEdnkmTIH0
	 9Z2gVR0ot1ZfRd9YefOtGp2IpJID6fjiwRijYcDLAyzOe8L/zoMeYDUCnhvat4Iec9
	 uNG/vahcXYgL5Uiwm5fzHeRvqq4sGvPX3Cuf1i1MZNkJJ5tca6tsYN89I9J+P7LIbU
	 WHlDi33cJ7aFJvT/tNZqgw6tgfb50311EzameUNMC6s8S7q6rTQsK/9tO9qdvxIqlV
	 OW8KEQZRWaNzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19890C04E24;
	Mon, 18 Mar 2024 16:48:02 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87o7bb9awe.wl-tiwai@suse.de>
References: <87o7bb9awe.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o7bb9awe.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.9-rc1
X-PR-Tracked-Commit-Id: 585f5bf9e9f65b1fec607780d75d08afee0f0b85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5574aaa303e6bfabd7a2296707658ae9e2e9a9fc
Message-Id: <171078048209.4121.5993893874426166792.pr-tracker-bot@kernel.org>
Date: Mon, 18 Mar 2024 16:48:02 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Mar 2024 09:55:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5574aaa303e6bfabd7a2296707658ae9e2e9a9fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

