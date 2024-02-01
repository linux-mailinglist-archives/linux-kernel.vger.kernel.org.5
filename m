Return-Path: <linux-kernel+bounces-48689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F68845FCB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7A21F29F36
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F8C8527B;
	Thu,  1 Feb 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOCDCPYv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC084FCF;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811793; cv=none; b=Sbv7cmpjjNEwnd4Qmomqr3G/pNUGKc86iqtdMU31J9WYDcvtdkj+jhFlZ73XC5HTH2sMjFyYxfNyZMIBMljiLKMsIvtgPGfdjDKjylR9ifTd5cF8vxnojN3KrTSt3l9nYO6vonG7LIBBtagseGVghVOcsxlSVjuMxqSgB8W8mDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811793; c=relaxed/simple;
	bh=EXmKaHQ2bwofMlqM/SD+30Ijqla2rDQsxNOkUEpcD/U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nD9sLUhsZMqo0fQJpSJm6K3n9bp3RiCoc6YxA8/u+krGOTj8CRWw9aYUE/ilGwdTjmTfMGyDoQVkBEIbHX15jJR2KUcTlSslpqD+k/1UaDKyx/O2P9V6ts5ehg7KAi7C2hvSR+HGXyQdlPDeTYBrobU+iiuwk/3jw3v84Dja8Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOCDCPYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A9BCC43399;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706811792;
	bh=EXmKaHQ2bwofMlqM/SD+30Ijqla2rDQsxNOkUEpcD/U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lOCDCPYv+VxoFRiyka1CMGuRbKW8+uogmdDTGp1Lm4M4UqKj1RCWZ75NXrz8BV42M
	 sh+jiHThF4YVzlF+zwJw7rSbb0Fqn3kEWixjSdAcztJoyXIRjZrKJ4o1R7B8HLOIfu
	 p35Q/omaVr4nwabRYCuTdFaGCRdtoPLG7MJVqEN9SdwBF4AgZ0MNW68IX8u6Sx1njE
	 aF8BftO8IZiCMWOwOBP5csaQhZx4cmehE0DDjIl0fnCzHXiSsrDSqHpKjI+IjzrKNq
	 m2JOitrAPXCUtzOt5uOPob2eQXKyhxIA+e2cMzZRHRTKqvmcFKeFb17YjkKBmNZMNE
	 gGwSiuKdH4Qlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8692CE3237E;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240201120602.C29FCC433C7@smtp.kernel.org>
References: <20240201120602.C29FCC433C7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240201120602.C29FCC433C7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc2
X-PR-Tracked-Commit-Id: 6500ad28fd5d67d5ca0fee9da73c463090842440
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a864c09ea6ef3f8721f2a36f21f0d4316340efc
Message-Id: <170681179254.954.11404374613992958526.pr-tracker-bot@kernel.org>
Date: Thu, 01 Feb 2024 18:23:12 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 01 Feb 2024 12:05:52 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a864c09ea6ef3f8721f2a36f21f0d4316340efc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

