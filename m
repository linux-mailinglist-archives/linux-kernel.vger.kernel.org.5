Return-Path: <linux-kernel+bounces-103919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D7A87C690
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79881F21E61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736DC11CBD;
	Thu, 14 Mar 2024 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S36irffs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8399DDB7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710459986; cv=none; b=a0mpnaRYkXMPFIAWqU+L3mRLd6e9AemWvFN9vnB0vBNPg6U1vJDnF26Kd/VUSGyvkONGN/aR/kTbc/YvBZ6kiWaNbGn3sfepaFqc/JxeuXFaBr/Bbom8R1vTsZM6YNbzDmG3zRO5uNLEqtzWEzCYyeLRGO+5KsOnirFYCkt2KcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710459986; c=relaxed/simple;
	bh=iOxmpL/Y81Ei1VULk8keIpePCzz+oTywINRcdwwL+Lg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bpCqRdgeOXcUyOcakKKTirQBiZk0hlxAP/8214EKV67hgiLyf+O7Q+xiy5Le7AiDZKJZZnF8iDb1f4+RAvMwQMka/oz9DuIZ3Refl+25rhVqKkUhhv2XnNb0Fk3OyBcP6rEiCgYBrm5d4b6tDS2csjwh5UYS3x/xhYWM0s3zL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S36irffs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90E0DC433C7;
	Thu, 14 Mar 2024 23:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710459986;
	bh=iOxmpL/Y81Ei1VULk8keIpePCzz+oTywINRcdwwL+Lg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S36irffsJ97zHUb81PkUQxkgliH0sdZ0qhXWa3UpxlnR6oKITuRwuITJfAeVQTjb3
	 bJ8Hd586CtT6eS3oL/7V5Vk/KXTt9QYeeiz/Z9S+hDqd086e6PQXfVavn+7pah+5XA
	 MRY25K0xQSWP0zRHjSqEib01WHYexcAwTxKel+b7Y/uo7ZocgdW/GMeQXFzb6c44vm
	 FVsYsDM0aIMJyuVqf+4itptc3H7hNHiu/9DM+DdvW60cP85krUQixs+0HsZZZX4w/y
	 sWjbsghZyrEC0XAV4emPfudFQbo2gy0VYok/TPDpyMC21WIjL/PuyefLwb0Iye04wd
	 gTmzv+MPoO49g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89AB6D95055;
	Thu, 14 Mar 2024 23:46:26 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240313003901.de4b1b153688925ff5216c1a@kernel.org>
References: <20240313003901.de4b1b153688925ff5216c1a@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240313003901.de4b1b153688925ff5216c1a@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.9
X-PR-Tracked-Commit-Id: e8c32f24766a1f22da024e73d1eb8e9c822482ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01732755ee30f0862c80b276de6af3611a3ded83
Message-Id: <171045998655.30036.10052167140755471302.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 23:46:26 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jinghao Jia <jinghao7@illinois.edu>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 00:39:01 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01732755ee30f0862c80b276de6af3611a3ded83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

