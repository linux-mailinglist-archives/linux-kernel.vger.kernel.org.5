Return-Path: <linux-kernel+bounces-29568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33BE831050
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714C3285077
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33081186E;
	Thu, 18 Jan 2024 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsIve6xr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72683658;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536309; cv=none; b=kPLqcZA9r6jXUi3Zu4KtIjTAye/DguF32vj1UqSxfiS5RRfZKa3r+hOHNl4mcWzx2lhc3VUWgXRdF8SC0lgydD8iM/WDDXFAIUemm/5g3AjK/zrq2VdHYhMjoXRCdjGGlbSxJXfhg1q9s1gfP6w61ODZsXPIdeVn9/SyDcCI1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536309; c=relaxed/simple;
	bh=YipIyI2sSc+tmCQE/gCko1/tSqC3h48uO2i7g15muTk=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=J8p85QzBcVwF92uxGWMkSt/VuvUmQl41HXru2CgrGw211EoBz5iCGvnKTcUYUYOvIvqVPQII7/5suOFPNB17dm9ke4HH04+2yEH4mS5lTq4Xdj/NP3KT7koaX/xoQCmYpsO9/QmuGTMEfceAJKszVfi7vGOqEjofaUKXJ2gfvuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsIve6xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B6A6C43399;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705536309;
	bh=YipIyI2sSc+tmCQE/gCko1/tSqC3h48uO2i7g15muTk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LsIve6xrkJrHsLOsU8JzgBZtlaMLumCa9a2I3bYkEXWC+TwDtBnXdePIBTktyZTaJ
	 4DL0enwNVKMrhIPxZTU4okeojvC0WWv+qThzNYzAOaFrfLt2jlM+nhUvpScyeY3vCi
	 OX1EcfEAtUQgXa4yTpBkS0jmlhHWTO4GX7k+J89tFsrWkQ1b4ZfvOlxzLlKmRslHnL
	 Vprbj8RcyA6ImrhXzHosWLQQG4KdBgIPIAHL3lnar08lWcLcWSSDzCtbjIpWCsX5V8
	 NcKFw4j8uPGi3g7tVXacHSKYz+p3KTav/Z1vT7M8aMfcN9hZyXmBdtOqlgzVped1e+
	 h4qO1a07dLCYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A9F4D8C978;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
Subject: Re: [GIT PULL] hwspinlock updates to v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240115034056.155592-1-andersson@kernel.org>
References: <20240115034056.155592-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240115034056.155592-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.8
X-PR-Tracked-Commit-Id: bcd0f5d18b0b1134ccf9ef68e7a0cf637aab380d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2ec2071cad819fe952a3f1ef66f2d2112c27b6e
Message-Id: <170553630923.10877.9547091529385300307.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 00:05:09 +0000
To: Bjorn Andersson <andersson@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Vignesh Viswanathan <quic_viswanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jan 2024 19:40:55 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2ec2071cad819fe952a3f1ef66f2d2112c27b6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

