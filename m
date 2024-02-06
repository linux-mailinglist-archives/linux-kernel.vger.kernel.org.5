Return-Path: <linux-kernel+bounces-55302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B24684BAA1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE43A1F24881
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD30D134CCA;
	Tue,  6 Feb 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhjk+TCu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A9213474A;
	Tue,  6 Feb 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235855; cv=none; b=ffce3tdvnJgMvQuW+3u0l2vBj88ES7LJuEaLPcVCtIahUWbfkHA5ZRg8gHUPeT2cwoGHUSRei/vZhecMq/ACJA9qxtsDKKdY8DCD9OxGeLxzIJNRW6E1LfALMEwvGprdKctdrwGnZCEii4Kzc9yAkbFegR9hBBr3+hvTMS2PUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235855; c=relaxed/simple;
	bh=rt2gbomlAKzHf86rD0Rdi08EvEQCBWqCJ3uvmPmjTF4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ur0G2VJrNBCohvwbsa9TUTjHps9q2gUVJ6JQD2VNBD8HeTmTDirsp/6AbxfMwbadmbU3Ivpw3YRwzeiiT4EegbtQ61WlgpP/ho69KbMh8gpQM3aEL2KyK9FZLmpmIaMRzSoO3S+7JLJFxKFxc8QoFHJoolkyHqxMcxXj5/9VBYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhjk+TCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D417C433F1;
	Tue,  6 Feb 2024 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707235854;
	bh=rt2gbomlAKzHf86rD0Rdi08EvEQCBWqCJ3uvmPmjTF4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hhjk+TCu3GJOkW+S758ybNCIvyn0Ca9BCVhLHQNZh6SjtHrezuEaCl3XkfQGZ8+Vn
	 v+aRDxg7dZjeohPRgS4SpBASCui4OkuhFI4lmTgUkkqPw8/ZFSoLuNe+YEOp8azYsP
	 4jGCbrEIJkA5cX261dvVWc/e+PMoulXuhL/sd6FGdlucxsz6o9icMmqMGM8EPJHEY9
	 0OPc84SEqC3K7fLP2OA2IGep5FjG6W7m9D9ke+yrre8qjYJcxbWqAwJFM0MlFhgCPF
	 pnyStuxBke7AIYmD/6x5Pwd5MoOqGSp6u4zTdByF4simCNAhQxHXFJFZgse26HrD3H
	 Ezs5RO08eGmKA==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Dharma Balasubiramani <dharma.b@microchip.com>
Cc: hari.prasathge@microchip.com
In-Reply-To: <20240206064418.237377-1-dharma.b@microchip.com>
References: <20240206064418.237377-1-dharma.b@microchip.com>
Subject: Re: [linux][PATCH] ASoC: dt-bindings: atmel,sam9x5-wm8731: Convert
 to json-schema
Message-Id: <170723585073.1032228.17039996472357795011.b4-ty@kernel.org>
Date: Tue, 06 Feb 2024 16:10:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Tue, 06 Feb 2024 12:14:18 +0530, Dharma Balasubiramani wrote:
> Convert atmel sam9x5-wm8731-audio devicetree binding to json-schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: atmel,sam9x5-wm8731: Convert to json-schema
      commit: a15f859ca312feb4730c93320bbe46929d0f9d26

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


