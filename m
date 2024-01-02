Return-Path: <linux-kernel+bounces-14669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ABB822085
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865651C226AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C56156F7;
	Tue,  2 Jan 2024 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6fbfPPs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7E154AF;
	Tue,  2 Jan 2024 17:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EE3FC433C8;
	Tue,  2 Jan 2024 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704217253;
	bh=mx0UU3WfKxc1FkUQRkEoQjqspsD2Wn4DLF/ciceKu5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o6fbfPPsVjnOZBfLuTngotOd8uBYySvgdIBmNvKr6S3vSZaCIJELacF6tNK+HBqpI
	 T3C/IEaamIzSD1pBFattiIPwul7EsDsNzbnMv4nmVk1J50ZZ61rVMukmdSQ0lSI8lx
	 vz1X9vutwP0x9wJj6Grgcqxeb27Mh/wn3HhQTbwwRhlBGEinUuFSJ654DGz7SSUXEO
	 5cK1niUNSceqB/0Jvdgec4BtPb4hg9PrlPnrG3id3b94y2NUEn+vFRmbSWrgxZPVyc
	 mPXwqtrHojuIeT4hm5Vnx8wEJM4+39hGWmZFqIpROsgzOjBq71psBfzavcdBEsWPRE
	 mxm2Mw7qzmUJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55EB7DCB6D1;
	Tue,  2 Jan 2024 17:40:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170421725334.27590.14473748225344409245.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 17:40:53 +0000
References: <20231227101003.10534-1-johan+linaro@kernel.org>
In-Reply-To: <20231227101003.10534-1-johan+linaro@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, mrman@mrman314.tech

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Dec 2023 11:10:03 +0100 you wrote:
> A recent commit restored the original (and still documented) semantics
> for the HCI_QUIRK_USE_BDADDR_PROPERTY quirk so that the device address
> is considered invalid unless an address is provided by firmware.
> 
> This specifically means that this flag must only be set for devices with
> invalid addresses, but the Broadcom BCM4377 driver has so far been
> setting this flag unconditionally.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid
    https://git.kernel.org/bluetooth/bluetooth-next/c/cceb1ba62823

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



