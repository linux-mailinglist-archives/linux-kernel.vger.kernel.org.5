Return-Path: <linux-kernel+bounces-99624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F70878AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD27282420
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2758AB8;
	Mon, 11 Mar 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3Bp4x5j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A9058133
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197078; cv=none; b=Ygjz1t6IfXMBLG9vkh2uTKLmOt1q0rNm67qsqvcZushbLdIE1RIvU+hTuOwP6CY0oL0npqX+kYIzLjLI/BVIp1JUS5x/4VKNyM+dKTY1nJbC2mA/6q1PDb+pZE7tdYStpUhJOuxwLD6B5tD0G49FOqEVyvt10kcqFJE15OqUHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197078; c=relaxed/simple;
	bh=oSJ5E/rWkfuWw+awWRC9JIBNkssFF7q6obYfnJE6RQY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RUzxeDwX+OvZnoSHYhSvOaCNoyfy08WENeOMvhVJIjygdtyU533DU8n6PnPsQYEb6DqrxAExdgxpDT9GsKS02C3aLZx5+NO2g6rzDL/OlRULuepyr0bpucuPiTxAYGGXJFgCpX11vE/48WlcIAQD8IsruGe8ZET6k8mIJqJMOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3Bp4x5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDB21C43330;
	Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710197078;
	bh=oSJ5E/rWkfuWw+awWRC9JIBNkssFF7q6obYfnJE6RQY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e3Bp4x5jmtyxZj9vcHXpHK0fTS0bg5/sbb4EXCAUELxbhHoKCIoOuZKBsRdP8nNUn
	 qNEmsemw0SJ3wkvRuzlXKr3H8movTclqFpz4kmba/dveV1MC3Zeum0ehBQzBDtfV3Q
	 Ffd6JNbhFBFsgK42aZKCXlDiuhtXSvb1dAzsKGYwilkMb/geVca3pzRXuZZ7janEUq
	 x+bO2jJMKqpo39ukvfAEMTHl0W+xlKFveTFZzFrvp/fj7itUacGvaTMVZQOQW+Vlp2
	 NS3lEN6kuldHNtzeY5G4FU/Z4zruj6m1ZXUmDO3FQdnPyMTO4Psc5kTML2hzRJqq4E
	 Q7jJAwHBYSPrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D15B3D95056;
	Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <171011361729.2468526.2426064486971501672.tglx@xen13>
References: <171011361246.2468526.10740060923051583953.tglx@xen13> <171011361729.2468526.2426064486971501672.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <171011361729.2468526.2426064486971501672.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-03-10
X-PR-Tracked-Commit-Id: 8ca1836769d758e4fbf5851bb81e181c52193f5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d08c407f715f651e7ea40b3a037be46dd2b11e4c
Message-Id: <171019707785.5315.11811802038250379972.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 22:44:37 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 00:38:55 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-03-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d08c407f715f651e7ea40b3a037be46dd2b11e4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

