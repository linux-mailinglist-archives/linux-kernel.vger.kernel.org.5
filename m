Return-Path: <linux-kernel+bounces-39221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7F383CD05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABEE2930E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A71386A4;
	Thu, 25 Jan 2024 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2zLosa4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549AB13664C;
	Thu, 25 Jan 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212811; cv=none; b=IGfmzH5tQjTuW61+YYp07yJ0zj2ITUjzvq/rn2uoHkrlgJqylqwtLFt0eAHOHrvkh9duU3VLxWnNBiLoEGqE2Z3R8IGmSVHqEL5pvktZoyTiijqo8gTxUSbr3HPoYXvY6ld1cqDkaXwIr202c6Dc11no/oDwKDIA1mWNMGk1MCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212811; c=relaxed/simple;
	bh=ff/svvOFhnJb/i9FEq/NRUeWjd0PoGSyFo4hAMV7WT0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uDHfJU+P9SwQytKfgNr95FjRIcxV5NEWYbPbmdvPDPhs5P4CE48/IQYw7fnWDeOEVjGSYtNP0dVKdBA16QeT54kl7Pe7RflrSYlh9RcCRw05LFBqExeA2kIWH4v6GhNTVi7Dk5yuHNVtrI3kjTUAeMUBgm6Vyrf8On3PpgtT9IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2zLosa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27746C433B2;
	Thu, 25 Jan 2024 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706212811;
	bh=ff/svvOFhnJb/i9FEq/NRUeWjd0PoGSyFo4hAMV7WT0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T2zLosa4BwD83sCeUaANLjcjW9E6O+nIkP4qWVKJmBOJZ0JcrvYvq37uEQyr23ODm
	 WNQJIHGyDEoH37BnXmxYhCoCF2r0XMDJ4PPtg535rf5Tiwmqjr9N2l2a1JxBJJisvj
	 iMbZ9dhfrx/p/NTYjrBXDUShIWUwAE9eFW/T4MxNLHIxFX1cXh1VlmyMbUUeONJVFf
	 drM7zMwPGUaXYvjaW8gnY68rWf0aVLeAmX2igX1s2eLdx/Lln6A3mt5t2V9wjQhOIb
	 JZqy4RhUiWqmRCumQQ6WFhNq4J6JT7Do6sLHlaOk2QqoqC/lJnbr9P3lGop81DDDIb
	 wd16VEvE2pHMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 184D7DFF765;
	Thu, 25 Jan 2024 20:00:11 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240125131606.32850-1-pabeni@redhat.com>
References: <20240125131606.32850-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240125131606.32850-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc2
X-PR-Tracked-Commit-Id: 0a5bd0ffe790511d802e7f40898429a89e2487df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
Message-Id: <170621281109.19358.1997160221925082392.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jan 2024 20:00:11 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jan 2024 14:16:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

