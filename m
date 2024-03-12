Return-Path: <linux-kernel+bounces-99797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 283C6878D80
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB211C2169A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D9DBE5B;
	Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MemQHzt+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CBDB64C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214356; cv=none; b=OZjjQoLGCSC126wewzhaiXpSpxLZswTlRtLYOL2A/O4J2FXQ4JPwDruZVVRec7D+7scfm59UVt1d5q6Zur1nxlnBuucz6K/fZN9CcdDgepD89H6cNLE3t4kixsqW5zJNaGnf5nrMjxTSMJ74tuL3/PH20OtLWAn6hbgItiqZmPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214356; c=relaxed/simple;
	bh=C7LN632UW/Jet42Ig+MFUsVb13nlBb4jNkMTvhGfcgY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Pc7n2Usl0stiG+ecLGBVoJLhf8uY7omDhtM6s4dctpok2CMWo/vBTJe4h5OMoXog+p+Opzl8OT3gqXSzTMdCAXuLyISdUJ9vXDE54kvR8pvr0/edfgYNtG/YtPeZ2dD1x6TIhgZdhfb+EmI9Iyny6WcCMr5iXGNJfOugv78hA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MemQHzt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3D7FC433C7;
	Tue, 12 Mar 2024 03:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710214355;
	bh=C7LN632UW/Jet42Ig+MFUsVb13nlBb4jNkMTvhGfcgY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MemQHzt+zGvQWy0gjRANtn0QGj90cMK/eAV2KrbFH06pmX6G7ZrAZsX/Ypb72wyh2
	 L2Drt75GxD+M/YQpK+zHpQza7ivIjuuOu1+3YyKLurwDMqB8XK+f/DzIX3MzgKOjiK
	 qH66IMWBawTIukTdM/HOgU2iHkcJQm9LDKonqhca/vuIyTBMWYBGiH1PAWkBS453fn
	 nT/asubupAtI+HOjcsSEL56jQ2MV3weSqLGCIwYbnljULxcpW2PVDWbsPf/0cCDv64
	 6G9ISbtMM6r4bZbz+IFCiPhTJ5xOvRx4grierfIzYkRiqkkWJy3HxGSTUCQVt5WxSE
	 uyxvMWfWoLp+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 929FCD95055;
	Tue, 12 Mar 2024 03:32:35 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze7o7FAK8QkRLg7o@gmail.com>
References: <Ze7o7FAK8QkRLg7o@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ze7o7FAK8QkRLg7o@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-03-11
X-PR-Tracked-Commit-Id: ce3576ebd62d99f79c1dc98824e2ef6d6ab68434
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5b1a017cb76e4898dd62fcb97e8aee6a63b33b5
Message-Id: <171021435559.8573.8456557232119151480.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 03:32:35 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 12:20:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-03-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5b1a017cb76e4898dd62fcb97e8aee6a63b33b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

