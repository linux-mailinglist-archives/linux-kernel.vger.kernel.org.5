Return-Path: <linux-kernel+bounces-139671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ACC8A0645
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6265D1F25C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2979913B589;
	Thu, 11 Apr 2024 02:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0cPoTob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92B5647F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804262; cv=none; b=uO3wEc65eQ9Eck/MmETaaeqNEknC86qdztw7Ud+dWE3bkUOIRslkzJSH6mJceNoxIyVVZD+kLTgMvdXlH9kyqIMGsmVsRDgCHfcOXxRqHDDiW6EYrvj5aQMKNCJebbTWzkHTa/39pkFrJhSrUc2+aMoPTz4hkKog9hW8pnv+WzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804262; c=relaxed/simple;
	bh=41LD9Xf3PP0A/ka7dozB4DzsSxmwpTfjHl9ZUd7xxH0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CKbF61PhyilB42nR6yTIMyV/2Pz7lqIaDy/EdhVctObdqriYoRHzIenzWHhJI73HGauALsGzUsPsd01bbZ30Ra1VTUMN2L2Va7VkVtYOGf5UCfWszE8my2iBiBkkLxft/kIOpeczvLqyzEVoMQdtiIYGLhyYInAis+Pe7aDT2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0cPoTob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28DA9C43394;
	Thu, 11 Apr 2024 02:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712804262;
	bh=41LD9Xf3PP0A/ka7dozB4DzsSxmwpTfjHl9ZUd7xxH0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r0cPoTobzDmNUObjcEz2P5px1yB3Le3x20uEMN+gqzya4hb1aDNFrSCMKeO8XtilW
	 jCG8Tm0JGC/v4kvh6zMCbd96+cyvP9ar02HytNg+f/jgFdOWLPUPd5wR7HClL8f+rX
	 35tiNbpKFLYkVDGX/5EpwfqqqpjX+kALUVbrYEcCm/lh0HbQkyHZCVCT0GYA2MpxOX
	 PH8MD56a2sQ2QB586tqapJm0RriQ9rv+ZrJMX/h5+GNZ4kk1tQZkDsxx1G25F3TCd8
	 QHGt6ePWt2CDeHZJ/jqJAUi4Rhsmq72Bt3I2ARjQD7/G3KwVE6rDvPiY9KlqpKUMAf
	 RjQ3Y6N/x2omQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F9D7C395F6;
	Thu, 11 Apr 2024 02:57:42 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240411100918.15b7b8a7ad25718a9dffff91@kernel.org>
References: <20240411100918.15b7b8a7ad25718a9dffff91@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240411100918.15b7b8a7ad25718a9dffff91@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.9-rc3
X-PR-Tracked-Commit-Id: 325f3fb551f8cd672dbbfc4cf58b14f9ee3fc9e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8c39d0f57f358950356a8e44ee5159f57f86ec5
Message-Id: <171280426212.32383.8694583910737677172.pr-tracker-bot@kernel.org>
Date: Thu, 11 Apr 2024 02:57:42 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Zheng Yejian <zhengyejian1@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Apr 2024 10:09:18 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8c39d0f57f358950356a8e44ee5159f57f86ec5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

