Return-Path: <linux-kernel+bounces-110683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A52A886257
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB37B1C20430
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB61384BD;
	Thu, 21 Mar 2024 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6eDmpPG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76742137C37;
	Thu, 21 Mar 2024 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055412; cv=none; b=n34l9UxYwaa2QysVCaSxGCgICKmUgX/xEEgUV2fWcSRfTNxND+NHSagMQ2LnGi1FnkQvUcymWp6jsaBc8HbR4F9/qUkPzgFkBNoFWWurjv/hJOBsO0pExuZ/t6AU8e2MbM6XLTvS0NioY3e5n/vQPDT+iwUvQPfHd1MvvrjGHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055412; c=relaxed/simple;
	bh=3KWPMM+v9fCJ1chM/6eAtHrqup7wEaHGv4x4+SL4xD0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AaPueMD9PifVCnXU9MBXZF2Ol8WzupQpo4KEhgMCenZlG+UG+srrPihmlbuYgtumuT/kvdvNOao4Wt1xPxHsx0mGNYPt2W3M9YEWE1+BBQ4iNeeofOc82OrDeGYsbrzMdPoR/4tr6WuYjRFXm0HrhWksRM08LnJiVLIK7im67AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6eDmpPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01C0AC433C7;
	Thu, 21 Mar 2024 21:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711055412;
	bh=3KWPMM+v9fCJ1chM/6eAtHrqup7wEaHGv4x4+SL4xD0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o6eDmpPG/f0QEARzEdcBUPtOgj/BFJ6X5ErRXYrgzfRRtFf/uq+nBLEpTHwf+xiEZ
	 GLI2AOYqzbSIJUihI/yqv/DRKbuBMeDUBMBqLuGkXw7o2VQaauFw6CYDmdChax81Eq
	 vuE0aQzmWQVupQZtA5P8ATyJ0JJGNC5/8aTjakbUCrQNjG7f43Wbds+zdFOeHoui/Y
	 lHo3uww1RNTxwQW7OSOINoyZhLda4tPpF8Q5S75jSXSbhHt+UBYTeoqSOd1zjtkQOM
	 zWQp64HTcIFAl8K+EO+v4y3z7Ghb8RVLD2xGI8NKZbXCCAhA148/nK8+WEUgGDEs2o
	 2CVVf+otz27Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE69BD8C720;
	Thu, 21 Mar 2024 21:10:11 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver updates for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfwvsKB20azzCoYR@kroah.com>
References: <ZfwvsKB20azzCoYR@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfwvsKB20azzCoYR@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.9-rc1
X-PR-Tracked-Commit-Id: 68bb540b1aefded1d58a9f956568d5316643d291
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a59b3f42e5703a89dd6ddf5bc818a4cff975302
Message-Id: <171105541197.8284.4646372532130064686.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 21:10:11 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 14:01:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a59b3f42e5703a89dd6ddf5bc818a4cff975302

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

