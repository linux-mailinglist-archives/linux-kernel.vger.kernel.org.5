Return-Path: <linux-kernel+bounces-106393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177B087EDE5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0489283DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4F75577A;
	Mon, 18 Mar 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jADnzKHJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781FA54FAB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780482; cv=none; b=M/qTfuxJ+6lCI5//Dk6wraiHVSVUyB+2st1xhZh+Mlw/PBI1E31doc+LK6s24PhPPHyGH4DkqU3UQnBqqDRkOcNHYT+Ufy36bADoIa+wkOvMAlDUX4Wh+15HuE06C4YXrGz8itFTKIyXo+is6m1LHZvOJzvDErVrFQY56f++Tfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780482; c=relaxed/simple;
	bh=MJmbk2ZpmBnGr87t+4FUPixulbHdsugrrUR5+NqTIY8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uFDBSnBIBb3fTj6NP0+x4T4/r1BKvueUTu3dwtMUnLfYl7JQ/Q3VBd3K2oSyqhRuqayM+Lnul7/Wgccic07Q0TuevRXOxU94IHHKXOV9SfvytwypRwe/DSMBZMsgQ/D0kLbVuZ5bOuHZdiy7bEnfDJLq8AwKh+LSIQnY0EMj3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jADnzKHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E6B0C43390;
	Mon, 18 Mar 2024 16:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710780482;
	bh=MJmbk2ZpmBnGr87t+4FUPixulbHdsugrrUR5+NqTIY8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jADnzKHJCNqxE/7XKBTFxpY5VSVWXEpqiZHuW9HWM4g8XlZmAxP9ejcE3o6UEVnRc
	 oIntt0fYK+KpbaGiLPZ9ZWorQacz5LyJIsenroZMi6QHzGxebURImhOuNmzNmKMNUr
	 eNzFqeO/NyDERubk9u/Q9LDZG7u1rbm2tbxzYpEkMk2KE7SZtpjhZSjUDsZ0CBXbbU
	 K3MShpkcj8A/tGsW1VOaOCBTScLL8BYvoyG0NumiG5/IEimluBwxdkxHrhc90dKAdT
	 o8IlyQjTLjp7HBeatUVS4TrpiUOgLYNuc7gnauyAFW8R1Q42LBdtCuamiLKSXOQi4O
	 oZb2jm+gsGO+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 448D2D95053;
	Mon, 18 Mar 2024 16:48:02 +0000 (UTC)
Subject: Re: [GIT PULL] IRQ fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfgMDZiXhrimMVC3@gmail.com>
References: <ZfgMDZiXhrimMVC3@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfgMDZiXhrimMVC3@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-03-17
X-PR-Tracked-Commit-Id: ca5b0b717b75d0f86f7f5dfe18369781bec742ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ae3dc83b047d51485cce1a72be277a110d77c91
Message-Id: <171078048227.4121.1539894885429781250.pr-tracker-bot@kernel.org>
Date: Mon, 18 Mar 2024 16:48:02 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Mar 2024 10:40:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-03-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ae3dc83b047d51485cce1a72be277a110d77c91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

