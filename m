Return-Path: <linux-kernel+bounces-29616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAF28310D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE795281B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C218F74;
	Thu, 18 Jan 2024 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7v6QMOn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23F8F59
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540823; cv=none; b=r9i3TQ5IK/QNwjynOH7We8KdlG0yL9WGCNd4CJ1sK4Yy9/2gQyNUzhmj6vGx63vkXTlPFw6JrqPBW7Ml4qWNB1UyOPUqMmbLWgT3Za64QOQA73e8Ibx467Cw4kKFIAMri9WWJSSUs7pgAhGUw9MM6VLKe7OnpaXjLEXQXDf7VGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540823; c=relaxed/simple;
	bh=9tiMm1v3f+cT1DqnewH3ZsVhXrDSKb1aHSlh5yf4ZGA=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=Tndih95KX3s1LIWXxUETip6RknNR3OShTLee2nAhDihuFUdLR7/1rPv4/pf52c5Zrl/qeeGy55C0+RkAW2/WX9HSwNHeMCrhoZmHhg/dYRvIugHD8JHPfcd46CZBwWHD/qPS5ZJW6vw/HyeR168VL38D7s1911JWMDShAFcjkus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7v6QMOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65EEAC43390;
	Thu, 18 Jan 2024 01:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705540823;
	bh=9tiMm1v3f+cT1DqnewH3ZsVhXrDSKb1aHSlh5yf4ZGA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=C7v6QMOnbW+4oxnMu1k6x04GB4l4InHQw7sd/XAf7z6KUuPIQXpAywUpXeKyiWb3D
	 zcC/lDYLU9wIPBPOPbdgEwWg+3eV3v0ZRIzRl1seu8Mg9/RDN7EMgiv3C8/5AxJdSY
	 6F/D/ZMazrIqH8pN+OlgDr5x6x5ypcdAva9UYvCX0v0g+j81xKtUJE337wF7BKzqdn
	 rS5wuf6RT5KUeFt4nMcg46yHlX+cSXNoVYXwhrTvMeNgJnlVmf5MzXyCufokThMBLb
	 ZIywXsYMDrMVoiGN9hDn7x1T81R1LbwtT9sUKG9PGOFX5Ph5N2Aloj1wfLz9TDZI5b
	 gWZvrsr4hQyiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55B8BD8C96C;
	Thu, 18 Jan 2024 01:20:23 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zae2CXdDjX89bxKN@kroah.com>
References: <Zae2CXdDjX89bxKN@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zae2CXdDjX89bxKN@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.8-rc1
X-PR-Tracked-Commit-Id: 5850edccec30325707f953bc088497b3b9041231
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 296455ade1fdcf5f8f8c033201633b60946c589a
Message-Id: <170554082334.21862.8835173740471334760.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 01:20:23 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jan 2024 12:12:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/296455ade1fdcf5f8f8c033201633b60946c589a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

