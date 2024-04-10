Return-Path: <linux-kernel+bounces-139334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C0D8A0186
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436771C232A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07757181D08;
	Wed, 10 Apr 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/czXkl7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC8A181CEC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782530; cv=none; b=mgfZZtmmd6pn7TZ0MMrPFN/Mm3xLgjjYDM5dYrKMjdFac9r7YTLpY9VYFZnFmQ6iCtQsosaRRwsnpSrLrzykzZiYB/JWfBBjMB7XZegTlkAzLYtpHpLauoJrRvEcDJMqTBcn3Lj1jBadPPHYEKmRX9lylLJJsiq3AzsW8vrMv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782530; c=relaxed/simple;
	bh=1BGh5aiXq0YcuX14BAy3q/b6EQjFcXwkJ6p0uIDJqhw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YDv7nhwkrzfQTnisMHVEMVg9rDC31hK4PX2KagNLwEWFexvCMwH2LGhmAswWuOPNMEUz1Hre9jVCLKiwcZWMOY4tSebycQ4svUv6RrXsSInRPz7ycd/LNI4c+Cu9N5lBQrKvVgdk3nqNJFlESEd9zkK11FMcTp6//9REwmovheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/czXkl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A464C433F1;
	Wed, 10 Apr 2024 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712782530;
	bh=1BGh5aiXq0YcuX14BAy3q/b6EQjFcXwkJ6p0uIDJqhw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=J/czXkl769Y5Z6B3y4q+JzCEA52+cTIMNFaIDVR77IsUZ88a/jTVrVdekl9yqy1cK
	 CPoH+pGjQmJGW1GeQuhgccvvsylUO6hsv30jqLUS+o6FRBq3loo1V7cwhC+5FqWDP5
	 mGh5Jk1+WvXTL8wOj8uj+Dk6DiIuvUVxSaF/5dycgEnuNXpvvtk3rj0XkZuZSKJFJ9
	 8bKcXgEwyI2Z8hD/NFf5qEe4xyb0U3y8gWkOz9c5VIXvKzEg+8bKZc32ALHs4fb2S8
	 BUZUpTDmmZFVmKEKV5ZTrBsg1YSQA4HAeGdw7Y28tiRUFxOeB+S7VvBwfN8NvCA8GJ
	 WojFTzcWJF1mA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FAA1D60311;
	Wed, 10 Apr 2024 20:55:30 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <202404100935.3D7CAE6@keescook>
References: <202404100935.3D7CAE6@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202404100935.3D7CAE6@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.9-rc4
X-PR-Tracked-Commit-Id: 9c573cd313433f6c1f7236fe64b9b743500c1628
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe5b5ef836c85fc687db4fa3548775fd363e25d4
Message-Id: <171278253012.335.7468220946275156728.pr-tracker-bot@kernel.org>
Date: Wed, 10 Apr 2024 20:55:30 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, kernel test robot <oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Apr 2024 09:36:18 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe5b5ef836c85fc687db4fa3548775fd363e25d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

