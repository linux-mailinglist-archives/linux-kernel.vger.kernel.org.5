Return-Path: <linux-kernel+bounces-31892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D0833600
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4971C282E60
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A181F12B95;
	Sat, 20 Jan 2024 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK7YCndE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF14125D2
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705779764; cv=none; b=XsmRJYWz/fuG4qKED+2SsSe1Vuq/y1qKrN07I0GQOKQ6vxCMwe4PcifOOmj1sYaA0nSdHI2ZfXvnmaQyj+iwFeuWbCKzTb0r1UReFJ0sXtZmUfpQ8IcSfoR0V01RKcaTrMRYU9j8gfQkxrkXPffg7Jd3PSBA+anl+hQTCt0Mtyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705779764; c=relaxed/simple;
	bh=2mxFYdmBSkm/9gBvn8lI4Ab/gdegAATDGXuHWlqWSFU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XMUWEXRtXBOjM6QEzAbXv/C0Vb9GhlKxw+nuydL14OggP10f2qsqYI6Lh/Rb9hkEkkpeh1f4ayf2mQvVsypGUiq1iGtM5mNtheUYtfTgQUf51sQFPfY6VgRIOw7HVyEXN3asK+kcYQZs7J4tZhn7rMLXCxnmuY1xRmT9MvIrSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK7YCndE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3CE3C433C7;
	Sat, 20 Jan 2024 19:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705779763;
	bh=2mxFYdmBSkm/9gBvn8lI4Ab/gdegAATDGXuHWlqWSFU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PK7YCndEEcTqo/onV8ZnLaH00M+ruFpVwFZp/GpHcmJmhKOXca7w1u04iCv6wILTe
	 IQgcmdPFOOY1+c0ztAhS+Rm07JoUrYEmsqozwUKI+WEh3qc697LC45rxvBejUrrqoD
	 V77ttEI8YSos/LyOyW/fpLNxdp6xl/0U5c95K8s5H2L+f87KcSYyUkp1dazwGzQ1+P
	 dzU3bB8naUQ2VI1QtjI6RpucAa/7ogrquQSXEtCMDLwWLRw1cm3afeayIdB0n0LVm8
	 yheGL+63Fx8tknv1wdHTUwjLe9n0/Z9RJlVuwEVVU03TXshorx5G1uB/SIPE1xEv6r
	 QuB/zrFD5foxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB80AD8C978;
	Sat, 20 Jan 2024 19:42:43 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.8 Merge Window, Part 4
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-878cc879-7aa0-473f-91e4-8288072cdd4e@palmer-ri-x1c9>
References: <mhng-878cc879-7aa0-473f-91e4-8288072cdd4e@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-878cc879-7aa0-473f-91e4-8288072cdd4e@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.8-mw4
X-PR-Tracked-Commit-Id: f24a70106dc1ad2a755b2d42f47cf1dcf24f0b27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5075d8ec5647322fb9e699bfb76331cc8ee098d
Message-Id: <170577976369.29448.6106762647083098483.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jan 2024 19:42:43 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Jan 2024 10:17:18 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.8-mw4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5075d8ec5647322fb9e699bfb76331cc8ee098d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

