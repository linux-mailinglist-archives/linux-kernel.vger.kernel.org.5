Return-Path: <linux-kernel+bounces-99511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9606878970
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C98B21BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7F65786B;
	Mon, 11 Mar 2024 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNJ98l0z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33E56B7A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710188770; cv=none; b=FRcLwkprGUWmNCq4d3fWWjxUHnBC+5nKZ0qLZQjJwsD8oLzePG1tdpl5J2z46D4oqdRvDkCTFSAYRtZBeefTCHIybb3M1TnZYPnY+moGncEKozkesifp+IlPBSrb5kv3BB8OrUiywtQ0wEhZCxRqgQgdG61HM/4dV/BzgJMu750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710188770; c=relaxed/simple;
	bh=InS4q5X8EsE8djt2ZOLtYosTH7pqpgEj6nMRcW4SSM8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LNr6LH7cGMcH0ZzLcqWhCA91XiBtVfNR6AvQdPSzf+woPQAHAY205C7lNDldAjWyckzbBuSU6PcDZSuxNL1yStDueTasSdqpGQJiMjN9apWPEMux2esq9V0cNNJ4ewPmHr4feJnhPgUbDJennYkhawF4sUGCwbonxPMJ+Hlbasw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNJ98l0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 025E9C43394;
	Mon, 11 Mar 2024 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710188770;
	bh=InS4q5X8EsE8djt2ZOLtYosTH7pqpgEj6nMRcW4SSM8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZNJ98l0zwSoaLGu9Z+WQpTu2fVm07T/eMpLY03rey7FBlfyO7OJHKfpctYcF1c2Fa
	 ZdtNSXYdM45gdxBaQCfCFRRquDIdvMNFh1JjQoBA/qqVWGnkLTSxlQU9pE17LJYaib
	 iBhFq8SHIKUDrxBaj7qtQFslADVU4tRwJH3j8TW1EfZgcV6F301ipiaaphDcfI/5AD
	 f5XxbFjyi3QP6mZwJrGnca1M6aS78XzDVNnvxTA7HsMqMjt8/YWdkLEfani1t5UpdG
	 LPDZFb2i6AZw50gkWfbcDIm7LClENoIBrDWHwdXMcGZoarvzWSt4l5B/e2NfUm55fq
	 KVceUfng5wbEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3952D95055;
	Mon, 11 Mar 2024 20:26:09 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue BH conversions for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze7LNUCf8bWg_wo5@slm.duckdns.org>
References: <Ze7LNUCf8bWg_wo5@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ze7LNUCf8bWg_wo5@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.9-bh-conversions
X-PR-Tracked-Commit-Id: 8fea0c8fda30129b4168464975505d5dc9735ac1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a1e09890cf8fb2e088dab4e4f332cfb85d9b47f
Message-Id: <171018876992.21519.11057799459584900708.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 20:26:09 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 10 Mar 2024 23:13:25 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.9-bh-conversions

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a1e09890cf8fb2e088dab4e4f332cfb85d9b47f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

