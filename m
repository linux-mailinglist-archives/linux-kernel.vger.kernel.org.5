Return-Path: <linux-kernel+bounces-75250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A085E542
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F16A2838C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8608529E;
	Wed, 21 Feb 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1ZCwLfk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4198004E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539031; cv=none; b=IV2YI0vr8/LDFyvOemQxVzcrMuT5fO6C8mj4+4Mt3s2jiftU5q2zsuboll8E5YB8IPE3QyIzlxUrjMF1PtH8RQmDQmvQ6c9Z8hzGrUZyhspuVZuG4LeoCJnzDIJAxL82hagw5wDPq75/yq/YhXJHwQ52Uft42oBCc1TjZiZyvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539031; c=relaxed/simple;
	bh=fpf+8arTk6Z5iQdXwHgM6+5zvas75nnHpQQnSHAKwD8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k9bcWpsQkDk+2dBm4dt6EvyofmP4mbSqwzGIKzVjMFjBnV7niKNGyfqz6chlez6MszOiEF9/XDTBfDvvVHyHbpRfTdoJa389BMLeoFFsjCQD086mq57CBYqdaYz4LYZ41E9JkOK4othFluKxZCmb4bny97Eo/JyRtYYf8CbeE+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1ZCwLfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2D1CC433C7;
	Wed, 21 Feb 2024 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539031;
	bh=fpf+8arTk6Z5iQdXwHgM6+5zvas75nnHpQQnSHAKwD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P1ZCwLfk2rUyT4GsM32Gy6mwVk4HWtyw91aGodg2bWt7MjexxNoEbwH38ZjZZtNso
	 aMW2y63EsnjXr6V9MIn5yu35R7JP/e+RwvhOvtWOW+XlvKlkDxgrmUNvzoYc9WnmNn
	 xEJeMLS8QQrgZbQ77nFGxDmJFMybqbg3O6e0Xy1L2CE6Vf2HxsdTTzBcU8Dvk2taAm
	 XJGwJRWStZRxqH6pQGyE2lrR6n5MnniMmdOKn+y/xGn7SpkYvVty4lY0240/4WD1lY
	 1soXKvtphie9sd0Oj3OQ7erRdZA5zVZVgUCt9HyC/9FAVbIaG5726CJgronOvfrRhc
	 9qLlIe5G/5jqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D811BD84BB9;
	Wed, 21 Feb 2024 18:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 0/4] f2fs: fix panic issue in small capacity
 device
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170853903087.7043.18353630972928163245.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 18:10:30 +0000
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 hongyu.jin@unisoc.com, niuzhiguo84@gmail.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 7 Feb 2024 10:01:00 +0800 you wrote:
> A panic issue happened in a reboot test in small capacity device
> as following:
> 1.The device size is 64MB, and main area has 24 segments, and
> CONFIG_F2FS_CHECK_FS is not enabled.
> 2.There is no any free segments left shown in free_segmap_info,
> then another write request cause get_new_segment get a out-of-bound
> segment with segno 24.
> 3.panic happen in update_sit_entry because access invalid bitmap
> pointer.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/4] f2fs: correct counting methods of free_segments in __set_inuse
    https://git.kernel.org/jaegeuk/f2fs/c/8bac4167fd14
  - [f2fs-dev,v2,2/4] f2fs: fix panic issue in update_sit_entry
    https://git.kernel.org/jaegeuk/f2fs/c/4acac2bf18d6
  - [f2fs-dev,v2,3/4] f2fs: enhance judgment conditions of GET_SEGNO
    (no matching commit)
  - [f2fs-dev,v2,4/4] f2fs: stop checkpoint when get a out-of-bounds segment
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



