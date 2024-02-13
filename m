Return-Path: <linux-kernel+bounces-63989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4966585383C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DACB41F2A63E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2095FF18;
	Tue, 13 Feb 2024 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhw+/xpX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075265FF01
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845673; cv=none; b=fFsb8Tvx3KHRvdmdoX9t7r/ed4JsXfh/GMKIfirdiG28UKrcRd5+Vj7W1d0X9aJmbjttMCcT7u60K4WkT3HE+cP5OB+DqruzrqbwU4CMuo2ew4oFGifT0VWThNv9FrADNSMCK4s9tR5RNQRZNtJyVG/pP4floNxJr6NsXE4xF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845673; c=relaxed/simple;
	bh=HvX5nO8VpSugzMUs/GdWVpAg4SuZJRZyMT/GE4vSENw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NCHd3J1G+6CSyT7GjNlsbHeHeb/Xz3kqj9kAhOlFNDXz4HGGIYdXOha2i/AUIf0A39p8kKRcDM2gk25WB28bMjkQrS2/OZpV4/qC7Cu5Awp1LC0+bLhm9HrugKcXMTLIFp54GXzMFyu8aXn+mcUwP+NLGTXPBr2n/zwfhVaLMxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lhw+/xpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C558C43390;
	Tue, 13 Feb 2024 17:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707845672;
	bh=HvX5nO8VpSugzMUs/GdWVpAg4SuZJRZyMT/GE4vSENw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Lhw+/xpX6QCUHD6C4bHZfiDC3LnnfPrx+MejaJtITz8Dw6ebJR+m8VjeoZcpX0EHa
	 BiueHXWejlIFg4a0iSFVDmo8Zx0jQYELZbLlbhy6/k/5gXIQyyaAVF6d9z0YoB1VyH
	 CbK+57+t5g2yEpLoJFjF4fTDbMymyvfytNXrP0PIOUm3hsgxSKo5B0xgPKnDj84zFs
	 ARhHjcmHO/ExG2BJg7rKTPldH47FM0SO9ZRGY6P5ZBEAZbdm8yB24QuDXEbPMQhfWq
	 5OQFPyTV25JMJ46rM+NTAKKwwm78+3pMKAus19+akH/EbBlin05MkqNvh0HZ7yHj3g
	 YWNIhaIRS6flw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5625ED84BC6;
	Tue, 13 Feb 2024 17:34:32 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/tooling: Fixes for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240212170107.60da326a@gandalf.local.home>
References: <20240212170107.60da326a@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240212170107.60da326a@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.8-rc4
X-PR-Tracked-Commit-Id: b5f319360371087d52070d8f3fc7789e80ce69a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e90b5c295ec1e47c8ad865429f046970c549a66
Message-Id: <170784567232.2088.15891845680226609222.pr-tracker-bot@kernel.org>
Date: Tue, 13 Feb 2024 17:34:32 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Bristot de Oliveira <bristot@kernel.org>, John Kacur <jkacur@redhat.com>, limingming3 <limingming890315@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 12 Feb 2024 17:01:07 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e90b5c295ec1e47c8ad865429f046970c549a66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

