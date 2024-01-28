Return-Path: <linux-kernel+bounces-41990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB0983FA61
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9CF1C21E1D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296B42041;
	Sun, 28 Jan 2024 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5TpUNBH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8123C490;
	Sun, 28 Jan 2024 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481667; cv=none; b=W+t+s+Isd1b3IksPALqzT/m+FNkGbblX+jDrT3kIzK8RtuB9XQ2Z7SHCFRLxh8iiCG6CmT3nbcAXxd3rQVh5iqh5vKPT6NJyQYGecgWAhnnYPlG+QLnNUMplM89u27GkDB7R11a0PChy2exYUR5PScEs4R57BNX/QO5wJ0+T9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481667; c=relaxed/simple;
	bh=BvaawTLecRpQRxEJoMN3AgHUSrodo+cKAnyZ9yOPOjU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qvueyvJP/3zwPAvPre0U3VDULJtUbfqmD5CN7iEI9K6HOc0HNBy4UaBVJk60xMxEdM7OGyeDCyDUixgOdo6UjRWU7a3TrXvAS8xW3AGOS+ui7BEWQjE9xIF0bHUeWN4iFXd6LLsAhHe1SYrc1KOaJtDekpBk8cyOljYX8eUSJ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5TpUNBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C52FC433F1;
	Sun, 28 Jan 2024 22:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706481667;
	bh=BvaawTLecRpQRxEJoMN3AgHUSrodo+cKAnyZ9yOPOjU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K5TpUNBH4mqaT83tPEie+TPPg58jMB3CfQNFZIh794Nbo7LAFm/cl0WCfEzH2+5yo
	 unKbdJoXfZxA9hLvcEaGyb0KvxcMGpaSeJvT/nkDBzUpIv9orQpMr1JKuB3ca6TjoO
	 JMlTbv4E51s3uWfE9bAyiWSprturL2tdiOGDW/a+OsgrRDS177NCv6Wcc+ru7eFvG6
	 B5lyDJq9p8nVs6LxuiRuGRz58sAu5pfL1t9DUXA67W0gDO8ivQt7B4hwf/e8eXQ2EZ
	 emNI3Do/ooCTNyF2nBPQt79vZvGkCwINVdu642D0v+Vi5jyD0/1iH+LMBhvJ4/n2wN
	 I+QvKC6QuPhTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09FA8DFF762;
	Sun, 28 Jan 2024 22:41:07 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <65b6a29eee7e6_56723294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <65b6a29eee7e6_56723294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <65b6a29eee7e6_56723294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.8-rc2
X-PR-Tracked-Commit-Id: d76779dd3681c01a4c6c3cae4d0627c9083e0ee6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3eb5ca857d38ae7a694de6e59a3de7990af87919
Message-Id: <170648166703.23772.16021667323278437453.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jan 2024 22:41:07 +0000
To: Dan Williams <dan.j.williams@intel.com>
Cc: torvalds@linux-foundation.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Jan 2024 10:53:19 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3eb5ca857d38ae7a694de6e59a3de7990af87919

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

