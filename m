Return-Path: <linux-kernel+bounces-144943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0D38A4CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918EB1F24492
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A810F5D467;
	Mon, 15 Apr 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6tjRIrH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CBC3FBB0;
	Mon, 15 Apr 2024 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178401; cv=none; b=oa5uoaylzv1/ZW4n5xOjNex6eTShXrxBh2qaXmu3RcLUueefxChmZaL5cuuIcJSvt+C8Nz0c4ke4uHf+z+zQeVhX7q50SMAQNhM1DvKwAIakbstvN8FSBWbfDwEhC65DN6imA7v2Jgro3FwPtXum0TaQR4gQ6BlDMpYp1cp16gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178401; c=relaxed/simple;
	bh=kfvyNsCyNmGnY4Zz3DbNuf3727prsr30mDPRfXJwYQQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fCV4yvSDqeWqJRsvOFH/mKcwucPw1xWuXrey75wDAjFUDWSmqAgx8c55nblE8euWIVNoL8EBNL7zxzNfLhbHeLwgzWzj1H4Tnild7v8QnSStmSZwP2Jc6enrh/jUBeRg/l1dvvJWj8J9DiXZL2u0PXpM2tdE8GxShPawIwDulTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6tjRIrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FC2C2BD11;
	Mon, 15 Apr 2024 10:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713178400;
	bh=kfvyNsCyNmGnY4Zz3DbNuf3727prsr30mDPRfXJwYQQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=n6tjRIrH24V/fmUUgV1+TVsJb2wPTk3Qw9a+4CZx5+Det9yD4eQWk+d++eImSpul2
	 WzXn+G2nzon4+IrNE2bLs1U+z9a8FN/Ucy+/dcNQdVHL/JNwXtxecPpgs2XZdzCKst
	 j+JV4FHPDtNnCJ56GELBJ1x76aHVuMbGebrnQnmPlcpnwFWUMawBJJAqGFnNB41pCh
	 2098EoW5gL2vFk8rw7C1O3gFU6YMEZFUHrBhToavtuSQG8KtZl08nj8Cw+nZVYWzqX
	 9VTX3Ki8GmvgLf+dYkmLqEUtIE0sMyShfx5aJlm5tMnG9fBijNddklrENiVX6uMNnO
	 xhKMEzGLhiNJw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20240414164703.239851-1-krzk@kernel.org>
References: <20240414164703.239851-1-krzk@kernel.org>
Subject: Re: [PATCH] ASoC: amd: acp-da7219-max98357a: Constify
 regulator_ops
Message-Id: <171317839864.1652048.9391561381349380434.b4-ty@kernel.org>
Date: Mon, 15 Apr 2024 19:53:18 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Sun, 14 Apr 2024 18:47:03 +0200, Krzysztof Kozlowski wrote:
> Neither core nor the driver modifes 'struct regulator_ops', so it can be
> const for code safety.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp-da7219-max98357a: Constify regulator_ops
      commit: dd8c3473bbb8b4fdc44ed3a5a864cfefab9038dd

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


