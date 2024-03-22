Return-Path: <linux-kernel+bounces-110888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB45886540
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05C51F24944
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7A3BA3F;
	Fri, 22 Mar 2024 02:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlKCjA6N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7818B666
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711075313; cv=none; b=pAHhV7j4eaPfiQa6dWO/2LZRssWLM4+zqrezhS6VjVTrDQ5gMAglxFAW0VM2x//CurMBdVz0YUZrxD4hSHK9LpCuj0VGxExew59jBIHxP7ToVxxHBgsvweEAvEtXi+cBRUUGKISaG/NTa77HRCk7ot8tgMDMS+Q/mmFKIqROGhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711075313; c=relaxed/simple;
	bh=fXO2SgdhlURZb/EYs9Mpm72mFyCGNJlDezX1lbUrMsI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aKX354BwanAJQIipf2jvqEh0axfnlI9zt3yow4b8m+2RA2y5UcAljE83UGul/RVY1qKDYwtF9L425ZPF7ZSnpd4EttLQgfKwUA28AOr0M1Qb/V9dc4NVdGp4zslhOupOl/ftA6YO+xQfHh0CqV2taSorMLWMzUc6BQoWGrMDuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlKCjA6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9FDEC433C7;
	Fri, 22 Mar 2024 02:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711075313;
	bh=fXO2SgdhlURZb/EYs9Mpm72mFyCGNJlDezX1lbUrMsI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AlKCjA6NaWF8sZxVqRg2QlJchyZzx9/8sfelfjUWNKJ9EuP+0iYinBBY4KAsz55gP
	 iiseMl3RS86uB9NKzf4FqHuqGtBETwbet8mKRk6CWobWHJmKVKuA9EEiyleK0frVSy
	 BjkfqB25eOHOOIYWEiybPJlfsU96bQc5y7Q9YS0vk6Q4dh0k/Nsu6B6NnWt+q1g+ul
	 UTh4ctSZpVHG7fJFexOnHZbBOKM0IPuzGc37rA6fCZnb2L/+6l1/iBY7PhAO0WGMgN
	 374tlg5/vJ0Vy0Fmq4OxSDgCZYwX8mt8jmklpU0JwMEb+EfPDsCvUL09TeFfa9IjlB
	 Xchcf+gaTpSlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A17F0D95060;
	Fri, 22 Mar 2024 02:41:53 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzRFvT=3VK85c4Bgwd15Wcj3PaCLMXvPr3ynzHAFsvqJw@mail.gmail.com>
References: <CAPM=9tzRFvT=3VK85c4Bgwd15Wcj3PaCLMXvPr3ynzHAFsvqJw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzRFvT=3VK85c4Bgwd15Wcj3PaCLMXvPr3ynzHAFsvqJw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-03-22
X-PR-Tracked-Commit-Id: cafd86cbdc607eadc28a008cddacd78f0894c628
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ee04901215b3cab8fa35aa5bf4692d7aa312e36
Message-Id: <171107531365.27086.71817879676337456.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2024 02:41:53 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Mar 2024 11:34:13 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ee04901215b3cab8fa35aa5bf4692d7aa312e36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

