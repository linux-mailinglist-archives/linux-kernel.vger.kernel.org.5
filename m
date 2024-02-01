Return-Path: <linux-kernel+bounces-48687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90DA845FC9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E9A2985E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76008527A;
	Thu,  1 Feb 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClUmgX40"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E955C84FB5;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811793; cv=none; b=pl9L1/QZzkgefi0jRVVFudta4hoHIaLmsA0L+/+ZPyGQ7LMOsXwg/IMY/nJRoEQxIZxhJ6Kpt5uF2sAvRtgSSv+iGpQpQpnSTHpWYDQIOYMc42U4qPgro16KSBVG6b6oR2PTHLeCFbqluUmb8GJxTcLRptwlBH9qcZGOrW9UPYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811793; c=relaxed/simple;
	bh=dYHEZyzFDMNRESViUxpIGg7O+oIhEHIcwsdoOOOFcoI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NpVBwjZHNztooyXU/stxTrQZo8kQ78Hs5wGXF+tLR5K2gysPAT+zPYRZoXJDv9Mi7WlKY+QoeTMP649pl0RqMZRp6Za2uYkyXWEITMIyV9UimaaB5Ncmv5xLwmZL6Rle7XLuYQEUavxVjEbaM+wtXzT3cEWUpIi3AGvKH4D+pH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClUmgX40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E361C433F1;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706811792;
	bh=dYHEZyzFDMNRESViUxpIGg7O+oIhEHIcwsdoOOOFcoI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ClUmgX40sOnwH546IDth9FI6HXCn6fZF2JcqoO+t7DKgA92glbpTTzmWnGp9b96vU
	 Rp9zoaLVB0NH7Hhxrxj8XRC9csDDL8f1yVuZZz0RLPuj7zCg0ltroriHRXVdXJLqOV
	 G8iKpsclbugKwVGexddOInqJ8GygYKM/+W7hk2FNLhu2e1gAdyrfc/exuf51b+xl8e
	 UjrrP7yE3kK9pNRCCt0BlSsa0kUMiWO2FbmrGBr9aC0Q+lywVBZ7l6p9tFg1p8yKdO
	 1koPg10RBXvZYyCUo0sB2niyDdNsxrcPzQqKd9ZM8bFQmaVNVOIFM/TFbOX9R/gddr
	 12ZuRNh1l7UJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48A0EE3237E;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20240131
From: pr-tracker-bot@kernel.org
In-Reply-To: <8b9583bc21af9323bf40a53b7f62c5c9@paul-moore.com>
References: <8b9583bc21af9323bf40a53b7f62c5c9@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8b9583bc21af9323bf40a53b7f62c5c9@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240131
X-PR-Tracked-Commit-Id: 5a287d3d2b9de2b3e747132c615599907ba5c3c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d805afaf02e64e83a687182dd1214a703d4cf0f
Message-Id: <170681179228.954.17098697822150756350.pr-tracker-bot@kernel.org>
Date: Thu, 01 Feb 2024 18:23:12 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 31 Jan 2024 18:46:15 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240131

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d805afaf02e64e83a687182dd1214a703d4cf0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

