Return-Path: <linux-kernel+bounces-89068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB8886EA2E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9E61F25034
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004F13D3B4;
	Fri,  1 Mar 2024 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6Ycz0EI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204603D38D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324245; cv=none; b=uDEHhnQGao1khsPhOFukqpBTQTmR8W9HPDLYEA3wWmWo+Z3CTsNHss0qoHrAdNmmq3tlWyHEK+5yPZstka5l6/oeHEgaaq1C/oO7+pV4mPH0XlAp4BO8HDMZHR1R1Q/0xUVQXQ/U8qT09XNG6sVhqtxoDvv3AnCX1JTHOxivRp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324245; c=relaxed/simple;
	bh=Kj/kYldBRmVKDR5v5fTZ7Yo+eiuB4GvJWSOHxUMC8O0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cCWj5uagVKMRVvJsMHo5FtiycuEh4jUNXmr2p3k/WHyMqU/gACWQIKgpgmWyw38HVsrnR5VnR5l+gmDIlXBILp+gGwL/VlY+fPBde6u/FNOapnxSiNmmDjrHKTbl87k3TMqJSPT4Dg9WIBOdLmsGmpUSjk+tsOKxj3G2GbGIHnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6Ycz0EI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 025E3C43390;
	Fri,  1 Mar 2024 20:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709324245;
	bh=Kj/kYldBRmVKDR5v5fTZ7Yo+eiuB4GvJWSOHxUMC8O0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Z6Ycz0EILJ8Vqb7pMG7y2RuILnVwXhGfEFGJ9h2U53K+RH9K75HETs1K6dm3OI6Ru
	 7oOJcu2hjAInQh9/3ooAJdGr0H9fgSnni6p+voP5FpaGXpHc0Z2fI+iEXfJGk9ZKIu
	 VnmfmCjlf1VBy9QnTy42D/11V36IaBFC6ftpE2Esomua5nqpPuzdfTjkuQurCsD4XR
	 OuJhDEOQbbCIzO3FVD55H9SgdoBdmZcI5/WvQgN2oz7Vv6JUeUbtzhuTMLHYiQ08Ly
	 pdy8r16VgeMsSruK/7rZXD5FtPVWrdsMBOnlFcfNjsI0p9AHnXu2Vp2vwXTfTgJwGU
	 06z0mfOOORJIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3B57C595C4;
	Fri,  1 Mar 2024 20:17:24 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyc=L_69XMch05z=R+Kw2BC-jRCgnYMXMRtUN+RkCW=2w@mail.gmail.com>
References: <CAPM=9tyc=L_69XMch05z=R+Kw2BC-jRCgnYMXMRtUN+RkCW=2w@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyc=L_69XMch05z=R+Kw2BC-jRCgnYMXMRtUN+RkCW=2w@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-03-01
X-PR-Tracked-Commit-Id: f6ecfdad359a01c7fd8a3bcfde3ef0acdf107e6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7187ea0978bb4226873b55a065b5dcdda7530b9f
Message-Id: <170932424492.25962.2304478243242740471.pr-tracker-bot@kernel.org>
Date: Fri, 01 Mar 2024 20:17:24 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Mar 2024 15:41:03 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-03-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7187ea0978bb4226873b55a065b5dcdda7530b9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

