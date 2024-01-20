Return-Path: <linux-kernel+bounces-31936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CF9833702
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 00:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E50283386
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 23:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B64B14F60;
	Sat, 20 Jan 2024 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM50pSYx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D015D0
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705792138; cv=none; b=GFEXTLsYMl9RH7z3pLolQqVNW68ScugzRrldVsgXXtvKOf0TmCMBPFgoZdQ/xuzDavpftg6UqvloKvT0HIB6LJQq9QPvklMtugQc+dWOoBgUWFgQ7rHU5qlDLdKM/YC73bSlLrk9EbE9FPU2zG1EuMyEcmBBAR+oGGsWke7nb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705792138; c=relaxed/simple;
	bh=Vk6RXv1lK3MsKSy2HoqNw9yfT0EYnlTUWQojqIr7e6M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tyEswdmirhW5G2a/WBREjeyw8Qnot12VsNZDuYHIXlBRXaTHMdVEwcxArUQtgKSCQX4rEdJ4OGlpOjH+z++U3WDuJso0be9mxdCi1TJHpBRh4A3S83VB/JXGZXgkZA2KvGrw2q7MAd4lUuiCvrZzLsBx1z4nDPWbS608l9mvbDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM50pSYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A58D1C433F1;
	Sat, 20 Jan 2024 23:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705792138;
	bh=Vk6RXv1lK3MsKSy2HoqNw9yfT0EYnlTUWQojqIr7e6M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QM50pSYxUPAvt+XYSdR5Wpt/YWp8/z+7T9fVR5RwtEyOMl68yHynglR1NY00mjPBs
	 GV4Kv0GtNMD7Fl7fU53rsqEQs8SWw3sccCqLr/cHDInjtnf+XZSYO2cZaAbE18Qgoz
	 Qk4QQ+xsL9iM9VHJFu+00GOeGumbOJBsDJG0dkk37vRoCtHLWhABq8zM7R+MOBcKBt
	 xViklCp04bEQCUyjmKdc9qwdDq8IdeAx7li3Kv5fdpn72AMx5HtE6PlTBoWrEVhpxW
	 6JYA4QrzzI/eLuFkELuqgFx23oP20Q7ZAVK0WzLaSMCydTqHq+Xtp6uvLrgIkhmCKf
	 zhZ9dKUS3GFVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CDD7D8C970;
	Sat, 20 Jan 2024 23:08:58 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZalezMgxAVyu5WEE@matsya>
References: <ZalezMgxAVyu5WEE@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZalezMgxAVyu5WEE@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.8-rc1
X-PR-Tracked-Commit-Id: 3d0b2176e04261ab4ac095ff2a17db077fc1e46d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b93216d3be55924c43e097c1fbb21bbe1a5a5d5c
Message-Id: <170579213856.25914.4528518701101562413.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jan 2024 23:08:58 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 22:54:28 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b93216d3be55924c43e097c1fbb21bbe1a5a5d5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

