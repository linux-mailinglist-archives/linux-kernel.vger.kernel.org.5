Return-Path: <linux-kernel+bounces-33890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4146837090
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37BFDB35B22
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF9054FA7;
	Mon, 22 Jan 2024 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOxdzxnO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E5854BC2;
	Mon, 22 Jan 2024 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946564; cv=none; b=EsF7z+W76Q8GAUpOw/XBqouDXIHiBh+W/miOev/5BkY5ySNdbdmHJJPVAZ6Z2WS3fU94a74+Rt97wBrP1t+Rj8ypIUMm+OoLPw74AwGZwtjd0E9w/Wm/PWEpBk7jM3atedy3EH/MMhivCV9eUjbXbpfzvSmA6WFX99Ls2s5Cie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946564; c=relaxed/simple;
	bh=Sv1GTY30PBaA51sk6WavNXRM1IuqO2ZM9cimrH4GKto=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ACzIFip6Vkxw/Z8l6JaSF/H8oi0mDnqROz0AUWDYWv7a2fBZ7RmEIPJmHp0Esr1N4DvWvaVkCQq+2EhG/D/4/ax8IV2Es5DsrmpvU09yJp606ldOZF/Php4u8S2jLQe0yDZQ4QPyxmMPKb8Xg+6ezwOdcZKw+B1UpyxUQeNz3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOxdzxnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FE92C43390;
	Mon, 22 Jan 2024 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705946564;
	bh=Sv1GTY30PBaA51sk6WavNXRM1IuqO2ZM9cimrH4GKto=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AOxdzxnOKfB3Facn0XDHbJggxnro1/4wYUIrPfz2ZXVN8QmQ0jAClTS08hvheX54Z
	 WQKLijPqLbxxsy8Ybl50vj0qfBsgy476Un5f0P+S16D+JAtgWkqU5NTZEZf/LEuC26
	 DEM7AQnbyQT6FUsq3OZmvh8/q9OhavnKn7fZYxfBvEM6YoV+stBjiZdl7pfu13X6Wo
	 whuX4eUltHZJoetuTAYw5tMjCfIA6+0ef5M96jBsRupl5HgItIHvGO+P6myJaj7yEB
	 0DkmMHxd7CrvYvEAhtMZOXqsD/TZzOrg7Ppd478zD0VMWITaq7uUqjVoFwnRIYrA7C
	 3arQlNxhUVhNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18E58E0B616;
	Mon, 22 Jan 2024 18:02:44 +0000 (UTC)
Subject: Re: [GIT PULL] Enable -Wstringop-overflow globally
From: pr-tracker-bot@kernel.org
In-Reply-To: <Za6JwRpknVIlfhPF@work>
References: <Za6JwRpknVIlfhPF@work>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Za6JwRpknVIlfhPF@work>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wstringop-overflow-for-6.8-rc2
X-PR-Tracked-Commit-Id: a5e0ace04fbf56c1794b1a2fa7a93672753b3fc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 610347effc2ecb5ededf5037e82240b151f883ab
Message-Id: <170594656409.6833.7683463320991212076.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jan 2024 18:02:44 +0000
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jan 2024 09:29:05 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wstringop-overflow-for-6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/610347effc2ecb5ededf5037e82240b151f883ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

