Return-Path: <linux-kernel+bounces-167908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2629B8BB0EC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AC428597F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C6B15696D;
	Fri,  3 May 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujCkvaqo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3AF155399
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753776; cv=none; b=L0WoMIZPFEsPYEk50ddx3QoB5xNnAVOo55c3KpXlJspWh6V9NgFc3OAH7ch2t9YC425Z4peHTwJJCQT/TP7pY7JMIjs2ME37UMoVqqm3pyYUw9aIyL5cEtD0d9CSw/WSHFxDnqpnwenR+VKgQ46yrmAcFVJF5/WnlYzw5vl+WV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753776; c=relaxed/simple;
	bh=WGfLyEbMff9klV6cWZVBg70AvLSeYQq3HexgKbnHaeY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jmpAzmAOVlsRQopvfpoErodGil004Z6/5tFFnVfFYtgQHmPH6OhyngesjW8tsDmPq4myK8YAkyjbscWe9O6ZxWxVFIEWA92Go8rZApvj/1ts4QedIgs9/78AZY+VzS+WGzdLmYvlhxeb/NmRqvi1gYcj/cYKn9kPjuhOHk/VnZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujCkvaqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00370C32789;
	Fri,  3 May 2024 16:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714753776;
	bh=WGfLyEbMff9klV6cWZVBg70AvLSeYQq3HexgKbnHaeY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ujCkvaqoL5g6839Wdyu1uFcihgyjyNN0C6fuv/QKobeCNSAh2R955gaDNrOmr3mC4
	 LTUtXZk9Mt5uDzW8HWjkvQ2thfa5k1dvviJ1zspejOls5/jfcPOmSFiFR0GW3clOv5
	 AKrBIJo2Jj5SW+TDQfnb1oPhsDQod0JJ946zKJvn7YBiuzQynoUcAJ3sOy+tO0VR91
	 nH1p4TJjn7LAHc+92M8aA6hzOIRBuDeIQc6FNOY91NADAX4Tsa+13apRtVIPMIjAQF
	 IS8gWrfUJrlFrUpzp/9hmRfuN2ceCFZiOlahl9iCy0f3TFzz0zmyDMxZrsJb1PY47v
	 EtutTOxrUGf9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAC5FC433A2;
	Fri,  3 May 2024 16:29:35 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty6LzXnyr5J1RrR8xRdiRcooTkoPuq9m108mUEsF7R98g@mail.gmail.com>
References: <CAPM=9ty6LzXnyr5J1RrR8xRdiRcooTkoPuq9m108mUEsF7R98g@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9ty6LzXnyr5J1RrR8xRdiRcooTkoPuq9m108mUEsF7R98g@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-05-03
X-PR-Tracked-Commit-Id: 09e10499ee6a5a89fc352f25881276398a49596a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5a66609a643443e2b14773dcc784496ee1e5457
Message-Id: <171475377595.10066.13436030257937843822.pr-tracker-bot@kernel.org>
Date: Fri, 03 May 2024 16:29:35 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 May 2024 13:52:43 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-05-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5a66609a643443e2b14773dcc784496ee1e5457

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

