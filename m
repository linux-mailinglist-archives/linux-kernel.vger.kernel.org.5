Return-Path: <linux-kernel+bounces-5767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36514818F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C76B25F64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870DF37D16;
	Tue, 19 Dec 2023 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0x1jHOM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1F37870;
	Tue, 19 Dec 2023 18:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC1EC433C8;
	Tue, 19 Dec 2023 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703009199;
	bh=2AlFxLi7oJh7Wa2NVO96A7tL3W01cNMV+NcW1zh9qDM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n0x1jHOM5g1uy9hxI58NgHZwTsQEJjCGuV3K/cBxMRRFgUyHp/TndRdTCsbAlSNud
	 F2fV1NFM8jwNWonTXby5r/bEyKmcc4qTFXE6RhHQRHe7k2Wfa9u4snAogXXEoU2sbQ
	 jULiZXGkQ1uzOzqf7Nol9zwJ9O/8EFhmdGcgUFSqeAVv26irpJ62lzFHFo/wTJe/a9
	 g59D7OcAyl+B+YvhpMbR+WqGwmRYWEnS1J/R56kDJuWceOcFJvomejes37rlEZxYYu
	 i38C2M1kPKzrR6OG+/hbCSczVKLbDAOqgR89+V2tkvMzeJ4XDtIukGdjfBif5LmLQk
	 o5V3yMKRvh5SA==
From: Mark Brown <broonie@kernel.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231212-topic-sm8650-upstream-snd-card-v1-0-fbfc38471204@linaro.org>
References: <20231212-topic-sm8650-upstream-snd-card-v1-0-fbfc38471204@linaro.org>
Subject: Re: [PATCH 0/2] ASoC: qcom: add sound card support for SM8650
Message-Id: <170300919611.125466.12203726463843347252.b4-ty@kernel.org>
Date: Tue, 19 Dec 2023 18:06:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 12 Dec 2023 09:08:18 +0100, Neil Armstrong wrote:
> Document the SM8650 sound card using the SM8450 fallback
> and add the SM8650 compatible to the sc8280xp sound card
> driver to use the sm8650 card driver_name like SM8450 & SM8550.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: qcom,sm8250: document SM8650 sound card
      commit: 773df207fdd6e17d7a43abf83ea155ade9a95f79
[2/2] ASoC: qcom: sc8280xp: Add support for SM8650
      commit: 7211094dd065908747a143f9adeff41cfdcf37c0

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


