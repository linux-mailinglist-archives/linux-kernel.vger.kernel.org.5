Return-Path: <linux-kernel+bounces-122378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE90688F5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533DD1F27B95
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34EA34545;
	Thu, 28 Mar 2024 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og1JxUQl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CBA1DA23
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711596600; cv=none; b=CJ0u6rYgjbeiudx4wM8ZlpnP17vw27Kvu4ye0hEaYE/E8PCsG4kOyYVeQ5WmUO1wB5DyMJD5R1M/lW3IQE6C1yxtwl/Wg0RJq+D6DDpLAlYVV4edUH2kXIMvXIU7CpxDqhHAjezs3cBiIkVm8DN64c1NKCVOLXzbjJX0s4dCt54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711596600; c=relaxed/simple;
	bh=CEfsYmiNVGgb93ohKnebxF59cvd3q6hputQVYN/pFU0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d9YOFQuHkFxdxA/lFj0qOEDkzZCujwDVKIBz4jf34Urn9mn+eMGAyGk3ORsUDpnDoMFQnmpvGYNWqrY8ijlV66Z9m/08L0d2MUN4ZSUlxzaeUw/6S7vU9HiZTvu6YfUV1pVsdd2B34qzJdArstgcVyCKUKBfdUo+yXiLs0a4TA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og1JxUQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7CFDC433C7;
	Thu, 28 Mar 2024 03:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711596599;
	bh=CEfsYmiNVGgb93ohKnebxF59cvd3q6hputQVYN/pFU0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=og1JxUQlAW07TW7zEGaMvOQ+WlliLwHCxU+Mc5hq8/wj3qPEMpUDxmrICVGgOyC82
	 YhSEpB+vKwHDmsMdv8iSpxujDQDQEjbKE0/ae0ofQL6c8Ac2KSSl6If+Rudhi4auna
	 aRf0+nt72PAEWEQpAz+uQQYCk2CqDceHNPrUJP7r1xJcUkzQ5yv11TzrvwB2ifo6pw
	 XMpA1QBOCaMbAHYLYAIF9O8AgBcGO4OSDuaU9SbmOqLi2MRmITauUiBUYWrR9SIdDR
	 LZwgQRt/MZJlj1q2734etDpDxm/jHsijWWv5xE1Gqt5N/FEGS1O4c0XPiAvgcv2XSQ
	 iEACgTP67n5FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5559D2D0E0;
	Thu, 28 Mar 2024 03:29:59 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZgTb62/wsjacMpC8@debian>
References: <ZgTb62/wsjacMpC8@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZgTb62/wsjacMpC8@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc2-fixes
X-PR-Tracked-Commit-Id: 7557d296ad439f66a87cd34917af2a4172517826
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d025e2092e29bfd13e56c78e22af25fac83c8ec
Message-Id: <171159659979.21268.10017313312226024950.pr-tracker-bot@kernel.org>
Date: Thu, 28 Mar 2024 03:29:59 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Mar 2024 10:54:35 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d025e2092e29bfd13e56c78e22af25fac83c8ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

