Return-Path: <linux-kernel+bounces-32155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FCB83575C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86BEB21CB0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CFA383B4;
	Sun, 21 Jan 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBRe6biR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC91383A6
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705865634; cv=none; b=BGU0AQFPy2HmX+u7/L9IE32dA0n8Ck56mqUCuicva+dFqj3qQmKBnroO7QYIf6LD2ycbb4qge/Fx6X5Hco2mLkUj719quuMPRMMKuRPV/xnrcrvy9WYIubRehmvuJVwJIop8wOcaV/34On7bmnnDUOSrlcMNphBp0j2kVEUlcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705865634; c=relaxed/simple;
	bh=2bOoLdGbvNjKPjgT/9HjkEcaQwFb6Umi+JUAxYFTRzg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=I6mhVTAb7zSNsiqmzlb45VI+Z5DvGCfqrRYtsozlwcZC+lT7vsO1XTFnDZQq3MqpMJV9j0FtYPHVKxVzKeMy3/OctSSp8kwu0b0V/7XkWqoAyx4moV/zxHFUDba90o7NyrIhm42VsgRGH34BkBxUGoO1yU8QXfvURthm6LbsU8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBRe6biR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 759D3C433F1;
	Sun, 21 Jan 2024 19:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705865634;
	bh=2bOoLdGbvNjKPjgT/9HjkEcaQwFb6Umi+JUAxYFTRzg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VBRe6biRDSZK4aj1ZUjEmRD5xlU+YL2P90KSb3QAfE5cLy2ejB+MGjwqzUotJ4fKb
	 vfgEtyS6MShKYn23q63s47qNXBje4mrL2dTJIlvOTk39WvIRirVrp2G9rEcVgHrgFV
	 9I67oJzsnn0x3zZoblbb4/sIZ6w5vjSrQnXlyuSX5GCnjQsUSHdqlsU4QKVs8DPiKO
	 fC/iRSFkCHdgkXQTVDQ5pSYytfCi+kArfhKOCQ+tMSjgoq3r0jI9EHJo2OaU+CmAsy
	 z0s65jAZQxhOkCvkiwNL+jw+GHaJt8Pthm4VsflsOsWCEEModQzj3Y1HvcCw0Zn7rb
	 pLRMPgSFKKMfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65A53D8C970;
	Sun, 21 Jan 2024 19:33:54 +0000 (UTC)
Subject: Re: [GIT PULL] header cleanup fixups for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ips7d5lbyq76awhnj5ttnsbbvaykkemhnwe56rzphetm4zhn2k@nciievifs2fj>
References: <ips7d5lbyq76awhnj5ttnsbbvaykkemhnwe56rzphetm4zhn2k@nciievifs2fj>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ips7d5lbyq76awhnj5ttnsbbvaykkemhnwe56rzphetm4zhn2k@nciievifs2fj>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/header_cleanup-2024-01-20
X-PR-Tracked-Commit-Id: 5f4c01f1e3c7b0c8d1e5dd6f080531de7aa5e47b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2368fcf341d3a6aa143e3cdfb0440fabd152c83b
Message-Id: <170586563441.13428.16310859383451146662.pr-tracker-bot@kernel.org>
Date: Sun, 21 Jan 2024 19:33:54 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Jan 2024 20:42:37 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/header_cleanup-2024-01-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2368fcf341d3a6aa143e3cdfb0440fabd152c83b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

