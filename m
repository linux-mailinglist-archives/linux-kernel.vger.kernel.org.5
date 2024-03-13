Return-Path: <linux-kernel+bounces-102558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0999A87B3D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5A1288AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D505A11A;
	Wed, 13 Mar 2024 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMuQblVM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164C5E099;
	Wed, 13 Mar 2024 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366458; cv=none; b=qe/wC2lEzdb1OSSlHs1/tzhL/knxk2fNnY2nUUs4qwUEuh5zaxye4r8VmrIrbGo8t/SotbaCbFP7gZa3v9x7K1ZF/xmfy5mir4wmJRBiMj1c6woas9c/FkFyOQSesv3DwWf4kXsur4RoyeN03nE9J5dviO/926sH1kxfQdNCCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366458; c=relaxed/simple;
	bh=NLhzVlh6rjz7a+YzbzcpwdqpY7R6YE9Aog/T8c8e41E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dBv3ZPR6zR+LlnfZ1Ruhu3GKfNxDiNV2cxqCnRuHKy/gDB8TFtb4WiMUHu0jl9KCQuAoPjB09Pjta0kX5ZK8rzoL6LRZRnVKBSlyk8FgYQ01Dyhl9fPLLG0JsB8bdCG4Cqm3TDaopC9tIrqBd3/2uJzi3DhU0/GEejTa5r3Vnto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMuQblVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91936C43601;
	Wed, 13 Mar 2024 21:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710366457;
	bh=NLhzVlh6rjz7a+YzbzcpwdqpY7R6YE9Aog/T8c8e41E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kMuQblVMr7EFbig216t9i6ouP8VHYiYfQBTWpZjEJENmFrVL+Go/PhKtF5sI8GbTw
	 Kc/EGy0c+Khk1NYvW2F2VLOLu1jqQoMYTdW0y9SbRwa8uTWu9oo2EmoPMtQIKCBo2N
	 BIZpTWFRmW6EWnx5hReTY3ZJXqyNm9Q/leUOdAJXQNoJxu0HURF4h+AJELDXOjEP5b
	 8fzc2tZ5fnJ0pqUQtxJ/AASytQSq1mdbrzU7rLwwoogdLVQ2VeldzcflMOuKw23SUB
	 YJfr7hQfIT1PJ2pI71VY4EaFekzFdGIqSJDGL5g9BTEOXyeuCv3Ow9H7OLpXNFxOka
	 2Q/G0RWbvNrSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D41FD9505F;
	Wed, 13 Mar 2024 21:47:37 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240312002904.1929283-1-jarkko@kernel.org>
References: <20240312002904.1929283-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240312002904.1929283-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.9-rc1
X-PR-Tracked-Commit-Id: 6fa6b796e037a15b1c208b1158f801f9adcb1f2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27b984af7a93581e59061e6c4c0c4a62d130d41d
Message-Id: <171036645750.31875.13878486296973699091.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 21:47:37 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 02:29:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27b984af7a93581e59061e6c4c0c4a62d130d41d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

