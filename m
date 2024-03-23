Return-Path: <linux-kernel+bounces-112405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2EB88795D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664D02822F2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5433225568;
	Sat, 23 Mar 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX6a09dp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA31946B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711211111; cv=none; b=pTQ4y6MQd4a25TjrB60T9xPOrUK5/B4W2aFk7c9FAtKP+j9qSDA4McIaxTw6CUi7iDIpu8KRbkwLQXLV5j9TKLCr7Tu68jyA13BeshC/p+WBEm/D/vmoR5um66OwDPtZExxXgnA6zsd/l+c0idMNedqvyKhZGhXCtKnS3YM2Mw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711211111; c=relaxed/simple;
	bh=5UrZG1YQs5L7URoIE8CGrd7O1yC1mZAAnBLLOxjE6mE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=llAaWWsit1i7gZ4lklV6BbQcsXhQ7v7Pm41b4H1rExnWrRGIsiek9e+YVbaatJ5rBq7Vjj7Frq1WlLrW9C9zVbe2QWJMUNFWIJCcV70S5huO0EOpAMBEoP4qcSvZNsLeK1Ny+KlPx8hyQOZDJ9FG7H2Jc1tTvgnS52G1rJH2opY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RX6a09dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B76DC433C7;
	Sat, 23 Mar 2024 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711211111;
	bh=5UrZG1YQs5L7URoIE8CGrd7O1yC1mZAAnBLLOxjE6mE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RX6a09dpdUnGAOoGckWgMhOQTRWC6+BVyrKZgxeW89X4RUIdFa4TI+dFkcXQk4e/5
	 /1xWWWfuBAgUCbUVX3dpDsoRqW9mtGf5zBkdLstOvlt3HOP8yuIpfqEoMNbFt0WyTC
	 Zjk/Sweh3cdKm8mFdxd4sSFrCux4/pRAZlg/IHuC8zO/tX4YS9GaDhNTmSiBsXO5s+
	 f1H9MH3kJzvsLy6932kShsja3T7kZd64s51fsuOdnW6R22NUjWqK/1lx9fvXo0KLU/
	 +CNWus/HlR8ZXy/2gAb2wF1Glyn5WKpNmAnrO3D8MFBwyQIF0YDq0/nz38XMa2eUV1
	 F4eJnJwOk3MjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4114AD8BCE4;
	Sat, 23 Mar 2024 16:25:11 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202403221655.A2BCB96145@keescook>
References: <202403221655.A2BCB96145@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202403221655.A2BCB96145@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.9-rc1-fixes
X-PR-Tracked-Commit-Id: 231dc3f0c936db142ef3fa922f1ab751dd532d70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b71871395cf3a0ca7c0a7d79b4faa584ac872809
Message-Id: <171121111125.3260.7785423389854025290.pr-tracker-bot@kernel.org>
Date: Sat, 23 Mar 2024 16:25:11 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, David Gow <davidgow@google.com>, Guenter Roeck <linux@roeck-us.net>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <keescook@chromium.org>, kernel test robot <lkp@intel.com>, Liu Song <liusong@linux.alibaba.com>, Marco Elver <elver@google.com>, Nathan Chancellor <nathan@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Randy Dunlap <rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Mar 2024 16:57:14 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.9-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b71871395cf3a0ca7c0a7d79b4faa584ac872809

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

