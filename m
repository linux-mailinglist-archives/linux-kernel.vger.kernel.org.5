Return-Path: <linux-kernel+bounces-64081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5853A8539F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB141F22EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF31DDA6;
	Tue, 13 Feb 2024 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY8DxBxj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F258B658;
	Tue, 13 Feb 2024 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849094; cv=none; b=SEHr8xxUNosb5/G9gs5vbHbivdjiJeiys867YgwTRipLqKUBuZJKGq1A8EDifbg6FDMlD5s9+Ug0jIwvibYsZf2pP8REofzwpTlZ0z9yWHjwkY6TAD/sRJJ2hqe79uJJW/lktVJgII5uaNfw0lU3BUfxLmvIm54+csVUgmz1Aqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849094; c=relaxed/simple;
	bh=Ab8fxxdy291RfR+OBopZ6Cc/GzwuF9lMaVqa+RwJDiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=airfyOwedP3DdF3LoED3A0g6CHXEcIDr1M+Mmm/wfMyBmbLbdxif7cTV1Wbgyy1J4kH8E64SEV7yPWXOyiDoyu7RAlXKBKQlbmcgZqw9MF2N0rSmlOIJchB8KYBv8Wh3UBm4ifpFMyymSDwgzEVKCFFPrPUDxPL1z5qWUSRbBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY8DxBxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11013C433F1;
	Tue, 13 Feb 2024 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707849093;
	bh=Ab8fxxdy291RfR+OBopZ6Cc/GzwuF9lMaVqa+RwJDiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dY8DxBxjfJNMd1QRmcVNxD7LbIByw9EBGh51gAiUFT/IYlJR3fekzyBQaC85Abm+I
	 2rdzxvVjWSJNWPBtYPdoFgIp+DCkdJRxK1ZjgALs+ul9n4Zi6ciqM09pGkx9y/bMVK
	 ZKEblLt2DzKaTcdhOwn6VL912rbNVxYAF/l0qF1U0wsmf8/tIlzsJSuOgxidbGiMSG
	 AlAg4BWyj0OEvdk/dy3fc2SbZEPcpkLCuthKhsPCj1qwKwAYZffcBPmpIPPI/6gcGy
	 IQiafICqxTJLV+k4rPbpHmQo92gTf3PipaALQqqnpbiUFCZeQBw7DRcjDRrlHfSn0M
	 pEbF1c7DTij0A==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 NXP Linux Team <linux-imx@nxp.com>, Sebastian Reichel <sre@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213010347.1075251-1-sre@kernel.org>
References: <20240213010347.1075251-1-sre@kernel.org>
Subject: Re: (subset) [PATCH v2 00/17] UNI-T UTi260B support
Message-Id: <170784909076.647645.11591150150653881447.b4-ty@kernel.org>
Date: Tue, 13 Feb 2024 18:31:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 13 Feb 2024 02:00:49 +0100, Sebastian Reichel wrote:
> This adds adds support for the UNI-T UTi260B thermal camera, which is based
> on i.MX6ULL. Patches 1-14 clean up all warnings reported by CHECK_DTBS for
> i.MX6ULL (i.e. for an empty board). They are not specific to the UTi260B and
> in fact that machine has most of the IP handled by these patches marked as
> disabled. Then patches 15+16 introduce the vendor and board compatible DT
> bindings. Finally the last patches adds support for the thermal camera itself.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[03/17] ASoC: dt-bindings: fsl,imx-asrc: convert to YAML
        commit: 20c0c9b352df1ab7915c827cb1d182bfc32f9f46

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


