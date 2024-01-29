Return-Path: <linux-kernel+bounces-43472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832D3841451
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245301F23324
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A888158D6D;
	Mon, 29 Jan 2024 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBEHjpqW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C02157E6E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560171; cv=none; b=Fqo0GQTYXqlgnw7EKwZZQnk/bwCFRus9inWTwr5SvcDIygg7V55YdsKM99E2X7utlsfI38793joI6j1mXPj4JnlMEti6J87Om6kwCNZ8EDMHQu6TZiKp58w7Vlmw7nVhDTaY3pY0wqhikU23kLggajd/bcdTa61HjbIfy5eu/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560171; c=relaxed/simple;
	bh=g89ct8LZtexls713Tf32nFxe7xzSJiRvadNHPxIicWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mm7jrP3QwAW63z2UEJjnXyTks6SkFm0dCHYa82G9zBMAPxJBKMi4yosWfKZMSujY/+1xYwCX9ItR14nLQ3KdwzKSdI5tb6yJbd5dT1RviI8SM/Zw/CGBaVxB21FYJfvWshbhBuLC3BYE0uovzoxxWXlWDv0gfM+HBMAE3rTcHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBEHjpqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB98AC43394;
	Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706560171;
	bh=g89ct8LZtexls713Tf32nFxe7xzSJiRvadNHPxIicWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FBEHjpqWS9qGj+DyJdcX9eYqH8PmOWWttK19x159DgXF1ykISdOS+UsRH0iT63Gnk
	 rTip+4MKApnoafJoBmKZJ3N16Q8tSmPdfMs8ve/5+2IQ7uKgHB2qG5wDKR8pTMsXBD
	 qne3APCSOJALXnU4fSGjsXdhVsQ3ekFwnpXqDRho6zKIQdFD4BsjGq9mfcl3tXRqcj
	 9bk7W2HAtvrNfi3N0uPthtC038olY1lyc0H0SdGrKf+8++/8ysah3riKl8hPWoh52t
	 lNeHspbjwEYlWhb3sz2Muia5GBHvqzw/2XPVQcq/zA8cW4U/A8lsNKxMPw/S/yMebZ
	 W94ICKv4Rzd8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9DF5C00448;
	Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unnecessary f2fs_put_page in
 f2fs_rename
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170656017082.16041.17585819028221577977.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 20:29:30 +0000
References: <20240112171645.3929428-1-jaegeuk@kernel.org>
In-Reply-To: <20240112171645.3929428-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 viro@zeniv.linux.org.uk

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 12 Jan 2024 09:16:45 -0800 you wrote:
> [1] changed the below condition, which made f2fs_put_page() voided.
> This patch reapplies the AL's resolution in -next from [2].
> 
> -       if (S_ISDIR(old_inode->i_mode)) {
> +       if (old_is_dir && old_dir != new_dir) {
>                 old_dir_entry = f2fs_parent_dir(old_inode, &old_dir_page);
>                 if (!old_dir_entry) {
>                         if (IS_ERR(old_dir_page))
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: remove unnecessary f2fs_put_page in f2fs_rename
    https://git.kernel.org/jaegeuk/f2fs/c/fb09ad63d798

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



