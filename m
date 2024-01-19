Return-Path: <linux-kernel+bounces-30671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 582318322DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B335B22826
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D04A1C30;
	Fri, 19 Jan 2024 01:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYyAcqvY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669915C0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626523; cv=none; b=faJqn1IxchdkIPsiASrJbsbWepO/vMUGRSfgiqXPsqVtSGs44dN93LBGde+Ift48/IBbU5CxPsQB+XZY77XyoYFS8JEDqJekUrwbio+W3ktWewKb1VRVr3RWBHKux1evPFMYB93nwP68PkTAIOYNVVhSNchko+Ml36J3179feuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626523; c=relaxed/simple;
	bh=dd5zWSFk0APR5QWWiGxwTuqQEAW6KVKOPZ778ahkZjY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TJ61Oy8NU728nGTG2AKsMdt1LWZ5bkbqIlW/CX9dN3h6HsCzTNDTT2uOklINGPwO8ctYHLruVG6Y2uEy2J0G96mcOkjYxhBK4INoAX2Lzh333dCb32JLpU0CrdWNZhcrDpwvZMYajsB2UYP+5U4hrIU2FxONBgldy/GTV1xxulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYyAcqvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 754EAC433F1;
	Fri, 19 Jan 2024 01:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705626523;
	bh=dd5zWSFk0APR5QWWiGxwTuqQEAW6KVKOPZ778ahkZjY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fYyAcqvY4HbA/6sQ31839qRar+JPosnIjR8IcZfJ+d+uhNo65g35R08EjPnUCWVt+
	 /xXJz8qfaK8mIGN8jiTxyQ2BVy3AwkPBrWO1S892SK0WA/YjeDobDT1q0Ws8uVNc6Q
	 Yker6JjcilBc3UYGQB+vuSgGAay9vIWXP6Zlcj9Sh6gnoAWXKbEHJjN/hyJ2huO9Di
	 rcoU3F7Mq1AG7FbZchgN6wMOcjCchRR4bvaHnQmdKl7ljdHiRhmpS5XOGbX9NCSdqN
	 rmdXIbiSB3qkwJ/jotJ8Scd0NcSgZmS7r8BKSYmmXWN5LaZLUkUEGTGsbDq4WMe10H
	 zgVzRbOYGT2gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64F7ADFC697;
	Fri, 19 Jan 2024 01:08:43 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: small update for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZajHU5m3WWbcHWV1@kernel.org>
References: <ZajHU5m3WWbcHWV1@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <ZajHU5m3WWbcHWV1@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock memblock-v6.8-rc1
X-PR-Tracked-Commit-Id: 2159bd4e905704b1765b6b883ea15e51ad986a6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77c9622d87d21d989eb1a866e4df8eb5e3ce00e0
Message-Id: <170562652340.16604.8697132346188077686.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 01:08:43 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 08:38:11 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock memblock-v6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77c9622d87d21d989eb1a866e4df8eb5e3ce00e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

