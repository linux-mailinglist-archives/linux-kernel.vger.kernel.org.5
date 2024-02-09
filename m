Return-Path: <linux-kernel+bounces-59958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC6C84FDE8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD19281DE0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6059D294;
	Fri,  9 Feb 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+BnZhMk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE563B3;
	Fri,  9 Feb 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511733; cv=none; b=RZpktjhxKhRwhRr6NFno2KjfHS973Y7dIBSgO2VZWhBxiVZ8Q4mJJsyee25LnILiJxS4YXgsD+ZdSOIN41pfDYTtEfqk3/hSas7qkgZO5ozhsQigJpy6LanRFaUC4OEJksvvw68GVj8xq2f6GH6xykkY6YnSuBq0lAJTQhUovEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511733; c=relaxed/simple;
	bh=kNYvhk7i0JhSWiEEGVEhYUrUfkcIqOwz6wex6co/WgQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FVaXUutGu7jvlDkiHc9h1EmhRnT5gHT0hsKUU7PjV2uTHNghgIdkD3qv15L1fD2OZHy5hwRw6ZFGccClsosh9X6A+Ry1pIbk3hf/lHaAfVKdFigKHi7ZZ0JRn2m0mF7Uu2U/SD1hLDT+wa3oNeiPPllt+GCt/tl9QiU7I/m93ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+BnZhMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72246C433F1;
	Fri,  9 Feb 2024 20:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707511732;
	bh=kNYvhk7i0JhSWiEEGVEhYUrUfkcIqOwz6wex6co/WgQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p+BnZhMkShGU4OjQhUHSxnll3ajog1zrbSQXGWsEIDjTdNAPmQV6lQPd1FheOiheC
	 lM4sIR9NkK8yfVdGIPTn4R96bQkX96CphVgquGXgPZ01rhpy4eSn+KWHoL/gPzzUhL
	 sRGlWD6SBhzW5s/AI3BfrthEyvglHSr3jeVqXb7OEjqBWFFxwsqkX/6IlrBjUkotqI
	 Bfl0JVHG5Xhylo9jbo96AyiMWGWImW4VQCf5g07wgo2CzX7H4SQAUZbcFJ7a4X1fNb
	 IQM6bIrtuuO9emiQ56kKROqtk2zSpoZJYSK3oG3LkCiVwI9oAj5x5m0SBKi7WmBICC
	 30wYoR58vow7Q==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240209145700.1555950-1-rf@opensource.cirrus.com>
References: <20240209145700.1555950-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Remove default from IRQ1_CFG register
Message-Id: <170751173117.2414457.382973415866845999.b4-ty@kernel.org>
Date: Fri, 09 Feb 2024 20:48:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 09 Feb 2024 14:57:00 +0000, Richard Fitzgerald wrote:
> The driver never uses the IRQ1_CFG register so there's no need to provide
> a default value. It's set as a readable register only for debugging
> through the regmap registers file.
> 
> A system-specific firmware could overwrite this register with a non-default
> value. Therefore the driver can't hardcode what the initial value actually
> is. As the register is only for debugging the value can be left unknown
> until someone wants to read it through debugfs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Remove default from IRQ1_CFG register
      commit: 727b943263dc98a7aca355cc0302158218f71543

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


