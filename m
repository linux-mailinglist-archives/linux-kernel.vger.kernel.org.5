Return-Path: <linux-kernel+bounces-164393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902888B7D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C089D1C21F35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C060F194C9B;
	Tue, 30 Apr 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f680dp9O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F208194C79;
	Tue, 30 Apr 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494799; cv=none; b=pZUbfVzAlJJBWg9xMDYs8cY9/MZUmBLts5eDAopErL+nw+h0nRHa7r5QPKYbkcMCOE8DrSKL3II39YZPLe38cWaH+a0kqBz68IvV16gKEvw7bW5I1A/DnG88VfkYjetdnHRAUnokEZ9hRFmEocxtPTbdVWMfqW4E3Fgh2hs44ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494799; c=relaxed/simple;
	bh=KyOudUwezyt5wREKVpzZElCdXrBdRNlVspsdTMjgLFo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HLCTTkr75Q07GG7ITZnf5kSKh/GUSvinTPUXSYpHQyLVYRp/giDG7DiO95/JIUnVKjseqPoXuq7hsM/Cqy8aqHsoF2DPQytE7NPolVfLxmIx1IcPBn+on7qdnbllhTjPbcQCfNkTDHCXFM55OZQ7TbNNta8/a7iaCNZUnRZ19Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f680dp9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6CB9C4AF1B;
	Tue, 30 Apr 2024 16:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714494798;
	bh=KyOudUwezyt5wREKVpzZElCdXrBdRNlVspsdTMjgLFo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f680dp9O2hZh4uMSShDCJfPz+t9aO4tGlN2/YemSSiJR7Er98lwgre5pqORTyZ0IY
	 Nq44vH3D/kpDTl4chVol7GF7VzLUYotkDMEXmFM8hGVYCcaVIQdC2XrkYQXZl9S5eI
	 k1VInpoDzOQ5yeWq43rW/C6y5P1cqeK1K6SwthG/HelZnT9J6hHwutyJPjJZCigGU8
	 nOp+3DJdYIV16tawAyw3ecZ77bI9NBd9dxTyPaShTpAQSSb4j4h02Cby/AKqNNdseF
	 xL3YeqGH7FXwaQBiL+b1+2zkK8/XyiSXyZxocH1OTqKQZO7mNDJ1HaxzfF+VnraBz0
	 gcOheB1fzZDnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC9EAC43443;
	Tue, 30 Apr 2024 16:33:18 +0000 (UTC)
Subject: Re: [GIT PULL] Pin control fixes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdY8HPt5SMmqpuo-GKGf=94U7E9=5-eYiMpoJXv6kMJB7A@mail.gmail.com>
References: <CACRpkdY8HPt5SMmqpuo-GKGf=94U7E9=5-eYiMpoJXv6kMJB7A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdY8HPt5SMmqpuo-GKGf=94U7E9=5-eYiMpoJXv6kMJB7A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.9-2
X-PR-Tracked-Commit-Id: ac816e9eb5cdae3d33a01037740483db6176013a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5c8fc5955608cc3561a1ac949e3a39479f24394
Message-Id: <171449479889.9419.8450629285647903879.pr-tracker-bot@kernel.org>
Date: Tue, 30 Apr 2024 16:33:18 +0000
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Apr 2024 09:50:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5c8fc5955608cc3561a1ac949e3a39479f24394

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

