Return-Path: <linux-kernel+bounces-104890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792FD87D50F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF512873EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0293056758;
	Fri, 15 Mar 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz7fBKT8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DBF54F90;
	Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535056; cv=none; b=Xjq3dgvdEEUOCFobYwzp0xz6Ec/fWmKT8d0C/fRGyG7fEFxL4nz1/QZQyBLrBKh6dVrJUqT5Kp71jDln42BVyfffp35JYsoyp6dV3QWTg0i906o2Ycge39fHlfWNFun5xhzbHjQXw+1fTm1ebt1DXr5YtlRaYEogBpzcioDohfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535056; c=relaxed/simple;
	bh=XOGb3SMdykwlM+sMOP3my1nH1dJusdP9WhYHEu6eEjs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d7aAg3C2OjudCO+OAd4SfYT5f5jvUoJviPvnqEMxJUM9FXnoPt+mRPpuiSWvy/WZeHBaKs3YiKjSInrln56C2GxN9Cs3lslPBq23ULE1xM8/RIhqpyo9b4a/QXT7IbM/ENIGkWVLSGQbA8sy0PUZX3GsQmPNuLpdCVKFGeJplGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz7fBKT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E4B6C433F1;
	Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535056;
	bh=XOGb3SMdykwlM+sMOP3my1nH1dJusdP9WhYHEu6eEjs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Cz7fBKT8B6XJolb6jvKk55mipEJuOk1zpQmwQItLyPLi06RGw2+4emCbwy3RndLNC
	 8YHmTfnlWEvy0Zjd1USg3mrpc/HyVfGtgrY/ui7d4rFYrcB7GqG7uYKm5H19/YJRbi
	 dYzqLzeSqlbjmqsApfAcDWN3331YhYzwhKjb8kdlWU/593NuvLpQOoGnPEpweKa0ZZ
	 Mk9FmUEFmr3JhWYTk2gLwNBq8IyArPjcZ2bjvkzjXuJ701YFopfoglTEiyic3H3A/V
	 moWtA+/mpyzDi6HBFZqskmNbV1q3LWj1e8GmJ1OG6WW5X+EwUzXn+YRueZSVjhr6zZ
	 LZXc6MD3yS2zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1509BD95060;
	Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfQYfNzwx/4WeGKT@alpha.franken.de>
References: <ZfQYfNzwx/4WeGKT@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfQYfNzwx/4WeGKT@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.9
X-PR-Tracked-Commit-Id: 732932220078f6312f3ef57c17523d3d7f995655
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54f42d2ca84ea9d490e6934392954c9c320e3048
Message-Id: <171053505607.29375.4113284848308356641.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 20:37:36 +0000
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: torvalds@linux-foundation.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Mar 2024 10:44:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54f42d2ca84ea9d490e6934392954c9c320e3048

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

