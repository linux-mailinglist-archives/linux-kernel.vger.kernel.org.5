Return-Path: <linux-kernel+bounces-30617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21879832216
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D9F1F2195B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250FF32187;
	Thu, 18 Jan 2024 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFiBuzd0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8522942B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618911; cv=none; b=DTg1/gm/fShRPvQKalCc8LrWhGeGGEeSzriCyX8KYRn5k9iRCqKqi60NasQKw7e2FMnq2HiY8/KV6tEou5oF06dhqa9nnXzGAmZw9MmQ69pjuzWE7lQ6+w+aQeNk7VSk5EwL929rBHOQ6SaanocFeeEjTYc165ArS4pmcCeKEKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618911; c=relaxed/simple;
	bh=W2cuhAcpU+niULJ3Lgiut5zOksaXIFhPGwLB2FRipwY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jWIFQmqNfXwb+xg9sZLttXGII07y32dbwsMWRuzsmRoUuoeLpEOX60UmLsak3B7bupSbH497GkgMUhOz+lkwYa6XtOH/NFRDmxiL/Ufp6zl4yFIZ1Crhvdjn6HTj71f7Xb9ZzhxEIBqYUKkkQK+vcJiiZsMUITOd6uR4CtPZYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFiBuzd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 426FBC43390;
	Thu, 18 Jan 2024 23:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705618911;
	bh=W2cuhAcpU+niULJ3Lgiut5zOksaXIFhPGwLB2FRipwY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fFiBuzd0ozOmDfqSQs1jpgooPmc+y1bKdrb6Izz9lHoAirNEPvZS/KrwoqtK5adOv
	 FNRAc6Hzm6yhnIdtvdaYWJEQGVSUr702dpKLJGdPa1XgwH/u6mr2mzgi4qtDKD/K3w
	 eFpo/I28vnm7HaH+ArKNSIP4IMuhkLShUzbiOkclu3QjpSb1QMetNKfHLsdL6M10Ko
	 5BLc8VKKfg5uV73/Vy4JofcmQ4bbdRQbvDOLkEe8pOlqvK/MBWH+XiHM5dGRBbHjgc
	 fo3bOGjfUNxvZvdDWLvpyqcvR4GDv62k6DmWM/xtrIPKhHjvU7V4zUew0iHBvuzc61
	 uN/WuiJRs09YA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AE1CDFC697;
	Thu, 18 Jan 2024 23:01:51 +0000 (UTC)
Subject: Re: [GIT PULL] x86/tdx for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240110211822.3014608-1-dave.hansen@linux.intel.com>
References: <20240110211822.3014608-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240110211822.3014608-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.8
X-PR-Tracked-Commit-Id: 83e1bdc94f32dcf52dfcd2025acc7a2b9376b1e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4442cadca2f97239c8b80f64af7937897b867b1
Message-Id: <170561891117.14039.16322884724821440005.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 23:01:51 +0000
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 13:18:22 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4442cadca2f97239c8b80f64af7937897b867b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

