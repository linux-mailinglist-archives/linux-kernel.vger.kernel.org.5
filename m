Return-Path: <linux-kernel+bounces-102550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF0B87B3C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E234B2195F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCC75675F;
	Wed, 13 Mar 2024 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwTbOU94"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1945644B;
	Wed, 13 Mar 2024 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366446; cv=none; b=mi9TYtKC/XTkYfO/pk9PDTAKrATjup4+tqB1NXhjjEf1/bJc65oLlFvUqerNLsjWsQ3LwTZ4LSNTFv8CgF/m4HD5YTR0uSozx+dkXeksBOU45h42eFv+OIjRrWek9GjwaOA/3k+Fiuo3/+YYNtEVqTnItEIM0kxCLq+zWZ+KYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366446; c=relaxed/simple;
	bh=LTJOMtoe7yScaaguL7Oni8uQ5NWZ/HHFbkhQtx8CreA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PbKApMZJWCQLCwjDweX7mbXMniOBjPqpPukvLxbEa786vlVVnDjr/7UPEK+/2uoWJGCqjvo81iNAV32O+Agp5ZD7QqRltpnN6ujw8tFAn7SoDsjmN/9uLdwt6oZeT2PsKsQivcqENw4HanM1VolocHsaFEwk4P4K7DH0Myv4Vm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwTbOU94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52D6AC433F1;
	Wed, 13 Mar 2024 21:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710366446;
	bh=LTJOMtoe7yScaaguL7Oni8uQ5NWZ/HHFbkhQtx8CreA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MwTbOU94zGcMX1JqRx24JbF677Y+yrWzHllURe1326E8lXwvsFjVcEgkLkcXoRr4Y
	 1H6xWImRnwHGglatlROSCUqbLKOUK1A54gKdX4udAlk3IHe2SoB9bIe3Nr+nzQCogX
	 orksFUZhEK2XZy0k/dJySNFaBKFTolwKsYGJLROfYGlrs052OkLUFFxTbJd5S1hZ2F
	 ig8FTgH0fjvu30sEODytVLMjuayAYWJEVfBMjQR6Fx33iG7KImB0k0e90zHXK612pU
	 6TtIkSPMs+WFj+F41KZcxsNGY7Rel+PGXiUPo1zWYjB1HxBfJwito9ExhAWMBGcsPM
	 ynVGB3RxHwYTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 409D4D95054;
	Wed, 13 Mar 2024 21:47:26 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfEDmCMBe2b6Eyky@bombadil.infradead.org>
References: <ZfEDmCMBe2b6Eyky@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-modules.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfEDmCMBe2b6Eyky@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.9-rc1
X-PR-Tracked-Commit-Id: d1909c0221739356f31c721de4743e7d219a56cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce0c1c92656e3ea3840c4a5c748aa352285cae9c
Message-Id: <171036644626.31875.5937353448305489267.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 21:47:26 +0000
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-modules@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>, Randy Dunlap <rdunlap@infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kees Cook <keescook@chromium.org>, mcgrof@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 18:38:32 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce0c1c92656e3ea3840c4a5c748aa352285cae9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

