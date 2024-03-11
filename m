Return-Path: <linux-kernel+bounces-99371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A32878769
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E78B22376
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF8458112;
	Mon, 11 Mar 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tda+R1yF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110565576D;
	Mon, 11 Mar 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182029; cv=none; b=rwKW9MtHU2RqYXcmzdjuyCIma7KdfdVC0zn/QvXMXhccV/AZdzwhJes7kcZUclq5BElunLvz2tOiwz3aTCG6TWUDF4b9rc9ww1nHyV4zuuFEvVYDj9lzVRR7suPT/d1Eh14DrAXG/ieHPRDSORIXgw0Z3Fs4PKf574XV7tQiQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182029; c=relaxed/simple;
	bh=rkD7RpXY+7MWiG/caKgaZLTZ6RezyYxLrS4DhmRKf2E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c/mpe36tv/5KxisiLZoloyUeVpJgqobs/r7apG2ssqRyR+Rka1EKVtu9AaHc6UnrYVyxik5aq4IYv6T9PrMDXh5SZFDTQFUzQCY5F2HpjDaAP5VJUCz7zvgcEVP7139zK17hcc50JFuW0ceYbF9H3Nc6QOkG6JxCUkE/gBTeEB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tda+R1yF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC866C4167D;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182028;
	bh=rkD7RpXY+7MWiG/caKgaZLTZ6RezyYxLrS4DhmRKf2E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Tda+R1yF+8sJWIXNhVg51BcpIYmgNnQ3nbFWVgW8+B3tJiwjqLfSQePphwgEd3RRo
	 ISsrtbCKiL9V3glqqBuOjCgn67Vxw/Q3WWIRTwYFf4M7xaF+aH8t9X6QSdg/YRILEl
	 i1jpBnI4b2BJKIG/2WyaajE59RAwB1DsgPuPpMuufo/GwGWufe2bajRmG+Tqfd2VHV
	 0aamPzSrIzPZwrFhUUYXWmpLgpKrzpi6io9oak3qYFvSECJftLpe4STstoEmpVKhtn
	 gg3nmGA4/kfQ9gU8b3xj4rAlpJuDDWAhZ9U3rKNxYZpfcL60Dfej3vswvgp0uMmnUL
	 SRCOhKWBMT6HA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB887D95058;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Subject: Re: [GIT PULL] vfs uuid
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240308-vfs-uuid-f917b2acae70@brauner>
References: <20240308-vfs-uuid-f917b2acae70@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240308-vfs-uuid-f917b2acae70@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.uuid
X-PR-Tracked-Commit-Id: 01edea1bbd1768be41729fd018a82556fa1810ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f1a876682f0979d6a1e5f86861dd562d1758936
Message-Id: <171018202882.4685.5917067549219642332.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 18:33:48 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  8 Mar 2024 11:19:05 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.uuid

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f1a876682f0979d6a1e5f86861dd562d1758936

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

