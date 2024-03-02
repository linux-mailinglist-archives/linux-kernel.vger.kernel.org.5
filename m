Return-Path: <linux-kernel+bounces-89546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121C286F1D8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440F41C212CB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D326336AE5;
	Sat,  2 Mar 2024 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHfC07fu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D133CFC;
	Sat,  2 Mar 2024 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709403739; cv=none; b=JgHldh4Kioz6AL7AZ4n/O/PMNEFUrpwu09hEK9ryPsg9bNTDVr2Y3UiBpo1gh0+XNYy5bQkWRW2pD07eN82VGe/czWwC6JnLYghvAHwzkb5U0icV4bKap8Pfk5zBM+tJK8866e7aAuyC+4gbSoF1aXidh+YjA4VZJVwqb04KQKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709403739; c=relaxed/simple;
	bh=EtdzeW+5zmeQbspVuhxB1nQ4kSN6YpAh72DSSc28gBg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FDo3TJeOA3DwAzdi/9lHF6NlV2DJdSdQ6nA632SqPh+VUC0V6uZtTcDJD1Aq3eHfq3hpzkC26itaKb/sVGBVm6eD0V6JVlt6BtmR0Kjc59wD5rzMQAOg4hZuazx96XrL6h15BcojufdKoSiKz7dneEV2cd/X+UF3jM5l6HXWcsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHfC07fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBA6AC43399;
	Sat,  2 Mar 2024 18:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709403739;
	bh=EtdzeW+5zmeQbspVuhxB1nQ4kSN6YpAh72DSSc28gBg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qHfC07fuR3i0O8iA75O+/hWXTbpq358mf2/z/YsnMuV0M8sBWh+l1d7wCB5CJ+qih
	 4i+KA/HOUSqk3bERVEXmEoQSZyG8cwnaJmNpL0VlHL0E/XK4TEUbNRfGDn39AgvWsL
	 UxzTVoFSXnG8TaTGa45kEWajN48KeXjFFgSB7Opka0DaFcWdQcdIk2qbSVsQl/8MuY
	 ePJoFTEouGDAQu+1vT0i2+OTii+ek7Lsm9jioRuI4vEVF8J/hXu9ajiONRMG9UTMkP
	 +nswyxOTsxwMSHLtMIqSuGC8wwGW1pUge4bsevekHiTyoeQpLgIBjLYisZkJOQ6lPB
	 JeAUiFUyNvoug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D844BC595D1;
	Sat,  2 Mar 2024 18:22:18 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <1f7995571142ef7e7ed2739bc6f8574d40159de7.camel@HansenPartnership.com>
References: <1f7995571142ef7e7ed2739bc6f8574d40159de7.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <1f7995571142ef7e7ed2739bc6f8574d40159de7.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: ee0017c3ed8a8abfa4d40e42f908fb38c31e7515
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fd664466a8f8e50099ce0a7bb40515782cb3569
Message-Id: <170940373888.2799.5248042845000583063.pr-tracker-bot@kernel.org>
Date: Sat, 02 Mar 2024 18:22:18 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 02 Mar 2024 15:24:53 +0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fd664466a8f8e50099ce0a7bb40515782cb3569

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

