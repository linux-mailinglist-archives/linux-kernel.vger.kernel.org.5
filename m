Return-Path: <linux-kernel+bounces-73884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBA185CD1B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C481F235FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3223C29;
	Wed, 21 Feb 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkZkIFWJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA96FC3;
	Wed, 21 Feb 2024 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476709; cv=none; b=koF5rhXcFkdGCxjI2c9udzyFzwxEo/y+Tx3xPHnity4Sf9UVxvcsyCZeQ4rpAf3H7UCQzcIQmjaOwP3fgokBM5yXXWRf6NWNtLpsVILjQmtVwAdcIuNQBEsJJ0OR9cX3qS+OeAu+L19Ww0eBKtGDvflOLHtI9v8UpXjiat4RCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476709; c=relaxed/simple;
	bh=Ncr8WgFBMmxONPdwFz/Fb8hFz7H28QbV5ZY6jMhjEYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VP2gFLBjC2dj0hX5nofoVVycqBBzFKoVdvetJyOYaH+T63wn66nzX6aBUfxRIhqOCM6IzC4vWAovHr/LOi+/sFT7BcnI9MLvu9VhPf6PaFZiMaR0TNnRHUBFIjn119DSzZkOkL+aHDMC53NAHsDSGRsPTsGHZ7pjwaAFjbyNeXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkZkIFWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F8BC433F1;
	Wed, 21 Feb 2024 00:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708476708;
	bh=Ncr8WgFBMmxONPdwFz/Fb8hFz7H28QbV5ZY6jMhjEYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pkZkIFWJrVR7bo//86y2c2Kn134q5TqKjcMMuBLimZR6x8tLtjOaA7TfjeZrmYfDw
	 7EQL48GphdVQprRVKhyWZjxEow8XNe2TbzkcmVzaIlZO+udwjgf2nei9ix1sI6Jn2P
	 7Wi8EaI10oaZmUHP/lQ3DyHbecbPqd7L54ILynIdZWx8S3Ow6Qmr3Wp7M/UsNB1Unb
	 ydSWIdLrTcZfslvVTUC0DkoJT942Fg2tGww6DPnJxK9jUBJS0XQOZ12tBoW4MPqV0l
	 e5eXJSQSmG6HU0USdQkxUfepIBE6iujQV9TK3fNWCKeiAo1/+iQlohkcWC3zd/N+1+
	 mojqpvCWPTEvg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240216134918.2108262-1-colin.i.king@gmail.com>
References: <20240216134918.2108262-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] regulator: core: Remove redundant assignment to
 variable possible_uV
Message-Id: <170847670760.72396.11946631659826067398.b4-ty@kernel.org>
Date: Wed, 21 Feb 2024 00:51:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 16 Feb 2024 13:49:18 +0000, Colin Ian King wrote:
> The variable possible_uV being assigned a value that is never read, the
> control flow via the following goto statement takes a path where the
> variable is not accessed. The assignment is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/regulator/core.c:3935:3: warning: Value stored to 'possible_uV'
> is never read [deadcode.DeadStores]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Remove redundant assignment to variable possible_uV
      commit: 055100d1a3b27ce154b3e3041d3cef24778821b3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


