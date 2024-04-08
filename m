Return-Path: <linux-kernel+bounces-136009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A48E89CEDF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFDE1F24C33
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F07B146A74;
	Mon,  8 Apr 2024 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbuGWRzr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530142C853
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618376; cv=none; b=oA8F7ITZEwTPCPYxiQVzgW26mI4hmVuvohpLhOATlfvw9wEb5X2BVJ57L6/cN1Wm1Mwbf+9bKRfHbxgBjZCYc2rfZ6asnoHqIB46tBEO+7JyobidrGfUIKINkN/z7Y8LiOWXAFAl2Cf7j5YmVnzbLj63amCOZRDwATrNHG+QEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618376; c=relaxed/simple;
	bh=vm6u9GrdNbMw5gXQBRWwbuIGy313zAOWvskPr01w7O8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NmxSYVc07QtRxHKOCfiQE9TTcRFSKNj/kPjY8mTpsMYjccvIv4lxw0Pp/P7uUQiUxTJJ7gfAJVgfaTW/qd0W2SKm957YctHMbbqudau3eOIT1aAAo/MnHFziuXogrrtRNUS+DizbKQ5L2pVxFCKnC2YMTTrhMWClbEXa+0FcU7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbuGWRzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28F0EC433F1;
	Mon,  8 Apr 2024 23:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712618376;
	bh=vm6u9GrdNbMw5gXQBRWwbuIGy313zAOWvskPr01w7O8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BbuGWRzrhC4wQaDBhQtpZ8hS/oY0qo7/u6yIgdu+1zn21k24XhxhTsQOcqfEyP7x2
	 OuyrOpQUQmQk/8QY4zJFRvfPmqXMABx0HH8IzFZHli1Cj7Z3Q3TRTpkKHNrRawHZ3c
	 UgjwpnNa26PBrF2ak1xvt7otaqeZ0OhTwUIHt08lHTIehEBWkUGLqh4huBOAPGFECX
	 dVnW2URCGCBPQ5KnQrKPJfOucSXjTLYjSwjUE3S+UePXloimTboBB9tzlqlRgpC6/I
	 76EBfOAFN9amUQtqxdDp24MvvD7Y4tSjq16LEGjIFI9qm9VccBWaJTWbWdf21y+/C+
	 iFV1Jdx+ksAhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EC64C54BD4;
	Mon,  8 Apr 2024 23:19:36 +0000 (UTC)
Subject: Re: [GIT PULL]: memblock tests: fix build errors
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhOCPl22BRClRPO3@kernel.org>
References: <ZhOCPl22BRClRPO3@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <ZhOCPl22BRClRPO3@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2024-04-08
X-PR-Tracked-Commit-Id: 592447f6cb3c20d606d6c5d8e6af68e99707b786
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f0a8fe3215c432234baed20eb8210efe1c32b10
Message-Id: <171261837611.1997.7128901775174934356.pr-tracker-bot@kernel.org>
Date: Mon, 08 Apr 2024 23:19:36 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Apr 2024 08:35:58 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2024-04-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f0a8fe3215c432234baed20eb8210efe1c32b10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

