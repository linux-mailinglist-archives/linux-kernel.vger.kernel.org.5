Return-Path: <linux-kernel+bounces-69990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6A085915D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5058B1C216B9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224D97E58A;
	Sat, 17 Feb 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG20CcuB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5575E7E0FC
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708191610; cv=none; b=RGRNO9gdfyOxTEh/7rQstyhVbNDCf3GVzX5muHKke0pQOHDDqSNsZF9aa2NqN6UoDMl62nCCKK0oidFWRgECSrE0UCoa8hyFI7Hr7aQoexd2U1kvYN2PuZ6/ma2xMH1Eo+AvmcCxwXcNPnExjA9ZfTnaviJwvhJT5TdbGfL808k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708191610; c=relaxed/simple;
	bh=7LWr+bZW3R5M/3IpRM2I2HJFInRc9eVxO+CHOxr5Nl4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PJWbCnFeM+qDuRQqj0JXJRx1pJkS7QXR4ZbnINanEZ1OI3QVgMAsn46ixzFtDPBzu6CEZzjrPVRqd3gxfqYw3qRM8wKDaRiABUSMiO2ijJvQqPEDvxuKHwyYwVnPGyuj5ff10r+ecJFOm2+cOljw7Nr64+Bru3+zMWKtyeaJfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG20CcuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BB34C43390;
	Sat, 17 Feb 2024 17:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708191610;
	bh=7LWr+bZW3R5M/3IpRM2I2HJFInRc9eVxO+CHOxr5Nl4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MG20CcuB19cS7Aenkn7WIUafR6wnmF5/zGUcocJGKcofXvvuB4rzkFdMT5iYBgZ2w
	 scaIxyvrTrnqZQMl3KuTSgG+vjCAUZPiThCJBoNYJbN2ePY+qDdYaNCMdYjmOtfCdW
	 kXKw0rh6dU8HM2j5dFkaeQx6S17NciGFEAXw7jcQic9q5vkObx40SXKVHs/nj0vjl8
	 j1B37uszJURhFR8BvjtdYkWh/PWnfwrRRIhCLm6j+UsGURtidmbw0hf906wt9pW49T
	 KMdyYRFcVwbsvFsr3Qhjgd6qfBIeXUOQOTj3ILSQECBdgNG1bkeSRHngvt9gbqSBHI
	 WQm3WQ/tVSagg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0534DD84BCE;
	Sat, 17 Feb 2024 17:40:10 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZdDNXWXBNNY5lc4B@kroah.com>
References: <ZdDNXWXBNNY5lc4B@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZdDNXWXBNNY5lc4B@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.8-rc5
X-PR-Tracked-Commit-Id: e20f378d993b1034eebe3ae78e67f3ed10e75356
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7efc0eb8250845916a157580a42e23fe1914b738
Message-Id: <170819161001.11002.6186812472300002117.pr-tracker-bot@kernel.org>
Date: Sat, 17 Feb 2024 17:40:10 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 17 Feb 2024 16:14:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7efc0eb8250845916a157580a42e23fe1914b738

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

