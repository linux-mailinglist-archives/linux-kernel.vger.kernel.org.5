Return-Path: <linux-kernel+bounces-143296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8A58A36EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7881C241E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2CE152185;
	Fri, 12 Apr 2024 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2IcYDG/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7938415217C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953054; cv=none; b=Tkrvyi6rBLqSnPYuZoZuZBSa+3s00t9BdLnel30eEh0lwjVvKx42fh+9Il9+N/s4uF/f0Bb2mdd7He3guspFOR+UcifYKmkk0aZF3p1taCENNVtULNiWQayT9LqbC7PvukDTTGNn8x+9wtPM3dMV/U3PRuzGlU0Q7LuVQ17zrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953054; c=relaxed/simple;
	bh=sP0IrTaUKYHU8erhohuyx021P3CCPjrXk193bO/BHnM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Q/7wfI0oHd272XZPjGLGhGFEHrUcJzIynEkcJwvWM5EJp++30zyZVtXYhRuJJ+DiGZdfWtw1jch5o1j+5Ecky8dP9BuKhEs/xJAwvCBzB5lxlIuJjn6EgH1AV4a47YxccRczQPWoe5hwhJtIvB3A4ofAe1T9ychnYhbc/VHscMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2IcYDG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0275BC32781;
	Fri, 12 Apr 2024 20:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712953054;
	bh=sP0IrTaUKYHU8erhohuyx021P3CCPjrXk193bO/BHnM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=H2IcYDG/PfNrJfkRKv6JKbZRGGRBDlefXvoqwZtLd2d5QootOx07Rh55yu2BE0xUV
	 B/+px0tS0gATi2LnT/wGLcyTI1ermuHJQabU7FdpTaHSxqVX1kgmi4popsir+IukOj
	 uXwoxIpn/EDKGonHRNnP9ZXw0M1tMhNaa7JvcurvktBzRnkVZ8L+knrI9YPZtzJ2ja
	 nuyuwKzUqs02keNfh7d4VxWs7NVNCGHUvHoA3buQS1hbsMyzVJ7HvwGsebgfzfcUIq
	 Snp6Cg7IyYT+BxnTDq+1zTc4b4KlMKVrzk4Ho8V0OeG3PcvnUirN88/c/YiTICSrLH
	 ljKpsLP7eozNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDFCDDF7855;
	Fri, 12 Apr 2024 20:17:33 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fix for 6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zhl1_IacWOADYI4K@arm.com>
References: <Zhl1_IacWOADYI4K@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <Zhl1_IacWOADYI4K@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: e3ba51ab24fddef79fc212f9840de54db8fd1685
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f2c057754b25075aa3da132cd4fd4478cdab854
Message-Id: <171295305397.15771.6965800909588759438.pr-tracker-bot@kernel.org>
Date: Fri, 12 Apr 2024 20:17:33 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Apr 2024 18:57:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f2c057754b25075aa3da132cd4fd4478cdab854

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

