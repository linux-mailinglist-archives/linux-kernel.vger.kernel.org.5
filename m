Return-Path: <linux-kernel+bounces-151775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC248AB3BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BD61C218E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE0813957F;
	Fri, 19 Apr 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUvDr3tg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D3137C22;
	Fri, 19 Apr 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545383; cv=none; b=SjG6UgOPDYiREDKx8XJfE26x+9OMRg8EE+dI904pgJGjKmCd+wcArEk7jr0534bmBJg5GFE1b3He5vP0jkaeNOJAoqqaRWlLLpa+EKqNf4Zw7l5qhJDP1nMX++M8CHBjnu+lYgMsGwqmXhUIK4A+aoVzfJdMC07b0wCrtptexA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545383; c=relaxed/simple;
	bh=LvIXi2wN+yYFSO+Vl+/VTbjTLcA1eivTooBBTxxTMFY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FUpHvvmerihdkTaVSpH3p1Tt/1utEXlU52iZMBhZCCzOaDMy2GZ3XWPKavOlF/PKKgKkqNxWr4UgQIO/QFh2grZolqMEXgcsyn3GFl/Ebgqm0njNHcVOCVxuEv8J+6g0Gyo/LCR+Y9V4p3ByRzqy4N7iBERn+1WRyLfR4Mr0OfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUvDr3tg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA5BFC2BD11;
	Fri, 19 Apr 2024 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713545382;
	bh=LvIXi2wN+yYFSO+Vl+/VTbjTLcA1eivTooBBTxxTMFY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jUvDr3tg2+e+IK8hbS0oKwepz6deiX8ey/Q5Ts6OoXyjRv3cIqY2il5DN6iGMueDo
	 aLb8wty5XOmYl6iRIB7xJak08SF2Sx3phsdpLLexLFZVkeWKMhOSPsAqBq2zB1e6fz
	 mPtjTzA16ik/eTFeO7Zv2ScUhgqWo1KMa6s36F5ZYGq4ytuozt5QmUd5aJ4uZiJH6F
	 WOkUvymQomnB/0HiMQ0OGu8kShribmPeOdJaN7g06NBgvb4kdWyFcT2yyBhVtmDQH/
	 w5odCMXVaxXOgbMZIHTZ2IGEUGEZYOZ/a/fLogQkVepp/Rk4Wm2wv8i/RqQL5fXD8e
	 Yzo7quqguhEVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9AB1C43616;
	Fri, 19 Apr 2024 16:49:42 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hqseoeH6t0xKNOC-NMAXz5dWxTA5DKqGdxn_AghRKP1Q@mail.gmail.com>
References: <CAJZ5v0hqseoeH6t0xKNOC-NMAXz5dWxTA5DKqGdxn_AghRKP1Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hqseoeH6t0xKNOC-NMAXz5dWxTA5DKqGdxn_AghRKP1Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.9-rc5
X-PR-Tracked-Commit-Id: b552f63cd43735048bbe9bfbb7a9dcfce166fbdd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbe0a7be283829566c966642c739e820e0be1081
Message-Id: <171354538273.26173.3611669050829355017.pr-tracker-bot@kernel.org>
Date: Fri, 19 Apr 2024 16:49:42 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Apr 2024 15:16:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbe0a7be283829566c966642c739e820e0be1081

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

