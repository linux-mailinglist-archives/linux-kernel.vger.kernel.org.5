Return-Path: <linux-kernel+bounces-110681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A10886256
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DFCDB23809
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B88136650;
	Thu, 21 Mar 2024 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg9bF0mc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7060137C37;
	Thu, 21 Mar 2024 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055406; cv=none; b=NahhMFqC/2DfvnCbxSUOnYqOeCUvaLEg9/LYxUTwou5u/IOeaEWVAdtvwKtqYn7LZklaSkGekLdUJhO6zl+ybw8C8ZMEWFrOC/4lcihQtp0/tFs3I10ADVF2/nG2bXs+eNir4k+x4tzJ4pkfaj61bai7Fzndj8bHGfn50JTfLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055406; c=relaxed/simple;
	bh=U5Prvr/8AcQSn+3I1B6Wdpb50+BWZLxHR1Z42zOQSSA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rvqaXF2fcWpIWTly6vVWSa0959T18fsv88HS+zDEhrw7hd7V0/kX0A9F8sgtz4p41W05z1tVV9k/dXtuwDyoiCjdtfT2Vmc+Oelo1Z85PRglwW63jf2gqdMMGQIMhXXjEizVQLEl8Tc5fqYlc6llJasrh7yfaagPp39XVpID/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dg9bF0mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89637C43394;
	Thu, 21 Mar 2024 21:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711055406;
	bh=U5Prvr/8AcQSn+3I1B6Wdpb50+BWZLxHR1Z42zOQSSA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Dg9bF0mcjIUnLPTmxHDNw9O16Qvm4Vq6KCvVQpMx4atdxMu7v2B+DTbbJStjkKRnY
	 Ebx/tSrFb874M55t6prGr1LgMDNBYEQ0pf07qcDpXqmytYZ0xaQusRMJbUKUro8ETJ
	 ItPY8vu78bD74vNWK/4uMon/Mvd7GogbQ93p/ojFS7QhbFlSAT+kiIxfLAeu3/3zaU
	 G5VWP4M51E+I+e3kfEiQwyYSGgsueyT5Z6Buq7rBRnqD71NqnBvMX7SBihq2j3bEx/
	 aBQvaRRfZJDhqcue2oktnFSlIu+/2T3dHR52gllI/d6OhRmxHMbAv0h6g0TmoqEzCO
	 oP42nZAz114ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 725ECD8C734;
	Thu, 21 Mar 2024 21:10:06 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver changes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfwvlME6MKUHhQde@kroah.com>
References: <ZfwvlME6MKUHhQde@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfwvlME6MKUHhQde@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.9-rc1
X-PR-Tracked-Commit-Id: d6c0d892b44cd16e0421909cf7f2883b9e625e4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bcb0bf65c2b8d67dbe7509da8d1461ee4445db7
Message-Id: <171105540646.8284.2643369827600799017.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 21:10:06 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 14:01:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bcb0bf65c2b8d67dbe7509da8d1461ee4445db7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

