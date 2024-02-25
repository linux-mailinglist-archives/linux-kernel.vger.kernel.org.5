Return-Path: <linux-kernel+bounces-79915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED48286289F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 01:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F527B211F5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2341373;
	Sun, 25 Feb 2024 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCXRGvA7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62E10E4
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 00:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708822636; cv=none; b=fo00dSqCzN8rEVvWIwfOnj/Oma1E5SlOyac36063gDfhT0TLW/j2wq+K/JSpHsWzYB4t8GS3s2/Gvru3J/x4foMyQJlyDVdiYRVj/Zyq/Hq1b2BOv+DLA82PREiPec7UqaW/W7YpZ3bNMES3pXNFsGawneaiI7n12SW+2v8GQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708822636; c=relaxed/simple;
	bh=gskYjTtZz1RQxCoilkwn5p3RZlAHtJoAXwW7n3t8sHA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Wx+b5tzlxNex8KXCvqLI68Nv/XMDHGrVGquOIoJn6SDRW1sGLS5Z8VLsGymVtH98gkQ30k7CU0VvygQxvd3NNZpVtm+Z6Y+AKj/jDbdUIUZ99Xkr1OOVqafd28GRU9FVRkALr1a0A/teDaA18XWOYC3mmI7ANBYcdIdcOS7v0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCXRGvA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCB56C433C7;
	Sun, 25 Feb 2024 00:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708822635;
	bh=gskYjTtZz1RQxCoilkwn5p3RZlAHtJoAXwW7n3t8sHA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SCXRGvA7q7VbLko6MU5akV/Rdy8/54cJr8ZnWAL9yTqAiouS2UG9nVjBzkM02d/0J
	 47qlaZTV9dRO/m9zNn+rC8jc26LR3wNTdxVBW74VSY1ZjkN02ktsdKJj5Op3mBBT3e
	 ALNhdVJab3b9Pz6CS+WysWiih1jJ+ygS/BSYeUkFZAo2s38Qh98WB4PfLiUd+B1TRv
	 QgTa3CwqM4K+UGGn+HMX2DZoWsM91oIwZNaexNur2Cf+v8zlol5Z82o1YDz02D47LJ
	 4gF5+hjIDb5lkudcStJiI+Tt9EuwmUStu4S6CF8NtVwMgOhgxBolViUAx6Pg7GPDnm
	 HggSLA3jp6xjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EB0FC04E32;
	Sun, 25 Feb 2024 00:57:15 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.8-4 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87jzmt9y9p.fsf@mail.lhotse>
References: <87jzmt9y9p.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87jzmt9y9p.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-4
X-PR-Tracked-Commit-Id: 20c8c4dafe93e82441583e93bd68c0d256d7bed4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab0a97cffa0bb3b529ca08b0caea772ddb3e0b5c
Message-Id: <170882263555.8321.1129219517275240699.pr-tracker-bot@kernel.org>
Date: Sun, 25 Feb 2024 00:57:15 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, amachhiw@linux.ibm.com, gbatra@linux.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 Feb 2024 11:35:14 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab0a97cffa0bb3b529ca08b0caea772ddb3e0b5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

