Return-Path: <linux-kernel+bounces-29573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD0F831057
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115A81C2212A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303A49468;
	Thu, 18 Jan 2024 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXnlxpX1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13182CA7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536310; cv=none; b=LNBX1iO2hDyQDyrFxcZ3Z2VLEQRjgYoGOZGNKlr6Utuc9LNQQy4yVNiiSkcFqsilQYVbfXpD7mS0GpypvppaGRJpGukrJX2HB8XMjSTTQWl//6L8Zmn/tJLioc4QvdHMWBy/APGQlfVzBMtcKQXy3sUuh4eVQDzzlNjahVRqOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536310; c=relaxed/simple;
	bh=C3YgVT0aw3Jbd91BtgPDl40vrqM5uvYvxmYgr0eXCb8=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=C3sVTDXMfe9IcMU649l7yOesOvVOwWloaHV01guDZpD3s534VianuC1cIU9iY1k+rO43fdZbCT5ZwtZo7Un7fF3kCDAsgm0zwJBJ1L9LQdDZsOBl8Bq//Kudz/JFsokI0wb8p/Xv+hFzZtkrUEoUk2CDLtM0JgzxWZD42UubEKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXnlxpX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C3FBC43394;
	Thu, 18 Jan 2024 00:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705536310;
	bh=C3YgVT0aw3Jbd91BtgPDl40vrqM5uvYvxmYgr0eXCb8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fXnlxpX1LyCooYdIg0GSncKeNqD/H6I+S7rrVL0s/8qeTUPcEpuaXRP+wCyYiSxOz
	 cNejinEdPRRJ/FqtvmFKA9nC/0qe8oZpCecjYKscqpbN2Ck94+0X/Wo6JN2l8+u0yG
	 eMNqkfw1bzFWcpBESZsQd+XbYC+PgM2v9SEpHXsvkACy6yaud3MY2pBACuNxWI3Z10
	 nBkyVfkCs9Sjhqq9qc97iQVyqgJfrYWIH0bCVVOR7mM7Rm8NuAAcdwTottrBaq/yt6
	 c3oFpIXOUmE/ruQBEe2LjDfEi4HjfUSi3udwYHqhAWzZOKf/+sBLWXlGRxUYmI1yWE
	 Vz7EEPs9m1cAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31C91D8C96C;
	Thu, 18 Jan 2024 00:05:10 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240116163955.GK1920897@google.com>
References: <20240116163955.GK1920897@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240116163955.GK1920897@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.8
X-PR-Tracked-Commit-Id: 4289e434c46c8cbd32cf8b67fa7689b3d2ca4361
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08df80a3c51674ab73ae770885a383ca553fbbbf
Message-Id: <170553631020.10877.13412688476244995846.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 00:05:10 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Lee Jones <lee@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jan 2024 16:39:55 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08df80a3c51674ab73ae770885a383ca553fbbbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

