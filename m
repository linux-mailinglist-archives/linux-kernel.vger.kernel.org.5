Return-Path: <linux-kernel+bounces-100647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E095F879B39
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814E8B20F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8DD13A866;
	Tue, 12 Mar 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbk3L/e0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E760139597
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267609; cv=none; b=QXpjZzftWXvoB2i6HORtruCCUgDu6D2XhcCkGYfcjK8ARAqgs6EWPKxpLzegkfySBtQ/7okQgU+fdp4+Q81cnGO8FGV8JS/4qZHk310eziJKUECC/UITZ2MKpRtGLQJ3/JnaCaC+5LPG2RmPnvm4GcN5nIWX1NTR3nCE1OjwQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267609; c=relaxed/simple;
	bh=hwqoQLazlRp03OTGfEBfvs32LIr3/WgkmSbbMuv7IKY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UdFcgWEA8Bg6dlk9+qeH5GbQBfwJ1sxFaJ8Uamein8Jg/kP3Ws/AFcvQdISyrY/+EgwurTTKCDh7qKm4UVkXsUx/tLqBogrUBDIF300Q/rq8Z/gdrOgWzFUOqaGNeht6Jnwcjb3NMwLnmoOKpwEE4eeOCFhjVaLlnhFRRae1h2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbk3L/e0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47A45C43399;
	Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710267609;
	bh=hwqoQLazlRp03OTGfEBfvs32LIr3/WgkmSbbMuv7IKY=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=rbk3L/e09jpQxtD10E7TbtFiBV1KomN6fCG98d/S3zP+kSH5cyq501n0JETIIJJ5e
	 GAaeQgkRNnk3eV9O96k29S7A7GS9H56pR5d5p0RXa4IEr123GG+0NU4SR6/XMIFK3k
	 10m4ykBrbccxB0/2rZOwJ+U3bOjV76OWUni/7VIWDRR5+srGAmhViaODYYb5pzt0G0
	 M1JaDoD3N+ylXaQ3i71JftHyIVGcxWCx4eOuzZGyOBSt2qyjhCUAy72E4EWXxv8HuK
	 SMhbKqatzFKnp41HzOk9acfYtUedQMJDMRBAUEq+hwX8WVXD+77xDsUti/LhO7qVFw
	 pFoeMFV33EVTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D7C2D95061;
	Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
Subject: Re: [GIT PULL 2/4] ARM: SoC drivers for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <2bb4979a-508f-4791-82ac-ce31065f6da1@app.fastmail.com>
References: <89d0bb77-a608-4ae0-b9d9-e17fdf5f12da@app.fastmail.com> <2bb4979a-508f-4791-82ac-ce31065f6da1@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2bb4979a-508f-4791-82ac-ce31065f6da1@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.9
X-PR-Tracked-Commit-Id: 049238d24467e3d2121e8ef2abef1149be6722e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2184dbcde47aefd5358b14463a0d993013f5609e
Message-Id: <171026760917.25732.10991309858732518614.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 18:20:09 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 17:45:29 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2184dbcde47aefd5358b14463a0d993013f5609e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

