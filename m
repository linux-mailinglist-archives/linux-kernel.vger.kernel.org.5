Return-Path: <linux-kernel+bounces-144233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5D68A4375
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A13B217DE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C11369AE;
	Sun, 14 Apr 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCzv8Lnk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345C134CCC
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=e5bMGrojRmI5/LyJG12lb23Xi8WiMdZTVEzJp1+983GH9X2W/RQK/fIB+9UoVlWZHqOGOi5ABsGsMzAr+gzebN996uK6/vPFD57mD+daudoMo07snDeM6x77WPVphGUTW7luZLIX+Y3Wc09/wWb7plNdtlQJLRlVFqw4GljDx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=bxNO3fkRN2ASJqrntL4vOhcWHQKY0KbQtg8KAE0BNuQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BiJuvcY3WjxT9NGWM/ZjG0r2wLX3omXMJQn1f9JwT/zTAzK0U1lAcdpLZqbtDY6Cox8GRqenOWpx9Z44TcoLyhalMYdF497qW9GlfSyVzIaxQC8ylz3UuuSoZSXOxYq4S+0ZZD6EjCxBuNRsinrsuSJIzQKvj7RRG2eNZtEGB/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCzv8Lnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 522ECC32786;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=bxNO3fkRN2ASJqrntL4vOhcWHQKY0KbQtg8KAE0BNuQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cCzv8Lnk/2BPKQQn3P2DLmjc/aDjSDHRyDxOGODvk55yta9kZOAusmHl3RJYW+jNN
	 Qj9KQ//DAH7+ehRwCObwBMT4Cyo87fqfDEAgDajEY9I14Rr84k0l3B4qNsCQcO2NzT
	 JxjO9WSqDzdKIUbrfaGahBKIDscy4wk1u0jCkUhZPzAtP7Evg9+I8QTMzMfdt3tXew
	 G2hUATt5gWcSaZDno7IAe2bb5RnMCGVi1j7Csr7z7mADH7DLRoUNR8qgi+nOuT/EPN
	 vGLgThOdmRbdzylbstJhKMOq6ZgMZ40MnjPtAEGFYsmUoS74OpFXINSuLpymt4uGJg
	 R8mCAnIPPnA/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41C5FC43140;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: support .shutdown in f2fs_sops
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171310876526.3156.6732886911990694550.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240229143838.45149-1-chao@kernel.org>
In-Reply-To: <20240229143838.45149-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 29 Feb 2024 22:38:38 +0800 you wrote:
> Support .shutdown callback in f2fs_sops, then, it can be called to
> shut down the file system when underlying block device is marked dead.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h  |  2 ++
>  fs/f2fs/file.c  | 70 ++++++++++++++++++++++++++++++-------------------
>  fs/f2fs/super.c |  6 +++++
>  3 files changed, 51 insertions(+), 27 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: support .shutdown in f2fs_sops
    https://git.kernel.org/jaegeuk/f2fs/c/ee745e4736fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



