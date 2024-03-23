Return-Path: <linux-kernel+bounces-112498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7CA887A8F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA621C20B41
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12605B669;
	Sat, 23 Mar 2024 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAjPv9ri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0DD5A4FD
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711230964; cv=none; b=fp9aFRAVaZj8UmtX+Ai/dyKtJB2I3xrnBIb8GS0EFRZzztz06L0RItB5ShYiAyjUBbdbItmPKHuAOZN7zmmzxpZy4QIY1j6mqPwoBzezKvLKNQ+UTWp9G1SLVTgnzIVKrAgxBiIsO9WoSZhqu4IlCwddmFQfqY+hB/LgtKaezyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711230964; c=relaxed/simple;
	bh=1RGeTYpblCEx1rdBdVmpyDzb9+/hpvnXfrVb1SBQECs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BfpsbVauUB2SdV8/L0OdP5Yl/RpPEbY+R5FEbOTAIlxuwBafkaepbtcrOaDx46+BM3eBgqmGudQWVw/ow9V/VpTkeTpl2ROdGiTZgdvK0MCPIGfuyVeU/cdUGhnGBFlMte/1H5ROBLSiLJPWy7pkqu5A+Utz41aD3ZbjIhfyOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAjPv9ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2554C433C7;
	Sat, 23 Mar 2024 21:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711230964;
	bh=1RGeTYpblCEx1rdBdVmpyDzb9+/hpvnXfrVb1SBQECs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hAjPv9riobOahE15pu0zRhe93LadLHCRPFFn58PjQx49kRh7Y2piWQsBQBDjZNZ8L
	 zXkPAAZr7Fu1PVYDLNRL6owhjPj0UIl5DAWEafnEUkeYCZzC8y+q4Wj7tmHyLtKGOf
	 NovSR/zBXa95Hej8ZnwhQjm9XHP/DVLjmEQaV+HCaAGXSOc5YPEIB1DXz1sg+sEjYP
	 1YP2AKU+CMlkOesB5Xmewyd75W9NNmsX3nQZxqKHcWQfPTf/NnAi0zkhzCp4Mfn455
	 om34DhtU4ek8jQvdMcNjqG6XCJcuV+qKZDQ2clEDybVk0dW3ZALMqfvMQsasdg66r/
	 wNDDJnIGf+nhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7867D8BCE3;
	Sat, 23 Mar 2024 21:56:03 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <171122347111.2772088.14110191144631232859.tglx@xen13>
References: <171122346785.2772088.10596056144848184713.tglx@xen13> <171122347111.2772088.14110191144631232859.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <171122347111.2772088.14110191144631232859.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-03-23
X-PR-Tracked-Commit-Id: 86c54c846e126d6f7cbfacefa0cfeaed6f67207b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00164f477f065a0faaed7f2ca8f1c724c99b6fe1
Message-Id: <171123096394.10193.15000720989559382274.pr-tracker-bot@kernel.org>
Date: Sat, 23 Mar 2024 21:56:03 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Mar 2024 20:52:02 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-03-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00164f477f065a0faaed7f2ca8f1c724c99b6fe1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

