Return-Path: <linux-kernel+bounces-29523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE082830F96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCED1F25DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B0C28DAD;
	Wed, 17 Jan 2024 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuTNv6Ib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D19288CE;
	Wed, 17 Jan 2024 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532295; cv=none; b=dhIrUOdocjbXsQDzewj0PpOzds553V3GEUdImgdnUsM+tbEZP2PrkJMVJ0Jin0413hA/6KL7lJTKzQVNDn+sP3MtuqT59SlMabe/1trYKjQFfrX7wavwzTA3FghTfMN81orGgdUCK/LmInEo/roZKAm3w2UoIOFt0vVskhu8lKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532295; c=relaxed/simple;
	bh=hmqTcgq8aZjWJYiIOYvlDr7nZZQc5P83VIlhQ7uZLqU=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=WXdBSSvSjllXRuYc0SVBRY6YrXv5tJ1OxC8MrFOBfikWwRXwJmX1X1QSMVcXPfXRfdzhYBip6Ch2nf6DvjtF9WP/hMJWT8awNqSebJkZ/2YOydWTvLqX6O8Jr67iiJ+J5bp8wxhPPxG7dBQ0gPR0nGlau+GTHnvwxQALfApvuKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuTNv6Ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D47DC433F1;
	Wed, 17 Jan 2024 22:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705532295;
	bh=hmqTcgq8aZjWJYiIOYvlDr7nZZQc5P83VIlhQ7uZLqU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kuTNv6IbuQ0CK4x8pQV4cnhciy+wTz7yxxX0InkpP3IV1FcdbfFHOjjfQcwWZ9DnC
	 dZgnlIrpmU2hbJFV6Nk7v2z21+qWo+Ir+CBSDa7OE9cfQvLeF2i8gEi5bl+qjeLxAU
	 g17gvWiEexMGV7mnbY9bROC4X8HvR5xiiKH6sXP0JKVbScOXuz8stE77Kjaqb/OfhA
	 e9D4Gc6I7PfMDr/C0yXfce9HsgB5ClHHEGG1V4eC0bcuCOTEd9xuC2o9CKuKtemJqx
	 eFu40Fy5glBXed05TZL6SrMfyEaBnjf+5zGehwr5/mti/y5Gab2MEJ38M4jcZw1mwG
	 3Jm2hHVuT7Ilg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57C21D8C978;
	Wed, 17 Jan 2024 22:58:15 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hSZRrS7+aeqCJek5APiObgo3BW04cS0Circreb0JpJTA@mail.gmail.com>
References: <CAJZ5v0hSZRrS7+aeqCJek5APiObgo3BW04cS0Circreb0JpJTA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hSZRrS7+aeqCJek5APiObgo3BW04cS0Circreb0JpJTA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.8-rc1-2
X-PR-Tracked-Commit-Id: 9223614ea760a77873c7061875cb91963e6f79b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b5bcf9b842087ba38cb6292637910f384368cff
Message-Id: <170553229535.5987.879461625112514065.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 22:58:15 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jan 2024 13:08:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.8-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b5bcf9b842087ba38cb6292637910f384368cff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

