Return-Path: <linux-kernel+bounces-133554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6900289A57A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF1F2832D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78550175561;
	Fri,  5 Apr 2024 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pv85l6xo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB303175552
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347819; cv=none; b=CKBDm6/rs0wG2Pf3E7uXZqH6/9FeMYf9m8b7IQTUtZ1rZhwAcudtPbfXT0EMSgMZksnyzkPSlDyOaywqGNcruQZi4tTq4yeP8APx2Us9pxSMJWxBXR+vqMYcxHxn+I3ewz4BkHU84+eScbs0VqT5T0RIuyKscpiEXzJMdL8qPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347819; c=relaxed/simple;
	bh=TRRyT0NzN4udDGntL9vR3p8/0PD8F5VMwB+mcKL5XXo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pegjengYjkNK8hbHOxsmuVbH44ScCo8TCmBC95hUKGS749OEE5uzpqvpWq50Dazj7vXLdm7bjf4W3GeYpywmWnjh14KgBBaj1prQx+sFcN85reLj/AkIMgNUoa48M2dX1SjqLigMMwnA68FiHH7YfrJpYFwoKcYLSN9TfaF4nwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pv85l6xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C5CDC433C7;
	Fri,  5 Apr 2024 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712347819;
	bh=TRRyT0NzN4udDGntL9vR3p8/0PD8F5VMwB+mcKL5XXo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pv85l6xolEKkLwwh6Q7km6BiVIlZwylz+mrLY7bZgdNuJWw5s9BQxIQPp/JpK5W2D
	 GS14U0lxK9vKwGn23QSCZeKV7Fq3z8hisuwJbJAeMUgGBAtemdP2m5kOfoldyF36Uh
	 GH/QZy1Zn3h2IlDpE9ZMCh9I17ZHJfBgiT7wTTf6ReUkkjvXH9oKaJdUNMw9AK7Dev
	 DPXggOKrPXU9WlCWKNVMs4CktBuAgp3Qh+1i6gX7yEO1O5S4ZWdIjw5eTWOt53EUi0
	 XILz7hTFD0eE7LDD+bJ6da23wMZInjzYEREkeRgT1RLWCdcmyIlIHhiS70HhrechIA
	 Zvy9v7yRB1uYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9264BD8A101;
	Fri,  5 Apr 2024 20:10:19 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzjcdJovUtZWWGG8=Qbv_T6csXfehWrrLr=Lxd0OCsCVA@mail.gmail.com>
References: <CAPM=9tzjcdJovUtZWWGG8=Qbv_T6csXfehWrrLr=Lxd0OCsCVA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzjcdJovUtZWWGG8=Qbv_T6csXfehWrrLr=Lxd0OCsCVA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-05
X-PR-Tracked-Commit-Id: 4c8595741b5dd3268d6710545461ee9a7bbde891
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89103a164210f1c88caedf880ac9ab9576a1190d
Message-Id: <171234781959.2800.7077844484895239707.pr-tracker-bot@kernel.org>
Date: Fri, 05 Apr 2024 20:10:19 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Apr 2024 13:41:06 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89103a164210f1c88caedf880ac9ab9576a1190d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

