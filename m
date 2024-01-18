Return-Path: <linux-kernel+bounces-30473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B65831F20
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A308E1F26005
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7694A2D7A6;
	Thu, 18 Jan 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiLU8W/h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DEB1C281
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602928; cv=none; b=h47pG7DhgMCs+vxkFXypx9/Gd8WAtRUYVRiUEaAN5AAz/QojH64h/hoJ146ASetdgi2sKuBqW3J1kTUX2eOHgKm6olBmqIjzmkg8wM6Yb6AKbcrOMtaU50i/sOKOELqeUalRkA2OtTWBIdGa2ukhbgweNsSfKFO3mGNRgmuiNwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602928; c=relaxed/simple;
	bh=WRLBet5PTDcQ0rQEClLNwnyBg7vXQ4GHqZyfaZTozIk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PSS/fTpBvhxu9FDufo6XMFyOJVn0EFYK04YQ1Fwfe9oejjXNlX07jSNfe+d9TLshnd/XdKvM1wFWx6pOhlXqhrB2RBlwCRpGDJsFrGT6Yp6Y6xkicIB6pjYbRoj2AscU+o/U94HpK3Err4nmwPt2lJ0p990IWZghbiBweNhmQ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiLU8W/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90BBAC433C7;
	Thu, 18 Jan 2024 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705602928;
	bh=WRLBet5PTDcQ0rQEClLNwnyBg7vXQ4GHqZyfaZTozIk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NiLU8W/h8kHfLV5hTMpFSBqN0Zp6SlilX2QvQZN0pd4MGAaVnv6c6lV059hvfGZSm
	 bOgYnmNZnyCp4FaAkMVmwYfRIcDcSRKYUUzt6EGHClUWMmHZnH2zqAqebCdp1TH+mF
	 BS4X0nZ7lhaT67C9SrHAroEI3xLiUHb8oSX+SiAqhsN6t01e4gDdGkfN9legDpk5po
	 7I3TL+Xs29kdabfXYuRwbEkWMcDKZ9pOOyhzRe9ERVTuNvPS4VjDMmVHqUE4sqTI9x
	 paDp5hL3QDemGqkf/ipiYeglAZeEykcm3PiZepOx56ForG5m8rE+aCZw91N+a7jB4Z
	 p1SZNqtxCf4BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8113DD8C970;
	Thu, 18 Jan 2024 18:35:28 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zae2LeqyFdjqb8mV@kroah.com>
References: <Zae2LeqyFdjqb8mV@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zae2LeqyFdjqb8mV@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.8-rc1
X-PR-Tracked-Commit-Id: e3977e0609a07d86406029fceea0fd40d7849368
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80955ae955d15ea5c11d55cd50032a5243a6dfd6
Message-Id: <170560292851.27544.6072989356911558853.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 18:35:28 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Saravana Kannan <saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jan 2024 12:12:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80955ae955d15ea5c11d55cd50032a5243a6dfd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

