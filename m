Return-Path: <linux-kernel+bounces-161136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1278B4780
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0D6282698
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391E244C85;
	Sat, 27 Apr 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjbvyOuJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1B28F4
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714245427; cv=none; b=Wd2tlWziDv7Ss/AoFS3h14tzEBLkC0h3EciB0Il/fbj6QyLmYkyIHlIMzmJXRSvlMNvFhry5ZuFAecASWps0obKkgxFC9IPm83geiAUt2mYO38R0F4rZ6oxjoJTshjBCZsgutcrZYLXQdm0WR+gDZu6z99erkDGLivs79U9em1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714245427; c=relaxed/simple;
	bh=1rBmnpmp+3+JeOb4OkzzFCSSkgiCQNgM06ytnrIgAZM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U13plVW3sdTtepkLVzwMIAU43IsBMeeAuyfaELN7B0Pretp/3hw4awPNpuO2WSHEDDKaXrDh/+2d77jAMgEfg5TDi3fDQwFyCBCdQMpeWsJ2SytPCvPXIOw9zEEz3ybROP1pB/H4yjq1aKABSx7n144lQqAl+qys633yj8fiCIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjbvyOuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A128C113CE;
	Sat, 27 Apr 2024 19:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714245427;
	bh=1rBmnpmp+3+JeOb4OkzzFCSSkgiCQNgM06ytnrIgAZM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mjbvyOuJxXqxs9dB7sFqVku9giS15pxN5OUhicJTAWk6K1r7IQYGRehSTU3Hspit1
	 yykTo5Tgln5hQ0xTPbeX5wRoCsQ34htqvmjObqDB0m2OyndPYi9+oezofl6cdvKcO3
	 yuZy+vSjHwg9V4vo8zgGjfd7AP3z5w7Hd2muAMDd4u456mwB2FfpUThDAPOLoYeFwH
	 GayYoOgpZ6PQG31Hp+Ky3gHKJ7R//l38G25sWlRLIcbgG3kA32qG7fZf7KawzgUBE2
	 6rzI418PI7rePSanGcEZAyo0VeOzZHNOqDVG1j6nAzKpqrtpsaqa+RcxMkbeMyLst9
	 zTukrVvJnx5UA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 506E4DF3C9F;
	Sat, 27 Apr 2024 19:17:07 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-2f5e2c44-3944-4a0e-9669-12967d8e6f15@palmer-ri-x1c9>
References: <mhng-2f5e2c44-3944-4a0e-9669-12967d8e6f15@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-2f5e2c44-3944-4a0e-9669-12967d8e6f15@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.9-rc6
X-PR-Tracked-Commit-Id: 6beb6bc5a81e1433a1534e75173f67d42a6f225a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57865f397001f592817eea513251705d45d000af
Message-Id: <171424542732.11751.17792998119200649819.pr-tracker-bot@kernel.org>
Date: Sat, 27 Apr 2024 19:17:07 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Apr 2024 07:56:54 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57865f397001f592817eea513251705d45d000af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

