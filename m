Return-Path: <linux-kernel+bounces-164229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE78B7AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B1F1F2297A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7263F143749;
	Tue, 30 Apr 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9gpPdhE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E777110;
	Tue, 30 Apr 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489462; cv=none; b=bvL+GBQ0G2SV3qn8OqW8oApS/pyNwbxZNyWGahiJe7l429d1swFEusopljo6U26rfl0MjDXyxaKhcDQ2vIzBKagM9P+FzrQTtNaYwGCdS2dmLZWRdC2ISe4u0hf6DfY5Gk+Hxa008ckryTwLYo1zwMOh3+1l4zDAo7f0MXqTwPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489462; c=relaxed/simple;
	bh=Z5q2Nql4gGeIGPKUOj7Ec9NwNGxgGzdUAKboktFQTuk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UAf6QyLdM64sE8xs/MultbHWtd+ZJfS+e3fihlu7fjsRRdFD4OpSvRpd0URQo7CDrsFZWEO0GLrMAsgXktP/qhf2OSxgc+CWzSGJrrN6EfbN/msFRE7nG0NOzVT195BhHmMMkNVrUchS0SeS+AgnTUzfUZrhOyYvA1TqAaU3iUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9gpPdhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3421AC2BBFC;
	Tue, 30 Apr 2024 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714489462;
	bh=Z5q2Nql4gGeIGPKUOj7Ec9NwNGxgGzdUAKboktFQTuk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m9gpPdhEFevIbqTMDhkmmfgtymgffzJii7iwfv2uOu0LPbGLRxDdRn/cHMdupHSu8
	 ZFQGipP2BUccq2362ZpvLHvh8UnMO3W0hp+byoY2j4YJNqAOfoJkV5dcwa2RI01Cwc
	 hPpv5fgLj6RJkHiEIiDk2L5rKo9DeoQ6f1hgWyGjVyj9x2qTbwHIdFXW4sdGO9dcLt
	 IFZYOdJ1I2qHPlHCALxhduYuiYSkdOHLrIieJk1J7u0hcVFyReC+x3ZMJqVAQCgP5i
	 VRdETfEJ/Y+KhGlNiI3+4jGA/bjWt2CXVLIU5nXIdOu8icNy02PemRRJqc+24N8tsc
	 5CsN+dPgh+a6w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240426215147.3138211-1-robh@kernel.org>
References: <20240426215147.3138211-1-robh@kernel.org>
Subject: Re: [PATCH] regulator: dt-bindings: fixed-regulator: Add a
 preferred node name
Message-Id: <171448946105.1878639.3147802468127954828.b4-ty@kernel.org>
Date: Wed, 01 May 2024 00:04:21 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 26 Apr 2024 16:51:46 -0500, Rob Herring (Arm) wrote:
> Define "regulator-[0-9]v[0-9]" as the preferred node name for fixed
> regulators. Other suffixes with names are also accepted. Combined,
> these make up about half of the existing names in use.
> 
> For now this only serves as documentation as the schema still allows
> anything to avoid lots of additional warnings for something low priority
> to fix. Once a "no deprecated" mode is added to the tools, warnings can
> be enabled selectively.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: fixed-regulator: Add a preferred node name
      commit: b6d4b3500d57370f5b3abf0701c9166b384db976

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


