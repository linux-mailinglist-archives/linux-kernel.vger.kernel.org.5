Return-Path: <linux-kernel+bounces-133733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E4689A7DB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D6F1C2188F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEECE1171C;
	Sat,  6 Apr 2024 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvWqmKsD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC55E3C00;
	Sat,  6 Apr 2024 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362200; cv=none; b=Qa1wFJ1q9BtdLQVutLJEjQCg1wcqalu/CP75mjafLBgwbCq8hWeHq7SmL/Kt4g/IUFksaNM6DfGvK6rqASevjhCvjwqShzaGx3tz7zLYG1AxRVogemEEGMcSu5pHUsHPzW3WN/xr10/hqIwGlj70mK7QwZGs/wgEM9HKUQgrWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362200; c=relaxed/simple;
	bh=Nb2+B+acJncpp4EjQitV6HHDapj0g3OMSXh6FMxidsU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CZZ0S1xq8b0bywxyfxbpaF+wvTgr4RGPaenl4wBf0w9+7XnTRjzRxa3kReLlEOkTwOFZ/nZr0Zp3JjFmR0yX/rgM6oQVoG095fZl0mzPfahDV26CpRwQvTnuKEPLKzeUYK8Ij0J7lrRO047HDirNtRHcIJw49CXJhzsYA3lT6Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvWqmKsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD406C433C7;
	Sat,  6 Apr 2024 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712362199;
	bh=Nb2+B+acJncpp4EjQitV6HHDapj0g3OMSXh6FMxidsU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JvWqmKsDTubwKF0dBYyhkU0Vr/1aOjb0xR/YlgFipuK0IAuZtK5hxJFWZx8n8OS8H
	 h/H6KsV2UHB1O2t2h9I/2mplMxp2sc+3vZhOjndCvFqvJCA3TRRL5Ba4owAcjYzAzO
	 0Rvy8OcOr5/4husU1Hx83qaoEKEQUUygwpRJxwtmXqwHvQ+BSDofMfHc+Wh44qYp9B
	 +PsZOxfbOyYZAigihgVexo0hACJgbYwaen1e+yx6ouSDXSnK05ExKZ39DxRJA1ryG8
	 oK0tIQGOiTp8KMfbPmn2Vw4w7YLJgk4Jo4WXe5Wid60TqfXRrYKWoEqHFjhojURuNF
	 kVOgAOhBBeOvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C461FD8A100;
	Sat,  6 Apr 2024 00:09:59 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <fa81207eef6f94b71de19640dec34fe6199c90d3.camel@HansenPartnership.com>
References: <fa81207eef6f94b71de19640dec34fe6199c90d3.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <fa81207eef6f94b71de19640dec34fe6199c90d3.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 2a26a11e9c258b14be6fd98f8a85f20ac1fff66e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4de2ff261f535f2ed6ef56d4acf5f888ed8b95bc
Message-Id: <171236219979.3482.7216334853638864237.pr-tracker-bot@kernel.org>
Date: Sat, 06 Apr 2024 00:09:59 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Apr 2024 16:46:42 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4de2ff261f535f2ed6ef56d4acf5f888ed8b95bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

