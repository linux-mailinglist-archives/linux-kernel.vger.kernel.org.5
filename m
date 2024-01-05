Return-Path: <linux-kernel+bounces-18269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E47B825AC2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97511F246F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCA235F1A;
	Fri,  5 Jan 2024 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjZrp9kn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72935EF1;
	Fri,  5 Jan 2024 18:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA156C433C8;
	Fri,  5 Jan 2024 18:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704480502;
	bh=RkFt9IIYomhELhaSYrco17mS19Uik7xg/MPUw5WN1mw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BjZrp9knsEd0ZweLDzWv7N+f87DyNs5OkDTp+5ClbBUICCwtTt04lVT5BmSjVETjA
	 9O8uzYpxNT7ZIZG0PDZwD7HATJuurUZQvPkbF6SoAHWBttvdaPqM6UhAHEMNEToVYE
	 uNoc3diHnH1pTjPAg6CK+MtGA2sJwscDXHWjKzgQOeKaiLiDYLkuaRUC1kccOzt70Z
	 sqxlgBrFr4SIbgt44EyO9UwD553bQ8woCEBrFaQPLbSDrxU6UesHANlPqlIsHIFSKM
	 oYDkdMDgTHb8Cf/WkhBE8AproKezZiUSD1pOp+1WzXJ6ZSDum0cWyC3AcqYVG8Xswf
	 9iaekUGjFVYrQ==
From: Mark Brown <broonie@kernel.org>
To: conor+dt@kernel.org, krzysztof.kozlowski@linaro.org, 
 Shenghao Ding <shenghao-ding@ti.com>
Cc: robh+dt@kernel.org, andriy.shevchenko@linux.intel.com, kevin-lu@ti.com, 
 baojun.xu@ti.com, devicetree@vger.kernel.org, lgirdwood@gmail.com, 
 perex@perex.cz, pierre-louis.bossart@linux.intel.com, 13916275206@139.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 liam.r.girdwood@intel.com, soyer@irl.hu, tiwai@suse.de, peeyush@ti.com, 
 navada@ti.com
In-Reply-To: <20240104145721.1398-1-shenghao-ding@ti.com>
References: <20240104145721.1398-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v5 1/4] ASoC: dt-bindings: move tas2563 from
 tas2562.yaml to tas2781.yaml
Message-Id: <170448049855.417990.715024813727231807.b4-ty@kernel.org>
Date: Fri, 05 Jan 2024 18:48:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Thu, 04 Jan 2024 22:57:16 +0800, Shenghao Ding wrote:
> Move tas2563 from tas2562.yaml to tas2781.yaml to unbind tas2563 from
> tas2562 driver code and bind it to tas2781 driver code, because tas2563
> only work in bypass-DSP mode with tas2562 driver. In order to enable DSP
> mode for tas2563, it has been moved to tas2781 driver. As to the hardware
> part, such as register setting and DSP firmware, all these are stored in
> the binary firmware. What tas2781 drivder does is to parse the firmware
> and download it to the chip, then power on the chip. So, tas2781 driver
> can be resued as tas2563 driver. Only attention will be paid to
> downloading corresponding firmware.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: move tas2563 from tas2562.yaml to tas2781.yaml
      commit: 3dbb4e3602d217d7139b95a36077a6b7252dc290
[2/4] ASoC: tas2562: move tas2563 from tas2562 driver to tas2781 driver
      commit: 645994d21287a1ad2f637818d737f7a3d84e97d7
[3/4] ASoC: tas2781: Add tas2563 into header file for DSP mode
      commit: e9aa44736cb75e901d76ee59d80db1ae79d516f1
[4/4] ASoC: tas2781: Add tas2563 into driver
      commit: 9f1bcd16e2bd41d758438f1d74e5f2d35f1e8c8e

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


