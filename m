Return-Path: <linux-kernel+bounces-30711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B7E83236A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA7C1C22403
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888CFD53F;
	Fri, 19 Jan 2024 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHx1d36j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1884C69
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632021; cv=none; b=WOZu8NrBcjqsPVQSiOriUdnPoLMD/u6I2al/9E9VzJk/4roSJ3NUi2bth831BVwOwsxK3Rtq/jDWpzbFUH/uD2O2LKbnyPOlDdK2dDjgWkEV6/FcUFf3bfvDianh8rvB9X9+mwWEt04u+jg/cA4QQElIIagYOSenayG75pqWE7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632021; c=relaxed/simple;
	bh=3LQLFqkSRwpBdrvgaAJzv+QRr4GqaLfcGn2KjUktbXg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mytmt3frP8D+638oee0Fb9ITm9s7e4OeeaGL9aouRzFShuhR+xDQzXNkKBaFNIrFoqjn0cO1kNGltzr9lj1QMQhbQDSp0uPbzqjL3jZBURPsFStn3089KJQjZTaQHfOFCZ1JgX4F2IiY3+BWCd6kDzw/iCXTEF589WAxswmswOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHx1d36j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E913C433F1;
	Fri, 19 Jan 2024 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705632021;
	bh=3LQLFqkSRwpBdrvgaAJzv+QRr4GqaLfcGn2KjUktbXg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iHx1d36jRgOWao3gPv4TmShkzfW0+uDB+zPKNzHT/9qPlLrYxR2rVwlWBUNDx3sBc
	 4IpLHSdr+nAPY2qI+sPeLzJz5Kjccq2ifPPmBJU2uS9LUPLYuOk7N3xe5HzkITOxAv
	 D54rm9JGL/XLrdw8EpfcdfFsn9Ub6V2z80uWsAbIZL/AEvjYJAq5P0yuy25r6046Px
	 fL1pqpf9grbKn7Su+ASoOb3aE+wJB6kZFa9GFPbsiEO5gcW9jIRCgzxDkl+Kw38/tB
	 jKCNk9/wvYUto4Np2TzfuWTrF3F8HrQIydq4b4plXtoDrJNsVKkh9QQrb0J9rB8jCc
	 Gw4rlupbTOZBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89958D8C987;
	Fri, 19 Jan 2024 02:40:21 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZalEiKJWhdH2D9JV@debian>
References: <ZalEiKJWhdH2D9JV@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZalEiKJWhdH2D9JV@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc1-fixes
X-PR-Tracked-Commit-Id: 2b872b0f466d2acb4491da845c66b49246d5cdf9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f3625006b157c5a460970ca4d651b100bfa67bf
Message-Id: <170563202155.16016.7679623835755808959.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 02:40:21 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 23:32:24 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f3625006b157c5a460970ca4d651b100bfa67bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

