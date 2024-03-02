Return-Path: <linux-kernel+bounces-89618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDA886F31C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 00:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9AB28410E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E21553E20;
	Sat,  2 Mar 2024 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIw1Eff2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3261E538
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709421623; cv=none; b=LADCrwMAc+BH1w5eNyYXQTRCEWzZ89oUeuedqcFSPDJp7Nr6jCM7R/CLvtE7D3EvRgH3tW2vekH+n6fXHBS8aUKfOmVIDbrCXp95OSGCZX+ycv/DDNF+ioPqSAYd2elVNEbsqDIwkyv0t4n1V4vxh30wSqFkTOzI3hAhNNJxdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709421623; c=relaxed/simple;
	bh=5hT1Gm9kieKmDtLN+o5bF5+d0pJA1q6p0U4HJJi5Gzk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W5p9ZIguYv13f9dDy3IIYglZJufETpTyGY2OhADXn40d6s5Uc5JUvH7tjqfalLO2p/L/8riBxDPDxa1ak8qB52FLNV3JbtotcBFXCSOoI8w+xuOqAiyL30jv6GhSZ34dDEcEHkttvxev2AjNQY9IuOyRU/+DMcLiJoxP6IuArZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIw1Eff2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13D0AC433C7;
	Sat,  2 Mar 2024 23:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709421623;
	bh=5hT1Gm9kieKmDtLN+o5bF5+d0pJA1q6p0U4HJJi5Gzk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fIw1Eff2KyGOxveOF6bgCLrPuZXNbCkY4THXS5/nMahynkjHsBXnhQkpd7h2lbxSP
	 QPsF+7q/PO77zVvLfV+JyQp6S0G7HZLqnSNG1OaFyzGED+UNompb4BApOHOzUeM6ig
	 R80vi0R3syCf+OUUW0h5GYfGbYqPPMhHANdG0JEHH6ouzK14NKdieBF17taHg3cpAn
	 lx3MoPxzj+wbKQksGKUZvJI0yVo88t4U2b77WuQABq5OwdrXXKTPEBhUP9g0pHjrOn
	 7xISxDX3SOlt58X2Vv7AUhONLrxvIezQCewmKXToH/CS/fqlkPLlzORJtk7pe/TKwc
	 Eplr4+goZ928A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 020CAC595D1;
	Sat,  2 Mar 2024 23:20:23 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240302231242.GA33788@workstation.local>
References: <20240302231242.GA33788@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240302231242.GA33788@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.8-rc7
X-PR-Tracked-Commit-Id: d0b06dc48fb15902d7da09c5c0861e7f042a9381
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04b8076df2534f08bb4190f90a24e0f7f8930aca
Message-Id: <170942162299.12689.18397051625287685447.pr-tracker-bot@kernel.org>
Date: Sat, 02 Mar 2024 23:20:22 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 3 Mar 2024 08:12:42 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04b8076df2534f08bb4190f90a24e0f7f8930aca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

