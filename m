Return-Path: <linux-kernel+bounces-67608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 860FD856E05
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9771F26A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF9813AA24;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMU5Hx63"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25C513A885
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026607; cv=none; b=IS5wlIcIICw7RKyG2gocebhX3TuBBy2whyDmkDqqV4diIO6AbWznERCpvG5+UcIxTHtdoZGuiPm7MUVwpATln77jcMdvjJcIia7O4JudbfftdvYNieGDVSsUEsBJwdGpdB3AI/f3BrV41pkUrLo3wCRkz0mLwlt+yhG7jAslbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026607; c=relaxed/simple;
	bh=uHf3Ab3mHEfwuNjj6FgRIROvlIxsiOrSGWHDF0D8yEg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pwbXQXOuUMUXTOkeQw20MuEUn/kpoH0T3NP6j//rTl1FAralMtgncLQrp5sn1ZRrhtZ1hDRmJTpWn6m5O7X+fv+Jg5yJxheHPprgGM59kEh6wb6A5T2lQwLqhctfKPzlDmfgPQIMHgS6UYhXlwdojjoO6lheePMp5dPltoIEqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMU5Hx63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAAAEC433C7;
	Thu, 15 Feb 2024 19:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708026606;
	bh=uHf3Ab3mHEfwuNjj6FgRIROvlIxsiOrSGWHDF0D8yEg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QMU5Hx63dyyRqyq5rhEi5aQDnUNG0/Ga03QjYWk67C2J40YQudIATk0I7yo+opciq
	 xKuPr/L/uHhEuspxC0ib3/b0fQ78mjzT0hnI+lRGdPEtsIJjR0u5wYRWNmpjYrQGE8
	 l0EoxNrOEaKgVL/TdAd1ocXRLVAgZ6KvCh6GMjH4rYEwvoD8QN5IJlzz3d0aIj5Bjo
	 R9YUnczT8TyU0+f8rU2FYi4n+cPP16eVRE4enbttbgeuga9OMmP3t0J1qbVWL2STXj
	 uyjXUGwa7YuLMs97B0sAnCdQf07vz4R8HUW/csV080wzuvumPXhsoTMY4PQkQuX0P5
	 P7dH/tcO6toAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9641BDCB6EC;
	Thu, 15 Feb 2024 19:50:06 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2402151330460.21798@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2402151330460.21798@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2402151330460.21798@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024021501
X-PR-Tracked-Commit-Id: ab41a31dd5e2681803642b6d08590b61867840ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9207fe7572f92b564c84f23e895213e6eaf98c01
Message-Id: <170802660657.17476.31248757132308491.pr-tracker-bot@kernel.org>
Date: Thu, 15 Feb 2024 19:50:06 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Feb 2024 13:38:10 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024021501

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9207fe7572f92b564c84f23e895213e6eaf98c01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

