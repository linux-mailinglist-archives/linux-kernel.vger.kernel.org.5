Return-Path: <linux-kernel+bounces-29569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4229E831051
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EBF1C222A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A3420FB;
	Thu, 18 Jan 2024 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c676TbJZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E380A41
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536309; cv=none; b=m6bUkwSUIMAPaYEXAjla0sVJhJ8ojASVVl4UhlAEx/7xPs1aEm2FKY3YmQhyF3SmNaIQAW/+mYx/FdT7Fr6+c2+QH2uHonE3S6LUPtOM63qx8b/MuBKBi1xZeNEpyhZwSH8YUid+FokWqpQ/2jyeoI7u6Xi0dybqYnNngZPuutY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536309; c=relaxed/simple;
	bh=nS6mr+7hJrrmsamX7BzZtPzjONB/yIBaa2JaZcL7Zmw=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=hCYtdRq1CxkJpFGx4sqA6zp05cdMEPbqlmayAQ0sWff1mjTNU32NK5TqcZyKVkC5iFkxtv1TK5fnx/0k6wnv8BR0V4pYmpIlBKHDAc9VMkgvNFOWwsOnJ9caSDPkczJiUdhSAs7ZHFy0Gwtw8wPuW6HIAp23alESjMyM8VLENHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c676TbJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71B40C43390;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705536309;
	bh=nS6mr+7hJrrmsamX7BzZtPzjONB/yIBaa2JaZcL7Zmw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c676TbJZIIy5aau4jc+Oq4qLHAinns+DWnoPCuH4UvXDVIMoknCD74S2BHKvEECV1
	 4ihHGOIokXxiErY7nEe2v+Wf+h+o+1MKk6vD9ZFH1LYAr9PubilC2kUrzL+M9Iw90y
	 JrW+UbmOOiLvGGvHMOk3eZEAVDeLCzke7+JBdqYeytyBIUtCgdzPwOqhri+0++9uvy
	 sxvmPwk+fawb97e7K1eyTqVjmTSkxWmGYAAaIolRy2PNAJyKnyVhw23YD0ISK+fyRL
	 EWvenijB8MtE7KqPRrv2cBe9jVTbxPyeCU8NQHAuwaTwiSmkYzLpAerIJc90lqATvC
	 SExVIdCpihuGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E961D8C97F;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx+5WuM8CjN5ACN1e4Wrr+qNhMSWQe1_g-QDiPbEpPbbg@mail.gmail.com>
References: <CAPM=9tx+5WuM8CjN5ACN1e4Wrr+qNhMSWQe1_g-QDiPbEpPbbg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx+5WuM8CjN5ACN1e4Wrr+qNhMSWQe1_g-QDiPbEpPbbg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2024-01-15-1
X-PR-Tracked-Commit-Id: 205e18c13545ab43cc4fe4930732b4feef551198
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8893a6bfff312ea6fee89bfaa8761f0b9456199b
Message-Id: <170553630938.10877.4890122680633334583.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 00:05:09 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jan 2024 16:18:01 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2024-01-15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8893a6bfff312ea6fee89bfaa8761f0b9456199b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

