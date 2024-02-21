Return-Path: <linux-kernel+bounces-75255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC0F85E547
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C45284E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618785C79;
	Wed, 21 Feb 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfXdMhEb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9C8526A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539031; cv=none; b=Vt5cfxMCRAapJ7yM07S/mZR/+iiRSAZ2UGrc4mL615WrlZjxWmKK6pxzm+OkSzxDUptjgs3Zdf6AeiayYWduw4QE8RaiTD+vPbRyUtH6aGBs2KflPkQW7XJ/gUBQdaZ6hnaIfsvd/vZGF2RlBChQpeKkJK4rWcsT08NIw3N4XYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539031; c=relaxed/simple;
	bh=P68oB+HZpF2+QQkiji48wICkD3gj4McmB7ESLj4w458=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bbbz2TnHRZlPv4WmV5tQuGzZE9StqakVIFk2QoR84VBiWVGok6RmeH8GVDwzUB0O1w4c+FChbKc9VwLy0kc90VxjqgtQ7c0/m8g/V9oKlKtD+bvtDIAQGm4IBeEnmysILjdoh8/QX/4OaESURyrk7/y99L1evcuPNhw2rqmGl/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfXdMhEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4316FC41679;
	Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539031;
	bh=P68oB+HZpF2+QQkiji48wICkD3gj4McmB7ESLj4w458=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EfXdMhEbsrCeqZdq0pwQal+qtvAQpOnV1xu4HoyGYlDRZqNGhUpNt0xmsImXMeqOB
	 xFQOrtopfYqLTGBtyqoDCs2X/Xf+JruncleDwxcj/iInSqkEhwcx6jSgcJU/UzsdMS
	 /ZBXSbRiEC0ntbmxgedk1oX35Fifo4WGj+mD7pYduMLvO52NG8kIGKUMxSWYEd2jfJ
	 DxxVklx/+qTWLWpeZdmo5BQhOEoqB2qi5FXwMQdE0hF/lm9xYwT/giql8rQfeR8/PO
	 LPHw5wH2dN6hN8DDF8N/GppNz5x2712brueoiAq2RJhq0wZoGcrXNQlv+H01+2yBsf
	 EJBU6/qy3sIVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27C4ED84BB9;
	Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix to check zstd compress level
 correctly in mount option
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170853903115.7043.15916338851504288763.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 18:10:31 +0000
References: <20240212160818.1020903-1-chao@kernel.org>
In-Reply-To: <20240212160818.1020903-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 13 Feb 2024 00:08:18 +0800 you wrote:
> f2fs only support to config zstd compress level w/ a positive number due
> to layout design, but since commit e0c1b49f5b67 ("lib: zstd: Upgrade to
> latest upstream zstd version 1.4.10"), zstd supports negative compress
> level, so that zstd_min_clevel() may return a negative number, then w/
> below mount option, .compress_level can be configed w/ a negative number,
> which is not allowed to f2fs, let's add check condition to avoid it.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: compress: fix to check zstd compress level correctly in mount option
    https://git.kernel.org/jaegeuk/f2fs/c/ff059dcdda57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



