Return-Path: <linux-kernel+bounces-30679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C28322F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81697286064
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3FA1871;
	Fri, 19 Jan 2024 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia+JrGkK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BDF1367
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705627491; cv=none; b=iL2E2FG/kjcc20oNjWDGTKBgcSS89FiWLRDhmw25Vy3KmRtebI3O/6smM7HKRPk7GrTt8FMLBnLNZNexvSa5ZXBkoD5dA3uQ8QgH+2NjaRMWAjUjL9IE199Ld44v8S07Lrz/vCZMEz7KYVxcA0eLcSYfHtXu5WuZMSTjfaF8dQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705627491; c=relaxed/simple;
	bh=g4xe8ty0PmjITBGno53AajsRYGmUEkadj+YZQ3W9BoI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A0TNVzuChPTXI0wXWLpqalHnTtQuxHsbWMpvw1uIf+GeJBlEFj3sDu4+1VuR8c3b+XUGA9ovZEDo1lpdwk3XJwQbbJjycA5l+/0kklOS8W+kIlRbPRkI9AVbZilC1gurFRq1Ff5+26sRIt5e+lZmg+i9w0Ri2tNKYVZEDBg34iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia+JrGkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13DF2C43390;
	Fri, 19 Jan 2024 01:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705627491;
	bh=g4xe8ty0PmjITBGno53AajsRYGmUEkadj+YZQ3W9BoI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ia+JrGkKUIXxZNYu20cIoV4HfVwL6fPh5jBRAQOjaJQlymebTp21zwG748U74rJ3e
	 9+BQpD1xwm+7CPWMyVt63H1zOEmbNGIh3uxXi/zqh3JyeXKoe0QZuAWsEvyYHwoXxK
	 OYsnX0xUVj8bXtLqlZD60yL2fzzBqeA1MrzRKG3f0p9LZDaelptWdbOJlU9SJjyztE
	 9OELDE1RFjqz5XcguFzuDoUL6dT2wmLgrU09hSKqnZCv4LeISjMUKBQEml8Pi0vOLM
	 LZ8BToZkDA2LWg3aRi00tUBzbVc1bdCX7L9qRdaaA5YvdsRwHtxCSGcSOT7K3C1RfZ
	 DGYWDDS9wLPXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC3D2D8C970;
	Fri, 19 Jan 2024 01:24:50 +0000 (UTC)
Subject: Re: [GIT PULL]: Soundwire subsystem updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZalYTgul-JeuE9sX@matsya>
References: <ZalYTgul-JeuE9sX@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZalYTgul-JeuE9sX@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.8-rc1
X-PR-Tracked-Commit-Id: becfce5233a78956654f36555f1b9187f8d11d56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d5d604cc48a7babeb30e97aeb443679415573af
Message-Id: <170562749095.26879.13732109933288205944.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 01:24:50 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 22:26:46 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d5d604cc48a7babeb30e97aeb443679415573af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

