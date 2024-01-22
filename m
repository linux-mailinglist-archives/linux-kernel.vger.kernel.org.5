Return-Path: <linux-kernel+bounces-34138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8DF837439
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C62BB24FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A8C47773;
	Mon, 22 Jan 2024 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWvoqp4K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72047F6F;
	Mon, 22 Jan 2024 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956263; cv=none; b=O97qIVpY5Xg7+5NJsibKz4FEd8osyZhyDpRmSfAcREDiQ6DWAj8ByoKbM60kpDSkE+N0GoOsl/hx4dH1JRoHi0Ol6BwD11e6bTdVlCR4zoZQOU6h2OmiLUQfY43SI0mGecyELwF4IvKSqdZbyreiD8yxGSjA5ICic/lTLQpAKHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956263; c=relaxed/simple;
	bh=jHahJBNOqmpxsRa3jIC+1XUQhYkCmY2XrppesnzXsns=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TXrNxt6j5dyZUbYbff7gWhFLRs1COjmxhGYDoik4G0KvNuP4d+nyZyTcmdw35Vibx44i07dtzZ2LI80pcl8/dkP3+gaNSkPhtGtVM46+3zuRvwANVkHojveAKv8TFxmDTzMD8T0h+9NAcegQEv80WviINSH8vhMne2OAyXYgci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWvoqp4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF45C43390;
	Mon, 22 Jan 2024 20:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956262;
	bh=jHahJBNOqmpxsRa3jIC+1XUQhYkCmY2XrppesnzXsns=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=PWvoqp4K/BSNf38aC031IAIAGvnawluui5ppROC72eOoP60pdyF1a1GwutIp0XJun
	 QhmRWGJjkX7a0NYQQL8DLh+Ia5f5+X8L8ctO9WaZ8uIG215wxpE27CvYw4EilCUN3L
	 E9H+xcKGmq32P79671o0+eXHdOm3vVIi5pIenMcYURyq0Q4soYwq5Hjuw43lRjz0Rw
	 EjR3S5UQr9grqDMROnI3/eegu7gSW3xG5eqL1XGUnbbAyOYK6wOdiUfCEhCcdaybKt
	 IDqTL3GZe4+rY7rbVlbXEJ3VTQenQ12EPtMjRjav90PSAkruylijxR3Epy0W2AxU3H
	 tV+SWwIVLeu7g==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linuxppc-dev@lists.ozlabs.org, Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20240112054331.3244104-1-chancel.liu@nxp.com>
References: <20240112054331.3244104-1-chancel.liu@nxp.com>
Subject: Re: [PATCH v2 0/3] ASoC: Support SAI and MICFIL on i.MX95 platform
Message-Id: <170595625937.145475.18065779265515755326.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 20:44:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Fri, 12 Jan 2024 14:43:28 +0900, Chancel Liu wrote:
> Support SAI and MICFIL on i.MX95 platform
> 
> changes in v2
> - Remove unnecessary "item" in fsl,micfil.yaml
> - Don't change alphabetical order in fsl,sai.yaml
> 
> Chancel Liu (3):
>   ASoC: dt-bindings: fsl,sai: Add compatible string for i.MX95 platform
>   ASoC: fsl_sai: Add support for i.MX95 platform
>   ASoC: dt-bindings: fsl,micfil: Add compatible string for i.MX95
>     platform
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: fsl,sai: Add compatible string for i.MX95 platform
      commit: 52523f70fdf9b2cb0bfd1999eba4aa3a30b04fa6
[2/3] ASoC: fsl_sai: Add support for i.MX95 platform
      commit: 2f2d78e2c29347a96268f6f34092538b307ed056
[3/3] ASoC: dt-bindings: fsl,micfil: Add compatible string for i.MX95 platform
      commit: 20d2719937cf439602566a8f041d3208274abc01

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


