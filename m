Return-Path: <linux-kernel+bounces-98302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B549877819
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C613B1F2108F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B2439FDD;
	Sun, 10 Mar 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZo0eIc/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7D3987C
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710097212; cv=none; b=EHPKS1Vj+6qfzkIEhZ9vb73EJCmrnXcPuAwSpZyC5Tx+yxWDE0Y5x7zj1uQqRpaVR7UyuSxukYqQlsc3RAMU7UoEarZMHUhhwUjcEKbVe32rATav5SpHTdjTl3g9GAUJpU/U/S9ikEWt0l76lcj5EejsjjOQRmASAmde4jbs4cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710097212; c=relaxed/simple;
	bh=FK4H1mezFqdFro1JGhqHABzE54G6XxrM01VMc9pc1KA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=R38iJLPP+Gapi5kagNFKxrdll/islMnORtrY5OCLH6s14tyWOBrm2mDTpHfSR+udsup28nD1d4vY8HrdaocY5Qklz5aa5TUoWzgGDzt9+X5YOJQNTWfoUyeC6fwSHfAeDOcpl2SYA3WbW+0/V70OjnA1xJmtHBbeCZ7otILc31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZo0eIc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7723CC43394;
	Sun, 10 Mar 2024 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710097212;
	bh=FK4H1mezFqdFro1JGhqHABzE54G6XxrM01VMc9pc1KA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MZo0eIc/V7MdWbmu4YL41jds3s+kTtgXyHAIG3gJrbq1LLD4+3L3SU4rTCd2kzQus
	 nSpLkiaiLXWqFpJEeVhGvUJ833F1uoLXqrlya8fx9om5ukr0XNGhw4fES9RN+NcjwM
	 /7fynPEh3lfJdy+geXzWHroISRPnPnFxcy2KZMSmxx3yTnJkFpfQj9nEi7dwiTVtza
	 E1K0KMkzG+v3DI4H+JsHtmqVV0mr/iE9qrHPhs2MNV5u4hJrXAyUFN+dxqeGLgGd9r
	 4jbPy7HWJqG4L1igSsiYwjiDOUnKMpuzVHXC6HOa98wL5WdWUvPLrd0jg4UESiKJGF
	 5RyKG14doYEpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44D64D84BBF;
	Sun, 10 Mar 2024 19:00:12 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy fixes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze3olI5SfqS-1RJ0@matsya>
References: <Ze3olI5SfqS-1RJ0@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ze3olI5SfqS-1RJ0@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes3-6.8
X-PR-Tracked-Commit-Id: 47b412c1ea77112f1148b4edd71700a388c7c80f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 210ee636c4ad5e88a77f858fa460033715ad7d3f
Message-Id: <171009721227.15660.11407102587561504224.pr-tracker-bot@kernel.org>
Date: Sun, 10 Mar 2024 19:00:12 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 10 Mar 2024 22:36:28 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes3-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/210ee636c4ad5e88a77f858fa460033715ad7d3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

