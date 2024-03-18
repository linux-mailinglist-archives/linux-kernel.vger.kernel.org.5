Return-Path: <linux-kernel+bounces-105596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9878487E12D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DC01F22085
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645F915AF;
	Mon, 18 Mar 2024 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzdTXkdo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9967FA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710720284; cv=none; b=A86FAZh6UrpIY42JRdsBaIiJp0+1+gERDbE2FTuRK5u2BqeeAalg+dHx5E0tmYFjesQ4v5nFO1ZfzVezqsTOySaTrE2xes4sPMJikO0wqpCxwRB3CNA0qj0DabbP9g7SghqXo7bpBTtS4GrL1wegyOgyKQeHd8aPqJPCyIKWv3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710720284; c=relaxed/simple;
	bh=G5kuk0pFj1tJi262LSPqfIVOmYjuE9gk/QXorHUmjQc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KwKX4keBkz7bLeheZab6qekOMzAfJiMs9EJieJztHX4aSDsXoQ9CNRkxOBjqwxn5pNFBRLiQySj4wk1gzKT1xtq43CWnW5sWd7ABEOB764Yx07xO/dnU36AOR4KpoHA9gWlk2NuB4EQI6gSQaTANa5joXHm/YKFzGT8m3sz7n28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzdTXkdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63765C433F1;
	Mon, 18 Mar 2024 00:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710720284;
	bh=G5kuk0pFj1tJi262LSPqfIVOmYjuE9gk/QXorHUmjQc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hzdTXkdobYG0GRizybrIY7fWf354Hw0u6gr8Ser3Yl6VdvlUi7inXgDqHRJmJzGpP
	 +TZckJkaDtTQhO3zvbGqKElrNRbSZNuXwX7HKAmcWXXlT/tk5T7uPnDEBbcoeFZg65
	 TMHEMHkC8jX26DgGc5fQmvAPSSOKQLLQNR9f2aJajDqdgdDRm0bgd14Gi4leqqQqbR
	 cm5G3/lui/7+FhLTlvNWp9TPM9rNdbRdZXM91NrV+8itKcW+c4JdhuzabVnutNCej+
	 bDHyk0FR1OUi0+jUUuEU6Keqg9m/S4893EwpraZueoCkx/ePJWi7Ht8n+yh54F0ZSJ
	 w3sdFJBr4poOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B2CBC39562;
	Mon, 18 Mar 2024 00:04:44 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240317233017c4c35cab@mail.local>
References: <20240317233017c4c35cab@mail.local>
X-PR-Tracked-List-Id: <linux-i3c.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240317233017c4c35cab@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.9
X-PR-Tracked-Commit-Id: 8f06fb45853900b4deaa52e2a9e16f3d9550b011
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6cef5f8c37f58a3bc95b3754c3ae98e086631ca
Message-Id: <171072028436.28729.788751177236233811.pr-tracker-bot@kernel.org>
Date: Mon, 18 Mar 2024 00:04:44 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Mar 2024 00:30:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6cef5f8c37f58a3bc95b3754c3ae98e086631ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

