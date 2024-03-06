Return-Path: <linux-kernel+bounces-93959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E9B873784
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15C8280E48
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2841131E32;
	Wed,  6 Mar 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrab2BIH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A97130AEE;
	Wed,  6 Mar 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730791; cv=none; b=Qu1sb8RyuWPkLCqawJGil3bquXVfjHdVMENRqcu92Ya1cn/gNb8LJhbkXbH22Nhb4/SmAPIPJwH16xH8C5Rsf131TcVnvnXweoWgKemWUfbedWAeyZwedhkC/JKWn0xiiFLZlKnkQugIkeGn1ZaMAjf8p0Z52caIcBqSJ5nMoFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730791; c=relaxed/simple;
	bh=yOhwaGsC/lWPIb3ztljvxktWVaALdLmAgQMWRiXDiVQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WvTBVvWhYq0O5t3ldbR1EmXmIq6KHbTh01xUILo6fmpqlAv8Y/YEYlq6wUVy9sa8PzeKoleikBi78z9mqg7GQCsUuxE34paLz2Gzz36oUn4AwIAIWaebrmoV2IZh4o9oH72NM3CIZx9G6iCxPATwIuyH7rGvEPRODEz33w52mTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrab2BIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3036EC433C7;
	Wed,  6 Mar 2024 13:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709730790;
	bh=yOhwaGsC/lWPIb3ztljvxktWVaALdLmAgQMWRiXDiVQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qrab2BIH9agsK+zgozbu3so/KURHltrGzdqamvDwIvpJFy9Kj66mFnj045iQn0Pnv
	 j5qnOiZ303sw3Wb+Wl4Vl1v7J0mqXG775UQd+YC9o3UJxZ6qatn9Q/lCNRzIzv0925
	 ERJZhAgT04FA8cAHXCobdkHRRHG+RdZJHefe4/U6QLQRhw6CqLYP90hs9CHCFh3yLG
	 /t20d3l/aiYHPbSLDB2GfHkJEWTZwsQ60z3jM69ISr3Bls559DNlGU7dBTZQQyHKZJ
	 7HPSRfDpdiEgM3orDT3zluaCrEtmEqdubVbrI/kIYbxUQtNrUAuYReGmHfiOChKzqG
	 IBHcDI/tX146w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240305152131.3424326-1-robh@kernel.org>
References: <20240305152131.3424326-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: nvidia: Fix 'lge' vendor prefix
Message-Id: <170973078551.143235.16133167101955701655.b4-ty@kernel.org>
Date: Wed, 06 Mar 2024 13:13:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 05 Mar 2024 09:21:31 -0600, Rob Herring wrote:
> The documented vendor prefix for LG Electronics is 'lg' not 'lge'. Just
> change the example to 'lg' as there doesn't appear to be any dependency
> on the existing compatible string.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: nvidia: Fix 'lge' vendor prefix
      commit: 482c9f3d42ba58a2ae1f69cbfbf3a9f3e251527d

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


