Return-Path: <linux-kernel+bounces-76681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C1985FAF0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD89286F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF5614691D;
	Thu, 22 Feb 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh1IaErF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97D3A8E4;
	Thu, 22 Feb 2024 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611514; cv=none; b=D0vCT2XYOioQEGvaMiJFqILU2cjUfh19IwkfrMQF20/87kaSghk9BitmeDAbiAzZ2XOo8dnnpzSZaa5OGphkbU4mBYztPMkCPMqIF9jE4Tph4RQ7I9/+NjyyhxLxJkybPboCT50m5KKYgX/6FL39qNdAbuRPfBoEWNtUwOUhdqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611514; c=relaxed/simple;
	bh=4sH5v+ZMdGS+5cx2T7gwpvtfeWvziYaZFTJijfU8mjk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gEbIjJGZhX+6F6e3bHQrnWTqVwVdcQ3LUQtLsGpqJzzp4hk1t99p/48HpR1rM0DpKDvh36WsDrphJVO5C32KVte1IvbJ5gdoKngSZbtsJW3Lkeh8oS7naMroNDHwvZAkuXqM4FtnH741cmGyLJqZu6+qaRzJKbCZFOEd1GK2ihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh1IaErF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B867C433C7;
	Thu, 22 Feb 2024 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708611514;
	bh=4sH5v+ZMdGS+5cx2T7gwpvtfeWvziYaZFTJijfU8mjk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dh1IaErFQC3KZAaCSr9t1s2CAI5kwufOviIScCh4ZLJOOdjVGpX9typAdLVEnw+p0
	 T5tPoee/asNdT/VU59PB6ryjkh10ypmIBJLvts02AH825jUX8d7DQcZCGZJLSgNqqm
	 VlqqCMEDGM2+qmZw+bJ9PJWKAkTh7RvN5cd2O20drx2KSYimF5hN+8Sb1kDttRzzML
	 BB6PyU8dhh9P0po4lZKmncGxTWE6UN5ttxlHFN+S3pJ5OfWmLRuC7PWffx68bcu/M7
	 R7HVnzBOefDyGr7qPoImbqEeBHZM5kExV+b12Ff0898Zclt2seT0FXL9DXxgFMpXkJ
	 FPNkLBQXODXXw==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Frank Rowand <frowand.list@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v6 0/6] reset: gpio: ASoC: shared GPIO resets
Message-Id: <170861150977.56623.15929903004855832989.b4-ty@kernel.org>
Date: Thu, 22 Feb 2024 14:18:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 29 Jan 2024 12:52:10 +0100, Krzysztof Kozlowski wrote:
> Dependencies / Merging
> ======================
> 1. Depends on !GPIOLIB stub:
>    https://lore.kernel.org/all/20240125081601.118051-3-krzysztof.kozlowski@linaro.org/
> 
> 2. Patch #2 (cpufreq: do not open-code of_phandle_args_equal()) and patch #4
>    (reset: Instantiate reset GPIO controller for shared reset-gpios) depend on OF
>    change (patch #1).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[5/6] ASoC: dt-bindings: qcom,wsa8840: Add reset-gpios for shared line
      commit: 26c8a435fce6ef8d1dea39cc52b15cf36c7e986b
[6/6] ASoC: codecs: wsa884x: Allow sharing reset GPIO
      commit: 0dae534c48239be0a99092e46e1baade0cf3e04a

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


