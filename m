Return-Path: <linux-kernel+bounces-91087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0679E87096C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8065CB26CB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18200626CD;
	Mon,  4 Mar 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXmSdw/T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59F62171
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576429; cv=none; b=NGDpLtN7/eLs1EevObQc6cF/yFjiWf1ShFXI2EEeRCjUhZCB4XuvZTenncKkVoDh/6LVod6An8Ve5TX8dHdYYgYqEACZ2j23iMBLRs3jkXA/FhOYcMqjvz3R1VDYsTFMMNF+oiMeWcZZ5Kl43uriv+QAR+tJdCN6RC4YrnP+njc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576429; c=relaxed/simple;
	bh=3+YKLBXSvm2KnOYfZ9A26/aG3sIoBMt8bfvbid9PFaU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eSXJT3xCm/fbKoyCZ/LVwsUGiaVldsYE6oL9C++KSG7L/WSo9sAgFk39a5WdJCN1/sMR16Mjp6tLR/3PGgJUczU72Abb/4bqSKCd/uiaySFGzf0+bUM3fP0IQdsQfXftHpxw2LhgbhHN3wwzA8fy9XXSLmNlkIhV4/UlZf1CjK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXmSdw/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0306FC433B2;
	Mon,  4 Mar 2024 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709576429;
	bh=3+YKLBXSvm2KnOYfZ9A26/aG3sIoBMt8bfvbid9PFaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PXmSdw/TWbB+0ho1n3G9PcRqUsDVD70CSwL3mYRByVbYI3523/ChvtgAVYCxjCB7a
	 Sg10ID4XhnErJOH1ZiBAQJXOa7HgpaX+jdY1xtQRugUGx/M/c5hAiN4G+uUvOLPr/5
	 2CeHeJ/0PS6J4B60sAgmRBwjS0CF7+2fX1ZoyZa3kiMzkxfyksEtrDf5A6/uyGb4L+
	 1+5Kq0FPdh54bNnaKvxCC0IMM77uze3gy/+jNWv8L2X8Vcu1CjwWT23+/iJ7vKUxAp
	 LFi+OMBs88SBPk9uUAYFjz9K7980hM7XArQx9sg3yzNGosK0KGBTB4NB4GKrM6EkzH
	 39KEfAeevHEtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D15E3D88F89;
	Mon,  4 Mar 2024 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to check return value
 __allocate_new_segment
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170957642885.16816.17706378772269565327.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 18:20:28 +0000
References: <1709281555-11373-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1709281555-11373-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 hongyu.jin@unisoc.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 1 Mar 2024 16:25:54 +0800 you wrote:
> __allocate_new_segment may return error when get_new_segment
> fails, so its caller should check its return value.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/f2fs.h     | 2 +-
>  fs/f2fs/recovery.c | 2 +-
>  fs/f2fs/segment.c  | 7 +++++--
>  3 files changed, 7 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to check return value __allocate_new_segment
    https://git.kernel.org/jaegeuk/f2fs/c/28f66cc65403
  - [f2fs-dev,2/2] f2fs: fix to check return value of f2fs_gc_range
    https://git.kernel.org/jaegeuk/f2fs/c/22af1b8c31cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



