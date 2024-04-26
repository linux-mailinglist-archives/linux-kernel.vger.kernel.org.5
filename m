Return-Path: <linux-kernel+bounces-160665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D058B40C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A021E1F22C91
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28042260A;
	Fri, 26 Apr 2024 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk4BjI0j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3258323754
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163099; cv=none; b=FKyeMB8NXMU8cUrJLKKQ5+u6pOWYI8b//rlwOAd+6kEsBoMhJesKA7CGV78pZgvomlxt/hSuHA1ttaNvav/qh+5MefV3BWiT29+AcU5MuZAA73YG2Tn6v2CimHW3xxm5JYIoKRIIZmYkXNeb+lcpsYg964OTm700+2AHdOGupmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163099; c=relaxed/simple;
	bh=zEUd8BRcbfhGdsmNm1IYQD22UmZYM/KYGx7otkXLSyA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DkTHJK1GV4OvpUUjviZmP8jilADrxX4598uDovGvnQAyK0pjCycRN0u41oAY6V9qgPCDH9G22W8ATaME1Cz8GUSKkbkXqBewjzh52F0RYB3sx/hLy+3uaql86V1pNRSBgK2BATzStG797zAaMUyswCyNvvy9ktN1q6wPfYvPs/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk4BjI0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB036C113CD;
	Fri, 26 Apr 2024 20:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714163098;
	bh=zEUd8BRcbfhGdsmNm1IYQD22UmZYM/KYGx7otkXLSyA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Sk4BjI0jXBUFoioc3WpDoZzU8fPnNTi57X0wyIzgTTbwC3CEDgLnYBG9H5RpHADRT
	 TGfiNmGN926WblcSPZ3+L/nNKqMFl7X6FhdVeMqXcq0x+SlRDXMSDz5Ucwzc7BaxHI
	 rlBIWSX8jri6E7B/Wdpo4sb09W7x0j+HCsT1VIetO0xNbIrtw7YBTCVwcq2csNHUv+
	 BUyynFwD1bMrfVPHE/moADi3zs60eK33gDuj+VXXlWGLnw1Qt3Jmo0QAlkjLgkenEO
	 XLyU/5KX3L9WCJ9l3h0PpP2d9K89Gzfq98ir5cEcNvFhq4aXbBMWe1O0sFhhMm2oAW
	 18gEzo/LsFxig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1585DF3C9C;
	Fri, 26 Apr 2024 20:24:58 +0000 (UTC)
Subject: Re: [GIT PULL] ARX fixes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <80a2b41e-74da-43cb-8532-fc3b17879201@kernel.org>
References: <80a2b41e-74da-43cb-8532-fc3b17879201@kernel.org>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <80a2b41e-74da-43cb-8532-fc3b17879201@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-6.9-fixes
X-PR-Tracked-Commit-Id: 61231eb8113ce47991f35024f9c20810b37996bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9e35b4aeb2f061390395033314898d07498da03
Message-Id: <171416309871.19521.6563933224187974806.pr-tracker-bot@kernel.org>
Date: Fri, 26 Apr 2024 20:24:58 +0000
To: Vineet Gupta <vgupta@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <abrodkin@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Apr 2024 12:08:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-6.9-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9e35b4aeb2f061390395033314898d07498da03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

