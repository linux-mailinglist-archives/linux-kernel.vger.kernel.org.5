Return-Path: <linux-kernel+bounces-29389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B87830DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621501C241CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1645824B20;
	Wed, 17 Jan 2024 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm8leWN1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EF324A0E;
	Wed, 17 Jan 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521818; cv=none; b=e6N5gb6pHG0bCQoEzafNwKMNyujkmOyuXVbjjzrtTBVLtP/U06QWpI36A034tAyf1DYJZ5ldX1+AAiMWSAEiMfVDtuO8zLDX0Mwt+Zz+IjjuKWwLWP/Mx1X4z7iUMt3by0vQOlhZcXGPi+ucSX61kshTpn5UIMPHzqf5maLJIoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521818; c=relaxed/simple;
	bh=4P8RX2t/zSULhuHoA92glZJQ8bY6hHyB/tlyZMbK11k=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=LeasQl5mrmtdsyIfPh+Y380HkZdH3ZMb9qDe7WEDIht+49184yl6kQsTv+6aIYhonFJEP/VAblg7FQE168XX6To503eyrFBCtLFd4/EwIoVkaL8OznnZm2aXQ3Wo70YQ0olfyrMZYFT4Y8eAamDw4MtT3LYJL0zLw4hg7W+8BH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm8leWN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DE48C433F1;
	Wed, 17 Jan 2024 20:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521818;
	bh=4P8RX2t/zSULhuHoA92glZJQ8bY6hHyB/tlyZMbK11k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Wm8leWN1cUpX1S/9SBcwg3oEdvvSpcx/AxktLJd0U/ovMUzKZmIKBKyAZ0uiL58qW
	 3KVzWLKIcSkHfqD7s+6iDhb8vLc+CIqkJSmJ1x6NYtU60VNopxnbTjE+FrG4xMBtDQ
	 8moa73s7csJy9yOqCxt5ufadzGPReXf+RA4inajgM2h9nMJB1BLENGz7qLk0eHahZa
	 WGwH3vXPK78J9DtU7WMwMhTCvVL61ntRDAgoX3hLslo+mkHiFO71QVUVATgneNrN4q
	 xw+YlaM0oOXNVQZrIs7aSfsyViJHI/ljIYG02qqmSwKaQbSYn7KW+GpRdwIMXB3bQQ
	 fvdUEl/oNjC2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D7C2D8C97B;
	Wed, 17 Jan 2024 20:03:38 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240112165917.67505f1509909230808c06e3@linux-foundation.org>
References: <20240112165917.67505f1509909230808c06e3@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20240112165917.67505f1509909230808c06e3@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-01-12-16-52
X-PR-Tracked-Commit-Id: 5d4747a6cc8e78ce74742d557fc9b7697fcacc95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f5e47f785140c2d7948bee6fc387f939f68dbb8
Message-Id: <170552181811.2985.15229324844308199993.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 20:03:38 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jan 2024 16:59:17 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-01-12-16-52

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f5e47f785140c2d7948bee6fc387f939f68dbb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

