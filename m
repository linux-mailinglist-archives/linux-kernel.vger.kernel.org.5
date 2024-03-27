Return-Path: <linux-kernel+bounces-121664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2CB88EC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCE21F2D033
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E8814D6F1;
	Wed, 27 Mar 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7bi6ts/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC241DFFB;
	Wed, 27 Mar 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559151; cv=none; b=NXT7ziokIIXcaPl+95WG++aM33WJ0tp6twOoPZQMr1XG9Pbb5AMi+EfixzEgOuTt+KnY5+HDapCFUKJ1zYiHYXg/Ha/Uld+c/3nLUXAP8a1P5V+CqozK+eBIQU+AztUgAfrnXev0yr+9qkXW4WFf/eiO+1jLfA9fQjrHDcmSMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559151; c=relaxed/simple;
	bh=WXf82O0sES9oPoOJyA/fZUpvP5TUDXvRNOgtA3CYGt0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W531qllydY1TaHUgtv09bepAQ07WrGC/9hZfL3ZUdUYS5EIDQlEftMBH5W6SUvIrg2Onjq5FBW/C+eSrwVYjTbzhMyR0U9t64llMSTsT2643okqwJSwpHAqi/u1uv9lb0rcWNrQAaevz8Q1FWzUphOKt4PCUcIcIGhT6cRlSnjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7bi6ts/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3661C433F1;
	Wed, 27 Mar 2024 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559151;
	bh=WXf82O0sES9oPoOJyA/fZUpvP5TUDXvRNOgtA3CYGt0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B7bi6ts/HS84u49z8sPu4+UhYE3qwLU5zpvrkXt8Mr8yf9P+j811AhOkR+rjsOGbd
	 ROzzUMHjAHYWH+nkyidVdIv60iYUCdhtfeQ40E/4z0sxc1g0y5ZW4C8H5J46B1tfcS
	 5SWZnyD92GgMX+yUSEpelH8/yAzm9EsPRz7Aa2NT4BWXj0qwf9WjNA1WBVHcWBN2Wd
	 Q+4VdxT7CPgfX4jEWvQQWjfKeuYl0Vh1EV6dPzX0Rrn7uOvu94fh4Wf+353hvj5/qV
	 pFeK19CJOMwsL3unL4T0iZHlyyWqT0nmh24BwPLNUYxnJuVH9j20IaJk+zsXjEcoZk
	 MWfX6jue2T3HA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA854D2D0EB;
	Wed, 27 Mar 2024 17:05:50 +0000 (UTC)
Subject: Re: [GIT PULL] execve fixes for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <202403261544.E7B2404@keescook>
References: <202403261544.E7B2404@keescook>
X-PR-Tracked-List-Id: <linux-hardening.vger.kernel.org>
X-PR-Tracked-Message-Id: <202403261544.E7B2404@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.9-rc2
X-PR-Tracked-Commit-Id: 5248f4097308c1cdcf163314a6ea3c8c88c98cd9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4a432914af728be2c149934295f337351aa774c
Message-Id: <171155915095.9372.2833118791775948007.pr-tracker-bot@kernel.org>
Date: Wed, 27 Mar 2024 17:05:50 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 26 Mar 2024 15:44:18 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4a432914af728be2c149934295f337351aa774c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

