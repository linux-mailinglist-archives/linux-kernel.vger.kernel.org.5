Return-Path: <linux-kernel+bounces-100872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322FF879E75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D3A1C22295
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D1814405A;
	Tue, 12 Mar 2024 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfi0oUT6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8214403D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282245; cv=none; b=UsIMmTk997N3F/HxQlOeiMjOSzm2r5PaeQdwaBXH+sJIsgq6FoOU3bBrtyksH5GGLPnv7CepKeiGZ/rjtHvWI6snzSe70Z9+aQso9inX3qz50oQsp18hfmKf/0CxXVmZbR/uavqMuTGT9JK8HLe6Y2+cPGTbHY0LdYZVGqQMBjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282245; c=relaxed/simple;
	bh=NDwBSQ2LV62fTEQ0G2MaEUwSk9ffYrpsVoU2mBwIPqE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TVvdRxPj/mWtHGVv6yGX1HaWnXoBNMV1o9iR/gNgN1izzmu3LbrJh2XdR3QcAkfumfDxUj8ngjyu5fysyCxAuvbjofoj0dO7YvIi9nES6dd6k/TJUScoqAeNK2DUzUafqaIv90eC2KfW5Zr1xRZKDtBMazsNpGt+NJ+Aa4Bx2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfi0oUT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDB98C43390;
	Tue, 12 Mar 2024 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282245;
	bh=NDwBSQ2LV62fTEQ0G2MaEUwSk9ffYrpsVoU2mBwIPqE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jfi0oUT6uSOelnJtwvxB4B0z8hn4bDacFzcK7GRQ0lJfbUqP3yLsTWxl095UhuFQb
	 Yxxe3GJJ5SRRHgYa3KTyC/sZp0jAns3h5YbnJv1IAdyyhBNkWMCnpeODBKk/qMj6st
	 vVw+VrNRoZGsfx4WdUTzGRxVgcHwKc2qiyPYg1n6/oTWsQ8KoBr+jbZNkW+bdbhlux
	 tDMsb7RM8AW9AgA/zvqqsMO/gWNotSlbq9kB+h7mZ/VbOW8rGBjnOumIOSYctBi6p1
	 sCDPLAh0WUlAk9w+lHmK/5E3aQ//au/VP735FEUtxaGyn4xd7HSNV8W5t9IFAd4N0A
	 kLzTSGaV+S2aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE73FD95057;
	Tue, 12 Mar 2024 22:24:04 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze/oXlaiQfdspyNX@debian>
References: <Ze/oXlaiQfdspyNX@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Ze/oXlaiQfdspyNX@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc1
X-PR-Tracked-Commit-Id: a1bafc3109d713ed83f73d61ba5cb1e6fd80fdbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f153fbe1ea11939e2514ba4b3b62bbd946e2892c
Message-Id: <171028224484.16151.240329771196733706.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:04 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 13:30:06 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f153fbe1ea11939e2514ba4b3b62bbd946e2892c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

