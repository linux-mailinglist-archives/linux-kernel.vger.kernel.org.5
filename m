Return-Path: <linux-kernel+bounces-117693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131BE88AE7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FE41C61192
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6FD1BF38;
	Mon, 25 Mar 2024 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rai8Zd7Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E831BDD3;
	Mon, 25 Mar 2024 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390705; cv=none; b=fYAfwdLvc1TDsThpke/sAD4DTcnoWxxb9Nw0hkXvVyCVIsGTx3+jU4UX8ACuItxu29e/5D5ogxGg+li2I9uKqmrrjOuq2AZsRzTqE1rkahm0tzU+4i/4es/QfaqS8GfoXNbsuFOHV9Klm6h0Y5q/D6pnz4GfPeA2idewablHyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390705; c=relaxed/simple;
	bh=7/6dO9fRg9aE9ipYGYuuuodDY5Ok2jwh13zUxvc5Dqo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nlS6fQp4A7NWUQnoa7AIMm3uD6dDSsRoLyT9Jmr2g7slqaK7TCvMJbVuGXVB5Y9J7umUawF1zNW65NomF2vp/xzd0HG3osNvo8BUHXPd9VmGBVrIrM0/kWHs5clkFF2E0hTaswDrR140Vtfj0TwgFZK+0qx/jbQiTGrrWN31cO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rai8Zd7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93CA8C43390;
	Mon, 25 Mar 2024 18:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711390705;
	bh=7/6dO9fRg9aE9ipYGYuuuodDY5Ok2jwh13zUxvc5Dqo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rai8Zd7ZJn9swG9VfYsfPT9Zpqxzy8OkvEzLL1iqhefeaxjVrKHXH0D4fNbHAUGHb
	 WIjcxtRBkyIZR9reHxYKx4BuvNNeVgry0sKxRj88P2jwIZu0GTD6A5v98TyL5jS2fO
	 /9w81stQuNZlTieggj9m4u0VhDQTRDRb7rxk22KD4jEwS/axru6Ncb/RmldXsSQv8i
	 0KA0FRUVj9XCzZ2pLUsPGEB/h/21mmult/YAkVMDwyE2/0h18FWX2wtxuf8uof1xkz
	 rOBCZh+/jTsP/S805WzXnDFSFWhhbX3WKcvDfMPrpvLPM2WVVp2gb3sgaNEtUv1PD0
	 m287zwivEou6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BF74D2D0EA;
	Mon, 25 Mar 2024 18:18:25 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240325121020.337540-1-agruenba@redhat.com>
References: <20240325121020.337540-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240325121020.337540-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.8-fix
X-PR-Tracked-Commit-Id: c95346ac918c5badf51b9a7ac58a26d3bd5bb224
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 928a87efa42302a23bb9554be081a28058495f22
Message-Id: <171139070556.16418.2236620180848658199.pr-tracker-bot@kernel.org>
Date: Mon, 25 Mar 2024 18:18:25 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 25 Mar 2024 13:10:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.8-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/928a87efa42302a23bb9554be081a28058495f22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

