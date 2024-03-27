Return-Path: <linux-kernel+bounces-122066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DCC88F171
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E9B29F0F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4E2153BEB;
	Wed, 27 Mar 2024 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YItXu0rO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFA414F9E4;
	Wed, 27 Mar 2024 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576625; cv=none; b=ZCCuZcnRyishtzbjmNE9+S8b7GrksCj20OzIAS2voe3JLEzhpnVDm0kII0C8oFPMJm0ErD8YupFgULPZ+peOSrFaH5WxK9ACzc8HC3t4UrfoyqLYWO4HeVCT0QB89GYp0hzvqdYQzAjWZ9JSOjleCTsymZZ7W96k63y1U11/Y2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576625; c=relaxed/simple;
	bh=eD8z1z3J8t0Ty4jenZj1K93BRTnnW5pYd7UFiiREz9E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NVY//XsEfcYVen7e9xJrbKAnS3RtcBofEGl+oQLSuVEHWgiFth4qFIR/kn1ofKlWozfhqjt3XC1giI7tTcqNlPnOHa0rLi/D7F5eJdcaxeBfJ8WVUbU/zhYj8SGXrbcbzQPPBjVL6iPHJIXsdtcB4exNgH0eKfpxkiDQ93y4j9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YItXu0rO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6158C43390;
	Wed, 27 Mar 2024 21:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711576624;
	bh=eD8z1z3J8t0Ty4jenZj1K93BRTnnW5pYd7UFiiREz9E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YItXu0rOmwo9x8vckv/qHO1WAyAx7jKdgGpNXGrSucfHtOdSrXTmWwOjSMU2r+xUG
	 QQsSmid+S+/W+hIht+Eh5eETBZdgva5yc+LEqkcZGYqPou//k1F1ObRdzX9cA3suA/
	 9WwdJPO9A6JickozngVkr4SlgTDihkbUIPPUzXkViQg+YsCjPoGqYiF8z6V8Iv4IEF
	 Tdb1jCV+3mbOH5Wyx0km8LwTKH5C3FMdT3iC0AbrcnuaAibFiILn7cv3sgohhkGEDb
	 0oE4uj6+JAlohK2QYSEYkRWSQihEoevl9aJ7ouyVCxxqmbgvMAQrSRVBmu2s8Onkk8
	 cPwOq1Ro6Kq6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D07A5D2D0EB;
	Wed, 27 Mar 2024 21:57:04 +0000 (UTC)
Subject: Re: [GIT PULL] fs/9p: fixes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZgSQ1nvIyOGm4oCD@3f3e8491d9e9>
References: <ZgSQ1nvIyOGm4oCD@3f3e8491d9e9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZgSQ1nvIyOGm4oCD@3f3e8491d9e9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-fixes-for-6.9-rc1
X-PR-Tracked-Commit-Id: 6630036b7c228f57c7893ee0403e92c2db2cd21d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4076fa161217fcd64a578ca04586c4be728cb004
Message-Id: <171157662485.29991.9722331021577168756.pr-tracker-bot@kernel.org>
Date: Wed, 27 Mar 2024 21:57:04 +0000
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: torvalds@linux-foundation.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Mar 2024 21:34:14 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-fixes-for-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4076fa161217fcd64a578ca04586c4be728cb004

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

