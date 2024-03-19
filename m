Return-Path: <linux-kernel+bounces-108060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFC888056C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FA31C22CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACA93A1BB;
	Tue, 19 Mar 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNCeo07H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63839FED;
	Tue, 19 Mar 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876584; cv=none; b=YkMJF2h0JVp5+Kuf0gE3ttxxip/wGYh3htXLrtQB6J2VFUt+0ZPCpKIcelIXzv0Hbwu3ji/cqd9estQAyh7xiTh8ZsI2GnSJwrfnnQTFg4jXUtrpOb8HSOOx5iuRw6hyNT7kEpXXhiUz9jg5NGoxjoUxEYxmQIgZOdlyCEiOnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876584; c=relaxed/simple;
	bh=xSUfbZ7GaZtekdMBnAgIb6awJJv5JU43OAnSEAYPfyw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S/gqRQ5ex48amCmWsOxveCQr6pyTWtdeEy0ZmNi1kFpdWmFPuoSMspeVgD+6SsAn9hfXaZggykHcskQpaoQLwdkhQ+9n5Qmc4AFa8AK0+TWuTKz5mYm7guB51gg0bIxZCssIryJD9GJuOSjFag0Wp1LKivtGY20ZnLFqS2M+H+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNCeo07H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2D6DC433F1;
	Tue, 19 Mar 2024 19:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710876583;
	bh=xSUfbZ7GaZtekdMBnAgIb6awJJv5JU43OAnSEAYPfyw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cNCeo07HwWdegf1Eo6V3Ujb9lIEp8PPzdGCaxCTrmjaLhp+FHN4ZqBeBW1XnGrIK0
	 IicT7Oq18D0R4JfFMeQoNTq4+9KgLlYTON/F7N0RGlz237ePbnPFG+Q7DZAh2dgKg8
	 R/3ezmeoa35ZoGhb7/xKFe0B5pc0qnHWKSaDYRPX78WX/M97CmfIfLHAb0bGRp688r
	 YKZUvW0UySASB840X6rXdiXm9vRQkOq5udSDlnH/2Rns2byoyTBKGxF5RPm+Xa5mA9
	 WGKDHySPHFD62BAISmAQHN5T7bAozHyb96Vbmu5vjG3SmTcPwn8I8GLM6GgeA0ySwh
	 nRJDU4V8qZ96g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5BBED84BA6;
	Tue, 19 Mar 2024 19:29:43 +0000 (UTC)
Subject: Re: [GIT PULL] More thermal control updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gf1UYSyEYKTpsaNFuaL4gEgzGm2715qKoSKKQA233+qA@mail.gmail.com>
References: <CAJZ5v0gf1UYSyEYKTpsaNFuaL4gEgzGm2715qKoSKKQA233+qA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gf1UYSyEYKTpsaNFuaL4gEgzGm2715qKoSKKQA233+qA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.9-rc1-2
X-PR-Tracked-Commit-Id: 4e7193acdecd53e79e341b0f6ab7b19596266f35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed302ad52ba30925a2aa8d989bf9625e1c51ce9c
Message-Id: <171087658387.21820.8413850970885425732.pr-tracker-bot@kernel.org>
Date: Tue, 19 Mar 2024 19:29:43 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Mar 2024 13:54:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.9-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed302ad52ba30925a2aa8d989bf9625e1c51ce9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

