Return-Path: <linux-kernel+bounces-32156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6C883575D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50661F217F0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC86238DD1;
	Sun, 21 Jan 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEm898vB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D338383B2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705865635; cv=none; b=fJtfmYklaQ0N5a1INVx/lvR9J93ev3zho8KLuZtPLIvPBz24df8Sz07Fqc8j+zzCJJdEmrGEMYFB8+ld6CjYel7zzcCJTJwX/HPlCP64q9visYskWdFHS76feLqF4LWi62SRrCr2fbE/sWXdYczHckfXaEKcAcxwdOZoO3m+J4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705865635; c=relaxed/simple;
	bh=eMfo6Aspo2RGsOIXmyrmtqLUu17T+4wEN8QbgH8ANr0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nJx/pnv2HCl09aobGdlny/fUO4x8m6fwMpE63j38Mfi7DFgXAsykZUTZoowfrtCGSJuSMQkqNwJACWqIzRyxs3I3Z8JNwQs9KpnhKBhUMd9C0IaZmrZHV6qFtn7zyFfWiXqPevCh6Ib0uvTqHMc2gomefT1sSpSU+uL1muOs0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEm898vB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ECB8C43399;
	Sun, 21 Jan 2024 19:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705865634;
	bh=eMfo6Aspo2RGsOIXmyrmtqLUu17T+4wEN8QbgH8ANr0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gEm898vBV003mPzQUWV17aYfeGXkSZBr8LYJmFzvtMvl/0ElsPFmcLABf9JUN3Jy/
	 CB//U3FlvCiWLrdOvmJU+44xV6s4alMuCJx3P/A6r0qhitx7r9cJ4G2aJDtNVYFF1k
	 /FYFPzAYNwf0H4S/onNJ2RiqYlmmORSxf3PoXiDRo5kVwoXcEwamOaHyhQcZFgvM6z
	 TFoe7E1c4EGEFr7Q0ab9NM1RuOABZRTrW+X57txDTmQMGp6W165i+ctqtdr6/GO5XS
	 VFvYfnOG1/UwU/kwfGgMIpB4JHEtbk07/Ou+EHxCqPjjGvtE/6Oe2FRFhwmd4vOPHd
	 1XQ2sGaMOdNVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8989CD8C987;
	Sun, 21 Jan 2024 19:33:54 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <170585625183.1573913.4183642933597906500.tglx@xen13.fritz.box>
References: <170585625183.1573913.4183642933597906500.tglx@xen13.fritz.box>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <170585625183.1573913.4183642933597906500.tglx@xen13.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-01-21
X-PR-Tracked-Commit-Id: 71fee48fb772ac4f6cfa63dbebc5629de8b4cc09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fbbed7872677b0a28ba8237169968171a61efbd
Message-Id: <170586563455.13428.14980834896818515665.pr-tracker-bot@kernel.org>
Date: Sun, 21 Jan 2024 19:33:54 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Jan 2024 17:58:10 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-01-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fbbed7872677b0a28ba8237169968171a61efbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

