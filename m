Return-Path: <linux-kernel+bounces-94349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E3E873DC2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50631F23B3D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE5013BAF4;
	Wed,  6 Mar 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFSZGg6t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB3605DC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747429; cv=none; b=TdJl8OpO7x0FU1mivLKsLlrkHLI/sgPO5y+mR1oFvl3PqxCuywdSyyi1cytUU6nmyRomvLHro8BdO0W2pXWI/AP8bl9o/7G7cFPSYir2N3yWbP3415s3rc+vvBx5Efit4zFTVr1qTZZA9MnPOoCnUKnLHWFj35BzeFfsBdXBH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747429; c=relaxed/simple;
	bh=7CB5Bot5JtGx9FNOHp5QlZ+t4Ki7IpsGY6s5MKPegSY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dk6KDXvzN0eeG71ixFYvwUGTA2GKCLrgQGOgQf0SlPZTrOAoUQ/gjV1CKdCyMX7eShHPg2Eu1hoZOuwujfqA4JCm9MtXRQqGvtIW1yW9RGla6hSjCyh20Ipu8SKQjDE6VTzumqvP1BvuNo//8+hThlGvU39Yu8te+X6Gt5z9sz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFSZGg6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A2D7C433C7;
	Wed,  6 Mar 2024 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709747429;
	bh=7CB5Bot5JtGx9FNOHp5QlZ+t4Ki7IpsGY6s5MKPegSY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TFSZGg6tb8BmHi/WN/doDwAsZ9zfjJAYcUXgkYXP+0UNL4QEYLy2LEh6uFQtgO/8v
	 7jRRTsO4l0zSuoiv16tK16/RA+gd92HgkIwTj0oVO9F908DVR5p3cVFmH0noZ1HmiZ
	 UA1KnikxF7HXc+AdOGSWdq+FkKR80IQlMG1N1xwDfP4g26ZBW1Hcnzd9CKxAhJwIYO
	 TfogW+jsIf/bA5elYAD9tA1Ig6fU2aoaKy85vuEkqa9SzWg0FEBlAGr6iCcIjAa1il
	 d92h4m5VYBHZkj6MoZtIVcdku08ROcpcnm/HOish5Oz4fm6AIqahayztM15gIhdmZ+
	 T2BSJbcW+0XLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECA7FD84BDB;
	Wed,  6 Mar 2024 17:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: Cast expression type to unsigned long in
 __count_extent_cache()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170974742896.3369.11970088169453313081.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 17:50:28 +0000
References: <20240305080943.6922-1-r.smirnov@omp.ru>
In-Reply-To: <20240305080943.6922-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: jaegeuk@kernel.org, chao@kernel.org, s.shtylyov@omp.ru,
 lvc-project@linuxtesting.org, linux-kernel@vger.kernel.org,
 k.yankevich@omp.ru, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 5 Mar 2024 11:09:43 +0300 you wrote:
> Cast expression type to unsigned long in __count_extent_cache()
> to prevent integer overflow.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: Cast expression type to unsigned long in __count_extent_cache()
    https://git.kernel.org/jaegeuk/f2fs/c/e88f4647d82f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



