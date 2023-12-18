Return-Path: <linux-kernel+bounces-4165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF7F8178AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5AFB23F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D3C71462;
	Mon, 18 Dec 2023 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGlPs1+k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007DB71446;
	Mon, 18 Dec 2023 17:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAABCC433C8;
	Mon, 18 Dec 2023 17:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702920500;
	bh=ssje5mv7upVQ96o7uXeJAzq1j9BE6IUQtrK1PRZCG5Y=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=eGlPs1+ktHN6oG9y0Np861Q4lICVrT9YkHXCludPwq+gBypEckXRTFyEiAnCXNe5V
	 UPfw3yGWiXkdQQy9/0v2367tm5Q7M4S0sYK/R1ovBIJgKMnNgvvgUMJPX1NvZQRI/a
	 en9QPpr53gQAnMYLZHO4uEoKNBpnED7F7Y67hi33eaIQ0CvXE7QcATtIR9d3rUuvrB
	 IPNY1Z+pLXdHZ3K1xd92X0lFZdnJ/mtJ+4yaRGh6bVFYdmWnQNeE9QY+I/WllUVorK
	 muFG7fubBi6LNM6z5kBHJt5oqDcEbc945In6g/9fjJGrfIeR/z2XMdovM7znikcLhN
	 t/1huMIp4COGg==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231204100048.211800-1-krzysztof.kozlowski@linaro.org>
References: <20231204100048.211800-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: Fix trivial code style issues
Message-Id: <170292049849.89121.10011961339428732958.b4-ty@kernel.org>
Date: Mon, 18 Dec 2023 17:28:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 04 Dec 2023 11:00:48 +0100, Krzysztof Kozlowski wrote:
> Fix few trivial code style issues, pointed out by checkpatch, so they do
> not get copied to new code (when old code is used as template):
> 
>   WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
>   WARNING: function definition argument 'struct platform_device *' should also have an identifier name
>   ERROR: code indent should use tabs where possible
>   WARNING: please, no spaces at the start of a line
>   WARNING: Missing a blank line after declarations
>   WARNING: unnecessary whitespace before a quoted newline
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Fix trivial code style issues
      commit: bb3392453d3ba44e60b85381e3bfa3c551a44e5d

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


