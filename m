Return-Path: <linux-kernel+bounces-128719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE89C895E9B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CDEB26BFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5BA15E5BF;
	Tue,  2 Apr 2024 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVPJSl8v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3415E1F9;
	Tue,  2 Apr 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092753; cv=none; b=BeyxdpQqmJkVzdO0l9HhyCynXhAwpd+B31DVSm5/E1psZ8EJAj79iltjKK2+D9WDATUhOEgu9SMKu6l35/IvCPqj+h8GOIYTU9dWXRJN8PhuCpyOQrUiM1j996218P+VehOm2Jsnrw+kyZNH9O/AnlYifMB1ByISLrG7eXDDRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092753; c=relaxed/simple;
	bh=QXVrWT4sxWYAXoce45NeFHniylOx/vOwE7xWnCnJBBw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=USvCQUnIFviSV3feenrp/zh32NxfaPSE4OMkwWY0Asn4WrElmUa6NyId3r43Zez3vc9XkB76Tqt5gtGzgFI7Khjdr/AOsqAt8/elVQjw93wlxqsS/m3T3bKU1USI0CeyxHAZieUIlZiY4E0oUQkv0V9VxOMiV1yVjb5EkXHgsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVPJSl8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FA6C433F1;
	Tue,  2 Apr 2024 21:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712092753;
	bh=QXVrWT4sxWYAXoce45NeFHniylOx/vOwE7xWnCnJBBw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=HVPJSl8v8suOYXGSagYAS12EA/xAp5XMdBVeEL3bs7WSiBJdQow0GPthrzIuprDef
	 eVWaqKu5RVxhdOrgySfsOqGi8tyl+XJgnVfihWzd60nfm6y81P3RcGjflR6u7O085S
	 WUFXumKISAyGdwYTSg7anOZ2FYY+Sk4NLL5yFfeA65jYr6VTRNi37QyhX8fliEMvk4
	 ulTikFNnB/ght/ukngzXTe08ReRFo6tKwI51grhvUBsiFXp0h5vu1YIePtpo6/a6qD
	 xl5Ylx1TdCt8Tw5+Vdf7YcEqYnvMhSOU41BuYdURgmZtd5sdmYWZgvqIfM63oAfMnU
	 k7qTQ1p/AnZqw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 shengjiu.wang@gmail.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1711976056-19884-1-git-send-email-shengjiu.wang@nxp.com>
References: <1711976056-19884-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: (subset) [PATCH v2 0/2] ASoC: dt-bindings: convert
 fsl-asoc-card.txt to YAML
Message-Id: <171209275013.212774.10957892545109249722.b4-ty@kernel.org>
Date: Tue, 02 Apr 2024 22:19:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 01 Apr 2024 20:54:14 +0800, Shengjiu Wang wrote:
> Convert fsl-asoc-card.txt to YAML. In order to pass the checking,
> add some used compatible string from devicetree.
> 
> change cpu-dai in imx6sx-nitrogen6sx to ssi-controller.
> 
> changes in v2:
> - update commit message for reason why add compatible strings
>   which are not in txt file.
> - add deprecated
> - add $ref for bitclock-master and others.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASoC: dt-bindings: fsl-asoc-card: convert to YAML
      commit: 4189b54220e5af15e948a48524b45d5ea2e5660d

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


