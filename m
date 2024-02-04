Return-Path: <linux-kernel+bounces-51485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3874848BCB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569A11F22BAE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1289B672;
	Sun,  4 Feb 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOHgujhq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA8A79EE;
	Sun,  4 Feb 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707031117; cv=none; b=maGsAw9zjgPnvcHT+g2UAv69bhmVr8tJtHU/YQFWRpIMvZkHDzrzohkCv/DxkE5TIWkBCS7KQF8MuDovT1XyWs31Ej6P4CqQFEDWKMeWfe2Kb123tE7XDouoadtY5GhRDt+ukkeE8o+mzEictdISBTrMl86vkDcIyzO3JCkwJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707031117; c=relaxed/simple;
	bh=7adbtacqyGpK9hS7czGsDEaY9b2tfwAggQjBFPc8Vcg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OQbRyUZWLloegyX8QmAkCEaX6L9jWq4pZFZUDzzEHjYn29bkHqRN8dRoKOIBjItpl4RjhHmv/eKqX84Mq/RBRoQPtiAI6Sa109DuIZGwgUu2sPd+TcF4ncoZd7e1U1CDD1bfdqNN7zdwEsiC230nmwJIvKqfuj2qoawoj7wJV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOHgujhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1FD9C43390;
	Sun,  4 Feb 2024 07:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707031116;
	bh=7adbtacqyGpK9hS7czGsDEaY9b2tfwAggQjBFPc8Vcg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VOHgujhqzaGax71/R/VLhYC4vNndEcU0ZvxB4OVVnQ9Z3a2QK2ex7MUknPeBHQ0uh
	 jsQCft9zD4oy2cnREFS/I4NlZepW88cPD1IGaUqMP3jeu9DBHbjrOEwoXV1acqBANz
	 sdBjlfCdFXdw9eC97xHmHcgwgwfO5Dj5YDsQvqmUR5vBlRAHHTyRSWqyqytmHH8Reo
	 D7wgHG7gwqbUiTVE/wLLWy6NaNjZbNcukbY+aRyLFrC/9STDh+74cQasrlpY3iLa8F
	 ygyxjquhUGx3dai1jJuRm/ULxUT3UL5uMdTVbBBe1Pb6LZL6wODXl8HSjT/wosuN5i
	 zv1nDQWq/6NbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C72B9D8C970;
	Sun,  4 Feb 2024 07:18:36 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zb604Bt0_l-KUvkg@kroah.com>
References: <Zb604Bt0_l-KUvkg@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zb604Bt0_l-KUvkg@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc3
X-PR-Tracked-Commit-Id: ad834c7c8e4a74dd6cd4397848aa255e473d4a63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 809be620dc070c02a6e0daee0dcb0479c6296891
Message-Id: <170703111681.23816.17747359219398741800.pr-tracker-bot@kernel.org>
Date: Sun, 04 Feb 2024 07:18:36 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 3 Feb 2024 13:49:20 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/809be620dc070c02a6e0daee0dcb0479c6296891

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

