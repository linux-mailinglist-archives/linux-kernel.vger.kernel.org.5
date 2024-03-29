Return-Path: <linux-kernel+bounces-124655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0223891B10
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949711F2321A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7ED16B45B;
	Fri, 29 Mar 2024 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7W9FMkg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298EB6A34B;
	Fri, 29 Mar 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715642; cv=none; b=LqWyurDwP8rNxeNl6MCJOyVBLC6InZCkUaNYv/v1yZOlXYIMDgjuU0a0MW6hXGDyoqNbOuLok/fdCeEFIhiAf3dbz7j+Z0swYCb3IMKn4hmvuJBsGnuH5MNmxR8gX2oUX70pi1uofn3pgIdLfnXlL6CL+7sQC52PehBsnI0qR6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715642; c=relaxed/simple;
	bh=qTt4KDqrXeyw7RGiQehYLzJUsrTZmyh6yO4pY/kW7QQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FvS0rBd1Y/lJyiS+wa2W+hLp1KnpXDQhjcRDniIb1jSgLRgyH6wBgIqN89x/ibcsKBYK17sj+FHpYQZdO7BR7HHlKlvSCRDrGSzzXbq8fmvafD5WbQw1C1vw4sj4nujQCXfwA7gTUCFj30H4H8GfWWQUvG/okiFXDewSXm4G/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7W9FMkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EC6C43390;
	Fri, 29 Mar 2024 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715641;
	bh=qTt4KDqrXeyw7RGiQehYLzJUsrTZmyh6yO4pY/kW7QQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=X7W9FMkgGc4kdZ6bP2+wdt3z3TpFAFr93b57eaWXr7PWE6e21DN5FsGMDtiAX9kde
	 5uYB+tCK5JI1m2msjBtUq1RrtWYwFurZTIVhwfbsdQJw/ZoTRuHM343Pk2BmqiJwp+
	 Z5CZeSB27kQIRtlnlye0hkc+PjGS3+mPs5zStzDNkq+DpeFeXE2KL8zb87QujcgI7S
	 XUyrZB35i30ExyvQEVo/3BdC2B40hgMv0vdbPlrjNnj1tIQ45gsYJeTGfqKXNCQltW
	 Rb28rlQZRUiU0N4K4FGP9Ov7kpjPQHCA4ZXeYjV0WUQ9iqx4Fwd4mfbd52a8sQD8Wt
	 +aGpGC38l35VA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>, 
 Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
 Oder Chiou <oder_chiou@realtek.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org
In-Reply-To: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
References: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
Subject: Re: [PATCH 00/18] ASoC: drop driver owner assignment
Message-Id: <171171563939.7557.7260921573529586225.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 12:33:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 27 Mar 2024 18:44:35 +0100, Krzysztof Kozlowski wrote:
> Core for several drivers already sets the driver.owner, so driver does
> not need to.  Simplify the drivers.
> 
> Patches are independent, no dependencies.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/18] ASoC: loongson: i2s/pci: drop driver owner assignment
        commit: c335412ced27459b6ce71e812344a0bbaf43ab6a
[02/18] ASoC: tlv320aic32x4-spi: drop driver owner assignment
        commit: 8a4836231c98bde3fa49ad657c09342d2d7e27a7
[03/18] ASoC: tlv320aic3x-spi: drop driver owner assignment
        commit: 54b8a522e67a8dfe135867c00f9fa297f0841c92
[04/18] ASoC: max98373-sdw: drop driver owner assignment
        commit: fe2065d645445dc2de61d9b336c41113759eef8a
[05/18] ASoC: rt1017-sdca-sdw: drop driver owner assignment
        commit: d95c19aa2ca60010bb1976399b5a822ff165a8ef
[06/18] ASoC: rt1308-sdw: drop driver owner assignment
        commit: b982047530d7a29eb68d42acaa19f249ac6ae5a7
[07/18] ASoC: rt1316-sdw: drop driver owner assignment
        commit: 7d5a2656626a6fbf573bde981c1550428a261cf2
[08/18] ASoC: rt1318-sdw: drop driver owner assignment
        commit: 3b7859dec834e96e8e833d2b2f2b4434e0e3b286
[09/18] ASoC: rt5682-sdw: drop driver owner assignment
        commit: e140dfeb1028ef49c34ae238863398c2c7e792f0
[10/18] ASoC: rt700-sdw: drop driver owner assignment
        commit: 554bec0c52dc6b6bbd605aa09462d15e9c41575b
[11/18] ASoC: rt711-sdca-sdw: drop driver owner assignment
        commit: 852298a5e1ce7e72cb3c491bce3bca7262f6ef16
[12/18] ASoC: rt711-sdw: drop driver owner assignment
        commit: 37dc3531c56b86143b69576c4b56434d8bfcbf59
[13/18] ASoC: rt712-sdca-dmic: drop driver owner assignment
        commit: e50d2fbb6371f4d8482f5e4e112155278db6fc34
[14/18] ASoC: rt712-sdca-sdw: drop driver owner assignment
        commit: 7c00f1706e4b9ac02fdfb2a6b93b4487cbcefd3d
[15/18] ASoC: rt715-sdca-sdw: drop driver owner assignment
        commit: d4f501e2926e32be76c0c564a634f06edef768bf
[16/18] ASoC: rt715-sdw: drop driver owner assignment
        commit: eb9e0757976fdf34b65d70c7d25a7f0d3d1ecea9
[17/18] ASoC: rt722-sdca-sdw: drop driver owner assignment
        commit: 8c70ce6108cda5c36b9c4e66b1fd7dc8ded2a7d6
[18/18] ASoC: sdw-mockup: drop driver owner assignment
        commit: 29580cd7b9c6f975e88597ca66a001b16b97bae9

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


