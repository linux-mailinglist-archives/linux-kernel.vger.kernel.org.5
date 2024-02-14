Return-Path: <linux-kernel+bounces-64616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E298540E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D44AB23BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A6A566D;
	Wed, 14 Feb 2024 00:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgUr3yJ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889833EA;
	Wed, 14 Feb 2024 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707871743; cv=none; b=qz3axP9D8z/16vVYA/5+Tqi8/8EnmutkpPE1mmbwUAjDXUvyQsClgOVBEV3TduW6CVydgrpCpbGFzo/JG8yM3ALuvyA95+5hlfdCZtNhnOOYiatX+dVWlLfscqS28Ng9HZTU6+VixbczDlSdxmRakdcPbUAq5ldntD0+9pJGZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707871743; c=relaxed/simple;
	bh=bqe9jQrUoDdk/Q2n/ceHUg/SnRN77bKJ73bZuPyGZYU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YdpVq/YtskjoJJPXmWfsWsRa/i/oVI5+4lF0J4OAn3RqUrJ9VGxlc1cNgYENXa1bf8p6MxqXFOi5HMkBrGJKsoMjOjsxb18KTyp9N5+zJjltwAyzkwvh+X+fe5byB5FHO7ZCn9cYWZ3VoXh8V1hyXHtB5tcewnJMZRN1a2cyrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgUr3yJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1592C43390;
	Wed, 14 Feb 2024 00:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707871743;
	bh=bqe9jQrUoDdk/Q2n/ceHUg/SnRN77bKJ73bZuPyGZYU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=GgUr3yJ4U6Hmjwoil6RyQf+rgVx/R3N/7iDECVMYOWiENhN54v49OWckW219dPWl/
	 /RILUeunWgxy1r+MkkNotg5ItqmqdhbvTW5wcAcXGeDZgCw59cX1n5Vo0Gkqk+NqRi
	 6UPGwVbMmYAA/wQ5hUKOndl5f/8mPQPpu4KJgGdKDkiEjq0iqLh/N06UQC+vNz9f4Y
	 k1Ow0EunL5uS1NM6CoXQLSX3o0na4XT/fDRMBuXzdhJzyu9tX8EP8fpD2KP9MMdmmx
	 7d/CZC8sMN95fg6fQmekagrNwPaQC+MelMt40Q2/Mp8W8JscWuxz2NQV3BRTrpJr8F
	 SWiZPvs4N0WbQ==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240202154134.66967-1-krzysztof.kozlowski@linaro.org>
References: <20240202154134.66967-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 0/3] ASoC: codecs: qcom: tx-macro: minor cleanups
Message-Id: <170787174139.1088332.990817006837500918.b4-ty@kernel.org>
Date: Wed, 14 Feb 2024 00:49:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 02 Feb 2024 16:41:31 +0100, Krzysztof Kozlowski wrote:
> Few minor cleanups.  The series will conflict with my series:
> https://lore.kernel.org/alsa-devel/20240129143534.109196-1-krzysztof.kozlowski@linaro.org/T/#t
> 
> Depending what will come in first, I will rebase the other patchset.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: codecs: tx-macro: Drop unimplemented DMIC clock divider
      commit: 58cef044e6ec88eef6f10565df8257138e2085ec
[2/3] ASoC: codecs: tx-macro: Mark AMIC control registers as volatile
      commit: b396071681ca65e66f2a8fce240cde26a6db5931
[3/3] ASoC: codecs: tx-macro: Simplify setting AMIC control
      commit: fd236653ab60bf64fde341ed9c940c04a542483a

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


