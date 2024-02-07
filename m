Return-Path: <linux-kernel+bounces-56904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC384D10F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440021C2516F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665F384A30;
	Wed,  7 Feb 2024 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA2zfu/H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E183CD1;
	Wed,  7 Feb 2024 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330066; cv=none; b=C5Kch3slCma4IUbd32xFw4/tUmaICiqY6EsCDe4bobnVpKMDLbtGJxaNNgxaENTCpBawar9l09sTMTTrHr5B7rYjtffo+CI0wof0X6NaB1XY1M38ShsOL50kbipCoyno7R5dEnWkZeXJsQpx6fmsmZNMHdPymYHffGIK0FjUYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330066; c=relaxed/simple;
	bh=fH8Upe5jFf9OWoHf882xFwqtEouPSCTWBjZq8M5jMsc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kL2iVGb/dkPqIIUwJB6Ewh36C2K/TMWZUfJ7Wi/LhSdzXNmp9yLCN7TF2RsHs10R8wtY56Fkk5k+Rio2ghlXFh5MjgrR5FSc132WdsHrn/WBh2iVe3BT0bFdwOxeeJBUAKnUIC5RKHreiziyqrrlkoL8bjq4Gz1+pQ2XedjswHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA2zfu/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F73C433C7;
	Wed,  7 Feb 2024 18:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707330066;
	bh=fH8Upe5jFf9OWoHf882xFwqtEouPSCTWBjZq8M5jMsc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YA2zfu/H6y+kCz7GwvdgH8nadBxD15FhSXNHRxhDsoXXPgqAvVuns5hQqRlSEQyP6
	 Uf9GRDgaq1082t4oph/sl7n6X/QyA5C2qtkU0uc4z6Cz0i+wWIeJ8qlOQ6rEupeQAE
	 Ciwoqh7IlwHVLhnzaxtDIM2+H/N54OGJ0TpstJC4ahB+GP2fvxsMek/SuxbHgL8E0O
	 nd8cLHj63ANwObnsyWALmaFabMcah8DkZwe0ApfwZ/RfPCYyNBvARGAa9dqn0KoiTF
	 pvBbZ9OX/jSQy3gKDrKyu7RIMm2XGiJaSQ26IlxrU4xhm7ovXDDyBy95m4ovePIzIz
	 5IXzR6+QLyNew==
From: Mark Brown <broonie@kernel.org>
To: Andrei Simion <andrei.simion@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240207132231.16392-1-lukas.bulwahn@gmail.com>
References: <20240207132231.16392-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: repair entry for MICROCHIP MCP16502 PMIC
 DRIVER
Message-Id: <170733006365.1096853.3231034830633743082.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 18:21:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Wed, 07 Feb 2024 14:22:31 +0100, Lukas Bulwahn wrote:
> Commit 64db3e8d7be0 ("regulator: dt-bindings: microchip,mcp16502: convert
> to YAML") converts mcp16502-regulator.txt to microchip,mcp16502.yaml, but
> misses to adjust its reference in MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] MAINTAINERS: repair entry for MICROCHIP MCP16502 PMIC DRIVER
      commit: 46d5baf046abeffcb3754321fbc2551027fe7de9

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


