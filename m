Return-Path: <linux-kernel+bounces-29579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E0F831061
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1482B23E93
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65208647;
	Thu, 18 Jan 2024 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C627Ekzl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A40623
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536729; cv=none; b=PMdBtOwPQkCHPJHWMjanOCcVp0CW6xWAZ2ENISPjPeE2NHHF4jbAF3BXBjeV+GsmhFCYQ2yWrmRm4uMAfS7Wc55fe7iumblxgQCIl6VaupuohItt7tsZ+uDjKsG+8S1ho+qAd8KygcBJat4LCcw1jfoXGdGC4R0p0F7T0X0zNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536729; c=relaxed/simple;
	bh=EQYR/ZXGXNTAe7ZD/nRHH1cGXBQDzRK6GTkmsvjo33s=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=WLM0EPyxsP3iqhbUegVPmk2DyoD6zsgXtub/xGOeVInib3oC+vY74QmQCCm6rlj6vO7nhuAt9OWYTTLS6q0c04iunrhdIlIAw0ZryAiqADj51VqvPRu1Oz2amL2/PYdYE8qgQ4sIgOhIzcY9QtPFzt/N6ivAqBUnQLajnioTZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C627Ekzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E1E4C433C7;
	Thu, 18 Jan 2024 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705536729;
	bh=EQYR/ZXGXNTAe7ZD/nRHH1cGXBQDzRK6GTkmsvjo33s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=C627EkzlkkdVepwj3kM33R4MGTXe8rekl7NeD/C2DF0hvxqCqwzFX2WpROkJvN6JW
	 UvVPnPL2HaSEAZXkYCZr6NTwpza1oEtmFh5TjQ2gvQGu2bPAAUI4vleWT45SOP0poT
	 BTrWrWcq1IubDddvqLPo1tB3yEpH2Z9ApIssJDVpa8y87lKecoxzLKx7w1N3i87qp7
	 fPnznJ7EpzRkIGHWedRygOzVdODUaPF7QFkz0eXOTWaLxCFV/PkJ66JwPywu52nGjY
	 fq0nLvIylZYZ6kAdpxcuw3WfGsMP3R4pd+hU8Le+b6vCVM72dH12aSQZS9/5k3PkKf
	 3dKFeQ+PVwmfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B9A3D8C96C;
	Thu, 18 Jan 2024 00:12:09 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <2024011423285495e8345d@mail.local>
References: <2024011423285495e8345d@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2024011423285495e8345d@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.8
X-PR-Tracked-Commit-Id: 4fa0888f6f3e6a67cac5afafb23e33f8222cfdd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3f4a07b5027e88209a7f47f572d8eed126ca870
Message-Id: <170553672942.17342.15541822461868026567.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 00:12:09 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jan 2024 00:28:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3f4a07b5027e88209a7f47f572d8eed126ca870

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

