Return-Path: <linux-kernel+bounces-106767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E8687F344
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59937281DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3415B5C8;
	Mon, 18 Mar 2024 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw1K7P++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9B5A793
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802042; cv=none; b=rJm0T7EG/wxFzFXoh8cKr2+L1Zsr33qih8gXuAloqxom9bEPMj/xnDcEHCg1C7UoaoAIDsxS4otq3Q+SM2jgbLL7S2liF3x2zqNLtQB49UWpVyJ9FyLveuSwYMtLajtaam6X1/Is0ATtf2OFrRW0kQaPE8EJjPxmPgcitVn2Gbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802042; c=relaxed/simple;
	bh=xnDBrr9ieA4Of9z0F4s7qNHKn3cs2MLpFDqgecAAoC8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lJN7GG5Tt6HSxqHi4EjcgQ2RhEIwhVlTtZMwP0IxcGPysws1rkXfw/cIikAbgekAxzt5Yibe8cvVk+dGqiPej173k5QMc18vv/l25nYPQueJX94mMeO0ONzzVTcSL5KH0G4dc/PSiYAq7bXztYAcQ2MfwAD/c5vdncuuWj/EF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw1K7P++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FC6CC433A6;
	Mon, 18 Mar 2024 22:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710802042;
	bh=xnDBrr9ieA4Of9z0F4s7qNHKn3cs2MLpFDqgecAAoC8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xw1K7P++M5AipCiiMv7vIzfWDpVgKNU/JXAN6mUulMA4ngOjvbnm8rXWCud147uXS
	 U0I87jju8CY8dVtFu/HYOJ9sm5MI9npXQYoGJ9Jqq0zj9IZ/jS56dVfDO64baS8ptn
	 LwmmY9lhT+uEycMnQOWIJeTKDUOKupDGlt0F6x7X7RDmEAMkgk5cEoQt5uE4zMHXlo
	 x2mljdA2oyGFujiwRoSAydUZJK/a8SUepjCHmHWQWrkw8N980VMCgzeQF63BIJx3Is
	 u+dy3rFmBiYuyfoUtf0lodTyWDKyW5viBg3tlRxj0ECKbOUxT4vpPqaKSfginD4fzj
	 ZLxAmAUY83GZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97B65D84BB4;
	Mon, 18 Mar 2024 22:47:22 +0000 (UTC)
Subject: Re: [GIT PULL] ktest: Updates for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240318120304.3c471ffa@gandalf.local.home>
References: <20240318120304.3c471ffa@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240318120304.3c471ffa@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v6.9
X-PR-Tracked-Commit-Id: 07283c1873a4d0eaa0e822536881bfdaea853910
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65b64246f28bee13f9c15e4f0847fd6cca39ada3
Message-Id: <171080204261.23091.6780170056401394041.pr-tracker-bot@kernel.org>
Date: Mon, 18 Mar 2024 22:47:22 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, John 'Warthog9' Hawley <warthog9@kernel.org>, "Ricardo B. Marliere" <ricardo@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Mar 2024 12:03:04 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65b64246f28bee13f9c15e4f0847fd6cca39ada3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

