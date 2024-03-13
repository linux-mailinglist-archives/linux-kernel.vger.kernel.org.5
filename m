Return-Path: <linux-kernel+bounces-101020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2ED87A0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9BC2813E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D63C10958;
	Wed, 13 Mar 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2Bga/YR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5EC147
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293430; cv=none; b=oqAShtHusnT0HRqdGyC9JtF3oh1e4epbc+CWMO5toqJOpo9w4Kli+hGccvrvHDu9RAJI4D3N9n7+2pzu8wF7s/sntIYxkMmQ27oGo6Ujompkqxmpc9PWn/SmqvBV0EuX8wZ6rZnrBsPcQxSOiQKj0kDo6I3FcuMUQCeps6kjpsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293430; c=relaxed/simple;
	bh=7nZy9/vurPXr1lYbS/73LM5YtBWgmbZJ5YIqQSYtFnQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=au+QkNY3o5winbu3uxZuI6iBhBv6gIjEdenQ+oNE7imBuFUPy560XGRlVqv0xtuFULCHpZDruBJRIF+WuDt8WWBO0bMKXxIpUs7DisYBMP/LLuaKDI3FsD7n8lrTJSfm/9Syc68gvfcOEd4i83/QBeq9Apgq8Z/n+EYH7cZjXgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2Bga/YR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF8F8C43390;
	Wed, 13 Mar 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710293430;
	bh=7nZy9/vurPXr1lYbS/73LM5YtBWgmbZJ5YIqQSYtFnQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J2Bga/YRp8sVgNGz4lcaA0QlE7hQfgHBNd3QdMB6cHyqXJqSEERoitbs2VSjHjt2E
	 B6DsR5KTJKZ4CYuK80W3zg0cbAoJzQq9pm5Ygf03xmdcE0shLRvu1ZfJPghO3kwu/O
	 iqEpTSN78NxwvVG2np+US9IIf2M0u6umaW5TXWs4wcq4+2kp9kA3fUkAyAUnDigX/T
	 MUzjIO9ulbz7Z3PUHtsEQQ4WA4GS615T2XuY6H5W3afTxK8/Mc0BfClcu0bvF7KeUa
	 7Xz2TPBAEr2857UYIqDypdiGvBdhMeSW2Z+/UDDzyo3HKt4ruEyqLd1vYO1aVlKyTP
	 5If3Arl3uP5sQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0540D95057;
	Wed, 13 Mar 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: prevent atomic write on pinned file
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171029342984.17296.1929429193688050018.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 01:30:29 +0000
References: <20240311235921.1832684-1-daeho43@gmail.com>
In-Reply-To: <20240311235921.1832684-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 11 Mar 2024 16:59:19 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Since atomic write way was changed to out-place-update, we should
> prevent it on pinned files.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: prevent atomic write on pinned file
    https://git.kernel.org/jaegeuk/f2fs/c/c644af133283
  - [f2fs-dev,2/2] f2fs: prevent writing without fallocate() for pinned files
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



