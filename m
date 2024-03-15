Return-Path: <linux-kernel+bounces-104891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3B287D510
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0831F21A83
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221056B77;
	Fri, 15 Mar 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMIvNMNt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1055C2E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535056; cv=none; b=SLN2/kaBv8J9nFgh64casc6dXUG7oJenNQ7FJm9YlX7Dehopk9j0Q9oKRZDh/885ctOTgIuJMa7heCWZ78TlkUhZO3Ztpkg1zcM3fltdPGr/Unf9lJ+msjKgFCchCXgfnhanqMjHnXpbuQxLVzust4e6atUBWRdHkt6xlBc/nks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535056; c=relaxed/simple;
	bh=zHsJ108o9xEAjqYBpZ/flhRrOI9E+Jyq94fgEiEqUro=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KsevaS+Ju6MzjXUnuX7YES3QiNuw2+gR3NIbX2WwCd/y0Wc6DLC8m8gWrn9/eiDQPVulsQ2hBip++pw6Tx1aDVcixSkkyynknMXb0nxTOfRiIiXotCLKdiA5GShxD5W0CYAV1ilPAjhIsvm1DnKap1jI4LvKPyB5Cgrz4fvBSsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMIvNMNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BE3FC43601;
	Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535056;
	bh=zHsJ108o9xEAjqYBpZ/flhRrOI9E+Jyq94fgEiEqUro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uMIvNMNtBSn+YHZWap8QyoDewITOqvFpcI7jzfDDjsS4BvY58i8BN2lQ9r9nsAqdl
	 gMw8siRrTh3t11B9dF/LsWGDdwUOW8P3aPCZyKxcFDVIsi0XgSXcZ7V49JNHas26Q5
	 ajms53q+qjvDI1y9tPK3tG3VVhfZwdH+F2/vdFO9kUo9hshrE+KIaRfP3VQyHruhv0
	 vHFM0GEOc2HtDOphitq3pndLiK1yEkO/naKiZ3Xb70qexeGgLiNX0ieyJd7iZAz6E1
	 mM716nhN/CdatiPQ39nQqr4DaZqlMwRH6Cnr0sbbfRucsnHGjABu362eahXOyW88F2
	 GIDrlYU9Zs/uQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63471D95053;
	Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
Subject: Re: [GIT PULL]: Soundwire updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfQuuDU8DDxdU9y8@matsya>
References: <ZfQuuDU8DDxdU9y8@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfQuuDU8DDxdU9y8@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.9-rc1
X-PR-Tracked-Commit-Id: e17aae16acf53938deb4b7702aa4f6cee2c4a073
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b898db92f10724420cb823c989adb1737fc046bb
Message-Id: <171053505640.29375.8731509358075370226.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 20:37:36 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Mar 2024 16:49:20 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b898db92f10724420cb823c989adb1737fc046bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

