Return-Path: <linux-kernel+bounces-164164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652568B7A10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD791C22BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33FB17A93E;
	Tue, 30 Apr 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On+hvumZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5341A38C3;
	Tue, 30 Apr 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487500; cv=none; b=X0KETe4nPz1a/BeFNLgKzf2tAkxipKVrDps5mgJvceXVSkAH3EBxShIYz2UR3M/nr3OZ91ShK9U2S0YXb+A5UNrDlHDLitiN9dcdlOCdkiePzqhMu7psoCKMsdeZyWEjEW/DQWqq+FMqaLOOdkVddyckWOAduDtjrdkAJTwvmdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487500; c=relaxed/simple;
	bh=HNbDuaW8oEBQ64Jwa1SAb+ct56UECAT4LCJMhkAgEkg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fNP2HIvcFvt2mPO0eW5u7x/Gm17XK9URNem7dZybGBHEAe8nRuFuCipt7GQFZ+vJH5z1ixamyy8o2ma0EwY9xBQoZP44zMqGEfsC01P2ODGBoVA9Yd1QQUkEocGj+bKrOthY+NW5OAvH4RTq4497EPwp2n8mr/gIOoIRgO3ohEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On+hvumZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F498C2BBFC;
	Tue, 30 Apr 2024 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714487499;
	bh=HNbDuaW8oEBQ64Jwa1SAb+ct56UECAT4LCJMhkAgEkg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=On+hvumZtL6lpnFCDWC4MieupvYouOMRTjPStureRgJPbvqcIje8+eADPGlKfj9+3
	 NsuBKV56kErxT31XIqBo0a6+zyWVPplY1ZlOAMZWsJWOZiKuq/dRflNEswgPs/j0oW
	 AoXZvAQwz/55mLEbQ+bcKlEqKpixaYGaanxz+/xL+6+cyZk/eO2M5wcbu5LgV1ZWMu
	 9W2U3gqZLsQOtyZEW7IoTMbCXuD8Zh4LjCCMHeNcwMRyFoCpDSI9ACj+Vscn4u1oQJ
	 hWqi9/DbvbSetf3bO3AhNYslRIGeE4bqb15bHMWylosHox9l1YOG2hPYMfgnpme3Pd
	 /il60Gmk7Fmrg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240426170322.36273-1-sheharyaar48@gmail.com>
References: <20240426170322.36273-1-sheharyaar48@gmail.com>
Subject: Re: [PATCH v5] ASoC: dt-bindings: tegra30-i2s: convert to dt
 schema
Message-Id: <171448749697.1870439.10977766992919745808.b4-ty@kernel.org>
Date: Tue, 30 Apr 2024 23:31:36 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 26 Apr 2024 22:33:18 +0530, Mohammad Shehar Yaar Tausif wrote:
> Convert NVIDIA Tegra30 I2S binding to DT schema and
> add "clock-names" property used by multiple tegra i2s blocks
> in arch/arm64/boot/dts/nvidia/tegra132.dtsi. This is not a
> required property by the binding.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: tegra30-i2s: convert to dt schema
      commit: 4a1baeefd1d5a955b5a55a75539244e03e623b0b

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


