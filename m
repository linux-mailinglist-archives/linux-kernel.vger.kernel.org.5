Return-Path: <linux-kernel+bounces-102559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88B187B3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2618B22438
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F37D5A792;
	Wed, 13 Mar 2024 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSw/LkxH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3955EE76
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366458; cv=none; b=lkjXWxIbYb5oTAwmrImcJu+jf2ideF4QxkxxCXELclWBAO9oU05f3xkUCYHyqlbX0tg3K/SFnudiOiyGcBtqnziFfiEX0CD3Eg6uQVfRUAaHrHkvA0pkqebtRPkXT/HHissIJjAILTVyzmxsB3q1Bqw+5RA80bw6jqhFSK1/7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366458; c=relaxed/simple;
	bh=LnwQmZ+5ZhRhu7eu19UeR92f8mknUq99peUlExDoK3M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XNekAZ6raEE3fdZ3ERMHbfrBDGzmy/zjrxwNbRiDaGvB98A5lJazPjKIzZs/L3GdLymo6rwm8IFMr+/mvHufoNLyIj0Y5kQq+QTPvwI7EmLg0G3J8ckhmSgeV1vF7WDSp8+PkVzyIn/3Z//UY0BdCp2lvpRC+OO5aHVURM23poE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSw/LkxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0434C433B2;
	Wed, 13 Mar 2024 21:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710366457;
	bh=LnwQmZ+5ZhRhu7eu19UeR92f8mknUq99peUlExDoK3M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lSw/LkxHr9QnFJE3kcUKOOnoWmPUGQ8pUInMSFOe8kmzJ1NtJoa2CAQaKZh8N+/4J
	 ZSMKaeiR5NVO3N9TdJmvUNhEU/fHNk6vIifvEX8wIz6lGwRgiVEdI99RtWevrxjxXo
	 WcOuNmbaYsERQyxD3jW8gCn6JSTUx+9GpxZvFcDdEfvzJgxiFV+G76+oOFatu1BDTe
	 qepdMLQfaVrtTXr712gDii58UheKb1HO7HrynNU5msLJqZZYhPns5qnubPTHkMzPJM
	 d2bwG2hE78icOmFJpDspOBKI2eiK72zZ1iN81k7UZgicN1Vq3KahmwIK2Cv0OyCMat
	 wMOSxVrEpXfBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC7E3D95054;
	Wed, 13 Mar 2024 21:47:37 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY3EByujxcqZfwawsQAcmyWjrLnkbZmTb5j7Tqzkyhb5=Q@mail.gmail.com>
References: <CABb+yY3EByujxcqZfwawsQAcmyWjrLnkbZmTb5j7Tqzkyhb5=Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY3EByujxcqZfwawsQAcmyWjrLnkbZmTb5j7Tqzkyhb5=Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.9
X-PR-Tracked-Commit-Id: 8df6bab6cb9abc98736ffae410a74647995873c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9687d4ac582fad1af9979e296881f28c3f35b05c
Message-Id: <171036645782.31875.11161468155441694580.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 21:47:37 +0000
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 23:48:47 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9687d4ac582fad1af9979e296881f28c3f35b05c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

