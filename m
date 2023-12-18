Return-Path: <linux-kernel+bounces-4166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DBE8178B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793FB1F23A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F685A853;
	Mon, 18 Dec 2023 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu1JCP57"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC815A878;
	Mon, 18 Dec 2023 17:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1036C433CA;
	Mon, 18 Dec 2023 17:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702920504;
	bh=71aBY2g687fY1ei3QKJuZYPBscgOTCn59XxQrrVnxZs=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Zu1JCP57xJMRG3pv/d+TTgL+/yuPxRnh8osA9xj3XEhlp+Uzcj+L69pZ/j9TzgHQl
	 UYDy1gonb7tV1tZxBi7Ck3bTPTEVs1XbsyeNNOAZ8Ht7CaiGFr+0jdwoNs8VlqyS/0
	 TMtB3nqLDx9rkAwlTmtpvGuCxZP68g5pVxHdaIBpppWj5fn1LWKetkDNO1uxT296KL
	 aUqn9bhsZFioPg2APmY5eT+fZ2/+ThYzJx+LMUehJQmisncDzuBCSruVTKpyq1dsZJ
	 J0cTfGMmtyVMsgpD21TvPi9joGBw1Ol+ePBV5MfW55WuX0mwdvesXZwwxMZPwK3fZP
	 Bkr+LBxwyKO4g==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231204100116.211898-1-krzysztof.kozlowski@linaro.org>
References: <20231204100116.211898-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: qcom: Add x1e80100 sound machine driver
Message-Id: <170292050070.89121.1154893046353970509.b4-ty@kernel.org>
Date: Mon, 18 Dec 2023 17:28:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 04 Dec 2023 11:01:15 +0100, Krzysztof Kozlowski wrote:
> Add sound machine driver for the soundcards on Qualcomm X1E80100 SoC,
> supporting up to four channel audio playback over Soundwire bus.  The
> driver is based on existing sc8280xp.c driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: Add x1e80100 sound machine driver
      commit: 6b9dc2da66578acff36401ba87fee93c2abf2a6e
[2/2] ASoC: dt-bindings: qcom,sm8250: Add X1E80100 sound card
      commit: 337d93b4285a92280edd7d0a910c3b7cbc70d717

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


