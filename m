Return-Path: <linux-kernel+bounces-124656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EAA891B14
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A231C289370
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC49B16D325;
	Fri, 29 Mar 2024 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sztq18cL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907C6A34B;
	Fri, 29 Mar 2024 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715646; cv=none; b=UQt0+wAi5qccxk+cHI6N/RGu2f/2z9FMf3aWnwf7Gl2EgZX7YHbZyddvuYild86OQvEabIvg7gcA4jNdXU2hXMBjA5gNAYdzQA4UVu9IZGHe5rNcLuf+steLNsCWZaHlUw95DvJYusRIZm1gvGkEpABiDpVSBduYaZ/nJz6WgI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715646; c=relaxed/simple;
	bh=IILtF9tSsWuvGOpEPCx8H2bDnQGM42QHz2TEYyNEtMs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rRBqS5pLoLMSmUJHMaJhmXBPLe4EvFJUJtHoLCjC5+/zV8g6UQSdFUSSdb6MvIUQfKTYpTrXY+f1tmI6/fMrHTBoWXMAF5L+yrfg+K9RdQfRno/MKRPSovRTE/P8Ul+Qw1mWSnLVozgn72LbxIoMpKyhRSCvCLgFJillES+Qm7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sztq18cL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39541C433F1;
	Fri, 29 Mar 2024 12:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715645;
	bh=IILtF9tSsWuvGOpEPCx8H2bDnQGM42QHz2TEYyNEtMs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sztq18cLNMkWSlCr7Tgtuvt2ijOxcVa0KBn9XnbWMmhZbpZpGBO0n2clnMq/+wI/D
	 VZPpkx4ewaXfNtzWS7y4pzccBJIRQzRTf4zuvhjoWiGKdeserypZ+mGNZxZQAoKhKn
	 IiIxlHkabRQeZ7AVww86vGUhjj6DEqy4aeo5cVpaD220EOnS5zSDbMUZVjeZwORcQR
	 b3D6YcVmXmIoxA9jo9bjDWI72LWsbsx0u0ef+DH/xYT3dafi4yi96YhtS6YeJf2dN6
	 ZAUlAp/n8VRxA7Tmn/yQ4et4SK826fapc6XyBiAeS3DlR791XLRudqZf6u52uBuO06
	 SCGbjyXJNuOhg==
From: Mark Brown <broonie@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, 
 devicetree@vger.kernel.org, linux-sound@vger.kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org, 
 robh+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com, 
 YHCHuang@nuvoton.com, KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, 
 SJLIN0@nuvoton.com, scott6986@gmail.com, supercraig0719@gmail.com, 
 dardar923@gmail.com
In-Reply-To: <20240327075755.3410381-1-wtli@nuvoton.com>
References: <20240327075755.3410381-1-wtli@nuvoton.com>
Subject: Re: [PATCH v5 0/2] ASoC: nau8325: Modify driver code and dtschema.
Message-Id: <171171564196.7557.2053181572527484871.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 12:34:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 27 Mar 2024 15:57:53 +0800, Seven Lee wrote:
> Revise properties description and use standard units in dtschema.
> The unit conversion driver based on the attribute must also be
> changed accordingly.
> 
> Change:
> V1 -> V2:
> - Revise the driver description part for the C++ comment.
> - In the nau8325_clkdet_put function, modify the max variable to hard code.
> - Removed "Clock Detection" switch control.
> - modify the "ALC Enable" switch name.
> - Revise the dtschema for "nuvoton,dac-vref".
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
      commit: 2e4c003b3672085267a358ebf82129b4e08dd64f
[2/2] ASoC: nau8325: new driver
      commit: c0a3873b9938bfaa77bd337cad33266a50a6583f

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


