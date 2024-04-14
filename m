Return-Path: <linux-kernel+bounces-144234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21B78A4371
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966FD1F21394
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E61369B0;
	Sun, 14 Apr 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+2UEr+/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C354D134CD0
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=pjeEfd53tye1QIyKCgNiGVP5mFrvDd11N9W/xS3vs6NP4EZvZAG86CXSPrAwofNf4PkozXJWpQRc3b7z0Grv/jQIh7rJlESJP1s33HCQqx6gofoOpoAgJEe5kUuWrGXgIGw2KqKLFqNmXth0dd4MfRFD8XFQe2e4H81WU9rfmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=3L4+fDkzDFHAZ+szBJYMTSWnDcyTz76RO9nlceD/Qaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d+e8IHQec/K4EL6h2TIXKfbB1GSH4eZiPzOEyeu3KKsvVIu2mkcjCLmcWCOIdt9aOJQN3J5UlwQPKXloJzIjP4Mb6IeVVbnBNK5XbMaCq3VaI9GPZk9hqhiaylkiiiV2v1Z/ByV79M+uEgZuK6E37pkgF9oVoWA9FtVZQDcKnHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+2UEr+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5294AC4AF0C;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=3L4+fDkzDFHAZ+szBJYMTSWnDcyTz76RO9nlceD/Qaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T+2UEr+/0bY28FJoGI0rIhcARvlnL+B/v1b3OYpgWWURjntitMAYAmQxPvvHLqqVy
	 sRvU8UzI/6+4EVOShVOojOkNiwN8EF1Z6ddzCDoNd55Ay4yBGROfaDdEnFZlCAGX6o
	 Kua3RFCm2kUf2rRQUaxbU7gQOQfoqKatb0bwpCmc/J/V4Im0DWvTEA8JAhHJcea3JZ
	 DNV032C0FyYWOlw8DuUyBXjgQSusSUgUlgZZrXyhOo7hb/CqzmHThp/EIJb2CzNwZ/
	 SLhV9nshkeVyvrScyklNlSHY6aDRK77yPrgkKl2sdYcz0gAUQj/RRJaHDGwF/vj8Rv
	 lioZavcJeypBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32D64C54BD1;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: compress: fix to relocate check
 condition in f2fs_{release, reserve}_compress_blocks()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171310876520.3156.2825403590213821856.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240407072604.3488169-1-chao@kernel.org>
In-Reply-To: <20240407072604.3488169-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, zhiguo.niu@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun,  7 Apr 2024 15:26:03 +0800 you wrote:
> Compress flag should be checked after inode lock held to avoid
> racing w/ f2fs_setflags_common(), fix it.
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Closes: https://lore.kernel.org/linux-f2fs-devel/CAHJ8P3LdZXLc2rqeYjvymgYHr2+YLuJ0sLG9DdsJZmwO7deuhw@mail.gmail.com
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: compress: fix to relocate check condition in f2fs_{release, reserve}_compress_blocks()
    https://git.kernel.org/jaegeuk/f2fs/c/7c5dffb3d90c
  - [f2fs-dev,2/2] f2fs: compress: fix to relocate check condition in f2fs_ioc_{, de}compress_file()
    https://git.kernel.org/jaegeuk/f2fs/c/bd9ae4ae9e58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



