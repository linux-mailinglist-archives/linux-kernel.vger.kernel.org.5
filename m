Return-Path: <linux-kernel+bounces-116405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC8889662
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFD929B980
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7992146590;
	Mon, 25 Mar 2024 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHuXb0gn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E14153566;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332789; cv=none; b=gO5tC6JN+wkEVuRI3CJP48UneLeo9zqcd44CBJSoRxZhNc4KS2OKorqIA/fatwS0rDcfQkHG01cTpTbgcFgmBQq45PlfVMQh/5uYX1CWX/bWNqhuLG/qEG8PfGdOKrT1Xh5qtTPtzHgxndzL64JDvH8ILZIlixVaanCWplnLIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332789; c=relaxed/simple;
	bh=MZnsBg6kd6EgY31Xfo3r2efSeJzcGFTikmm5cMaNdW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EZZxESDDL9+eUBelZRcxe9MC7Jf5VmCgcEI5d+ukLoEr/wM+DlbvWVFuCvuim5dZFJnFyzqjaeYh80nbUKIoMWcCLfI3eE5z5bVLfXPJKKynOLUIi5c+iyHU4jn901QV+g/Wx0fSyV3cA3EV4jvH8rOnZ0UTuf5pPP7fjpfWivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHuXb0gn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88787C43330;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711332787;
	bh=MZnsBg6kd6EgY31Xfo3r2efSeJzcGFTikmm5cMaNdW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UHuXb0gn8ME3oLxnbcGZw/hvAvm3EfiLqfib6Xdv5Zb9+y4gxhJF5pue6Uu+KGrkV
	 wXj6cQaBf21G9A0P9TPtlgvH7OsdTGBel/cD8PMOCPbw+rulqlxU20f6ccfU2L12Mf
	 IAcy1muYwbg+hNeSWoTP2aBkN9V/jZhCB2zlhRfGXTOFlUNQ87UmlKUNfwCW0WC37C
	 NER5RJ9cL1s1lpb4sDf9G214uD1PTr1ZWuSASQyOw4WVhDJJXj1WfulxJOVHqeZY64
	 +KxcCr9qVM6E8jnp+xggnuN214zxq8BH8knav36O4YF7PjJARdTUZdGx+31qDt0+8O
	 N7gbuMRdReg4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CD16D2D0E5;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] Allow coreboot modules to autoload and enable cbmem
 in the arm64 defconfig
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171133278744.9916.4500686862665628115.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 02:13:07 +0000
References: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>
In-Reply-To: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>
To: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado_=3Cnfraprado=40collabora=2Ecom?=@codeaurora.org,
	=?utf-8?q?=3E?=@codeaurora.org
Cc: tzungbi@kernel.org, arnd@arndb.de, briannorris@chromium.org,
 jwerner@chromium.org, masahiroy@kernel.org, nathan@kernel.org,
 nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
 angelogioacchino.delregno@collabora.com, andriy.shevchenko@linux.intel.com,
 gregkh@linuxfoundation.org, kernel@collabora.com,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Mon, 12 Feb 2024 09:50:04 -0500 you wrote:
> This series adds the missing pieces to the coreboot bus and the module
> alias generation to allow coreboot modules to be automatically loaded
> when matching devices are detected.
> 
> The configs for cbmem coreboot entries are then enabled in the arm64
> defconfig, as modules, to allow reading logs from coreboot on arm64
> Chromebooks, which is useful for debugging the boot process.
> 
> [...]

Here is the summary with links:
  - [v4,1/4] firmware: coreboot: Generate modalias uevent for devices
    https://git.kernel.org/chrome-platform/c/c2b28f6806d2
  - [v4,2/4] firmware: coreboot: Generate aliases for coreboot modules
    https://git.kernel.org/chrome-platform/c/f1cebae1dbf8
  - [v4,3/4] firmware: coreboot: Replace tag with id table in driver struct
    https://git.kernel.org/chrome-platform/c/8a0a62941a04
  - [v4,4/4] arm64: defconfig: Enable support for cbmem entries in the coreboot table
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



