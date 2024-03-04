Return-Path: <linux-kernel+bounces-91088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBAB87096A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B8D1F21F72
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183D1626D5;
	Mon,  4 Mar 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN1kw/RR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D962172
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576429; cv=none; b=oEwzCPqBQEbUoe0NvvDPTfjxAaznNdfdNJPFr85cbSM8/UFjrWYZFp0balHvzJ+i8xXJVSxoDd1D1RSwevUI5udQZ+t0qc6LnHb6K1LPDic2K4WZsFWSNAVc4ulYajs9F5HASek8wYCHjyi1x5iV+cQBxVe6wagtCbi3OQpYwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576429; c=relaxed/simple;
	bh=69mV4fEoSJENCUX2KVzifrbfBfaxcvgV4NzLALj2hic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SWmGrSvuwY09M3jGgIhjZP3NXTSivRWQ/SDheE6rviiq/sxl4GlJOHfNE1Ojs2T+YuXTPg8+t/2zrxPD+KCn47b6fQdfQNl5yNFw3QzQSmhxwZ4chZciJJx3ogslhgsc6IZ8zwOFfQBjiq5k2iE6PPVIjg99+LDZ7Et62IYdh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN1kw/RR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 190E2C43601;
	Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709576429;
	bh=69mV4fEoSJENCUX2KVzifrbfBfaxcvgV4NzLALj2hic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dN1kw/RRAyYO4dUEkEZjbGz56AayoVvYiZ2ZJ8ZyjbHBfiGhSUMlsobyk/yvh+gSS
	 /ZugPENub+hlOW7MTpv0uPiXzWPaLXqmHNlWaBMzQRMVydl6BSldlLH0c5og5FuwDp
	 lvWpBGkKk468EPvtHNP91NMgPDBKK/yQtStCZ9sGWRQjYIW97PDteCp9sBaxsPkxrN
	 L9nMQgUWFHLVfMN0FCKtZZ6bW+egEJgeOiDb8VZsHAa3UIaD6vzBHl/pTNyafskmJX
	 1UtYgObNmpz5M8/9lfKTrUC7zRm2XTBMRERqjVuVqkCNqx/9Q4O7L2VBd5fmcb47+S
	 Q5nen5lJRnxfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA229D88F8B;
	Mon,  4 Mar 2024 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: ro: compress: fix to avoid caching
 unaligned extent
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170957642895.16816.4057582792017070117.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 18:20:28 +0000
References: <20240226073539.2509926-1-chao@kernel.org>
In-Reply-To: <20240226073539.2509926-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 26 Feb 2024 15:35:38 +0800 you wrote:
> Mapping info from dump.f2fs:
> i_addr[0x2d] cluster flag    		[0xfffffffe : 4294967294]
> i_addr[0x2e]                 		[0x   10428 : 66600]
> i_addr[0x2f]                 		[0x   10429 : 66601]
> i_addr[0x30]                 		[0x   1042a : 66602]
> 
> f2fs_io fiemap 37 1 /mnt/f2fs/disk-58390c8c.raw
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: ro: compress: fix to avoid caching unaligned extent
    https://git.kernel.org/jaegeuk/f2fs/c/4b99ecd30429
  - [f2fs-dev,2/2] f2fs: ro: don't start discard thread for readonly image
    https://git.kernel.org/jaegeuk/f2fs/c/a217f1873ab9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



