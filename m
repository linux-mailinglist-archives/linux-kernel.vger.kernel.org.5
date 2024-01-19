Return-Path: <linux-kernel+bounces-30681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B8D8322F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90352B230B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0A723CE;
	Fri, 19 Jan 2024 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqafsaTI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401A15A4;
	Fri, 19 Jan 2024 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705627491; cv=none; b=NU2bekfVyD/VX6Nm/+N6/iY5bK8tfNITWi9aXB0w7oP6MdxR7yLlBgRbCTkO3hwZh8hSgpJefmM1ClZq2BUDf4aMgTMhMc7OxqTwQrJ30OQK4tc2lLwXSMZaMmvIBNjsGNNxIkDBp5cPa7dFBu1sTHgj4Lmf04Q9SD+UOq88+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705627491; c=relaxed/simple;
	bh=g6dZ/s8iRvFCBO9yFMXzjTMisIdd69xDaF1WTbDKnTA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Tt1r6+kcxLw8VYM0GncelM/Wo+gGDJhEx/ZkikWCJYRviEufQ0FG08nZeoDeQHLpPJ4KWjVTFdIRfXYEWwwBs28FRzPxj/OlJTzMDqFIMPOatbovtxsoyz0DO6envjV9XLD1TBQ71LFuJNMixNMg9MboJYxJDdfd5a6DiU/cEM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqafsaTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B704C433A6;
	Fri, 19 Jan 2024 01:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705627491;
	bh=g6dZ/s8iRvFCBO9yFMXzjTMisIdd69xDaF1WTbDKnTA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rqafsaTIANKHeOaF/RcTQWF2JB7WfF9Jz+qCj3wl1buRq1JYCtnmzqQOVx06hv1cq
	 87vobXjNxnFTPwiqozC4eBUGz1i+Vdm1YqjdA9j19Br+PkVWe06XKKuwmj5AC/9QAY
	 99W71GxximV/dj5iNMTY75Dl9igCugn8RXkFsMHVy+ToErqG77DMwoks5npx050scI
	 WZOgCSkePYG7oz3/LkQH9Y/sF90f10GsaNm6JrXIaEEGBi5iQk83iQ2uIAobSB8itc
	 A+xIsY5tuEA8gVUlcX/ZU3GTka+GyemAjbiiCHR2nq6qKNQDQ7T46XIk4fLuTYvU3w
	 yA12OJZJDBzMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CCB9D8C970;
	Fri, 19 Jan 2024 01:24:51 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.8-rc0
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zalq8fauylyDfoXf@google.com>
References: <Zalq8fauylyDfoXf@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zalq8fauylyDfoXf@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.8-rc0
X-PR-Tracked-Commit-Id: 58f65f9db7e0de366a5a115c2e2c0703858bba69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f289bdd4102fc870c8b97652c57d41952040d70
Message-Id: <170562749144.26879.11236730756200970428.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 01:24:51 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 10:16:17 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.8-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f289bdd4102fc870c8b97652c57d41952040d70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

