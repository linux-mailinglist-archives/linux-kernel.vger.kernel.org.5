Return-Path: <linux-kernel+bounces-152545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAED8AC04D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7B61F21051
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE7B3F9E1;
	Sun, 21 Apr 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcmnhUQy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ADB3D963
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713721018; cv=none; b=b9UX8KqYILKReWVU+73jdUrDfiHqVsXqGCLy3Z9JXiXCAT26F73wy44VXJQr2zdawpGLICNsiIZIdxG2Iqf0vMdgKgW9BHYakM3rci2lsuF4lConkgYuvHM1OzEJ/2zodrittG9Iq/yhySofkRKEtrI0E2pFpdaCJaQ0HK8wm/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713721018; c=relaxed/simple;
	bh=/x1mmqoXfB5Sa/YDckHm5TeZfCDoIbpGDTDa01DGFIM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kkuyAMaIee2tbkrdkOkXZdHAdqSRRw8JZb0rlR6+Yor0xWcG3ezdHGsllt7eJz9gaqlRppv1w5P9O3uJxqL9ztdAAUF/Afl9WFa4MIXKR4wfNBnHuGUHrP7133nYg5rqRVbXX1HXSh8jj1aRgeXZoMVwuXkR7wAu37TbixKbwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcmnhUQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40B81C113CE;
	Sun, 21 Apr 2024 17:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713721018;
	bh=/x1mmqoXfB5Sa/YDckHm5TeZfCDoIbpGDTDa01DGFIM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TcmnhUQykN/srwaukRXW+ezj5tYiaHrnZFNupAf4zkS/rUigXXdncvhUhKxxKU53J
	 GdQLcGwmSgVWlriArYUqJy5j2leHx4gjfqWKZV3rsna1FbxdIJ7Pou6bRq1dNWy40i
	 a+Eb5egHRgMOHqPcdCSEmanKhmnOu7+Kbsd0FFwJtcXZyXtmicX8cr+RA2PPvh/84B
	 bCfcqpa50g6AzM5wjtBb4jW68lwuXqXtLER5w8E1j78HUEoMdu+eSiz6BzlVS0Y9cw
	 QKytVn+arQv81oDsdiTMarxSf26EAvyQhbR8mmRi/G4YfjIsU1pNcIXcTVbE5XhhOT
	 XnA7ydY8Nr1Ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36E39C433E9;
	Sun, 21 Apr 2024 17:36:58 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZiT6ZlO9fECvbipo@kroah.com>
References: <ZiT6ZlO9fECvbipo@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZiT6ZlO9fECvbipo@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.9-rc5
X-PR-Tracked-Commit-Id: 156539fd65019e8ed6b9fbac0583cf519cdbb227
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e90ba757b1bc4d6a787e85d0a079d1dbfa9608f
Message-Id: <171372101822.14492.2652891190294913338.pr-tracker-bot@kernel.org>
Date: Sun, 21 Apr 2024 17:36:58 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Saravana Kannan <saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Apr 2024 13:37:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e90ba757b1bc4d6a787e85d0a079d1dbfa9608f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

