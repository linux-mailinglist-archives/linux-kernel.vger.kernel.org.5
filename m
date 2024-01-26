Return-Path: <linux-kernel+bounces-40842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F304E83E6E5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF823291C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D30604B1;
	Fri, 26 Jan 2024 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8A8c0yE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D7604C7;
	Fri, 26 Jan 2024 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311333; cv=none; b=Py7WoaQFPoj+GPYMK6fdaCishVRQu/6JMIGtWHDLOaNM94nlN9umob1I6hRsRJPHZiLiEpPiFITHvOBMo+Umg6qMGv56UDN8181rNmE50kmLt3/a+lT11HWSQl++XhnPRbKXC8rmJAzDdpTJMIQplElrVpjk6W6gNzW98aESNBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311333; c=relaxed/simple;
	bh=O0baEDSqHBaACrPol70dLTnw2rTFVcnfbClX0AmPaH8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Oz/nROPCmE1JNYdE1riiMZN59PgQ60eufsVZDYg3yf3YgRNyFIXAb+D4taiQYbA8OcnYzezyxsWf5/aPxofT/MqCC6Jc01fzSISinpys1qvTHKmvHn8gWX1yBfbu/qFr6FEWG981263oEzAWX4R782GkSm+qSLyjaPsgdJZAP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8A8c0yE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87323C43394;
	Fri, 26 Jan 2024 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706311332;
	bh=O0baEDSqHBaACrPol70dLTnw2rTFVcnfbClX0AmPaH8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K8A8c0yEH+EcGmU+f1cqElJGmrOjWUSnFnNGTXpsNBJ07sVZ2eYew/Z7+xQuJxvA6
	 2zrLpAglSEPFB5ZAHm/2TNOXd5QdjCKW++t2CPTh7AkCanZ0Ad2qdL38t6CzBtnzrV
	 jhRdgIfICnQ45Q+KBi/NWodJDe8TG04+AtSAu7vd/NYIq+sggkTZdSOi2IRgG1NJ1U
	 kZkv9ol+nPmksVExkLdkKfXQkC5bpnwT9bl/KkVaP+BaacOyG12ZVjoGCaT5M+WJD8
	 UVfTWqWJj+l+3YDTGIi7fP6yaJkzopATgyTB/2ufPIUuGJDRpZTmERlsjfOLNmIWIl
	 wQ63gmVm8Iw3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D50DD8C961;
	Fri, 26 Jan 2024 23:22:12 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control update for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hCuQuyctY9NUXJ8-NGR2PfVmY1y=Ajd936Mh9LnjNg+w@mail.gmail.com>
References: <CAJZ5v0hCuQuyctY9NUXJ8-NGR2PfVmY1y=Ajd936Mh9LnjNg+w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hCuQuyctY9NUXJ8-NGR2PfVmY1y=Ajd936Mh9LnjNg+w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.8-rc2
X-PR-Tracked-Commit-Id: c6a783be82c893c6f124a5853bef2edeaf26dadf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 667c889308a171748dd19d496a9714b77c688a86
Message-Id: <170631133244.4030.16862837073744185322.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jan 2024 23:22:12 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jan 2024 19:30:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/667c889308a171748dd19d496a9714b77c688a86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

