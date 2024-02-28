Return-Path: <linux-kernel+bounces-84298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB9A86A4B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05071C22051
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1BD3FE1;
	Wed, 28 Feb 2024 01:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1jA8wzu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3505257D;
	Wed, 28 Feb 2024 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082159; cv=none; b=NW8kETQVMzFrh+/7HYnHaAp8KlxL7d7d4Bz1oySPn0MFtrZmqw/u8HeiYV0TFDWYKNGv3++lkTZfwXsEapguhJXoy4RNVvQadUMeYYnKWIREWNamxFUnNDbT/mKI79c5QN62EQ8ie5+m5Q8A+jd7kSqD+J5I7O+WAa2bgckYeaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082159; c=relaxed/simple;
	bh=WFSWIv5vDLffyaYKsz3/YDBk5T/k2S9cUFTb62ck8b4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=frIPEwhvUXhqz72nVe39g6P5azk0+xfbcnPG6tbuOww8M438/Hx9ma0MEhKOWc5NfQXnNrI8g9wi3w50YK1hfRlV+RFTpcVVa+FrpAJSPR4r1Wb70a/rmIEtzjz7bGPH0njE4f3Al6a9BFLFdOuCJ0ldBIKCt+2mRaFvoo+4pGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1jA8wzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 721C3C433F1;
	Wed, 28 Feb 2024 01:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709082158;
	bh=WFSWIv5vDLffyaYKsz3/YDBk5T/k2S9cUFTb62ck8b4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I1jA8wzuepsFc5f8iS0NwhPwV/Dejvyie/wwhXCBJV6SSUZOwve2UQQE+qaRpTT8r
	 d7hMzuPX0zrLfdW1mdPcfn6xsCDdq1Ym8YYQUI3sTjSDFUpQy7bNjYleUJyRR2c6Dq
	 Ip8jcGEXzFVxQ1QZkBmYhBq7cEVinfxcQfW/vie6gNGRNIFNHlN7RtNprNZfzpbPln
	 iUvY1vIgDfYcflxvxMUk41QEDBGxj6lJHxS1Y+iFuLPwItFpkyT/i3zcywHqepsv4B
	 qpkbAFBw19q3x4DoNdBdMwzUWdeZksiCxx8vyTGSZfp66eLPevpT7yYJwps42Oue3H
	 NvYDjvcrH2iNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EFBDD88FB0;
	Wed, 28 Feb 2024 01:02:38 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20240227
From: pr-tracker-bot@kernel.org
In-Reply-To: <64a1045e4c018f135b78952c2c5ae3e9@paul-moore.com>
References: <64a1045e4c018f135b78952c2c5ae3e9@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <64a1045e4c018f135b78952c2c5ae3e9@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240227
X-PR-Tracked-Commit-Id: 6d2fb472ea9ea27f765f10ba65ec73d30f6b7977
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf1182944c7cc9f1c21a8a44e0d29abe12527412
Message-Id: <170908215837.19908.9638725340592583135.pr-tracker-bot@kernel.org>
Date: Wed, 28 Feb 2024 01:02:38 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 Feb 2024 17:57:59 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240227

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf1182944c7cc9f1c21a8a44e0d29abe12527412

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

