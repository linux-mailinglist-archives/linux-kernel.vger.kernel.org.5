Return-Path: <linux-kernel+bounces-141507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B268A1F28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16311C238BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E324B15E8C;
	Thu, 11 Apr 2024 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9A2DiaL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3153B13ADC;
	Thu, 11 Apr 2024 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862558; cv=none; b=Msfbpi0nUdejmMV13kB/E97ebweIqqpLGigJ36WZp9gXp22drLUfWhyyDji7NvR3SHSYdLo38WBJLt+IDhw12FAPRZ70waptt9AXpVhXCoG9rG229Gq7L0u5zZOpYViYcvB8ixeFIy/V+Ld6dZkj2/RI2pc8BlPqVvTgQgKeGXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862558; c=relaxed/simple;
	bh=LrXE02eamDRyO7UncN7D46NXNgZeJgGcSHqAjOZXu2A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=grOcjnNDM6Ox6fmLJQYjnQmdrauTOdEGNtzsstOjajHDyjxc687/EsP2xbGMdUF0AR2J47APQ9dZB3jKGIGmskr9QCite6X/bRmTrW1HySLKVZMeIiRv/wZsfL7rkaXWngcL7sz0RbyRgAayccoF6CO1DdUqVkv9EJET4vXbjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9A2DiaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1606FC113CE;
	Thu, 11 Apr 2024 19:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712862558;
	bh=LrXE02eamDRyO7UncN7D46NXNgZeJgGcSHqAjOZXu2A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A9A2DiaL8SnuC69L1rKyyHNjxn8aUxSng9VdsJSa+bxwzNHoSHZyK6Sac1lYnzeR6
	 UNhqZwvpo93JGCZA/GHh8q3QNdXY3Q7q1OPJRtRIEjCCJZZQ1VK0kq8XVQ0vxq0wrb
	 6p4eqgZHFrdpSOIgYS8c9ilNuW8ygCflcV7DmlyLEmAkNXF9ZD2esWvcH0kZVXeRxs
	 V7i4kbtFaha0IIg1laqd9BL4LJtnzlV8m+AAjweU4gLWRB8gCiwNl6FpjmYIkTvqKj
	 fOIkB68BsPQLhXU8YqcpUr5sWyg27KLrUqYkh9ESeNJF61AQw2/68kMdpD27YHVBFI
	 30hPAsqTVPFpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2335C433F2;
	Thu, 11 Apr 2024 19:09:17 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hCwmi=c_HC26APBEayNjzP4zepy9dMTypYz_Nh6fYk0w@mail.gmail.com>
References: <CAJZ5v0hCwmi=c_HC26APBEayNjzP4zepy9dMTypYz_Nh6fYk0w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hCwmi=c_HC26APBEayNjzP4zepy9dMTypYz_Nh6fYk0w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.9-rc4
X-PR-Tracked-Commit-Id: 3c89a068bfd0698a5478f4cf39493595ef757d5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 136eb5fd6a5d4e87f5c64a721b48b8a5da5351f3
Message-Id: <171286255798.2172.10476145499326377227.pr-tracker-bot@kernel.org>
Date: Thu, 11 Apr 2024 19:09:17 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Apr 2024 20:05:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/136eb5fd6a5d4e87f5c64a721b48b8a5da5351f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

