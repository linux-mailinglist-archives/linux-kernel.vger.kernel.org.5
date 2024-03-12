Return-Path: <linux-kernel+bounces-100649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52745879B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087BE1F24377
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216313A879;
	Tue, 12 Mar 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv/nxsRQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E3413959F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267609; cv=none; b=XxJNdnkQERCYJwQNYYLflEdYSAitFXwx5BmiTD/1Rcdlil5dcyBKjJoITlJkY4+esC+m6c50Mg7RiPXZjhLUYuHVdM0scortCfkELh2uYO3+a950y9kzQxM/RawRRV7Ke+ixjQ1gcrjgrJ/D9wk6znNJ+yKofDeIBw5WNTAw3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267609; c=relaxed/simple;
	bh=yTeDOkfYMZzzpCQxTB+5wu6GscJXJCoQWivULyANQJY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AkrCjg94n5gr/sK7ffszQypN8lpeiKcr9EWTMYghbK+LyYF46uYyySTERnGStwZoqUKT1gqSKcppZOb3fOf/AmRPJ+1LXPO5MjrAzp6M44uS0XqGyeGEFMzOvdOYJMRXNch2TPRz0B6nWPIIpRTMhIdkamWvpDsa7WCOCx+QwUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wv/nxsRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E975C43601;
	Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710267609;
	bh=yTeDOkfYMZzzpCQxTB+5wu6GscJXJCoQWivULyANQJY=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=Wv/nxsRQ9S+g8BDr0P86fsYga6bnyC0hq0gaYfoGS/6F2ON1FdUc3qZUNPzMOh4Oa
	 O6ZcGcDGXTmrh5BybYa8vPb+3OvKBeX78z9WBLmLQj/kMRCi2gymyIkQqbvdK64Rwh
	 ++A5qrod+z41+yOgK8wIxPe3CVtS8ylaXiCOeCtUgZa/uClnKdR+yaC9CWeUBWUUf1
	 Dg76kn+CuZMf7is+timz6z4mS2qssK4ZBh6FChLI5O0UWQOhawnH764xi5yxo1wN5W
	 pNmgdqN9DmA+mPztlHkunxwQa6CaQZSaga6y688Vd8mbqEXkz+ycuTZTpSgo4SgrPC
	 HcgpP1O8+/kmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 692C0D95057;
	Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
Subject: Re: [GIT PULL 3/4] ARM: SoC code updates for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <1ba0456e-879b-4435-808d-54dd91b9506c@app.fastmail.com>
References: <89d0bb77-a608-4ae0-b9d9-e17fdf5f12da@app.fastmail.com> <1ba0456e-879b-4435-808d-54dd91b9506c@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1ba0456e-879b-4435-808d-54dd91b9506c@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.9
X-PR-Tracked-Commit-Id: 98dcb872779f8bea30cd34716c7fdeb0963e3606
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a60816720d754883978c8548308c92f24ced86dd
Message-Id: <171026760942.25732.4150799776655353192.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 18:20:09 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 17:46:31 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a60816720d754883978c8548308c92f24ced86dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

