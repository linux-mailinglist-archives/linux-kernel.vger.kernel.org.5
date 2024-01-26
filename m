Return-Path: <linux-kernel+bounces-40682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E8383E408
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D30B23B89
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F09924B29;
	Fri, 26 Jan 2024 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAPLvw0/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C461DFD9;
	Fri, 26 Jan 2024 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305089; cv=none; b=DM0Gjpyx5xCyzGwIdCArOltcEIOa7132Fpy1jCmlfPHDHiecvNWuB81eLBkTs7fZzzPoBimmxm4iEtmiOPrmh5IBfZ9bO/5v86ob2cYeC73x6/Lc4s45WewBkWfSVNXXqwjF27ksfkJQ+ZQP5yDtvIFVODqa4D6pcBivPPxQQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305089; c=relaxed/simple;
	bh=Cyr+ohTCDNTF015J2dl9lIrDXnFHUzCsBweKOJFBkuw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kJ+VM1Q0LlvbAXj+4r7GQOmj53SNDEZZBvlz6hBfVeJ7h4GayH0QY55JjfermszAaxkgQnsmyV+2Ux/5SOcxC313sfh6fis854lNGA5OdcFcgQFt8C5D8cfViWrowfh+DUU4mkhx7mSu5xLwa5C6J3WZ3dl/cytsSsfLboG6CD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAPLvw0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC00C433C7;
	Fri, 26 Jan 2024 21:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706305088;
	bh=Cyr+ohTCDNTF015J2dl9lIrDXnFHUzCsBweKOJFBkuw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KAPLvw0/vaB0QKZx0Mo4DAoXZh5RzceBvBjcNZ7f0T1o5tZIqA+6+qFPlZi3DkuOg
	 wAj3bFB7Q+GG480+li8sMBk70or/p0ziIjQDlO+DTa7OeTVA2ZJLIUjRUATwQp810m
	 BGyLONVlk4pUz5DZarX/yzwG9KA3Z3gxe7b6MKAoplZx1Rzmd/WwmUtRaKUcJqaXrK
	 pup1pk3Sbt9jrIeE9lhgrh6LzP2DZOYtWok4k86diFPH7Co1pimFGiFQCxSo0sNORv
	 h5gff3Ta3vnKFIpA6omH23Nb9IeZRg2Q1YsT6jrCkV0UJvzwu7c1XI+wlL8mH4o7u/
	 a/Jaj13xIbnlw==
From: Mark Brown <broonie@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240124190754.1554899-1-robh@kernel.org>
References: <20240124190754.1554899-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: samsung,tm2: Correct "audio-codec"
 constraints
Message-Id: <170630508611.52716.16893175190780075572.b4-ty@kernel.org>
Date: Fri, 26 Jan 2024 21:38:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 24 Jan 2024 13:07:53 -0600, Rob Herring wrote:
> The "audio-codec" constraints define how many entries(2), but not the
> size of each entry. Each entry is a single phandle. Define the size with
> an inner 'items' list.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: samsung,tm2: Correct "audio-codec" constraints
      commit: 36553eb7785da18568de2b8ecafb3d80db1a0d6b

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


