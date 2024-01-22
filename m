Return-Path: <linux-kernel+bounces-34137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F107E837436
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFEE28EFBF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3E347F56;
	Mon, 22 Jan 2024 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESppTKry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870947A7C;
	Mon, 22 Jan 2024 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956259; cv=none; b=oQ9bDrfTZqKmVL/qbh5/uo1ONvhecXhrAw3XBj6d/fazZzG9gPEaqYIWdpoCRDPRuuM3/jO3KhRkT6TwzgCE8W60GElXCeySen4SfK+gY0hKUpRf6EA4a6UHvRPMRS1tu7LtWJhqhO17vIoKH1QHIodeivY/U4gHHwBSu7TbFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956259; c=relaxed/simple;
	bh=lozOmd/cqGod0cy3wd2A6y+CaR5n7riM80HCoDoyZuM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Edu2BK6+O2eWZq4q/O/vsXmLfMj/FXTixAldqo7O3HAQL6abQ+7XZ9LJ5AcvLzWIpOjBJAUdMR1Zc6C3ntn2qvzBpiBv4es0oNlPpMeApa6+z0QEMEFXKkTfTx3cXPyGULPDZWEyizpcu8IqhSp68HZiq6re5vx0oePwTnGFMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESppTKry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49C8C43394;
	Mon, 22 Jan 2024 20:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956259;
	bh=lozOmd/cqGod0cy3wd2A6y+CaR5n7riM80HCoDoyZuM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ESppTKryqkRXLyxvtT1SCiVm+RGydcihr8lSh1lpoHOYJ0qH8j67gaVF1cLOmQCJq
	 fD0aWHqGwuYGGAkbduME5fOHtYMNkz+F0hD90SWaDn83OoPZbbe16t1MCJ5EG2Vc1y
	 +ttFpWsXlLAwHwqK67ozQnSCGuFhSyo7MzLqfOTy8mhTFC+5IvYpZxbs5mkYyep6cD
	 pNhHOOt5NE6WNzrbO42enP5QjlGU5BLbBVq2Nsed3xbh05mjEKF9eN9wA2Ls1JdAtH
	 mAtsaY+qa2rxCeKbXrFlTBm50VbGZ8RycBnE9H0i3StP2Izz0JwihTy0wQRo+E7Y5z
	 s4oD1T1bkCXSQ==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231219-topic-sm8650-upstream-wcd939x-codec-v4-0-1c3bbff2d7ab@linaro.org>
References: <20231219-topic-sm8650-upstream-wcd939x-codec-v4-0-1c3bbff2d7ab@linaro.org>
Subject: Re: [PATCH v4 0/5] ASoC: codecs: add support for WCD939x Codec
Message-Id: <170595625545.145475.5243509079608923207.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 20:44:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 19 Dec 2023 13:45:33 +0100, Neil Armstrong wrote:
> Add the main WCD9390/WCD9395 Audio Codec driver to support:
> - 4 ADC inputs for up to 5 Analog Microphones
> - 4 DMIC inputs for up to 8 Digital Microphones
> - 4 Microphone BIAS
> - Stereo Headphone output
> - Mono EAR output
> - MBHC engine for Headset Detection
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: dt-bindings: qcom,wcd938x: move out common properties
      commit: 166ee0b3bfbb3611579c77fc84e44cd27a0099ef
[2/5] ASoC: dt-bindings: document WCD939x Audio Codec
      commit: edf647d1335fd55c81cdb8cc8cbf1da7d97739df
[3/5] ASoC: codec: wcd-mbhc-v2: add support when connected behind an USB-C audio mux
      commit: 0c105997eefd98603796c4e5890615527578eb04
[4/5] ASoC: codecs: Add WCD939x Soundwire devices driver
      commit: be2af391cea018eaea61f929eaef9394c78faaf2
[5/5] ASoC: codecs: Add WCD939x Codec driver
      commit: 10f514bd172a40b9d03d759678e4711612d671a1

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


