Return-Path: <linux-kernel+bounces-30673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F377D8322DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902241F22D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205124A0A;
	Fri, 19 Jan 2024 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICnVjQwR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C4EC2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626526; cv=none; b=F6IxFwKAnOTilBU1DkcKTJgIWTWcQhkOtC9kssFNWU4YJ5CJOVugtYHAZo21a475Bt6KSihUjYLQTFwAjKAwONj1eG3rTSM0/Bw+p9PcBeB+d4fBQVbjo+1ch52meuWeNRR3zNm7rcJrOT+Wikz/kqNJSgdw+iTxhvZvbTV2hsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626526; c=relaxed/simple;
	bh=R9oV/ApzEW+tx+UFjUw1T8ZMV99hzFzci49Gmc53Wj0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nfRwX7n2e4SuJCBAJHXm5xPJlsAiNPkhMtJa7nDpdVeo0TCq0paGAPwzqr/2ZcTkkuXQv9xF7dTrd2HOK4IqUm3IIyfiXijCQkLoDIRwTb3uGHztQmAk0sh7fH6G1h7zzW/Tp5/iHi48C7kBCVYSojNMOY5dz1prLBR5L4nHGAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICnVjQwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38F19C43390;
	Fri, 19 Jan 2024 01:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705626526;
	bh=R9oV/ApzEW+tx+UFjUw1T8ZMV99hzFzci49Gmc53Wj0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ICnVjQwRyNTV/Je+78KmUIwj+pUcbAw7b6jH3WTMUIjHq8+9vDGMwMfGzqWTBgLCT
	 Bl+CfbOVb8jRn0pD1HozAHihzdt+/1nTld3rqmZQK9qh2MuYutDtw7sstZHTNFOKex
	 Nda8F7qr7cjxwrPWV4SXZAc1eP38oKLj0sIhKp89SuBvKa106CJJ27uS06s51WoNgD
	 TibfWAJV1qz+7xNpoc/qchyt+2TSmpirsQvnP6M+TBKSokY4R1z+8aTVlsDxLwHTFw
	 qvxOgEfRnHs0+Gs2wbx4iXDTE2KAMRw0xqyeYGQPZ0bITZe5OWH1PB73uzTzjhh8aB
	 7FVIyLvfEDvJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20BF3D8C970;
	Fri, 19 Jan 2024 01:08:46 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240116164248.GL1920897@google.com>
References: <20240116164248.GL1920897@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240116164248.GL1920897@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.8
X-PR-Tracked-Commit-Id: 7d84a63a39b78443d09f2b4edf7ecb1d586379b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21c91bb9367716f61f46a352aafdeda61cb91c73
Message-Id: <170562652612.16604.9798354395320681504.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 01:08:46 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Lee Jones <lee@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jan 2024 16:42:48 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21c91bb9367716f61f46a352aafdeda61cb91c73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

