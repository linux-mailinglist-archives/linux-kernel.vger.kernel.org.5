Return-Path: <linux-kernel+bounces-123871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22971890F17
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A15B21DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9EE56A;
	Fri, 29 Mar 2024 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEAyJAOT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9896AC2;
	Fri, 29 Mar 2024 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671590; cv=none; b=t9hPlM9tlrb6zNOuGwyeol1m8Os1nmzNM5dUp9qLrlcV9Vm+rBMiMk91vo7fp/XLkWS/II/RY4LYc8FrDCnGDj4Hvlrpu1qrqUo7Ty//Q514BbQnoZbk0CiTM6TerG6VhuibYWq1KldM+moter2S+Ir8O0MLbZgeSda5vF6b6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671590; c=relaxed/simple;
	bh=y9/z8+XhCbfFbaLLyeRnzsdTgsjZGO7uq8rSJrvXQP4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fU0tXnmK0goqhanxMEH/GnFZ5aEOl5JWo0i9yt8chZmfSThLxxuKYxIPiX5X6NiZ7iKzDRd8oSGBpOg3l5cgH0BdYBrMfJrhRZf4wK/DVowlMBLyQ6ouRhIVooSZitkJtZbHg2kpnuFXASFXryWRnQtPyuMFUV4gY5nhhOCS3bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEAyJAOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24D2BC43390;
	Fri, 29 Mar 2024 00:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711671590;
	bh=y9/z8+XhCbfFbaLLyeRnzsdTgsjZGO7uq8rSJrvXQP4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aEAyJAOTD6YqwK/8lJ3BRcIuN0crVrXCtkabNSX/Kwif+N38LncoHhCx3GIW++GSK
	 VCuV/hcl58nUClV840gQzQC9cx1486g6yUTX0wqfj/J9bPSYMNHNIOhVz5a1yyZSdL
	 6ebNhVBmdv9INOSy/4wgEcEuViiGXzQXF0EUWg7h3MSzZ3jbdgKVV3VMo2SkD6uHRl
	 cVHBeCvSOwuAgI3HEybQ+UiLa+dqLWKxCEl9l2BYdfQ9cGxA59iYJI8SMzDyRBWCUB
	 ZnjK2AhGAL0VniQNsaAu/Cs9iw9KUasqkWa9lYyGsudrIXPRrlOjdPhFc1nSTk3d0h
	 F/o19ja5w5aAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18BC6D2D0E1;
	Fri, 29 Mar 2024 00:19:50 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240328143117.26574-1-pabeni@redhat.com>
References: <20240328143117.26574-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240328143117.26574-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc2
X-PR-Tracked-Commit-Id: 18685451fc4e546fc0e718580d32df3c0e5c8272
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50108c352db70405b3d71d8099d0b3adc3b3352c
Message-Id: <171167159009.21457.12914171393763552657.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 00:19:50 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Mar 2024 15:31:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50108c352db70405b3d71d8099d0b3adc3b3352c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

