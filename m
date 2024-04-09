Return-Path: <linux-kernel+bounces-137382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EA389E148
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F1F281531
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD28155746;
	Tue,  9 Apr 2024 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJbfs7mD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6132E1553A4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682851; cv=none; b=RHAlZmoUfdqZuJzIigfGdwCxwg68ws3AEFvUCEtKyEU8iGApHXttzjodfaPxgnZUiRtN3Iw3jlDOg6khXu9yc0RnfLezbpkmfK+8pmRXk6PQAF7Ga9AfQ1H+UxPbZTdJyJKSeU06/3BpTlSsm+hTFYAFJdKSvyqclTZxrUxGHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682851; c=relaxed/simple;
	bh=TBA2HdhdctdleihHhpwNGTmnAD2XEeUKBvJmag1oMrc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JWPtVcFW5gqRuyalAG1Fasyp19w1kQeMcU4vDdctSDPqg8fzciWPVf/GvkAfeBUk+Z0X/AJw8rWW7fg8esS+e4VUvus1OEvt3ciiTfNgJ/qFravKaQEMNf9+dNlPzO24CxrXYvN3uclKaCgWzt8/5aHg8yMWw6J2q+/vK0ul6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJbfs7mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DDDC43390;
	Tue,  9 Apr 2024 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712682850;
	bh=TBA2HdhdctdleihHhpwNGTmnAD2XEeUKBvJmag1oMrc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oJbfs7mDu9BM/dO9ZU0CMhMRsqPZ0uW3Trc7tZBlp7JzeFGpvn5PYgBKnu2dfkH4z
	 mahdyiYMjwZcrxqDmHQQbnNyE5iQqX1r6OP0pVBcfevu3epFSjGpGgpppolgXtU6Zj
	 zYnlEqkRlW+j61qowesmCry3m7qr1xd3eqqchzL1cJbhzEf4EToRmDAqmRLHL29Fr5
	 CCLVH89Zq3SF0k5aTFwObGLAmRi14zlsLyOrZczMDoCWjXn+pqSdMuvd75ZjohDw/1
	 rL2yKm//82kx/Z4yQytMPs+frJE0tco9xbeG96Qxb43OxCSU6fN3LWo+j8l5VQniPH
	 NOrYKyF43oCyw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: matthias.bgg@gmail.com, gene_chen@richtek.com, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, kernel@collabora.com
In-Reply-To: <20240409144438.410060-1-angelogioacchino.delregno@collabora.com>
References: <20240409144438.410060-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] regulator: mt6360: De-capitalize devicetree regulator
 subnodes
Message-Id: <171268284879.51855.7043430433984734547.b4-ty@kernel.org>
Date: Tue, 09 Apr 2024 18:14:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 09 Apr 2024 16:44:38 +0200, AngeloGioacchino Del Regno wrote:
> The MT6360 regulator binding, the example in the MT6360 mfd binding, and
> the devicetree users of those bindings are rightfully declaring MT6360
> regulator subnodes with non-capital names, and luckily without using the
> deprecated regulator-compatible property.
> 
> With this driver declaring capitalized BUCKx/LDOx as of_match string for
> the node names, obviously no regulator gets probed: fix that by changing
> the MT6360_REGULATOR_DESC macro to add a "match" parameter which gets
> assigned to the of_match.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6360: De-capitalize devicetree regulator subnodes
      commit: d3cf8a17498dd9104c04ad28eeac3ef3339f9f9f

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


