Return-Path: <linux-kernel+bounces-29570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5AF831052
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE16F283373
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7313623D9;
	Thu, 18 Jan 2024 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptRIoTDg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4985A5C;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536309; cv=none; b=lxveighxYO7fu3ssG3R6F54HqMkr+qhMMGzKNzMMWi33sbExWcXT8JnDqHotn10eDxqygGjSEr+lRxMDmVIptF969vzw6bq4XMcGfMLYgelaKN31bLInxWVhUP40VClgzrvY204sXE0hrWkOCDfd1Ois2GvD0xZKGS1fUssZidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536309; c=relaxed/simple;
	bh=F7bMKMvC8Wdak+tg1Pi57cpa/Gt+wxNzrIvZTqLTIt0=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=UcvykoLXXdhRHo3ePtEYvczoHzOcS6GNIWCgSpH095h/+NsOtnksu3QcqpzJ6mLD+9Dbtp/4Ae3t3qgdz9Xt6/3ZmyTWw0lkdt2tNgLqAK2ieeQLdXbVD/KfjWDVnSTRjp+CPy6gcls2YAQhwXuI2XB0O4GUEIzMnLDgY85yyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptRIoTDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BC9AC43394;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705536309;
	bh=F7bMKMvC8Wdak+tg1Pi57cpa/Gt+wxNzrIvZTqLTIt0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ptRIoTDgzn9XfdfDx0f4oRYcrAzJ3391Tq3Ws+aT1YHeTsSnU2k8AMgo4/strRlH2
	 gNSaK+QLvUhCu3XbzcRoCrzZm0hgt6uOBB8vep9mslCe0s7Cwh3C+D5b3XpxGfagCr
	 4It0ET4kQuz8g1lm00h6L5oHD8L6hrZ2lLdoFGTrigr3dbOImTnde6VVi/ohICB03e
	 ZEedruWo1cAnggDybbjJsY8d3Uc/y3MDWmVAllAYtN4mGh2qleMaTgbkirmExtr6nv
	 pTD0wA4gGmw1jd8LqSHiXFIV0cQ7HGbuNRhs3xPX/uFtKHT0AKw++J+ATRjs3XuOaM
	 gK5mnWBkf3vmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14CD6D8C97F;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240115033537.155277-1-andersson@kernel.org>
References: <20240115033537.155277-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240115033537.155277-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.8
X-PR-Tracked-Commit-Id: 300ed425dfa99f6926299ec196a1eedf05f47b21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e88481f74fee690316c1e0fd3777f919067d2d58
Message-Id: <170553630908.10877.9723578272706589212.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 00:05:09 +0000
To: Bjorn Andersson <andersson@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Iuliana Prodan <iuliana.prodan@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jan 2024 19:35:34 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e88481f74fee690316c1e0fd3777f919067d2d58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

