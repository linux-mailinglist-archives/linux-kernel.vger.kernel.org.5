Return-Path: <linux-kernel+bounces-142597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229948A2D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4D81F21867
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762E05579A;
	Fri, 12 Apr 2024 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/8FyDl0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9DE54F89;
	Fri, 12 Apr 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921793; cv=none; b=gdi2FHcb0Xysgn2nZJigvS1wvGB7uRpYtGx/z0aEtum1PEx6G11w2mG73JXI6Vlp8nfyqFO3QpRYqiSJ6o/WedfNE/zM4THIZ53xP60bMoCNTxDrlrwuzyoIi8HHSz3SIl7iX6ZaVaoiltVal/IRb2mpJXkmlqM0k5PR/17gWjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921793; c=relaxed/simple;
	bh=X7YXdle+xzTQt5DxzkCl6jE9JUBpdqUfFKAflv6dxmg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lyJAV+6mBAFnN5HhJHwU9nmsIzG5QzfnkO8njZ0aITNDKstk+wGURkB6oYqS5PwGXpKqnWhyKL8xL7K5vy0+7kNb5xYEGS8qLMBh4LC9ypmD2DjQeY1gih4+gUGxd7EN5pzr8BrQV6P65r67V3Ept2egnFTqCZXyBXX9QDy1TAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/8FyDl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A5BC113CC;
	Fri, 12 Apr 2024 11:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712921793;
	bh=X7YXdle+xzTQt5DxzkCl6jE9JUBpdqUfFKAflv6dxmg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=G/8FyDl0t6ngV1ufuRgKrSPBj4qoubXyHbyQoBQhVgie44vCIUjl5/LF4VFpURqcX
	 S0HQJ6WK9v/gJfGmd6oI1jRTVDwuWkjj6226oOPpdM5Nn7OB0HfLA5FOYy5eRZyLP3
	 xhe5pWIdzsauPERMWmQrSQTaJb3mfnQOhlMWPpy8bMB64MdmnxXmvTqrbnMOaCYSQd
	 j/wOXmnqNiKIw/z6cR4aaCa2dNunJvQnyvk/DKc6wyNUhXqXbNw4eSozNBJ69XERMt
	 OdpW8n7L/Uli1brqf7Ag39YggoaP13Q/WaYJK8qMwt7ij/BiGegW1Bvq2RLtbwN1nV
	 VQxqwcQbDU7dw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 shengjiu.wang@gmail.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1712830305-31350-1-git-send-email-shengjiu.wang@nxp.com>
References: <1712830305-31350-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: (subset) [PATCH v4 0/2] convert imx-audio-spdif.txt to YAML
Message-Id: <171292179033.6945.14805873606442129337.b4-ty@kernel.org>
Date: Fri, 12 Apr 2024 12:36:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 11 Apr 2024 18:11:43 +0800, Shengjiu Wang wrote:
> convert imx-audio-spdif.txt to YAML
> 
> changes in v4:
> - change the enmu to const
> - add more comments in commit message for second patch
> 
> changes in v3:
> - change file name to fsl,imx-audio-spdif.yaml
> - change example name back to sound-spdif
> - exchange the fallback and specific compatible string
> - update anyOf content
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: imx-audio-spdif: convert to YAML
      commit: 62bef5df35a87d0f8464b1a8837540988cfaf5db

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


