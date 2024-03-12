Return-Path: <linux-kernel+bounces-99802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D6A878D84
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93DD1F223E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E925811C;
	Tue, 12 Mar 2024 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayO/a0+I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A718C1BDF4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214357; cv=none; b=JvGkZusqA+kAN7vJRA/6Monotusb6hlAIFGP9+FZgCb4ZfC8U/i7YXG+2pMM8y58tDzNff/TVjh449nUrH3kG01bs3Hr/FOkj6GnFSE2Tb3L9PTWSiaB3BlfcqqURmrNrcVPtIvkoCtPxCLkJJKCWQ4K0LEOU0nz4SRQihbHshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214357; c=relaxed/simple;
	bh=/uhNibETdkUaxffwwLhhROrqxZ7YpbHNZm+g6+9c4Lg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YRRHzqtCiskFUiW4ivHZ9xlJyrvCpHH/MwwEx5hred3gcUbHhZd7EII+Def+BPlbCC7JcvVE8ihWu9M7ClIQo0OT6mY2+0PXJ/B/menw5aGAcJHl5caVhhTB4UHZARsbZL3/Grg3UOVBFqTGKkx8xy4OFMHxwDJdEo9XO+Kxkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayO/a0+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A407C43399;
	Tue, 12 Mar 2024 03:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710214357;
	bh=/uhNibETdkUaxffwwLhhROrqxZ7YpbHNZm+g6+9c4Lg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ayO/a0+IIwiQDA6jOvoR7Bm6hn9O+LKrBq1nk4rFP3okg8m/TKt7vjLg1ObNdbCnv
	 3tlXD47ItqR9HV+QBJ5TihNOR/Xqc2pj6x1UqButytipgQ2HMxh2TljQzfSM1jH7c2
	 FeP1XOP1FxfU/e/Qf557+eza8rO3tgmUq4Ti/KHmqxwyw0LOAyutlfDQ9WgOSl4QV9
	 fAIiZfUT8dV6uBHBjttdtzJn/6Etw4RGG7WPdWCWo3C8tIc6zNFL8JWJNYa4f2cQl/
	 CVyvltbxc+xt4KaX2DA8FmTClqWMDY1BOV4p01YJDsB3my/lMWAG9rcUzfzwUj7GsI
	 hi4GJS9IwTbeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02A62C39563;
	Tue, 12 Mar 2024 03:32:37 +0000 (UTC)
Subject: Re: [GIT PULL] x86/tdx for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311173855.346357-1-dave.hansen@linux.intel.com>
References: <20240311173855.346357-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311173855.346357-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.9
X-PR-Tracked-Commit-Id: 5bdd181821b2c65b074cfad07d7c7d5d3cfe20bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 855684c7d938c2442f07eabc154e7532b4c1fbf9
Message-Id: <171021435700.8573.13230125205318216769.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 03:32:37 +0000
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 10:38:55 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/855684c7d938c2442f07eabc154e7532b4c1fbf9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

