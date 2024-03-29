Return-Path: <linux-kernel+bounces-123872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB283890F19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0E71F2390D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260EF4A3F;
	Fri, 29 Mar 2024 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QePTstEf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE61173F;
	Fri, 29 Mar 2024 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671594; cv=none; b=P5DgkNcayCsPbD16Nxj9sDAVcOz/dx4hDfoml1rkyBnAZeU7RrS3Jgr2kYSy5GXUiy8Rin2ugkgvp+A+FlpkVn9Ut3ss4jcRBEycmXGwsky0EK9YiEzDZ+7IokgGv/wS8MjjAsBNrF2aEznVkEDZ7RBosk9d2JFRb+vP6G6xm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671594; c=relaxed/simple;
	bh=ZmfhDUUGB3AiP3qPWVc84UTRclF1K3hJt7boFYM5yJc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XO6OY14hFbRL6o9/n44OpqlQN7Zs5MUvh6DjCBCNPhIeYVeT6NdqJG51fDUj12/vgcfjayxtMLxa5rvfCDn6bOTnssmsOhNe00TmB/d13Vb4Y/riP+y4GoMs0CVbPvFgGqDTZ92xzKFyrYGfa4FqeyZ7IFkEOfEKXolniZfoYIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QePTstEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49DB6C43394;
	Fri, 29 Mar 2024 00:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711671594;
	bh=ZmfhDUUGB3AiP3qPWVc84UTRclF1K3hJt7boFYM5yJc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QePTstEfwCrCvtoEGWH/0COIXeb3URN1AywmYEJnXuDJUYpENA5u4sgOCnhhjRr6k
	 C/QN89c1nxDU+X019VOXuf/MNb2/+HTSeDsB9ZDhhSy5SJhzBOY424sEJVk77RUW27
	 L+ewBRjLbGFZt4EZsx0di+/WYwqwxbU1i5vVFOUL8KaPgvZgzOe+qjSNnVlaUmb5Co
	 DM/aAIw+BUnTnEgqdEvNsAm+iX4Fxw2iundl7V2wR9XWFThXrGWHG22HHQAHoPpbV/
	 R65afg2nOewt8iKyg2nX2pU5GU0SloeiQ10DnDxfcPYh++sDo4wy6nUYnCosRRA6Kn
	 ejTIRYgrkLe+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F14DD8BD1D;
	Fri, 29 Mar 2024 00:19:54 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240328121947.2533033-1-ulf.hansson@linaro.org>
References: <20240328121947.2533033-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240328121947.2533033-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.9-rc1
X-PR-Tracked-Commit-Id: 03749309909935070253accab314288d332a204d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 317c7bc0ef035d8ebfc3e55c5dde0566fd5fb171
Message-Id: <171167159425.21457.18246874475363006872.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 00:19:54 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Mar 2024 13:19:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/317c7bc0ef035d8ebfc3e55c5dde0566fd5fb171

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

