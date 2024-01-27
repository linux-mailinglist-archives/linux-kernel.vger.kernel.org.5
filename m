Return-Path: <linux-kernel+bounces-40951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD07D83E8B5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CDE1F227E6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127364699;
	Sat, 27 Jan 2024 00:48:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863F257B;
	Sat, 27 Jan 2024 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316491; cv=none; b=mSBt6ovYqVpf6RU3NX07RlxcDq33R/vKJhFD+4mdgcgxp+yOKUlYTKJRP5mhDTVY/TZErBQ9JW8PQqlldaoVAW7jpKgJ1RIMJ/YyJX7SwgvyiqtChZJm1sNMbPi49s76yjeDkUKUM7zBOUxtw4wMGXEwIt7wdNqT5CDnuj0ClQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316491; c=relaxed/simple;
	bh=q8hhvvmpw2PV6L+rCCqDfgDFHm1BwREgChGMZOEGrk4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YjAmnClrWzk+CYVk6BjIwwbofcqVfDrO4vRIUHYMdbmblExwJbnHw3HFrZSZ6pbXEQuTM7j3TQbkyaIMAJvTdW/gYhcPQWwdXOAYsqRCRL6V2XpnNPvnUWgpy4mBSt1gCjuBPewVgnf1+UK/qWgkEqP/H5chbMsfMF9G11wy4e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC7EC433F1;
	Sat, 27 Jan 2024 00:48:10 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 92843106A793; Sat, 27 Jan 2024 01:48:07 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Andrew Davis <afd@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240123163653.384385-1-afd@ti.com>
References: <20240123163653.384385-1-afd@ti.com>
Subject: Re: (subset) [PATCH 00/21] Power supply register with devm
Message-Id: <170631648757.848730.444578841906690483.b4-ty@collabora.com>
Date: Sat, 27 Jan 2024 01:48:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Tue, 23 Jan 2024 10:36:32 -0600, Andrew Davis wrote:
> This is a semi-automated series converting several drivers
> under power/supply over to using devm_power_supply_register().
> The more trivial cases are first, the last 3 drivers needed
> a little pre-work to convert their IIO uses over to devm before
> power_supply_register() could be switched.
> 
> Thanks,
> Andrew
> 
> [...]

Applied, thanks!

[01/21] power: supply: da9030: Use devm_power_supply_register() helper
        commit: 98be59bd03aa50d155ba84208cd964017e397fc9
[02/21] power: supply: da9052: Use devm_power_supply_register() helper
        commit: 57261cda154b3d0f8671ea222672f75b1e965c15
[03/21] power: supply: ds2760: Use devm_power_supply_register() helper
        commit: 88a72257a438375894de446885bb40946e0f979f
[04/21] power: supply: goldfish: Use devm_power_supply_register() helper
        commit: ada63f1ec91b77417cf195dadd646eaadb6f121c
[05/21] power: supply: lp8727: Use devm_power_supply_register() helper
        commit: 3b4d07fdaf17a8bb79173c2c40876d3221edeea4
[06/21] power: supply: lp8788: Use devm_power_supply_register() helper
        commit: 2abb571143c39f581df9951d263948726db42d86
[07/21] power: supply: max14577: Use devm_power_supply_register() helper
        (no commit info)
[10/21] power: supply: pcf50633: Use devm_power_supply_register() helper
        commit: e90a67f618c4a1128c49b11ddec37d9f1728ff5b
[11/21] power: supply: rt5033: Use devm_power_supply_register() helper
        commit: 3a93da231c12bb153224bbbdd3d9a83da9e0ba33
[12/21] power: supply: tps65090: Use devm_power_supply_register() helper
        commit: 503920abb586c3e355a19c680089ff5b33d97262
[13/21] power: supply: wm831x: Use devm_power_supply_register() helper
        commit: f2a7667c6cc09431575a286ec87e823fddd4dd41
[14/21] power: supply: wm831x: Use devm_power_supply_register() helper
        commit: f2a7667c6cc09431575a286ec87e823fddd4dd41
[16/21] power: supply: da9150: Use devm_iio_channel_get() helper
        commit: 9115c677071a09cf51cace59c33ed71ec61bdfec
[17/21] power: supply: da9150: Use devm_power_supply_register() helper
        commit: 077c1df8456f97d89e4880ba503d8ddf6af5be12
[18/21] power: supply: rx51: Use devm_iio_channel_get() helper
        commit: a16dc57e97558dcff7c422b3abec4f9880e8272b
[19/21] power: supply: rx51: Use devm_power_supply_register() helper
        commit: 4cb372a0ca220fff4a3878c4d1239af3e057e7cc
[20/21] power: supply: twl4030_madc: Use devm_iio_channel_get() helper
        commit: 8ac675344280a406835f03746594345209f2c1ae
[21/21] power: supply: twl4030_madc: Use devm_power_supply_register() helper
        commit: 4c5d387d79a65355b73e526cbf5754a9dcd5377b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


