Return-Path: <linux-kernel+bounces-99650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FCC878B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7C6282263
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E160F58ACE;
	Mon, 11 Mar 2024 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJkcRVjp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E38C58AA9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199101; cv=none; b=NzR4tmEasDVlVc3vtibPPwYz5o7Ajfu92DxbnnImk2RdHHaKzJG1P7Pf9xTQdHFtv2Txh/KRwNcjX4e5F+Rxqv4Q6YzpKjhimjxg39ozgRYw0rG8WFqiAxYjE3nT2fS4DL+9Bt2RsnMvrsa34kBcf2NGWtHN8JvZ76e2uFA/gXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199101; c=relaxed/simple;
	bh=cByKs5XRV7yrcvLVB5EwEoWIHhvdGSx7ZLPJUHABd3E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KxCE3C04XBND/XqSzt/oIRJbJr4rsSk07vPzpWxqpjDd55S3vXiusk9cJa2o3D8oRW1XoGrI1Guqq0s3D8u4kp4G4nI4qFJDNCKjZGXpMdOa/1W8OdRmW01FIWmx+h8RQVcOMENxwtJ4KXA9MSt7AHbQ6oDkYVHmmDGikdlxekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJkcRVjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10637C433C7;
	Mon, 11 Mar 2024 23:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710199101;
	bh=cByKs5XRV7yrcvLVB5EwEoWIHhvdGSx7ZLPJUHABd3E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BJkcRVjpBLAg7f5GQmldGr/7LR2zF2NHixzwIiYd20rQOCASkewcX4nPYenlHK2PV
	 rVQK0NrLdiiA6Cj3vHzsWdR9F6ykd/wRaKlyvHBDpergVHq+udKmiIWg4E0meeN03E
	 asUeOp/vlg9vjsBDL1HL48f8rHP8GvI3s1NzhYPHlTk4yhaYvpHk9pwJC7oShaAU5P
	 DU0j3o4zT7Hmwu+9vb5Zx4Ri74y31Fm3HfBOcycXPz8uDSfF6QaXEWQZjU6phyCMf8
	 RSGTiCdg6b9koQLsFDt1u2wHr6glKLur8WcSjlC6QZikMgRYk+2L1oj/8qZiN/CPI0
	 /xdL0GfXpVPBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB222C395F1;
	Mon, 11 Mar 2024 23:18:20 +0000 (UTC)
Subject: Re: [GIT pull] x86/fred for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <171011362209.2468526.15187874627966416701.tglx@xen13>
References: <171011361246.2468526.10740060923051583953.tglx@xen13> <171011362209.2468526.15187874627966416701.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <171011362209.2468526.15187874627966416701.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fred-2024-03-10
X-PR-Tracked-Commit-Id: c416b5bac6ad6ffe21e36225553b82ff2ec1558c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 720c857907530e6cdc86c9bc1102ea6b372fbfb6
Message-Id: <171019910095.25831.11770964133944877112.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 23:18:20 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 00:39:00 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fred-2024-03-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/720c857907530e6cdc86c9bc1102ea6b372fbfb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

