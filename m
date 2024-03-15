Return-Path: <linux-kernel+bounces-104893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFEE87D514
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED3D1C2285D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246CC59B6F;
	Fri, 15 Mar 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4paDCdx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140665676D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535057; cv=none; b=UbCWZYTLoQHb3vIJ1x8a9WqHrptvhT3oQZqGAGear8fQnfZYmI+nApERr91xbSNMgetR13oRYKEWQTLC8mXTH4ilc9B3RnqGdrfZRmivlNVMWhMBOodkwQ8utVz29CUyhb3aiQoNME+KzvhKNE6uGDq/eteBRc9rF8bmUSZkjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535057; c=relaxed/simple;
	bh=56WUXUmYJiBVlBlz6n6nfYzw+y4KXRbx4nA73JBW0Yc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VHE09t8WvpfsYi6NEt1FJHkCcsciVOqiQZ8MSkcrIH+MBWgVftdl91buLjqcqZiEYRG+gMZwB/6+Nce4mFwYGpgVf6VVk+Yh8RwtOm+cc/yFW1fcBgSbPcqQXfiyxFJP3L1cFITN5S8i87atqHzPGFsss8ZMifA3pjtbF+Z3HlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4paDCdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E96C5C4167D;
	Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535056;
	bh=56WUXUmYJiBVlBlz6n6nfYzw+y4KXRbx4nA73JBW0Yc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h4paDCdxpamxsRMNzczFJuxdtcB97INCOWAuyJUsXj2XxwqzYfNjlZD8ViVi3eljo
	 9yBM/addVrsh/nqrRCuRAvjyTakvB/wph2EgoNhcFBDOzCq3LgiHEAARX5bavpwo+3
	 utFi8FvmLzQC/CgxooxQit0CfIzsuMC70hqRcAsiMCXslQrWt0h3BNoO2qyiikIfU4
	 6JALtrqESaLMiGlN0k0D1POIplDgl4Kzf5w4DlUY2TQwLFm5MjFVRZ2v5910tM62/S
	 KI2kcnPZ5UdxBq5n/3gLxk/lYVXcMhUqzK3Cc6uyiNEvZm3LCaEYVyskiSgozkcWDz
	 3+qcZIax1NiSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E268FD95060;
	Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
Subject: Re: [GIT PULL]: Dmaengine updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfQ0bxZak7Nc3f6v@matsya>
References: <ZfQ0bxZak7Nc3f6v@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfQ0bxZak7Nc3f6v@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.9-rc1
X-PR-Tracked-Commit-Id: 716141d366f45d62ffe4dd53a045867b26e29d19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b3a4192dd01154bbb9f7c887c4b0fe35c9dc712
Message-Id: <171053505692.29375.6668439216204660518.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 20:37:36 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Mar 2024 17:13:43 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b3a4192dd01154bbb9f7c887c4b0fe35c9dc712

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

