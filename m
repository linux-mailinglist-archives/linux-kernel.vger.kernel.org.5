Return-Path: <linux-kernel+bounces-50713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF617847D29
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D05B27609
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE39512C81A;
	Fri,  2 Feb 2024 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGpBwyDD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1112C812
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917055; cv=none; b=jK2opMAqGgg8Gx5hpTpMXnaWmJyXdAIYKGiWMm+stZ+AXnr8+zrWlOzkRN02rW1jZoyO40FHI8B6V/+ALrXOaJcQc6BGMBOSfW7JfMUnAEb7C8tXo2kKETebcF/Mwv4ZGBUr5hWHwhwz7dq6IIWm5M3YInXzi3VZk9jEkDRaaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917055; c=relaxed/simple;
	bh=0xM83qA5gSBmYQJJ51KBdnNu1e4DUh1raPgYy7TTdns=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qikKMGVOv2wVVy6EJOlViSA8t9Eg8TSadHUnjrEyoPsYqywW1OS3lPhzZOOIctN60RrZj1O1lm5fGcUWFSK9SoHrktQ8iLIt/QkCnp/aLeOzqR0G96cNb5Ki11KIUiTf5pQiRPj4x1i3qUychNT6SOaUPdRSTgm1KCbWRIzX+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGpBwyDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD424C433F1;
	Fri,  2 Feb 2024 23:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706917054;
	bh=0xM83qA5gSBmYQJJ51KBdnNu1e4DUh1raPgYy7TTdns=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qGpBwyDDITlY181dvWIC+Z97wTOx5D+ZDUPHxSPAm9bP1Rby5zF5bD0hdwwrlZbzh
	 rkvEoBi0D70LTR5oPXMH9lWnKQG3MGtxugOWfPtNrXsDbLT1TAb71FIcISRfkSLEaI
	 JFJup6cam+jQgrqYhExk6zKZWgdBlT4L0xq1y+s7dMvPFd4gmnagk7JyoXU71TnUDh
	 ZN/0olvprbmV4RsKVcmYRi1xOCeMFvP+c9F2XV5tfi0rruUvl/L07jhiFCWWxubW14
	 0aV71uvFaYr3IWMnHfQqhbyNZ/5QJNYUZbNMf5+pqXmnR899iNE+CkS3+WnRyRoRbu
	 dtxWk46uHXcFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9DAFC04E27;
	Fri,  2 Feb 2024 23:37:34 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/eventfs: Fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240202170446.005f8b01@gandalf.local.home>
References: <20240202170446.005f8b01@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240202170446.005f8b01@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8-rc2
X-PR-Tracked-Commit-Id: ca185770db914869ff9fe773bac5e0e5e4165b83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56897d51886fa7e9f034ff26128eb09f1b811594
Message-Id: <170691705468.22657.6567895122445146376.pr-tracker-bot@kernel.org>
Date: Fri, 02 Feb 2024 23:37:34 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Bristot de Oliveira <bristot@kernel.org>, Vincent Donnefort <vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Feb 2024 17:04:46 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56897d51886fa7e9f034ff26128eb09f1b811594

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

