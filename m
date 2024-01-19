Return-Path: <linux-kernel+bounces-31459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF15832E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728161F25018
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3D156B91;
	Fri, 19 Jan 2024 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hvg6dBEr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50F5675D;
	Fri, 19 Jan 2024 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687384; cv=none; b=tRSaCynzqyl99wq6sizX+jUSc4TKi3htO1yt17yqLzdgxm15HJD0bCcb6g9HlP63WvQiolDQDYJKWt5dO7ajLDPg9h86DFn8J2XENkH+TQto1ymVXlAJ68T6PRy09nQm2aOFTTGSgKmIHy5CVh63gwob74vqgMaU53pTxB1nh2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687384; c=relaxed/simple;
	bh=7kpAKQYJJj6GVcDJ5IBw9xkArrXYGFOtaoxLpK2D8Ls=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lgDBgORmSerD+418078hrUHDiFWbJCDejcsUAiC7gHgbSUYGZXjNpOwF3/RhnXPWWyuy822XG0xvrEyZafBGHWYz2sI438gAVrPtnIj4FGKnEvs8V5ixPTn1fePETcfnwUtaWQ+hcoogPpIj/8f/U2GlaytRCwJzIDZcbKJCpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hvg6dBEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0516EC43399;
	Fri, 19 Jan 2024 18:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705687384;
	bh=7kpAKQYJJj6GVcDJ5IBw9xkArrXYGFOtaoxLpK2D8Ls=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Hvg6dBErCpb3iFBZBZkakigzHKFPSo5UrdPsW89M1xgnEqM1Od+DYnqwerg+FQR0L
	 /eIBlgC/hIzpTXdnvYHUSLc0M0qZHnm+ZNDI56igfi1dfJ4PPhtbsd4ekBe8H1bktg
	 7GqvvzlXUPG9za3okgccRKiIEB2+RjEoRb7TWsoyd7y+Rlrq0mQrsnXAJ90iEcPG3x
	 jC/KvJhmnrg9T0XlYrXx3kOo4Bj+3wduIMe4s6UQBiFooCmD2AZugDC84PYDd+U6OM
	 oFS2T9zPMVLNk4ty3F9Z4jNZgnL0AG7i6CZm1t+fKhIWJra2kliYkcHEKOI6evMze9
	 QecBgbos5Bzow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB330D8C96C;
	Fri, 19 Jan 2024 18:03:03 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240119160212.1466841-1-idryomov@gmail.com>
References: <20240119160212.1466841-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240119160212.1466841-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc1
X-PR-Tracked-Commit-Id: 2a965d1b15d28065b35ab4ebd1e51558fcd91aa5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 556e2d17cae620d549c5474b1ece053430cd50bc
Message-Id: <170568738395.12972.9786698282200212625.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 18:03:03 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jan 2024 17:02:08 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/556e2d17cae620d549c5474b1ece053430cd50bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

