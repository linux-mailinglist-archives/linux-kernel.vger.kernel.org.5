Return-Path: <linux-kernel+bounces-85673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A83E86B906
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2A91F2A44A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82E914AD07;
	Wed, 28 Feb 2024 20:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfUVuOKE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B755E06C;
	Wed, 28 Feb 2024 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151756; cv=none; b=DguqoXu5+8BR33FiXErLeqvK9AC7upw0934goJpl7QLgCIDWN9Dg2xu133XO9BWIy8fqIrv+zB1Xr3xixr9+87T2DxL2xjaL/fruNNoNGWKXXevtUjMBvZlxrIn3l3QVugPZahRPB9g5SBH2zglQyWRvRaQiHbML/tBxB7+4mSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151756; c=relaxed/simple;
	bh=vvdObZ8S9HV9UUwK3zVMJyO7dqZ+Niqkzt+OqQppGqw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EMIehDLVV+y9TQzCz7EtKPIFI51LXCcdf1ltX7+jdy/iGKvi1q0Y52tkIfI/U4hy90j1/mT81RMgpcgHhxXl2kHfAotpUL1mwxxk6HbWdjbKHCj72JtV+hugfBtAugy3TR1ytTQjETx7jOm4Di9LqjS4XMkxxowyBZekQikABpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfUVuOKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDF1CC43390;
	Wed, 28 Feb 2024 20:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709151755;
	bh=vvdObZ8S9HV9UUwK3zVMJyO7dqZ+Niqkzt+OqQppGqw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JfUVuOKEUC3ZU38G+EO/SNhcmPKXO6hbS7vMI1oPoPpAuhlM8z/D7/zhVJ70/BZVw
	 yJU/gHB+pChKy30O3jJB8neygJnL060XDnD3vlPxWVKv3IrZ15cH1FZxfhSHKNv3Dc
	 rej2IDb1FR6GavNz0PNBKp4tflgiYN+KxVcz3farzMYmc3WB+W4z+/i38lhS0t3jnh
	 3/vsDtHizKm0R6tdNaQokViiNaWvgtypFk9tNF4sravfKtt/izJobnusjqeyAA3vxR
	 K559MSUS2QPT0QKLMq96TswF7mgeebgZk0d2wCGTqqBcQHeHlgV43Z0nssdxxf5yD0
	 jWLnQc2ukgF6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A44FAC395F1;
	Wed, 28 Feb 2024 20:22:35 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gF5hjMi7m-uUtG7oeTe1Yn2TFSRp3Htv7ULkf4J-Tb8g@mail.gmail.com>
References: <CAJZ5v0gF5hjMi7m-uUtG7oeTe1Yn2TFSRp3Htv7ULkf4J-Tb8g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gF5hjMi7m-uUtG7oeTe1Yn2TFSRp3Htv7ULkf4J-Tb8g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.8-rc7
X-PR-Tracked-Commit-Id: f0a0fc10abb062d122db5ac4ed42f6d1ca342649
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 022d0c6e03171afef24a80f1dc8bb4edb7b64417
Message-Id: <170915175565.10893.13982573204269870411.pr-tracker-bot@kernel.org>
Date: Wed, 28 Feb 2024 20:22:35 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 28 Feb 2024 20:34:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/022d0c6e03171afef24a80f1dc8bb4edb7b64417

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

