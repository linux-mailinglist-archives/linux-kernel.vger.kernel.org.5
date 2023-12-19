Return-Path: <linux-kernel+bounces-5592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652FD818CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199E41F259C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D736AE6;
	Tue, 19 Dec 2023 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrqBKPcq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AAB37146;
	Tue, 19 Dec 2023 16:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F59C433C8;
	Tue, 19 Dec 2023 16:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703004304;
	bh=YshGhGatuu0XiNpZYItbZPJD2MbgKrCUH+6Ej4/eD/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LrqBKPcqgPoV0qNw9Xo+lHKYZoOUYOAmUKMfNh6KDuj+00QqYzBLdqxvNs6FskFUc
	 BuN9r6l24sahQFlvTimo2FJ51ChGu/ommKHG2rTIWurP5haG1wUNICyJC8KTRRqtQp
	 PDogK3syEoY9CAepcBYLEKyH71+pSuBB71y5sRB66HZ/uf85bgKS+rL8GcAp9fzTcw
	 AWeQTOY36Ri42521gdewarHr/75FOqFD9J6RftJ4VZeAnfewjLVB1NEU7jilALNK1u
	 hqoQ07dAnwFuyABDWdWlAJ6cZMJT1yqpQ9Vo4dMmKPyebckGaAsK0HcLsQo4rZJD0r
	 xqErbISMcB4Mw==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231219-topic-sm8x50-upstream-va-macro-bindings-fix-v1-1-ae133886f70e@linaro.org>
References: <20231219-topic-sm8x50-upstream-va-macro-bindings-fix-v1-1-ae133886f70e@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,lpass-va-macro: remove
 spurious contains in if statement
Message-Id: <170300430078.102048.8496688469911862862.b4-ty@kernel.org>
Date: Tue, 19 Dec 2023 16:45:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 19 Dec 2023 14:23:37 +0100, Neil Armstrong wrote:
> Remove this spurious "contains" which causes the bindings check of
> qcom,sm8450-lpass-va-macro compatible to fail with:
> codec@33f0000: clocks: [[156, 57, 1], [156, 102, 1], [156, 103, 1], [156, 70, 1]] is too long
>         from schema $id: http://devicetree.org/schemas/sound/qcom,lpass-va-macro.yaml#
> codec@33f0000: clock-names: ['mclk', 'macro', 'dcodec', 'npl'] is too long
>         from schema $id: http://devicetree.org/schemas/sound/qcom,lpass-va-macro.yaml#
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: qcom,lpass-va-macro: remove spurious contains in if statement
      commit: c13cf1991f4231d38f1c43fcf51ec1cf29c8c82d

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


