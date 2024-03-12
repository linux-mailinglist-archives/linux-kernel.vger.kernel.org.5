Return-Path: <linux-kernel+bounces-100582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C05879A64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863011C21F43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAEA1386A8;
	Tue, 12 Mar 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdfYOSeq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FDD1384A4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263504; cv=none; b=ItPpihaPN0KLfcUV7AFMXVAw2EJlW2RaDJvx4DxcJdPSCUWHUDrSyzNGoCwKnPu2EBsZHWwPuzjYrQ+tb8R6tJdEzWu5cNErqWAM3QDGB9awooDf7e/Es7xiPj/ylzFhSxn1RsOz/L1JNFSSaqpyngWwqZAKoNTNsWwbhTL+kWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263504; c=relaxed/simple;
	bh=z72IzuOV55+8kipGEpKZbxribZGwJwJGqmo7fcJA80k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TcUhNqZZ17OUocubXtAYgDlcSEioHLV0gO7fHmNoD0duPea6+m0+3wX7wOyb3j6jTJZGh05WCk0D/ce8/1TT6WTdTA2vrMnAFsAxHEhwGiB9lzLzqk6rtsJa4EmoqrQkeF0wufSpx1XhqTepP+Ix69LJKYhGDpkCSWEnH8cjnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdfYOSeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93351C433C7;
	Tue, 12 Mar 2024 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710263504;
	bh=z72IzuOV55+8kipGEpKZbxribZGwJwJGqmo7fcJA80k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mdfYOSeq6GGWsGczYxR4BmL3zYhAyvVIOsVS3R+5Pn4Ymi2gzWmvojkNQvh1q2Exd
	 WHf+EVWQneK0NrPowCA9T3Y5Q7uTeqzz5nMqMFZwjZHN03sEp+JwuzKHSXTOqEDEDE
	 ll9DJXi4idtbRXKGhBAyO8Gl/oBejwHz2ZOlPmKt3BPcKpEBEpsTKjfZdlaOujnhcK
	 xBBlSJF959Xv7wfGo0esMlsHF95RDlvZjvaqtXTAtHeA53ILD32ecIjr2ONEiMwmFa
	 qABh+XQuTV6rZprXDOMpRGqdSrXgDXLv06rcmxJlGxFpo006WM+64KMh4hlXle7GrB
	 RjgLCYDa3MCnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79188D95057;
	Tue, 12 Mar 2024 17:11:44 +0000 (UTC)
Subject: Re: [GIT PULL] x86/apic for 6.9-rc1 (includes a new revert)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240312162125.136813-1-dave.hansen@linux.intel.com>
References: <20240312162125.136813-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240312162125.136813-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86-apic-2024-03-12
X-PR-Tracked-Commit-Id: 532a0c57d7ff75e8f07d4e25cba4184989e2a241
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e66c58f743513119f703f3a47f0f93a8e82c0028
Message-Id: <171026350448.10470.11139316987183299482.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 17:11:44 +0000
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 09:21:25 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86-apic-2024-03-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e66c58f743513119f703f3a47f0f93a8e82c0028

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

