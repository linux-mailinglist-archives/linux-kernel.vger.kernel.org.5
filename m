Return-Path: <linux-kernel+bounces-59830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0EB84FC3D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0CD1C2168B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E47FBBC;
	Fri,  9 Feb 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT8WlMVX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650E84A27;
	Fri,  9 Feb 2024 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504383; cv=none; b=s2WviY8/zySbgAtlb1cvJ4bBYIdqJa2p8zwq6+FAf1KE+txoyyhN3BOPBdWmOJEG2HddBXsoPT8I1uVL7WMqAn+7JS2SIrIB7iyJIV3xDALZC/5rM2fFZnNFRrF/zNyiUT8Yy4oA0Vw0mWSwyOkOrCTwfyaFFxagp/FXy8SAFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504383; c=relaxed/simple;
	bh=wRgjzBfywx9qvPxiNdlgxQ8FPrnTeFUAP3ziQu6coWY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bm4OXTJg6ysgGhzV+YOeb4UTbEDIBu+04p/sAY9TZPuJwGD3JiO7j1JBdhAafOCOuVu0xAsMbFlnrwhzYTuiq4oElpRPz9QjbFAiknDgs6QafuMNiM3aHELUPMMgph5qGIOsVbKE0tOta+6e5if0xQ/KlJ4YuXvjYqzRqP5kqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT8WlMVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF64AC433B1;
	Fri,  9 Feb 2024 18:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707504382;
	bh=wRgjzBfywx9qvPxiNdlgxQ8FPrnTeFUAP3ziQu6coWY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cT8WlMVXivbsyYb/F+pC0rnGm/mpNQIoOsqnmQ8FMoyTbuqDpw6DbxYW48RaFw/2e
	 ix3xyFeSGVDTWnb+oGJmiaVOESQDApJ+0TR3984py6B5lHS8NzivhoCvOPXZJOkEM2
	 Cke4CL78c//cbPBvD7ssE66SQvi7tp3/2SUK9+XLZTsMVF7SHAu1YcUXm+pLvVRcsM
	 lfSbS+KB5aaBF5guse/3pheDUjhFhWBrPiKc+sHljP7V64a/FyUuQzqZ9IXqIteNw0
	 2x+GdGzEx3eEQMDEKTOLrL93c1Lr5mX21puwPT/RHM517FSUqiMBscB3lFxRKK+tFL
	 bgoxqvLMqXuYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB5D7E2F2FC;
	Fri,  9 Feb 2024 18:46:22 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240209123117.25215-1-brgl@bgdev.pl>
References: <20240209123117.25215-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240209123117.25215-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.8-rc4
X-PR-Tracked-Commit-Id: 2526dffc6d65cffa32b88556bd68e4e72e889a55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a8e4b3c2741a46c7c03c1726a124a750ba06905
Message-Id: <170750438269.872.15150127355951360813.pr-tracker-bot@kernel.org>
Date: Fri, 09 Feb 2024 18:46:22 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  9 Feb 2024 13:31:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a8e4b3c2741a46c7c03c1726a124a750ba06905

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

