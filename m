Return-Path: <linux-kernel+bounces-103658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A6E87C282
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957C428557A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CC676404;
	Thu, 14 Mar 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuwYFdS/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE376055
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440435; cv=none; b=XANtFTPCeUt/MNGEWq+j3Zp3lBVomEtRQOQ6Uo9XGvKX6ShogMyw7oM0+RtIXnI2fs+kRCeiWSaLlOaoXakmiadv0cvTUMUe2Gj7QuYtGY/jvItDCkD15JLy/H+PAmVsC9+qRYxcFsR4nm4qeb4HyDYpdpvQJABw8YK+8YagKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440435; c=relaxed/simple;
	bh=KSrAuQoGIps5yOBZIU4Jh/OBSCzI6O3JFr76XJsKAbY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pj2NVZgH4BJNtW6/WFD//JwI0Sdz9f0KI4gX+K8OjPpLQbGOUZiHH7OgQgiiLl2eu6fo/ouB68Oh63fV4yKWQP4jEYZUDdE9+ZIIaJ6SVUi5gUaIMSM2q2CaS3tXuqdY6u+skovl+fNcqdpXzoabQ35zNSHcuvar4/Sr2Vfvgaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuwYFdS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 981B1C43141;
	Thu, 14 Mar 2024 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440434;
	bh=KSrAuQoGIps5yOBZIU4Jh/OBSCzI6O3JFr76XJsKAbY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IuwYFdS/OykD1VtYfg5wjyefGXlebsKi4MSSWq19lzKe8SIsIyH1M6f6PR4ABFvGK
	 JROxMot5xT/h919AHYdKwX4BQblEVehHJH2DRChXSLPT8KAthhTivat+iepxaMI6o7
	 7kE9ePuxEPlFMN2FLCHBqpnOY+Hdp2+1KboqiDf6Nl4ejjI7si521q9/GWguXKwFZD
	 UVF1Ht+dLEFrC/SixjdHqiC3eNJZ8DKYzujv7mIay+PG1kqHvbPncr+mD1sDzyXDFI
	 hNP+8xEkKxGFgBFhbZ2YdDo9mwrYg6gjy23lSI5vN1urtcXo3briNVaCRaim0ev8g2
	 Zdbj8k/8tpXTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EA9ED84BAA;
	Thu, 14 Mar 2024 18:20:34 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240314143847.GN1522089@google.com>
References: <20240314143847.GN1522089@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240314143847.GN1522089@google.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/mfd tags/mfd-next-6.9
X-PR-Tracked-Commit-Id: 78334c343bef528b911da83a6b041d15a1a72efb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8403ce70be339d462892a2b935ae30ee52416f92
Message-Id: <171044043457.24196.18050108187448276762.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 18:20:34 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Lee Jones <lee@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Mar 2024 14:38:47 +0000:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/mfd tags/mfd-next-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8403ce70be339d462892a2b935ae30ee52416f92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

