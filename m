Return-Path: <linux-kernel+bounces-103962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB6D87C710
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A8F1C21CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C345E6AA0;
	Fri, 15 Mar 2024 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5w2hKcn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB151870;
	Fri, 15 Mar 2024 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465608; cv=none; b=Pf31Ny9dmwYnURduxb+/vpEeITAWumCCmJOw6JOot6aesDjaiM14Is2By4HaKb1MrbuiCxbBup8x7SUUodmHKAey1BRBVUYzOjeUxdybMc4aU1JDd+lsFnFAA2bqF3GjYPZObGOJuI4sOjr8TzWhYFLcsxkBRy0R+ZWs0NAuKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465608; c=relaxed/simple;
	bh=R02zdMpAsTWKaNl53UbuNuzIfhg6B2faysCWTPete5M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YF7pHoF9q2hmGCT1wJAWio6syCIkV/M5Z4UU5C16z1dyjvseJrRg898/IfFGWZPc+ZXz0EoxsOsgXYE3gHLumOvjBA/plkYUnr0EavJyexgTmmKUjvmnSyW2UxVtOU5E9HyQq0L3A7FgWKfv0BZe4x6hn44rVkQZNhKxz4shBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5w2hKcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E79A7C433C7;
	Fri, 15 Mar 2024 01:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710465607;
	bh=R02zdMpAsTWKaNl53UbuNuzIfhg6B2faysCWTPete5M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T5w2hKcn8CEXJCE9ukAjx04SDRpG3z06F1IcKhEV5VuENxgrY8vx29BtKOwpV8Xwr
	 qfCkPBC15Ku5OMb66gP8XR2kiCDz7p043RGM/2KPLfQUOn6kjtL+22rMLNsJvXZbq+
	 p092+olr8Un3IB53MaPfVUz9xuqbc56YJQF0EDsvyDazr+02mUsoc9DAYHjWJOrS0R
	 OU40vecyAN0zSP6JFkJxJGXEHOaFOwXIvDWfoDy3Pa6Pq1QlOI3oeTXXqNO/ZViGB3
	 l7NbW/n3wASP5HZOSOVqiJb++JJ3PhJfPa1+tVLJLs23Vwp1/7YTGyrdP9Jel0d8dv
	 9/7/Q+rOJhmIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CEA2DD84BBC;
	Fri, 15 Mar 2024 01:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] MM updates for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240313200532.34e4cff216acd3db8def4637@linux-foundation.org>
References: <20240313200532.34e4cff216acd3db8def4637@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240313200532.34e4cff216acd3db8def4637@linux-foundation.org>
X-PR-Tracked-Remote: https://lkml.kernel.org/r/20240229101721.58569685@canb.auug.org.au Thanks.
X-PR-Tracked-Commit-Id: 270700dd06ca41a4779c19eb46608f076bb7d40e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 902861e34c401696ed9ad17a54c8790e7e8e3069
Message-Id: <171046560775.16379.17192756931551493558.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 01:20:07 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 20:05:32 -0700:

> https://lkml.kernel.org/r/20240229101721.58569685@canb.auug.org.au Thanks.

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/902861e34c401696ed9ad17a54c8790e7e8e3069

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

