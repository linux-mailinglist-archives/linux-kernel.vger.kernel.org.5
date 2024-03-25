Return-Path: <linux-kernel+bounces-118029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9BB88B2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC05303A76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCD86EB50;
	Mon, 25 Mar 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7vb34R0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9DD6DCE8;
	Mon, 25 Mar 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401822; cv=none; b=Ba3hMMF01IOcDCwNZEm8Q8u+Nakvk3ZnSoBCDDGD7c/+aw+UAKLBuUPut4DuZfbqau2Hg+Ru4XPK3t8kG+QsfvavOuBX+quINlC8bXHRi6fgDRJp5csqzpUU1SQtWlWpwboETj4piwe8QMXhbYPC6/8HkzOqFUNvwFtpiAXo+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401822; c=relaxed/simple;
	bh=5VlNGqcHMvtON5unUlw6MhRhFT/EHB8rh4TeAwp2M0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G52BouEfsbin2rZ8DtYkSCkjEd/unGFdowRx1soTdy/FpoKxDRmUuOBiPwyEfOHzN6Dmjj3/4je48SXzafKTxyMUv2BqVluBrz2kj1RKGs/G2aVFbvTOO4BbWCuPn57iKO2TbCjdsne8NY/Usk2HPjx7AMydyQ7nsSXvqMhY4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7vb34R0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63D3C433F1;
	Mon, 25 Mar 2024 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711401821;
	bh=5VlNGqcHMvtON5unUlw6MhRhFT/EHB8rh4TeAwp2M0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z7vb34R0SjkxZbMxkaCkDhBVQvHg9e2lR2fuM9VeE4g41CkFoIuihNbq7fEapejgK
	 5bbMVFfCljC9GoGQGEMeTuo70SMaMFDOg4FzLCzszuEkrWxw1E3gAdGWuBcu3a04WN
	 bXvltTZdWNIfV3gB5yAFH11NnCJZgWnb66kzQ8+2APZcyWbaVkU/pdIpbCwRM/i0Kk
	 k2kUrKbaBGMT40PliisX7KRw7d2NeQpRA5gHNPa6jKPVwoYsH8mR2cw2dOX0ELv729
	 Byu6Q7Q4krVcmB2FjvmQhM4b+EN0hdo+FanbK7jSVAa+ZsEpvf3dptsOestmeFH6Mu
	 qNtunSaqMxNYQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240322145406.2613256-1-Frank.Li@nxp.com>
References: <20240322145406.2613256-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] ASoC: dt-bindings: fsl-esai: Convert
 fsl,esai.txt to yaml
Message-Id: <171140181939.365050.6118403026272055438.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 21:23:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 22 Mar 2024 10:54:05 -0400, Frank Li wrote:
> Convert fsl,esai.txt to yaml. So DTB_CHECK tools can verify dts file about
> esai part.
> 
> clock-names 'spba' is optional according to description. So minItems of
> clocks and clock-names is 3.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl-esai: Convert fsl,esai.txt to yaml
      commit: 885dd75f41f9fff5b277bc6ab28ad798f98a37b4

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


