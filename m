Return-Path: <linux-kernel+bounces-50712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0136C847D28
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE571F283AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235E12C81F;
	Fri,  2 Feb 2024 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjngJud6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7227512C809;
	Fri,  2 Feb 2024 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917048; cv=none; b=OWRtqZTHo5nlcjyiRF1lKzg2fGnSzzJ3DrAdY0Q27h0UNjSlAGrK6DlHtUWAGiXIc8MnGMy/O5tf7lchqjaR8TMmQlLAMDLKQtwe6AlhecvkAL384zw7pjbTki8Gm/smI2xfK2N+RrFrHFMWLOOvFx7gl6ZNf8InF1AOO+o36VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917048; c=relaxed/simple;
	bh=IRlvc8wQ06XihBsd3DRHQceumsTDxEqkN5tcIa23At0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ARSta0/jSab1N1f9UlC6JPWkBICfxdMSaypjgKO2uiOD9RiciWeIWYdFMNN6iQN60II9cw5rJUScN/3+Al2h/4fRIAcOXocq3v7r8yNIZTvFdF4vg1oHKY/GGWGLZf7G3kvzklAxA7OMAkV5QZwaAV14/cKfp7TX2knRMjv3Hdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjngJud6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07754C433C7;
	Fri,  2 Feb 2024 23:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706917048;
	bh=IRlvc8wQ06XihBsd3DRHQceumsTDxEqkN5tcIa23At0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sjngJud6wphts+K8Pmp7NSBWsR2dh9dMkjUbAZW+klP7w3woe0CjV2aTcmdQw2qg3
	 UJGZ7qz2DAzMPFvsvmaJITSVAhQck9wk+4e+CjBm9XpngNz3XSPF5kYIMYmfNLFF2l
	 A7lZBuNmdxrpZFeonGWaCl7WBIjuSc/pol8qoTaWsiZ8eYBYxIBbO+OZrszOQV5rjp
	 oPVVm31Wv0MVrLRtKZiYXm/E3qoxrYKeAKxDhKYU2PGCnrVxhiZnAU0LvSF+6Z3pjr
	 OBzRQUNyvsSbuHB7OvMLQ82ukGRlMW0ToUg6eIIow50P2bBcBbhDmvu9zgsqt9z2Gk
	 a0fjEkFsTNdIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E972EC04E32;
	Fri,  2 Feb 2024 23:37:27 +0000 (UTC)
Subject: Re: [GIT PULL] Revert "gfs2: Use GL_NOBLOCK flag for non-blocking lookups"
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240202162830.1323578-1-agruenba@redhat.com>
References: <20240202162830.1323578-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240202162830.1323578-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.8-rc2-revert
X-PR-Tracked-Commit-Id: e9f1e6bb55bea4f8cb48f8f7443bbac99b60d285
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b89b6af459fdd6f2741d0c2e33c67af8193697e
Message-Id: <170691704794.22657.17711723595426752602.pr-tracker-bot@kernel.org>
Date: Fri, 02 Feb 2024 23:37:27 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  2 Feb 2024 17:28:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.8-rc2-revert

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b89b6af459fdd6f2741d0c2e33c67af8193697e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

