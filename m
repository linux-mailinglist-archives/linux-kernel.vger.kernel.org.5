Return-Path: <linux-kernel+bounces-9754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D29D81CABC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED021C20DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1ED199B7;
	Fri, 22 Dec 2023 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+yssT+A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F891A58A;
	Fri, 22 Dec 2023 13:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A28C433C7;
	Fri, 22 Dec 2023 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703251803;
	bh=bm2zdXzlwGhq/KyWBU7GXObLreLaJq6XaJzWB5qnCeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u+yssT+AWXSrzdr6x+7JTVYh/Pf4NMd00s/NNGQsTvOD/k6WwYN3RNiUp77ZcXxaA
	 lKrOLIV/vypCjwo77Q/4+9aXFAvhVv0cRwSM4Wlj558V+XL7uQe/nbBKsXsyvHuqqf
	 mTHf8FjsP9HWRNFNsLTkqxpGLOPnGXVsT6veudvN2enl1Caa6sqQtBOCub2YkTC0MF
	 FQxe+dNLrhSqd8CMFMsMjUZQUXvTuheWwTW23mT+1f3henKNrtLykC1cYgd2CvlDGV
	 Z8pUkDgV3uo5YYteGcfrbfaZLLSXAWUYQKr4wOQgDnKpeJZqPIiNZtHoDiXlrPbXJL
	 m4mSKlznupMIw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Erwan Leray <erwan.leray@foss.st.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231218155721.359198-1-alain.volmat@foss.st.com>
References: <20231218155721.359198-1-alain.volmat@foss.st.com>
Subject: Re: (subset) [PATCH 0/6] spi: stm32: add support for stm32mp25
Message-Id: <170325180035.61341.901936375661515103.b4-ty@kernel.org>
Date: Fri, 22 Dec 2023 13:30:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 18 Dec 2023 16:57:12 +0100, Alain Volmat wrote:
> This series adds support for spi bus found on the stm32mp25 and add
> all instances within device-trees.
> 
> Alain Volmat (4):
>   spi: stm32: use dma_get_slave_caps prior to configuring dma channel
>   arm64: dts: st: add all 8 spi nodes on stm32mp251
>   arm64: dts: st: add spi3/spi8 pins for stm32mp25
>   arm64: dts: st: add spi3 / spi8 properties on stm32mp257f-ev1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: stm32: use dma_get_slave_caps prior to configuring dma channel
      commit: 6f98f25247b7ef03fb89030a3af6c0eb08132104
[2/6] dt-bindings: spi: stm32: add st,stm32mp25-spi compatible
      commit: f034a151059a84cecaae68f5a72ee5d815e94625
[3/6] spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc
      commit: f6cd66231aa58599526584ff4df1bdde8d86eac8

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


