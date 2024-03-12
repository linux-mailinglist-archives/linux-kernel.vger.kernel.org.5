Return-Path: <linux-kernel+bounces-100877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7070B879E84
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C18D283FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E4D145666;
	Tue, 12 Mar 2024 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTCDTcC6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DCA14565F;
	Tue, 12 Mar 2024 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282251; cv=none; b=nZWSqAu7fkNHA8QfuOtE3h+Y5rjdINzso6AOEhEU5Gyn7QIT/zcWh/AO0HxpN4WSTScwuM9oASmfc57vrmhLDTK3+2LS0vwstxvV2xwCKMrisT2BNSZgDM/13BGEpe63xmzVNUO0lFEziJCv3ujTz8qUyoUUcPaOnNtG21voijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282251; c=relaxed/simple;
	bh=xKvvt/Jokl5ZXKNDoMYoXH2piFip0VPz1QwlDxztxRw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gQReo4PeDEaRkWEmW++753cuG7FMFPzqXmeJJ+LNydmnZFCcAAKbHTXP3V/KC2xyJF47Pub2g9G26AbvTDiQrXw7PynpUCSO6K7slSrLHrqkXE7/aLGJ/fXNT+wC6BAYi17xSNrkegtBYwzlBYZAZCXN1tSILfClN2LeeJ0x/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTCDTcC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D4ACC433C7;
	Tue, 12 Mar 2024 22:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282251;
	bh=xKvvt/Jokl5ZXKNDoMYoXH2piFip0VPz1QwlDxztxRw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gTCDTcC6Rh0RReNj6pj4vkbP9QUsiS3xVVo69HobRtusydWKRBGToaEPiqqswED87
	 fbmil62MB5L9y9jQsToYKCxoYC0A07SRsaeh3o4SEBYJmJwfBzyB8xy3dpS7oA2C+s
	 A17JSLhD1Zuygnx5ORMmGqHktHB2PIKYwgrjgHNHMGi8zQ13UN500nlVT7etZ5jREn
	 CvsUNP/jPIGAUGZME1mPaXAr4SzRk3m5E1UZno06OdZ+NdBcJv8F+2n6rWkdmsJykv
	 jQb6ZdSc8vurDOqxx7M+d6DLB1JucM+wbzIdqBw9Rz7ZxDOtNEe+eL3nWp6hebU/0h
	 /TIMTokli1HOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 586FAD95057;
	Tue, 12 Mar 2024 22:24:11 +0000 (UTC)
Subject: Re: [GIT PULL] pstore updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202403111631.BB91A2422@keescook>
References: <202403111631.BB91A2422@keescook>
X-PR-Tracked-List-Id: <linux-hardening.vger.kernel.org>
X-PR-Tracked-Message-Id: <202403111631.BB91A2422@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.9-rc1
X-PR-Tracked-Commit-Id: c8d25d696f526a42ad8cf615dc1131c0b00c662e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41cb8c332bb904cd2108250075d195e060e1fdc7
Message-Id: <171028225135.16151.3795744581975381053.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:11 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Heidelberg <david@ixit.cz>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Kees Cook <keescook@chromium.org>, Kunwu Chan <chentao@kylinos.cn>, linux-hardening@vger.kernel.org, =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>, Tony Luck <tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 16:32:30 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41cb8c332bb904cd2108250075d195e060e1fdc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

