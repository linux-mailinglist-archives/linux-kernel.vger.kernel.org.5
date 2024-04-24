Return-Path: <linux-kernel+bounces-157032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653E68B0BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D91B28E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05C615E5CC;
	Wed, 24 Apr 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ix6QGTVr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3601315D5D8;
	Wed, 24 Apr 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967343; cv=none; b=m1sMDPxN9qYqy4cyhj/rx5qxTzjtm2TiEdu6b/9IpFsld5Wou4iNU+0oWxQtm4St6WJXrsLOd82BSdPd4EZI9uwfy9DJlHLr2wavIhlHZpBvJZdy9CCd4j1W5+bfOc7nOBn2uvxyEv6DdrBN/V5Wm8tUsGNbiZEVOIO6DskT5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967343; c=relaxed/simple;
	bh=Fh5MCAn/CD6jBI814D1jnEu75NoL8cNXPO4vwBfUu/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZLuYbiBFEV7TBRCG9af+ZSANDdZuVvA9mZsKK+XJiPJya6ymYufQx1Lw2wVr/74HPzCYC4+00gRDwQiI1kWQJCzhZBJz/P6CmI1Oon/puW3X+qx/hx3s8U/6WDNn1ednxq32JMtxExZ9tJpzXKAw6yQbf0+f66Zvv3+1GYrhZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ix6QGTVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D00FC2BBFC;
	Wed, 24 Apr 2024 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713967342;
	bh=Fh5MCAn/CD6jBI814D1jnEu75NoL8cNXPO4vwBfUu/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ix6QGTVrgjY824PwxrRwDye4DpweBSEsMd+APji9fFffzBQ6SvWkbub4lb4tHZvow
	 aaq+F2YkHFz8roTKYMwo74WP/8DLWLDN7NCXVIcfg8l7BlB3iNSLNeFxwrUj7HtdUW
	 kzS61XMTnckY8oorjbMd/GrgvRYDASjpA8F433a+iSyDSAQirsRjF2t0XmlrfoKLa1
	 O7igBzDcbljb6yfFkzB3tu9Ig99ZRbelYFFaHnm0qgdjsj3bro4rPhDoizPfYDkgV0
	 fo6/TiMUSc5AYJ9Gq0lzx2a3dmuJ2IunCVFSRRuRlTh3goYAkwaNqphMDSxDahDMGs
	 6D2C+hpyuYwkw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423115749.15786-1-sheharyaar48@gmail.com>
References: <20240423115749.15786-1-sheharyaar48@gmail.com>
Subject: Re: [PATCH v3] ASoC: dt-bindings: tegra20-ac97: convert to dt
 schema
Message-Id: <171396733863.1799261.10850188731294136998.b4-ty@kernel.org>
Date: Wed, 24 Apr 2024 23:02:18 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 23 Apr 2024 17:27:47 +0530, Mohammad Shehar Yaar Tausif wrote:
> Convert NVIDIA Tegra20 AC97 binding to DT schema.
> Change -gpio to -gpios in schema as "gpio" suffix is deprecated.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: tegra20-ac97: convert to dt schema
      commit: 701a22fd9ffaa409bbd45c2936870341b3ad9fdb

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


