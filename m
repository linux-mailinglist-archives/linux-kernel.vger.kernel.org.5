Return-Path: <linux-kernel+bounces-97649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7283A876D19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AC828226E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A53260B97;
	Fri,  8 Mar 2024 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5i0hI8R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2160B8D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936905; cv=none; b=YyY9n96mRuOxIpxaidAaAQyqJecn+VZqcXJUhUbt3PlbaHBDFc4KKZ+1o6rJHN/FE6Ov4KQJ+nOMoX08tI+gfEnowuJmGRbjPnlyNbzAktmnTujBC6EF7oM6NF7pONIAg9vgL9YDV1luTg9gM//0BKi8VflaByv1tCehGmGJJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936905; c=relaxed/simple;
	bh=r0RlwkZIdYJdCpEvDjJq8InKgNTycgDnFZkRru/ubwQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RFrQR96ZfQRHAG6reiDkzIDgMB+7IJmKmGeptLs4zqdSvRt7HjKbGClkjTbE3zZUYCAIekRK7oH70WsmMNMq0Uo4mmPKHrL1MzLZSwZp/8Iz8cHCvKAgzekS61611Z8uU0cODguzscwoVGyQjpCFd6SRXtOw2LW7qS6y9LiJ/FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5i0hI8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B10BCC433F1;
	Fri,  8 Mar 2024 22:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709936905;
	bh=r0RlwkZIdYJdCpEvDjJq8InKgNTycgDnFZkRru/ubwQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G5i0hI8RjEDR/oh1ZOK+lwd5pgV+KzQ0kYTDbCcwUfIvOoHnuItUY2SNSeI37kakH
	 3LVMUwJV/K/ODQHylzoaHV4jcdOHBLnai0apUu3G2RsiLiwnoWgys+Bd1ItniKX6BO
	 c+lQFno2YlCFfR/Y2yTgyoOjzF6R695eNl+9CzBrVEAPLfr3QGNUTx6LtiKcK6G/ZO
	 IpIo4eHhrIDBAuNweGefUn82fDueXEpkmb/7x/0YG16egk0AGrCPdpNwFLlSjemzVz
	 6OaM3JflvvnAErszEzawHIyiZ+nvTGk03o2DmVxGkwqLbGQnM5S4ZdBb4jqi5SXS5f
	 p/4A2NpFu58uA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D9E5C59A4C;
	Fri,  8 Mar 2024 22:28:25 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.8 final
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzTeAgY3rUR_KC8=q5MybJ5PDAyzXJyh0RUigR6_ccyZA@mail.gmail.com>
References: <CAPM=9tzTeAgY3rUR_KC8=q5MybJ5PDAyzXJyh0RUigR6_ccyZA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzTeAgY3rUR_KC8=q5MybJ5PDAyzXJyh0RUigR6_ccyZA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-03-08
X-PR-Tracked-Commit-Id: b7cc4ff787a572edf2c55caeffaa88cd801eb135
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6fac3c1f3287735faf1b68e0068f64e6966618d
Message-Id: <170993690564.2485.2022006535317820472.pr-tracker-bot@kernel.org>
Date: Fri, 08 Mar 2024 22:28:25 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Mar 2024 13:52:40 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-03-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6fac3c1f3287735faf1b68e0068f64e6966618d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

