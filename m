Return-Path: <linux-kernel+bounces-84297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C782186A4B2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5D3284B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798451370;
	Wed, 28 Feb 2024 01:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1JApS2z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FE184F;
	Wed, 28 Feb 2024 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082155; cv=none; b=iRZmfsqiVqqLoYRqJAIrM7Gp5CR1TX26Gip8NaubfsuvK27iunuGMAunafRhWhw84mgjeveueK5t8riL9TOCw0p61d+oWiVQd+Pv54bX0275Ht0vffJ/QRBg9+LW27XnV6VsThGIME5ocUQ4DisL6GWTbC3UpjpKBQEH2RjpuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082155; c=relaxed/simple;
	bh=Ss1t8tOexe1bUSVNAlwlvIUbyWlzH6hrnRn0aEYnpXE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ptiOFXj+LkWWM8AbJR3tWD5NF3aoSxofKVnuyCs6YE4z/K7wR+/7X4PVkDDdkyCKGuEysQQ932Tb4BPTVthBPFQEiTe67X2mpP5NA3dY87xp3mhjefucq6bMsYaFT666hem+W64t0KwiJjBFSN5iypHbqC9KhNlYomTXk0W/DkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1JApS2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 413DDC433F1;
	Wed, 28 Feb 2024 01:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709082155;
	bh=Ss1t8tOexe1bUSVNAlwlvIUbyWlzH6hrnRn0aEYnpXE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T1JApS2zC+bcikQhNryLEDupF4lOKSEIMD+NKV5G2z8yI3LITzORfrmMkY7vJaq8Y
	 ELYU7kaQMZkwr9/Ivq90v3NhDizxJlzlPKtyqcQyoEFew+OljqcWvbbrZXpkkeSTUg
	 pIR3YmkGS3VRLes6OWBQx0oXB4Oa7R06IlmMT2nTCBiHFi2Z77sMPz4+rKXyVj81Mu
	 7dsIMXdl2hQXQ8gEM2w19ZNBL1Nh3+Sh9vpjcnFpx7XxzbX2r/ORCJit7zfH49TSi+
	 Xp3/xNuiYWWLw9m0aIDTZkITpnI5RUutyzXB0Iabk+ehq/9o1hoPngNO0FefTd3JrW
	 y0JhiYt/53jNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DE32D88FB4;
	Wed, 28 Feb 2024 01:02:35 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240227145619.40b2f9b33dc2723df27f68c0@linux-foundation.org>
References: <20240227145619.40b2f9b33dc2723df27f68c0@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240227145619.40b2f9b33dc2723df27f68c0@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-02-27-14-52
X-PR-Tracked-Commit-Id: 720da1e593b85a550593b415bf1d79a053133451
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e10bf6cb4cdcc0ede9a83a0d986899dff219bc0
Message-Id: <170908215516.19908.14770012690399718602.pr-tracker-bot@kernel.org>
Date: Wed, 28 Feb 2024 01:02:35 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 Feb 2024 14:56:19 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-02-27-14-52

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e10bf6cb4cdcc0ede9a83a0d986899dff219bc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

