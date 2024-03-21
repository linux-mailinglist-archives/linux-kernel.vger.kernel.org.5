Return-Path: <linux-kernel+bounces-110757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767FB886343
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164511F2159B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7C5137744;
	Thu, 21 Mar 2024 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8+DLbiH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6BC136994
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059922; cv=none; b=nl0ATT/YBytbywf1c4Ix4ggOROTMu6PGojsULVfMgeLZlKxYkNJoieTWLThcDeA61yn9lc9Xfj3/Uk93LrnRjFnNFjpKto3Y4FXU6uzsCwgwt5mT04DQgNgFXYjSYLpymA0z3oswdAtt75tXukXGS7Z04SmByFSgXORdv1zTPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059922; c=relaxed/simple;
	bh=rcAjNYwqFOzSWc9d/RfV69MeDdI10escRwDbYudoLqc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WGEUGXsXB6HpdXUi9QhR07Dv1dzpyXb3/i8f0Zc4+0wbN9Uzk0d3RnyEB534wEda/9OJ1pl248EIYr9TfPQNRb03hEGeauowXvbPuVYqn+gBiDL0vGS5Pij4I97XGZrFpRSQwtRpF8AFP1hzTYOj3ENc7dhYnY9sPIipFytnRbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8+DLbiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 695A0C43390;
	Thu, 21 Mar 2024 22:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711059922;
	bh=rcAjNYwqFOzSWc9d/RfV69MeDdI10escRwDbYudoLqc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c8+DLbiHStkUgjOuiaiv/A+wukF7u7bFdHU6A3GFhpSRnRsPP0v0FgY/P7tjkH2jw
	 AHUcvtJUaLYhhykvwI0chIZGmV5TiQDJ4HVvKlSU1VJFSjsrL5ejn4lyqQ5nJA8o2M
	 a2TWMwErGF9qoRwIj6HNXxaqfolOdhDKU2/U/6cjuyC5oZyIVt9UEIJ5XH0c28xfL+
	 N8YU46LXn+aexHsghy+wlG5helk5ZB93kwhbdwKilxUxCi4+TtNTkrlab8jt2riLL0
	 w/bBGPuSTPvuAdSIqoqAze6nkg03g+xhmGX05kuwCnqnDGUPyclz0OsgatvH3Lhqfg
	 9G6lvtL8Z4xiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FDBDD95060;
	Thu, 21 Mar 2024 22:25:22 +0000 (UTC)
Subject: Re: [GIT PULL] siox: Changes for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <7elhkk6kzp7dnx47j5dwmljgzoeefey27qecvkyp7y76jxc4th@k44dxrl3x6fp>
References: <7elhkk6kzp7dnx47j5dwmljgzoeefey27qecvkyp7y76jxc4th@k44dxrl3x6fp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7elhkk6kzp7dnx47j5dwmljgzoeefey27qecvkyp7y76jxc4th@k44dxrl3x6fp>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/siox/for-6.9-rc1
X-PR-Tracked-Commit-Id: db418d5f1ca5b7bafc8eaa9393ea18a7901bb0ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00453419575d6b4f5ce0f370da9421cf5253f103
Message-Id: <171105992238.29795.15998865502186969901.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 22:25:22 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Thorsten Scherer <t.scherer@eckelmann.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 22:33:07 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/siox/for-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00453419575d6b4f5ce0f370da9421cf5253f103

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

