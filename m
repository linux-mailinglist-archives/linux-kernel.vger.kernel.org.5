Return-Path: <linux-kernel+bounces-59832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A3E84FC3F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B37A289291
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8486AC1;
	Fri,  9 Feb 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byUEMia4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4023284A43;
	Fri,  9 Feb 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504383; cv=none; b=roAHvKP6mOQ3FXeRn8o0w1th205uOD0P8j/G9UhhsvxJU5Ban1rDFY1Z8p4wDO4EeFo2x83WDILbYPccu8+80hZSKvoU1i3/CYuVYYCAsM4npyqmP1TUnn6GzzxxiCTj0pEv4DwX9j8Sngsl036gblSrAoEGy/rLmXf5GiPbNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504383; c=relaxed/simple;
	bh=CU1FbzJp8Gdt4/dbUgCCbnNWiK69iRgtHHmrGbDjoBw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o1si/AU6R4hg+ph1dFuQvZU9V7MBHvfqZdLCADsVEQ8GtrHhw61AeclLcO7eYu4GxS5zNmiAvK7//g8N/9HPP7n4JA9219pz73gZ3jDBrUW36rVxt7TQ+/XVN8OGe7nFQZBUgRIpIMJnZkw9JeetKKyFd0bBBP6zc/Vx/sppdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byUEMia4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 185B8C433C7;
	Fri,  9 Feb 2024 18:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707504383;
	bh=CU1FbzJp8Gdt4/dbUgCCbnNWiK69iRgtHHmrGbDjoBw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=byUEMia4rF22uPUMtLq0fjADivp8gwYe6HbgxsGjApcky5F5wICXtfSv+PwTNuYVO
	 F0mF3Sp+qtLHQoCaR1ykXgKlDvEbzcUTkxzQBS2dzfZ6uh6XW0PjNM2jo8ny3uRY/X
	 F7Tgi7T8taSdgoNxmYZicRGy1YrXEDYJ2h+GjwQN5R1yHyp5OEm08mZoDX/qkubkhX
	 lL0jWqaHqMUaQKnNb5iJJoZ5DgC/838Mqn/vDUmwzTv2myK/iyGd9Lm2bbSl1m8AjI
	 GsBiXQvAa1p080POSrRUyHs52V47eAFF3d7GzSiFpsxMRiuZVfgmbDvDfOXNLMdhZq
	 swAFpUJ6uPMYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01B0CE2F312;
	Fri,  9 Feb 2024 18:46:23 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240209150423.1339290-1-linux@roeck-us.net>
References: <20240209150423.1339290-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240209150423.1339290-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8-rc4
X-PR-Tracked-Commit-Id: 34cf8c657cf0365791cdc658ddbca9cc907726ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ca243c23ee122ed983a2af3d454a4b58677d2f5
Message-Id: <170750438300.872.15951413663282480849.pr-tracker-bot@kernel.org>
Date: Fri, 09 Feb 2024 18:46:23 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  9 Feb 2024 07:04:23 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ca243c23ee122ed983a2af3d454a4b58677d2f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

