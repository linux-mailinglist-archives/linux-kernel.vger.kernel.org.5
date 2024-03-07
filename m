Return-Path: <linux-kernel+bounces-95954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847FF875551
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D4C1C230A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AECC130E44;
	Thu,  7 Mar 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRsdZ59d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFD374262;
	Thu,  7 Mar 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833142; cv=none; b=B4ygva9Es8BaQWSmex35mxuI+3OfAK9zQyQCP4MCFZDr3PuLfPyTOTxUK0UlY6wwyAdN50byi6SwDR4AZA/plw2mzTNq/aMIkkwZXFOovC9D/P/TKxtB3Dt6Kgu+YQQWaiDUDwB+DgcoeBhLyAbGoxr4i3QdLqBNxg5pd0SJZ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833142; c=relaxed/simple;
	bh=hr92BOMDZVDn+AD/0IRZy/Gi/tOEZPuEgX7n0alB/Wc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q7LzcnJyq/ZtkFrB3/G+s3dOmHDuaqxbvJuAgt5FbbVXVutKpPH9Ad9fMjk/ssTy/BEmu8P9joIdHt3fe/+ZfEsasNMVU7jI2bFDFz8SlwDVN/b8KB+4iwjaYa9cod3Yd78SQFxtP04ELODTN/MNZL6SfT9Z84a5YdD0bsL+RBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRsdZ59d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82711C433F1;
	Thu,  7 Mar 2024 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709833142;
	bh=hr92BOMDZVDn+AD/0IRZy/Gi/tOEZPuEgX7n0alB/Wc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nRsdZ59d9dWwYxnwWTP8KXaCy3VhNlj/7m25bUZBU+ILfXiwGaULgl4Evfb3oBE1f
	 eTQFVq5bf8gZvSehzy+DpMQhZ1rlOeVCHMQQaCb/pPVtImjKoR8USWbBdblh2UDn2E
	 IgiV31ntJJbuOKi17lDNeMiJ0rEizqyKuam7fBUlGgLW1kCLCfPLX7SkiU+b1KNvub
	 gGy0pAwtw3copgKzGONwLog44IgCpQnIPsW32XbZRd5hPWWIvJJi/o5s1BqSko4GNK
	 we0a8PNLKZghk+fq+6v88LPkr960VNnkttEuUWxraqwVeilIaTtXVOFYM9WXHG0yEv
	 IygFBR55QXfwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70A22C3274B;
	Thu,  7 Mar 2024 17:39:02 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.8-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240307130604.485199-1-pabeni@redhat.com>
References: <20240307130604.485199-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240307130604.485199-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc8
X-PR-Tracked-Commit-Id: ba18deddd6d502da71fd6b6143c53042271b82bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df4793505abd5df399bc6d9a4d8fe81761f557cd
Message-Id: <170983314244.22258.3329669996541695126.pr-tracker-bot@kernel.org>
Date: Thu, 07 Mar 2024 17:39:02 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  7 Mar 2024 14:06:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df4793505abd5df399bc6d9a4d8fe81761f557cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

