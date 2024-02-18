Return-Path: <linux-kernel+bounces-70484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F075B859881
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908271F21363
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73DC6F503;
	Sun, 18 Feb 2024 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSATmoLq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE996F500;
	Sun, 18 Feb 2024 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708280528; cv=none; b=GBQJ61myi2tcrrD4i+7zlH3jBBFcxovbJatMgmzgIu1x2p0xp4OFjup7VAja+7fEF+rc1XJBBCfxQzESKVqvTp2rH3a0RvUEBx1wOir8q5KKBuGLJQMu4V4O3dJ9WgEbt1JesG0gY2461wA9GPYE4BmQWtKIueO5xdJK7cue0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708280528; c=relaxed/simple;
	bh=W/21ChNGp61DoGffufE5YnFqcFGRd4cnnptiDqe7ayw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H62C60/RystR5WjwvdjGo5Gc1GmTyK86sgsUYUu0efmqpcwjbrOl+NRwWaBpzT58SybItFnAYNnNpICnaRgeiZmawEFARaK3d1BmdqJn8UbxT8pwA2OOD+iyv62QQdcfmAm7qQk4X3opy7+HZRUYQPT0cmNJTaLwz/Siwuxqtfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSATmoLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75BD7C43394;
	Sun, 18 Feb 2024 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708280527;
	bh=W/21ChNGp61DoGffufE5YnFqcFGRd4cnnptiDqe7ayw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BSATmoLquRoylWLEYqPPW3Y6CFUZVSsmnJs3cdtJsfo9SColWjILoBW5sj7SWL5pK
	 sxFGmcjisjajkhAPmlZ7uu50yswpNNm57fmIHEE80egfjkqaBSct8uS570iCYHmivp
	 QHdTuCO/Ik2brAOBTpKs3sy/bZwh2/p6R72bI3r/bQg/zVU0TfTmXmTpglTSKv3Oid
	 J6hKTqevwFB+wPCo1XbLr33/VQ5O0dFQXBnTlDqo1izogJVPjEVEedgFROrXjhcP6D
	 tj2ec+rCnEC0GyMmnTNX8dKs7ykd6EWCPkg2nwNPoku532vjNkC3l8PiFQ6ds/qNAv
	 xzz95ldPG6oQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C151D8C96A;
	Sun, 18 Feb 2024 18:22:07 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQShtLfRkfXhy7+avfzbgR+4c86H6sLq=x+9F3GGdsv1Q@mail.gmail.com>
References: <CAK7LNAQShtLfRkfXhy7+avfzbgR+4c86H6sLq=x+9F3GGdsv1Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQShtLfRkfXhy7+avfzbgR+4c86H6sLq=x+9F3GGdsv1Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.8-2
X-PR-Tracked-Commit-Id: a951884d82886d8453d489f84f20ac168d062b38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c160f16be5df1f66f6afe186c961ad446d7f94b
Message-Id: <170828052737.10456.5225402919059913396.pr-tracker-bot@kernel.org>
Date: Sun, 18 Feb 2024 18:22:07 +0000
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 19 Feb 2024 02:24:40 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c160f16be5df1f66f6afe186c961ad446d7f94b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

