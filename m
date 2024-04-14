Return-Path: <linux-kernel+bounces-144235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D00F8A4372
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E501F2140F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8841369B1;
	Sun, 14 Apr 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToyjMp5q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3624134CDB
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=tXag8gIKiLIbIlk3Bj4TEaKjxCIbAnbkO0ZMSS/N669Ad0Rks26JK7QCg7hj3Uh5P1h3d+XCCPF6aUzrW1alH+B8Ziojgtj1J4kzBx2YGd6LFS6riYux0OnUQe72VSYxmQ57gQgzEuweaBk3UFQW4jIx6xNMw6f3/qwCtDN2aB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=HffsvLIWPYupnLLRGUro6qCAd4PWhu6U8ocjNHJuxnw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TytJu6lUaE9VNABUuLXQnDc51iW71t16mmz+4g+kvBMKG3yJXiuEcMkZ9IitDl7+GZdNb1SSWClwVSfwQ8NdAtlzSirhKQ/1NGyP0Y5Myk9QAraJYhmfEOBD+Gx2InICIjCSVvNB+Il4kalNiF9GcYc+g75IFN4NbKntN25adK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToyjMp5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EA1CC4AF12;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=HffsvLIWPYupnLLRGUro6qCAd4PWhu6U8ocjNHJuxnw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ToyjMp5qtRzUYH2jifdqiBNs0QatLgrah3+j45X7lCpCXWN8nwwC029iGcyrWkmpA
	 IzjZ/bki934NFywDG74xj3uJG4u4LppiNiObZd+/GiwlF8X9oh4Tgb28yz3BdNVNe8
	 PK1jryT+J5BxIwQDiwPYAMh4z3NpWa3nq0qlFiBQtKwH5qhXrjPUudDv91eh0SsI0e
	 u8wRcwN1HQeLX9MQY7YrvS0rT05Ogg2m1N4bf9ZMJpGWQC9EqeR9WLxaM9MW0La7y7
	 CCgp2HUMHafp95CkDNBFptpOYP4OT68BtAQktm27ikHj09bzutd27nkppDqS1UMXhr
	 MHE57pffFpD+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F653DF7857;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: write missing last sum blk of file pinning
 section
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171310876532.3156.10776428756258877374.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240409233411.1197830-1-daeho43@gmail.com>
In-Reply-To: <20240409233411.1197830-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  9 Apr 2024 16:34:11 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> While do not allocating a new section in advance for file pinning area, I
> missed that we should write the sum block for the last segment of a file
> pinning section.
> 
> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: write missing last sum blk of file pinning section
    https://git.kernel.org/jaegeuk/f2fs/c/b084403cfc32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



