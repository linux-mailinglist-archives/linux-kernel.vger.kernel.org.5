Return-Path: <linux-kernel+bounces-69041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2944A8583AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF121F24F50
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458B9134CFD;
	Fri, 16 Feb 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErzP6j4Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77689134CC2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103470; cv=none; b=Iy3uaMqamE9/c0O1WFSM+LhRH5toMQtXjzaNZy0l7bLb3d57+WOkRthWQvBhPZ6Mwy1xjAwAx3yIDCO1bc6SHdWhosnIypKMQgkUPy6LC/7T0gnqFHM6GCUfdnONepThZ7qItJ8CtPCG6HyfIGC639WM++nrR7NLu+VPDygnEuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103470; c=relaxed/simple;
	bh=uXYroRBM3zKlllC3fgNbck6ay/pQdsmZ9GYmNQQ2tqw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZSahuk1wrHfcvwUPywvxb9wcVz64R4NKynSOgKE9FCXh10IGdtraYJMcH1FhE4NhIbh5vweA9vPhXExOdLYUu9QHdgtjCD89L8AqPPLFmGQuws1je7LJgrMJ8WjYKQC+7xbclUdTaiyv2CRxsVO9/CTx2gHYYAQ+5bwWRKYz1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErzP6j4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DCB5C43399;
	Fri, 16 Feb 2024 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708103470;
	bh=uXYroRBM3zKlllC3fgNbck6ay/pQdsmZ9GYmNQQ2tqw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ErzP6j4Yv/Sl2fozzRk9QEHmpoaal+Oo24kBnBe7I5y4s82jISH8xkhXjg4lN6EB9
	 KhgHBgfyotB4itCSJ3cNHVyOEmdeE1kdFTnP3SOOedohCnpHhmuHKhYAtEl9ofrEi9
	 DztOoxdCPqlS9MAU2WKqId+fLLt1y0vlD2bMz/gniSMhElbl8KI71Lq0W3we/vXFmP
	 EbyazbCH0kmGx+2r/aPH5+OIZ2Jv2Ko5Tn4yiUeQSwJTU37Bf5mZlpXIr8nAgQS6Q8
	 VzVFOw8m0g3EkOw8kC/q18oT4/HIGXmIeeUaXYH3SzsJrJwDNEEz8an2TBes/+Zuwz
	 AiA9WhikgAymA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 376E4D8C97F;
	Fri, 16 Feb 2024 17:11:10 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz=LsdsWYZ0hG3Zuw_pLTsV-7wBh7C3hUmAcY9fcJf_ww@mail.gmail.com>
References: <CAPM=9tz=LsdsWYZ0hG3Zuw_pLTsV-7wBh7C3hUmAcY9fcJf_ww@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tz=LsdsWYZ0hG3Zuw_pLTsV-7wBh7C3hUmAcY9fcJf_ww@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-02-16
X-PR-Tracked-Commit-Id: ea69f782d0e37d9658d4b7df241661e651c43af5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca6a62f9fe23713ea2b58a256a1ab27b9cc5a05a
Message-Id: <170810347022.29072.8651832318733133310.pr-tracker-bot@kernel.org>
Date: Fri, 16 Feb 2024 17:11:10 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Feb 2024 17:20:39 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-02-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca6a62f9fe23713ea2b58a256a1ab27b9cc5a05a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

