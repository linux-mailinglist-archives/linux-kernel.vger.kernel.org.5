Return-Path: <linux-kernel+bounces-141513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7368A1F34
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17791288559
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EDD2941B;
	Thu, 11 Apr 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8b4IHqw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0961C287;
	Thu, 11 Apr 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862564; cv=none; b=DCXW9JBo6QC9m3Gm2sxAvDVUQeot0O+ltxh2nkJEQoDGKmbrgaZQWoFLVzco/oBeClzhfgq9tE/dSO9gQPQGg3H+StFzG5alyp9EzlRR/ki9c/k5742ofq1X2Xs5dT+Dqbt31S/YaRbczQmLrPEFAcaRQG7q2Mt2meI7hLWQPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862564; c=relaxed/simple;
	bh=usRNEJqWbMeIqe+6FvaB/rbolOBWygZpy9jfuMMXtUg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lcBuxL2lBKr5QdmxNVFLaX+9Me8BNpKs8ff+KaTn+nSzKyp8sWLTY9EYqkLy6XBv3MA84RdXmlAA36fiHF6ffRBppS6H3Klo9ZNrLi/wwz/GBpacSiS1gMS8hr80/e3GbBDWSXTuO6Mir+4Opbcn+7jLdXoAwrO9zytd6fdRN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8b4IHqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0976AC32786;
	Thu, 11 Apr 2024 19:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712862564;
	bh=usRNEJqWbMeIqe+6FvaB/rbolOBWygZpy9jfuMMXtUg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W8b4IHqwm8oco9APHltRTXMd6NdTqKStT3Sde/42wKAZLZaLHGHigPIgJnPKPhVqz
	 d1XLYwwc6tJ29cxqF/E7Ir6Ovy0QCpWwX1f/EFB9Hbx02KqfglUjqdxz4FV+CmCEbI
	 tcNJtl7f7IHUxn8s/l/gAQmlBDhJDEkmbY3s3n9BZfqcf7VKLdxf0PqCaXsZWOZGb2
	 IF6jzATyhacU39x3GaFW9VrarEuqA0mJF70NgblMEZN69FUei7WSDmeRI+ndy0GWCC
	 xEw0iaHRte3mQR6wRynPTQLsuudVJSOZ/ifzUUluvMSKzZheKSxXYoSfrzChwODvnW
	 cdaQfbChTgQtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1617C433E9;
	Thu, 11 Apr 2024 19:09:23 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240411133837.86880-1-pabeni@redhat.com>
References: <20240411133837.86880-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240411133837.86880-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.9-rc4
X-PR-Tracked-Commit-Id: 4e1ad31ce3205d9400816e08cf14b7c96295d22e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ae9a8972ce04046957f8af214509cebfd3bfb9c
Message-Id: <171286256398.2172.12561033857678072673.pr-tracker-bot@kernel.org>
Date: Thu, 11 Apr 2024 19:09:23 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Apr 2024 15:38:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ae9a8972ce04046957f8af214509cebfd3bfb9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

