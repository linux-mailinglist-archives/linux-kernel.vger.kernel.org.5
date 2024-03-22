Return-Path: <linux-kernel+bounces-111902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A48887260
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC59B23FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E864A60ECD;
	Fri, 22 Mar 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe7EkVM2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6160B9F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130288; cv=none; b=NzdInBj501ZyxpD1U3XWRceklvrFHXrshJygjdU2qktaVWhIze+Tw/IjyYUTXq7AmMz73EyfbnXbh0T9tJdOlJMG0c32D7oPiWwrwAMmDR6GhDMXmH+jtVhtPbYX7e0rDu/Ox0/elg3ZSaNpsOMU1ar7w/i1rFl0lRrCaWm8bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130288; c=relaxed/simple;
	bh=BuncvNeNfuiQyiAMnrZBftzn+j9tJRF8CoQDRaBRqTc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HyJoIKnq51H5FAAn89ur9l4xGLz3r3ZJAZ+FZIW0Tzd18t3gMPTnce7PysNtDnjOby3RewvabnTt2QLlGYi3ifF+hF2iZPMZZF/kQoIindUMhOd0yq3JJMMU1GnP0r+Hm19uM6+5BoUd4rM2nJMP2Bs2CRTzInpycA6s7Wlz7SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe7EkVM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CE64C433C7;
	Fri, 22 Mar 2024 17:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711130288;
	bh=BuncvNeNfuiQyiAMnrZBftzn+j9tJRF8CoQDRaBRqTc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Pe7EkVM2ZXRHUSOg9eEEE6td4gaS+jl14MX52S11fJ1QMzP9MAhpdMSZVHMBc6HUa
	 XEExT9z8YQ6dmYkPtRup3n7jt0gPhDw5bmPoicAuzASHi9EdQxtu1ir+xT54oCbAmi
	 eN9T9OURIPmEnxuTPpZyJ8GCzHXTI3wIJq/3TUs3/UQFKG/cA6S+l4d+t+7YdbnaUa
	 Bw14ZXm5hB6NLmQ1lp2iMmKWshhSnCrjNN/NgD5QRFAw41z5Ps34ZWduUy9by8YduR
	 feU/dohqAS0wMKhvyX5Sn77CopZ1SON7sl1/FCd8BUSQva4+TCDS54mwgHhsCttAYG
	 QsjZ/pWlleLVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16752D95056;
	Fri, 22 Mar 2024 17:58:08 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.9 Merge Window
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-105d6a21-7483-4a20-a9e7-8e72770737d8@palmer-ri-x1c9>
References: <mhng-105d6a21-7483-4a20-a9e7-8e72770737d8@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-105d6a21-7483-4a20-a9e7-8e72770737d8@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.9-mw2
X-PR-Tracked-Commit-Id: a9ad73295cc1e3af0253eee7d08943b2419444c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c150b809f7de2afdd3fb5a9adff2a9a68d7331ce
Message-Id: <171113028808.2552.1070666340046445949.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2024 17:58:08 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Mar 2024 07:22:06 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.9-mw2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c150b809f7de2afdd3fb5a9adff2a9a68d7331ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

