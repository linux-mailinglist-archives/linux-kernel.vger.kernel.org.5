Return-Path: <linux-kernel+bounces-69040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CFF8583A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C011F24FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28836134CFC;
	Fri, 16 Feb 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unIITWEf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7C134758;
	Fri, 16 Feb 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103470; cv=none; b=twgjYDyYa6lukNCIG2oPcomshNQ5vpd1+4FnrEj+a3C+ArywTHj1ONy3WfwZl5BYNTYSh7ANkT8+9iMyoXeIACNGf+/geIa1AyM4EWWZElS2yrZV7VoJsy+3jt1J1k+V5w40QPUm4MrpCnfY+88UHzlhPO7ckZyv47DRcnWOU0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103470; c=relaxed/simple;
	bh=93vGL+4dxgbN8UwCtpMCNdpZZ/IFZRKMNaHf6EJaXkY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UEVemtmrXI5kyv4s48nY04XRQsE27deW0dCgh4SnlBZsouepJObdJ/T/Gxr+MgT1WPRB5XMEuxUk3Vb7m/kr09WKwzo6gAiniGsol28fYMEmc/gPePAmtVgpYZ+0j3jpSY1HH+ftaDkvaQL4FyL5fTvpx0SKDV53l031IUaw8ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unIITWEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3039CC433C7;
	Fri, 16 Feb 2024 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708103470;
	bh=93vGL+4dxgbN8UwCtpMCNdpZZ/IFZRKMNaHf6EJaXkY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=unIITWEfmZNpqNE67CGuV0kIDW2mIPr2jPMG8j6hc4nFfaGQZHaKQVDIUlPlxNtwv
	 OprC6n0are2bcJBt7AqoANbYxXurxbAd+7C4k/8gp5uC4zH3EqPzZOju7kHv1c7RpX
	 nooldNDz9iEMy4qF1trZ2J9NP/93JcDowL8AOlKQCCwenxeuxsnNkH3obwL/YVuT4v
	 WksurQIuHpwOvgnfcRqKCtncegp13wyh4CECmh7CLQZZTWoRs5O1lYdlYOhFZRW9dy
	 U3fW+xKRmWb9H4RUFzNSsbVelCCVzF+zS8dbKy/uaciYwb6xCvFNArOO3dhK6s/3PV
	 emFYwgabxWGhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CF68D8C966;
	Fri, 16 Feb 2024 17:11:10 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20240215
From: pr-tracker-bot@kernel.org
In-Reply-To: <6fcbf9b8e83e76678a0f520bfbbd6bcf@paul-moore.com>
References: <6fcbf9b8e83e76678a0f520bfbbd6bcf@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6fcbf9b8e83e76678a0f520bfbbd6bcf@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240215
X-PR-Tracked-Commit-Id: d8bdd795d383a23e38ac48a40d3d223caf47b290
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8ef920168141b09927ca840b767fda0f227080a
Message-Id: <170810347011.29072.14832226644961221930.pr-tracker-bot@kernel.org>
Date: Fri, 16 Feb 2024 17:11:10 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Feb 2024 17:19:40 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240215

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8ef920168141b09927ca840b767fda0f227080a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

