Return-Path: <linux-kernel+bounces-152940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7A98AC65F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB41AB21D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB14E535BF;
	Mon, 22 Apr 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGryFtmC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E655027B;
	Mon, 22 Apr 2024 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773361; cv=none; b=NRm7CJ6/RZdDw8YGczQ6FI7ROdGYruPFQieT2xC97OtH9wCfGupVFXFabroAugOauL17JT6IjhTpHsR0eHiwnFiHCJ+mUqvcRgYbPvSoB2P9COqszIuRw107dMfhMmm9w1k5m/Boz3xb0uD1KEvoRaZp6al1ECZSTp8e0zyniww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773361; c=relaxed/simple;
	bh=Z+gobst+gl3RwD4kqNC/52sndjOYrZEr5SeXwVNmrL4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ydy5cArqV0GZ5ss+rL/dTCEUA/w02hesg7xhcE4iA7b9dZBfORFHFrXhxql5rZJr2blg5n5t5k7wqhz8v5RJrl4MkaPlFWHuHSnxG5X0n1N67M9dJ59wIHDOWpe2lTN35r15tjbmMh5qBXaFpRt5fPN/8nclr0uaz88mEeNtIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGryFtmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02D3C32783;
	Mon, 22 Apr 2024 08:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713773360;
	bh=Z+gobst+gl3RwD4kqNC/52sndjOYrZEr5SeXwVNmrL4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iGryFtmCiyuRTfDlwWMA5QuI0ue7v1nIbLXHhOU8wMIrMtIlIj8iOB1MdAXnvNT17
	 fgqOJwwAuWm+KAaxYi4sFCs4MTM/B5vUP3mk8riAZ7rcxJvuZiydhxs1XiZG9t8i07
	 FLerPVvSsK5d11ujBo5WYgh4qDuZFcG3CCmCq5j37aZwW/34sjaoMDjNOi/wKlhac2
	 MLypzJ/khRgXaSMU5HTiDoBhswql80K5RkGwNTpAdVQZhg8QRc3sJF3bq3Jigqvsth
	 8fxoMFA2wlE0qLcoPfsgopWGAdE3l/ItVZMrri7q11+O8vVPZuiuXM+MoK6Btp19FT
	 8a2KC1P3B256Q==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Shenghao Ding <shenghao-ding@ti.com>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, perex@perex.cz, 
 tiwai@suse.com, 13916275206@139.com, mohit.chawla@ti.com, soyer@irl.hu, 
 jkhuang3@ti.com, tiwai@suse.de, pdjuandi@ti.com, manisha.agrawal@ti.com, 
 aviel@ti.com, hnagalla@ti.com, praneeth@ti.com, Baojun.Xu@fpt.com
In-Reply-To: <20240407091846.1299-1-shenghao-ding@ti.com>
References: <20240407091846.1299-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v9 0/4] ASoc: PCM6240: mixer-test report
Message-Id: <171377335622.1755143.2290939269459235170.b4-ty@kernel.org>
Date: Mon, 22 Apr 2024 17:09:16 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Sun, 07 Apr 2024 17:18:41 +0800, Shenghao Ding wrote:
> v9:
>  - Retest with the code with Volume kcontrol
> v8:
>  - use some reasonable format of changelog.
>  - fixed the format of subject
>  - remove *** BLURB HERE ***
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoc: PCM6240: Create PCM6240 Family driver code
      commit: 1324eafd37aa5c5b970c1b48a857acc81f0685c8
[2/4] ASoc: PCM6240: Create header file for PCM6240 Family driver code
      commit: d537f7b52d71110a98cd7230cce1b56ae7c8ea71
[3/4] ASoc: PCM6240: Add compile item for PCM6240 Family driver
      commit: 6bb1b70690766367e166b8ff59f4b5f9739f7964
[4/4] ASoc: dt-bindings: PCM6240: Add initial DT binding
      commit: cee56a8e9cf89fd690e18eb2e6f09d3f8a6442fb

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


