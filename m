Return-Path: <linux-kernel+bounces-134575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534CD89B328
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC1E281FD3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE693BB47;
	Sun,  7 Apr 2024 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULUK2His"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8F39FDA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712508257; cv=none; b=fHyAG4XdLtj8YMg9pnRvtUJtfWsrnFsZXmmmkWHgQ8XilJQDaFmETONjSTxChzVhne+aIunSiSGkFOkM8iBDJ4P9/wdSsPgJwLuvIA7hOvaKejX7klOeMPIITl+4H+J9D+CkMoL5TFRrh53pJVKJJiWXh8xoJhZLOZ+iv3oi2Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712508257; c=relaxed/simple;
	bh=r3pe6PHKmYeauZpogqZ95BiykmRBMgkL156G74Ks+vA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DRqVrDq0L6QhpUxTQMxXz4jnOwBJ7fDGjov1ILRosA7GZtAdLCG0JT2inp9IuxJdWPsW0WRNhxLGWABogx39CgCCuLS9V1PPTagRuP+g1CmnXOj1oSg3ZMa/CnGCoMvkcna0Ge+3tkcsbNl070exjLDooLLPU8DTGmZOoDaHFj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULUK2His; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67CD4C433A6;
	Sun,  7 Apr 2024 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712508257;
	bh=r3pe6PHKmYeauZpogqZ95BiykmRBMgkL156G74Ks+vA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ULUK2Hise/GjWg4goJ4gPaRLLAhXLF6yZqTdBFAvmF7KDKscwTWcZJEchaGY8Xb8z
	 gvjXOg8Fd/S+5d9/kHRGLDmYEE6ZPeMnAAhvm8RNc4Dk8UgIVkWpPLcwKYe1pnkem+
	 E++p0OFgdI9BconVjPm6hVcTr/8WD9QvBcNHmPQ9xtkLrVFge+wF/cyzYhQG760Wfi
	 ILpRvzwMwY2BQ2bZNkVYPSfPTG6cmkMqNF+4/DH9X7D+65eouGPVNv8dfQyh0wTJ29
	 tCd0A6ullqrjaXgX8Bi9mH8NIjgYjRT8PsI7SRYzwg13RfStx1zntVrEK5FhLSNiy2
	 MemlzCivd6q4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DCF4D7E2B2;
	Sun,  7 Apr 2024 16:44:17 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhJWEdkpXlagP9GH@gmail.com>
References: <ZYbv3GXLNLuc+rka@gmail.com> <ZhJWEdkpXlagP9GH@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZhJWEdkpXlagP9GH@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-04-07
X-PR-Tracked-Commit-Id: b377c66ae3509ccea596512d6afb4777711c4870
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fe30842a90be9b57a3bd1a37c9aed92918cc6d0
Message-Id: <171250825738.19258.7646682415330227175.pr-tracker-bot@kernel.org>
Date: Sun, 07 Apr 2024 16:44:17 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Apr 2024 10:15:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-04-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fe30842a90be9b57a3bd1a37c9aed92918cc6d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

