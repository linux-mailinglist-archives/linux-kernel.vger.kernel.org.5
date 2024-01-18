Return-Path: <linux-kernel+bounces-29572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C70831056
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9494285684
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FE78F67;
	Thu, 18 Jan 2024 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRABnf+P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0949217C3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536310; cv=none; b=WjN9g6qC+XBo1s3TYhEZIvq/h5/5ZMgNE8LTBu8ynkqvT0PngMw0IOGbirW0IxghBeEq0TxVSZQbHTU5O3KV73a4j94P90jsNJKIXt4LmzpSfDwPMBcg3zfGUendQCaZA1Om7z9qSr1nfcltDLYAgi/jdLnIT+ZfU+n5xOIU4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536310; c=relaxed/simple;
	bh=0F4O2LVFd2Yv500WYcXNq6qlE9Qes2w2gHuDX7PED9w=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=McRGfbPbksbTLAbtKMWlAvQdSmU3m/6HxZ16rplw/EKqGndm77reigT+mGZ6ivKc6r1vcBFqD3EX3zcksChIGXo++Px6xc719cCcB/cxlwJMc8LY8Wp0hMiAh480qKvWbmOhI4f6RqlNhmvcT3wof+vGKqu2m/vUI1M1Y4K2pIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRABnf+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7905C433A6;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705536309;
	bh=0F4O2LVFd2Yv500WYcXNq6qlE9Qes2w2gHuDX7PED9w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fRABnf+PXpWm8hVz0qlkVALTZETVIb1mj3vqC83bzFDCXEhwYadE/YYXZYpfZnhUG
	 uKxtjG+RV1/l66Trq56gEvbNfHewicDmeqGnegpOZMhmY38tMwXRdEJ05WeLwSzpbB
	 W2wsh3QTQ8MuS1sXaJoW01332eaH73zaC90cmnoEg41m7ZULLIUDM0Xd2kdUtqZCE9
	 or+6Bvb6pr5xkm9+aBQO21yZptKVVabVBKHvjCtwBi3Rza9ed4N6px+Llgg+mamzS0
	 8y99UMnkTXBdKrwOHBsz1fmZ0tKkyWqtWS22zOkPpih8xuQko51EW4JsB232FuOeeD
	 YxQUgC9nhSDkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6B89D8C96C;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
Subject: Re: [GIT PULL] hsi changes for hsi-6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <xnu4qtvu45nm2eu5kq5lkyvfizbiaibtjag7mela6gmisxfu73@zlhfjzqbcmyl>
References: <xnu4qtvu45nm2eu5kq5lkyvfizbiaibtjag7mela6gmisxfu73@zlhfjzqbcmyl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <xnu4qtvu45nm2eu5kq5lkyvfizbiaibtjag7mela6gmisxfu73@zlhfjzqbcmyl>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.8
X-PR-Tracked-Commit-Id: fa72d143471d04ce3055d8dad9743b08c19e4060
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d197e97fb106c09d3d013be341e5961fd70ec8a
Message-Id: <170553630980.10877.14215430658029108347.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 00:05:09 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jan 2024 21:43:00 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d197e97fb106c09d3d013be341e5961fd70ec8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

