Return-Path: <linux-kernel+bounces-116407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B70A889666
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDD91C30130
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7B1146D61;
	Mon, 25 Mar 2024 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IW3oS+vk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11502153568;
	Mon, 25 Mar 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332789; cv=none; b=u7REQ7lAzJE27FtSPJ1eSaA5qN0mvEhGELx5KLu7mFDtGkmiWdlIWfp21k78JdllIhO//sDXhPAUsfbh/vMkGt+dQGEXXgrUdx41IkRb3wCemAJnrlLDvob0Dfn42azqF+4jn3mVSMq6+MYtJGIMuO5JDf6RhBDkk/o2r9S0UbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332789; c=relaxed/simple;
	bh=OQ6DaWqLtLK0mHL2i6HS0EPqyqAvookaS2ecZGz/nWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g43doJD1Zwd+SjGFr2tDawQRyGxaqDWtHOLzHbbPbdlZEifs5MViBVSEdcqAq4MXmI+EdlTb8RCW8B/c0Gl7UUu7O5d1K+qyZXe2jCfHGN1ApxYSjBtyyzvY+nuAnF/lYyilRgmLDNgJoFct7k0iusd1Lr+w+/W9TO8YCmiI934=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IW3oS+vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A56A5C4166B;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711332787;
	bh=OQ6DaWqLtLK0mHL2i6HS0EPqyqAvookaS2ecZGz/nWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IW3oS+vkvE1rg2omkWdnXg451W2R8QWxmUug1tn/Bg6l3cfmeu1XEIle4W9BtNPp4
	 0oal/S4apZS+BzY3gBaCjlntTY0jgQlz1t3PTdy9XjaTcskT+il7ElSZAp+JWMzJPx
	 t4H/ihZGECuHFrRbX8V87SXD5ftRGwC5bn6CdPejAvtWiLKQtnbNuipuyb5sBYBBYm
	 r76u6K1eEb3PqAdmigNT4nSlFA/s5U3UgALZVL8Mu6HumRAnW3tR7xT39q806nrvhq
	 m7JZPsTIIGWptqQY1qCZ3jSIb5cnxMaBAWbnn/lCp4J/k3we+Ge3Bv+ms0rQoNcWaw
	 NOIkisLFJZphg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90BCDD2D0E3;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 00/32] spi: get rid of some legacy macros
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171133278756.9916.16032493309661657935.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 02:13:07 +0000
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@codeaurora.org
Cc: broonie@kernel.org, kernel@pengutronix.de, mdf@kernel.org,
 hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, linux-iio@vger.kernel.org,
 dmitry.torokhov@gmail.com, Jonathan.Cameron@huawei.com,
 linux-input@vger.kernel.org, gregkh@linuxfoundation.org,
 andriy.shevchenko@linux.intel.com, ulf.hansson@linaro.org,
 martin.tuma@digiteqautomotive.com, mchehab@kernel.org,
 linux-media@vger.kernel.org, serjk@netup.ru, arnd@arndb.de,
 yangyingliang@huawei.com, linux-mmc@vger.kernel.org, richard@nod.at,
 vigneshr@ti.com, robh@kernel.org, amit.kumar-mahapatra@amd.com,
 alsa-devel@alsa-project.org, linux-mtd@lists.infradead.org, horms@kernel.org,
 ronald.wahl@raritan.com, bleung@chromium.org, tzungbi@kernel.org,
 groeck@chromium.org, chrome-platform@lists.linux.dev, michal.simek@amd.com,
 jcmvbkbc@gmail.com, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-mediatek@lists.infradead.org, tzimmermann@suse.de, javierm@redhat.com,
 sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 vireshk@kernel.org, rmfrfs@gmail.com, johan@kernel.org, elder@kernel.org,
 greybus-dev@lists.linaro.org, peterhuewe@gmx.de, jarkko@kernel.org,
 jgg@ziepe.ca, linux-integrity@vger.kernel.org, herve.codina@bootlin.com,
 krzysztof.kozlowski@linaro.org, linux-usb@vger.kernel.org, deller@gmx.de,
 dario.binacchi@amarulasolutions.com, kvalo@kernel.org, dmantipov@yandex.ru,
 libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
 corbet@lwn.net, bhelgaas@google.com, james.clark@arm.com,
 linux-doc@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Mark Brown <broonie@kernel.org>:

On Wed,  7 Feb 2024 19:40:14 +0100 you wrote:
> Changes since v2
> (https://lore.kernel.org/linux-spi/cover.1705944943.git.u.kleine-koenig@pengutronix.de):
> 
>  - Drop patch "mtd: rawnand: fsl_elbc: Let .probe retry if local bus is
>    missing" which doesn't belong into this series.
>  - Fix a build failure noticed by the kernel build bot in
>    drivers/spi/spi-au1550.c. (I failed to catch this because this driver
>    is mips only, but not enabled in a mips allmodconfig. That's a bit
>    unfortunate, but not easily fixable.)
>  - Add the Reviewed-by: and Acked-by: tags I received for v2.
> 
> [...]

Here is the summary with links:
  - [v3,15/32] platform/chrome: cros_ec_spi: Follow renaming of SPI "master" to "controller"
    https://git.kernel.org/chrome-platform/c/85ad0ec049a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



