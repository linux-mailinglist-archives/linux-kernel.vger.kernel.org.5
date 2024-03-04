Return-Path: <linux-kernel+bounces-91085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD92870968
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7C41F234DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0530E626CB;
	Mon,  4 Mar 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cpm8IWRm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4336E6025E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576429; cv=none; b=s8j7j87kBFyrJkzl6+jbtjprEUv6CzbnIL7PFQkCOsjB5jRKwZzChUIhbBWjQlbGtLb5yKc5WI+1L/bCPmc9hspaCbM0W1rFcTiot9SRcx5eRbFveXLdSTbQbLhX5P0scLkCGblONNP8I7vAx4PISqeWN4Aa79kJXsyC/rX8lAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576429; c=relaxed/simple;
	bh=lTbK2fW4sd5g7yN9587jwyOUJdCj3ya2dZC91nk0tOM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NEHqaKy+3bwEuDNnTcXZmM0Qdp1EsmjbSafeXiZfH1+4Q0J0wbE7atRvEJc3MdpcBzh0D0by2T5cdwBKcNyoXlVvA5a6oC4js1mzZ+gYn/bONLRkpmBoIt+RvVv76llWKzhvy8ijwOsIRD4saLBwI88g75j1h0dlx/DJbSsA5qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cpm8IWRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 113D1C43330;
	Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709576429;
	bh=lTbK2fW4sd5g7yN9587jwyOUJdCj3ya2dZC91nk0tOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cpm8IWRmhRN6aGArbKrbu6AynKWoRY3VFI74Yhsj6b1GKa0eJAyAafpc+KdMcMrju
	 oEkbgyffn5N4+IHT5Jzylw38cxhzk7jA00GSPLZoYHuVQqom3j4zrPxKh20ZayAnjH
	 DlI5aWOd+3twcQd4Sovd21Y618Sjd3zDPC7xk9+wbvAANeVQg+I3yiCaOJIrXUVkZZ
	 U5Z9LpLWcm8wH169HGsqlKukpj8i4qav4B9cTqwyLj5sG0ymnAGiwBPtluujy09wXm
	 NV/s653c4ozrKDFMqEXFoiBNu4nBJtYmpSKASaiFvFHXKixpAwKAmR6W/9AXpvn2w7
	 NEBGPDBXCNA8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F109DD9A4BB;
	Mon,  4 Mar 2024 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check return value in
 f2fs_insert_range()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170957642898.16816.15329403645520818007.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 18:20:28 +0000
References: <20240226031916.2420870-1-chao@kernel.org>
In-Reply-To: <20240226031916.2420870-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 26 Feb 2024 11:19:16 +0800 you wrote:
> In f2fs_insert_range(), it missed to check return value of
> filemap_write_and_wait_range(), fix it.
> 
> Meanwhile, just return error number once __exchange_data_block()
> fails.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to check return value in f2fs_insert_range()
    https://git.kernel.org/jaegeuk/f2fs/c/2fc2bcc8d399

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



