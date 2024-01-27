Return-Path: <linux-kernel+bounces-41349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3041983EF32
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A801C21EBC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77612DF9F;
	Sat, 27 Jan 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWWd1YWH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95792DF7D;
	Sat, 27 Jan 2024 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706377939; cv=none; b=DwDuVyXPaEsj/+igmmTVwKHHQwhLVwhGdpS9qxrvzN4aiVEpVLDoLzfW/pdjzo/Ii5+rJgG7T02Er1hq9fRj4xWAiDlpja5iwb1buviSllHuW0J8OUQVvjZe1tsUg6sUM/jMvc5f+hl6wgKHKBrYaq+IcS1PiaCs1SKJPJWlYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706377939; c=relaxed/simple;
	bh=Yq1CsnU6frX1la2STNxIBPcDP7o/7y9Djk1ccm7Ws8c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UH0HqpNugIRaNEU6II5afRgLiSkV8z1tpH6BG7fvsBfEmY76GRFzisM/LV4WfY7yXBo6zk4RIFruNH0u7URMt7sT6p+qLlFHNYHCw+xhB2gerNqIrsdK3yxk+E5q4y/mwkf2CygILV+qSfBzB/r9j28XdGWw1J27DU0E1U1vI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWWd1YWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D7A3C433C7;
	Sat, 27 Jan 2024 17:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706377938;
	bh=Yq1CsnU6frX1la2STNxIBPcDP7o/7y9Djk1ccm7Ws8c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SWWd1YWHuBTc/fbs1z6AheGUNO3mcsq83yn3ES7++Q5B99BJ4b7XXvfDbAZI0MDRY
	 Ca7VlBi1a5OowWyhnQjzreEmHa++RrjG4aSYJosDc+brrZBqpSkU2VWofTMw8Tk184
	 VF97IbIp0iB82TbqlDP45zIAvbG0jXVE450rPLVF65kQ7adh3aJ5TcuIDkKCRa0NdG
	 znGUvZ/3OIJNJBbYUV0vH/iGm42/+wOlWzrT4azK0zGBKt2KwDY3pEGUYQemkjWUmP
	 hgbGSPStXGDE28tKPuQ6fKSXdsRARLI07WJXCTko2LGic16d2aAk6K2pOAPN59l5ew
	 HAnx/zKqhn7bQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 596D6DFF762;
	Sat, 27 Jan 2024 17:52:18 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.8-2
From: pr-tracker-bot@kernel.org
In-Reply-To: <0a9cc4d2-6adb-4f79-a559-1a57a2b72de7@redhat.com>
References: <0a9cc4d2-6adb-4f79-a559-1a57a2b72de7@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <0a9cc4d2-6adb-4f79-a559-1a57a2b72de7@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.8-2
X-PR-Tracked-Commit-Id: 1abdf288b0ef5606f76b6e191fa6df05330e3d7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a696a29c6905594e4abf78eaafcb62165ac61f1
Message-Id: <170637793836.20657.10833731981724197985.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jan 2024 17:52:18 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jan 2024 16:50:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a696a29c6905594e4abf78eaafcb62165ac61f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

