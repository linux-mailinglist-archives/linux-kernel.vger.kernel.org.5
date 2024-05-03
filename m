Return-Path: <linux-kernel+bounces-168404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0561B8BB836
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DBA8B22DAF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC2784A3B;
	Fri,  3 May 2024 23:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdqqUa1I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEACA2C684;
	Fri,  3 May 2024 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778777; cv=none; b=AY4cPktkKALRk8xQKVf0o11FztcxGSzjN3uYh5cja/z4uobVJur9a5de95J2W0Jc5m7r1CyCMuhM28wnHSPDkHltKS4X04KXvjQVmQE0tfWG5eDle5joZQNvf4wQiGFgdxrFTPz4BNze0IrAvgDJODUfWatmf0ftgn74TzYw604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778777; c=relaxed/simple;
	bh=ooDSTrrnJaPNjnEpdZTK2JnudZxAgCc1CC+HWSsoSks=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d33cj1MTLADjgPbgG/Cca1IdBCMa0rMCbrcUc3fuc5oeS1wbDLm56f4xjw1H9UTNe74TH/gSprAtizFlJV/gHuVHVSjABexSqjZcThk/1zLUCZh03yXsh4PQ6jRahzoIIbgsI1Z+oL2DTcEZXfgAV2nxzL8UypY+iB6PgGN0zSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdqqUa1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45F71C2BBFC;
	Fri,  3 May 2024 23:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714778777;
	bh=ooDSTrrnJaPNjnEpdZTK2JnudZxAgCc1CC+HWSsoSks=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mdqqUa1I8qgp6Uw9SI1YpnBraFM7VcUpUarrwpm3agz7d2ViuHwwDg51fLc7Xbrn5
	 LycgJVPQoFmeL9ZPku9OrjBj5MWB+ffXfOPt8q7RHr+PVccspCsPafWO4MAeKVo0U4
	 3ij7Z5TQjN5XJHJfXhF1Lf/PgdiOfYQa4teV+sxeQR5/FlIOW5AfpN6PUKkTdhLnmR
	 QTv8o0E/2oX224aesg1ladnRwUYv1+v1VjI/Vih9VpSQN+EuUw3PEw3KrRx2dk9nH4
	 jqNNBzSS8GVM/8sAwwQOaXXKQOvoOTW4PDWCXWOB3RHX7E2VgqYM3+N343Oea1PEty
	 avEIOgDpVdNgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AD7EC433A2;
	Fri,  3 May 2024 23:26:17 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fix for 6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <64b8cfc3-c2f2-487a-bced-8519690239a4@intel.com>
References: <64b8cfc3-c2f2-487a-bced-8519690239a4@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <64b8cfc3-c2f2-487a-bced-8519690239a4@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.9-rc7
X-PR-Tracked-Commit-Id: 5d211c7090590033581175d6405ae40917ca3a06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7367539ad4b0f8f9b396baf02110962333719a48
Message-Id: <171477877722.21900.18023377163439705041.pr-tracker-bot@kernel.org>
Date: Fri, 03 May 2024 23:26:17 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 May 2024 09:21:51 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7367539ad4b0f8f9b396baf02110962333719a48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

