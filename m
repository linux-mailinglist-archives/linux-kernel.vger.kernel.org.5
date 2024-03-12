Return-Path: <linux-kernel+bounces-99724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B36D878C42
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5351C21200
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF2353BE;
	Tue, 12 Mar 2024 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dssKHF2w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1525F811;
	Tue, 12 Mar 2024 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207005; cv=none; b=kKMXNTdcvOiAdaxSJaVh7FdwYJaUVAGm79lkUHeEHcd5Cuqj8UNOQI4jBpyUl3KH4TLrdN06mff9Uo7LxVEPgjk3GrNFNSzGsd65eTRWv+Sc7l1qe6mkebrGS6rQ5miHM6Z0Ez0UOF9EwQPo3yk0aSOGUeWXTiBsAdLkwLrtlEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207005; c=relaxed/simple;
	bh=zNReEfidZjW7TzC29kl2o6cK/Ja/nTmzX+A/3j/LoCU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a0pCpbJfxEnCHZKlpNXS+j48G68VUPHmiwYdqkzpa+U1wbv/VTzj8SMnk7hEGCM/osyT5e4lWSXxRHNp6fOLj85FYZ4oIx2+SMpRCaJWMMh860KKKL4z4ztf8ziXPA8wvAQcVfusOpjLu3aUbyoriPjU/kWem0AKqbD3BvWa6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dssKHF2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E13F3C43390;
	Tue, 12 Mar 2024 01:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710207004;
	bh=zNReEfidZjW7TzC29kl2o6cK/Ja/nTmzX+A/3j/LoCU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dssKHF2wCxjIubgJ8fZYQGJzzsGzOZqERFxe73vaA0C73pkifDogwZfzILvmTqz2F
	 1buMoEpFfBFXdjv5M+BG/2Ymrr6T/DQ8jodRvWoD5doE8obOz+f39V5x9YDCy6w2pG
	 OpoO2Dhvka76SmS4jUgaGd0xW2B6TeQXIGxKx2HOK8DnExivwk/5NqOEFPDSLovdvK
	 5HqBIIb8dqVqFr+o9gGGe1A32V3MoAIdWMU4MfEfEFw77dxfuuvGu/eI/iMJK/NM3A
	 ss8Gz9zphw8bW2KoCjm74pmDvEe6oTsOBZwMOrYP5S9jayDxGrNvUzVQ2gTAHi4Rvc
	 HIeHVzd15UUow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAD34D95055;
	Tue, 12 Mar 2024 01:30:04 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
References: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.9
X-PR-Tracked-Commit-Id: af65545a0f82d7336f62e34f69d3c644806f5f95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0402403e54ae9eb94ce1cbb53c7def776e97426
Message-Id: <171020700473.888.16637533826672826953.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 01:30:04 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-edac <linux-edac@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 16:57:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0402403e54ae9eb94ce1cbb53c7def776e97426

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

