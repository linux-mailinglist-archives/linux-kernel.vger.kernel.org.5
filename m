Return-Path: <linux-kernel+bounces-31458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86116832E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF411F24EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9315856B7F;
	Fri, 19 Jan 2024 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOfqoMoL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C656744;
	Fri, 19 Jan 2024 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687383; cv=none; b=owdBd8waEs3PAf5+jma+jg6S9RvI+pZrkcG5+XJola+zj0eg+H7V3sPUovk2AwBf86IXtkLJCyErxDlEPlTKOS3/mdch3uobR+fiYeghnPeUo+zYFKxMwyfrFaAi76kAU8RUqP7u3FLu1qw/SWsLJ7OA/e3RVsnwPttM1BJMcyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687383; c=relaxed/simple;
	bh=Gr4/L+APJuGGptFHS6/JYjZ/xtV1YF0B3Gfi7Mc+/9E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=usuz4R2A501iVt4Xru5v/G2Scrh55rBQGkLi+h/pDT+bedord+jpvgo97Go+kAmX95swo3tdWYmvMUq2qeDlhc7OvB5J53kytCaiVF2wYacmJ0qtVJsLunQax92wOCx1O9isct5ORzt12t1otQ3oQD9X23YdbelQqlxI1j0xDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOfqoMoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC26BC433C7;
	Fri, 19 Jan 2024 18:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705687383;
	bh=Gr4/L+APJuGGptFHS6/JYjZ/xtV1YF0B3Gfi7Mc+/9E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cOfqoMoLSRmaWRXbiWTnPNuZs99LfkHeUKUrFGpw5uJ945nDhBjR2kh4e5Y4HLIPE
	 4UXLVrJYRiRBm/CI1krG+SCBGviTj1NZYExFupAiZpLTCliRsNeXOx49pvVV/Yob8q
	 aIFgvsDvnyNoi0Z1hAFvTX39356EVOK3vRoBiCU5DZ3/IZLJXzU/0atHkOmNU9omX6
	 4NgoK5AZUC0/bbGKIZKDY2Wx5pKG2SAFGUXyfWsnzM9Sm4E+8BARgDUXkdmQ2V4n6k
	 5u0ZZjzwUJvu7GqzWZCdxaGzOwpCnBX7OTvyxpAQQMRvu+YvrHBuIhLZ6uahWppV60
	 VJ74hJL7QUrHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C215DFC688;
	Fri, 19 Jan 2024 18:03:03 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mu+MHtC7VsKcv+x=Mr3=eghEfSrp-A4_0Sm2cuPDEzW3A@mail.gmail.com>
References: <CAH2r5mu+MHtC7VsKcv+x=Mr3=eghEfSrp-A4_0Sm2cuPDEzW3A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mu+MHtC7VsKcv+x=Mr3=eghEfSrp-A4_0Sm2cuPDEzW3A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.8-rc-smb-server-fixes-part2
X-PR-Tracked-Commit-Id: 77bebd186442a7d703b796784db7495129cc3e70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cb1bb178cdbdf005b7ac07bb67a1e1f3e365e5a
Message-Id: <170568738363.12972.239242121930944627.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 18:03:03 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jan 2024 18:39:45 -0600:

> git://git.samba.org/ksmbd.git tags/6.8-rc-smb-server-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cb1bb178cdbdf005b7ac07bb67a1e1f3e365e5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

