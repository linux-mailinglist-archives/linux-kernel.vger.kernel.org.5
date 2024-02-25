Return-Path: <linux-kernel+bounces-80249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A1C862C81
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF14A1C20C40
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D771AAD0;
	Sun, 25 Feb 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLLEOd6g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAEC8C10;
	Sun, 25 Feb 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708886766; cv=none; b=eQVpjbHRfBmLW5N68xtz1MGblaJz9xd3kJ04lUz4T1UnRs2laCL09UFPvOPuBeZby7qMMfIV8o4kWYAfeSDdbOO1kA6LVMhuiWsg3Sfx0b3oS1wwlGYlDdUDZqm71lFGe5vqN29ooYdCd9LpZ8ODc1YF+v0o5m5AimnxtQn2d8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708886766; c=relaxed/simple;
	bh=Kr2/AMGOujMAV2GBmZYtrsLdkbUKteXvq7Agm9ILqBA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qJ2i5FRUISyCT3dG7mn3HV0A6i2CIY7ttCPXDGfNpK2S/ZtBwVGknEIb1qedkiqbnYydyOIboNBN3JPcaHbibImGLun7jWb4uJc4RIyk4H6dshQG7HaZdlJIrSYfyr3jAguZNtj2CMldW9Lwncc811Q0iFwPhaP2T/HHL0X/o+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLLEOd6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C61BDC43394;
	Sun, 25 Feb 2024 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708886765;
	bh=Kr2/AMGOujMAV2GBmZYtrsLdkbUKteXvq7Agm9ILqBA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nLLEOd6g54I8quAUg46fsaZHZlqiQQnsixR0c81fcIaN2BjtPmBjgm0m1AUz8jlJR
	 GqsR40/3kCuzC6Z3JXGAMIcF7pv/9jWOukR3/R+2lJUKmUcVjsjhfjSIQTh1w+CcRN
	 FVQAN2Kd901xE7pOGOwr6iWibSu0sByybz8Ev5nCHpTJoS6q+g0M3EEFGFNtwIt1Bg
	 tqKdcrDliDKxCRtzFsnneLePi//9CKNDp7PF7RTKcGFY+0N1/tNX1RJqnjS4+G6gQN
	 9dS52dzcMAzE3wuvy+U11p3DpWfp73e5oK5TQGmSa7njHynZprMh7OALIaDn1R8wgi
	 CN2QQLZhs2rmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0EC3C59A4C;
	Sun, 25 Feb 2024 18:46:05 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZdtHDUx9Xsqq59k7@kroah.com>
References: <ZdtHDUx9Xsqq59k7@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZdtHDUx9Xsqq59k7@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc6
X-PR-Tracked-Commit-Id: 3b69e32e151bc4a4e3c785cbdb1f918d5ee337ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e592e95368433d5e2055de1e43b894408627bcc
Message-Id: <170888676571.24357.11720813242474167863.pr-tracker-bot@kernel.org>
Date: Sun, 25 Feb 2024 18:46:05 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 Feb 2024 14:56:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e592e95368433d5e2055de1e43b894408627bcc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

