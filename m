Return-Path: <linux-kernel+bounces-104886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9DE87D508
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF251F21A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E935491B;
	Fri, 15 Mar 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzHsDxce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7FC54904;
	Fri, 15 Mar 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535055; cv=none; b=uMji0hRjKnF7OKBnWYVS/VXhHIn5T5C8+2Htz2J14Jop9OUWZ6+jQR4rvyDEbEBGBJgQNKZzLYZM45OvV7E6GdqYfiXlcY5IYoIzVdGvVPpv626DcjXk/CWWbszWzTbmbZu4WKFRz5Mn/BY0t2/MK2Td6FO+sKi//raDWowxyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535055; c=relaxed/simple;
	bh=SJLJCTt7jLUTjOsk+Hhh1Qz3B3qBQz5/ebudg4iZy+M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kijKyqFFi5gPAMosmRoN/34JO4jkEMEkezBk+16je5Dqd9iE/wabgTdaf+HSGOHbZJ5nfGnQdCVE40F1un4W/AeF5s6r/GwJIShXuCPiQ6AIFwTyDJ5UfN7g6UkAzFyg075PTkhx6mamZh2FMr22f0jeoClMKo95nlCbUZ4z7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzHsDxce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E70A0C433F1;
	Fri, 15 Mar 2024 20:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535055;
	bh=SJLJCTt7jLUTjOsk+Hhh1Qz3B3qBQz5/ebudg4iZy+M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FzHsDxce0UdwXS0HmLPGdfk1X8xcEjwO0eLJJ0x6oNG89O18iI7M9nDZ4fl+nG0V0
	 0hEBvkosy7bwVoSH9dtfisLW4dWxb9Qc4Go7WRZPs4RpEwDDp3qhcPAptcietI+5HG
	 WVomya1cvyRBFH96qILqsBHurszsyTrD2xrsYJlLIAIQ/nqnFhSYf4yfNOHh9GLXpP
	 EetrpT+pYKWGMDx3xuUCUmkIZ4A4MpPJHzQI+SK8t8Da6HlBO8TgMb3Toazpab2Eia
	 jzEOzNYYiF+cHvbcYwOZPXrTLE2iDQtDCg02u/FQdhhGNIi6cQ7F7s75KdTRhrGj2S
	 PJOMHC+Zd17tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0EF8D95053;
	Fri, 15 Mar 2024 20:37:34 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240314194324.2487618-1-sboyd@kernel.org>
References: <20240314194324.2487618-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240314194324.2487618-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 3066c521be9db14964d78c6c431c97a424468ded
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6dff52b828655ccf416f46c08a48679740b724f0
Message-Id: <171053505491.29375.8756254380991307194.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 20:37:34 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Mar 2024 12:43:22 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6dff52b828655ccf416f46c08a48679740b724f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

