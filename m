Return-Path: <linux-kernel+bounces-152352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266188ABCC5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0ECC1F211A6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241644AEF0;
	Sat, 20 Apr 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGI+6IyC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC74AEC3
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713637970; cv=none; b=I+tvtQHAcDEwrImslTLxG/T9hTSvejFseEQpM5TDYEBlX3gzXD9mNrCpAiGH0NadRc/1/kFz0ZLrYkgmRfgawUiVZ6hQ91XBQLyOpAaIdn8vqiddurV2vnN6LzZ6XyWcgldc8NKMS4khi4+cmDHLdb0eCkAJepznK1F8yl9Nc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713637970; c=relaxed/simple;
	bh=FL1XUzzfr7XOft6TDAyAyqAcmbRITFTq5WPp9HlS73E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Xl2dXJ8oOtOqAgjGyUdAQyNtcbqAO6pKMqyFaSzgbDk39wMy3Uy3n2+Q13GdY/b01S6zkrPH87O204iezmIqEDj2088WeLQXve5lIhZxSNVhRTMm8q3VB3PEs0LlWc56gN86zktEQjAwkuROcy9P6/BBqMtns58TpbFpIZjyHt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGI+6IyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 501B1C113CE;
	Sat, 20 Apr 2024 18:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713637970;
	bh=FL1XUzzfr7XOft6TDAyAyqAcmbRITFTq5WPp9HlS73E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vGI+6IyCx2Mh+2yDZmbrBvMgsH9Wi6x1FhCt7Ydq++c+qYlUpnFU8lhCKqOL/xZC7
	 TrZARRPfJrNqQdlcNA1+zo/NevWEc9+8WMsbzdvRIu5T3cjspzqpAHiOLC/vhNcO/G
	 9oTrX6E6N3ZtXNZz7tU4ZxqiIWqcGcDkImHR/mkD2hb2r1dlZj8jaratBwgh5+/ifB
	 Iyulr2M+iqjQg3nwfhfZuAvUY1Icfk6hn+7GHOtpJi34y9jEih3vPTm1jmH+KVSfeo
	 gynCqEZxzSqegUa3g9KOuoMtvdZ6rSYSzmREMWBcs0j6xaXINaCDX6mmtaXAgxo9DO
	 gRAuQUQhwCWJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 485F7C433E9;
	Sat, 20 Apr 2024 18:32:50 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.9-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87jzksaf7x.fsf@mail.lhotse>
References: <87jzksaf7x.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87jzksaf7x.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.9-3
X-PR-Tracked-Commit-Id: 210cfef579260ed6c3b700e7baeae51a5e183f43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e43afae4a335ac0bf54c7a8f23ed65dd55449649
Message-Id: <171363797029.22086.8963090920006760925.pr-tracker-bot@kernel.org>
Date: Sat, 20 Apr 2024 18:32:50 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, nathanl@linux.ibm.com, herbert@gondor.apana.org.au, sbhat@linux.ibm.com, linux-kernel@vger.kernel.org, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Apr 2024 13:24:34 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e43afae4a335ac0bf54c7a8f23ed65dd55449649

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

