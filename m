Return-Path: <linux-kernel+bounces-93010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3E1872961
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3C41C222C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F1D12CDA8;
	Tue,  5 Mar 2024 21:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOHcIWla"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236212C544;
	Tue,  5 Mar 2024 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673922; cv=none; b=RCOg/5cEYfq1Aa45j19W9iPHBjQibL+MBv+tqgZex+FGTXDTRX2dtrqSQjbRjIY/ElcMOi166/AUGq3xoCi700RwsqBt2mjVwJg7Z1FN8t9wEUSMOrn5gcXK9MhWUBzKjfWNOgLoa+QvM7J3KHcJzlJlVHRZ2lT9ndfbBSpY5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673922; c=relaxed/simple;
	bh=3vwozV/+i7qcqZpX/YulQ76i5WnakIpT+ErSVyFTRsE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oFxWJpgofV8evoLGsnBYoKw4PRRfmCpbcUKpmhBeGLBkQ2nlmYXDU8on+jMNJdK1KKIhKaoEwD7+Yci/gnnvqL2uKwM08m6+qeDXLwsJr6uAurdspd2sLVyzdZWFcsxNubvKB1nSu6VeM1ZN0qa32zxjJ5w6vY6LrU45MeNZgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOHcIWla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5785C43394;
	Tue,  5 Mar 2024 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709673921;
	bh=3vwozV/+i7qcqZpX/YulQ76i5WnakIpT+ErSVyFTRsE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WOHcIWlaqNWowMUbgJjpSvmOclp1IX5W27X2N1RsQ0/XOQF6JrLNdZo4odGV/G3rK
	 ldFl6YveF5xJ5r8epCk3lgAl2UHuK0aQTAt5l1h7XmVNhNrsfSnsMNlIyBravdJZU4
	 F7Fmj6aQFsQ4Xg7NMYI/xw0YjKLkAm7RG5u8jgr6V2U73+alin7u3zMlh4iZKTCh7l
	 8kr1hGpMsM5DoVF6SCMTI2QfYC+SmWWCZabtb9eDStHZDB/e5UuZrgMoapvuv6DQhL
	 rQqOosN9xRdNJxxhzbHuzyv31aZEU36utbk1R5qZc5conLo7MjDhXWlNKo39H6dZx4
	 BVNMC7Of3DAww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF114D9A4BB;
	Tue,  5 Mar 2024 21:25:21 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.8-4
From: pr-tracker-bot@kernel.org
In-Reply-To: <cfc29d60-e11c-4d7f-9d9d-637ebde8f5fd@redhat.com>
References: <cfc29d60-e11c-4d7f-9d9d-637ebde8f5fd@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <cfc29d60-e11c-4d7f-9d9d-637ebde8f5fd@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.8-4
X-PR-Tracked-Commit-Id: 0314cebb29be2f961abb37bd0b01cb16899868f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 127ec4c0b2ac4821e8de17b9a3d0c0af883770d2
Message-Id: <170967392170.2988.925045113673928951.pr-tracker-bot@kernel.org>
Date: Tue, 05 Mar 2024 21:25:21 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 5 Mar 2024 10:36:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.8-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/127ec4c0b2ac4821e8de17b9a3d0c0af883770d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

