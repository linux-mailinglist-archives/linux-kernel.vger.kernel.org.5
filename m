Return-Path: <linux-kernel+bounces-33707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EB5836D83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3F928B114
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CBE7691C;
	Mon, 22 Jan 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjRt5IdG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4576909;
	Mon, 22 Jan 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941232; cv=none; b=sVTST+t/S0wvnFcvFqcq/BwNezoQstkPgt+WafBGggwaRs1F8bMVw2x4f/h2il640cgd+w26CmXjBRouwGqOYaNOXL8sTyKZOdoiYdji45gvKqyldQbtPq10czfYXG+Z/O37MtPakXM+VGsPHpUkVgStunNtv28l6fkJDI3BuNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941232; c=relaxed/simple;
	bh=AnT6KpLa3u0hFMSAd/NwItFYFy+ZRbXGode8jH6ETD8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GRrDBwGIPndGZ/8zIheLRPkyLgHlna7FoNnhhJ6ufsK813itCCfDUQv1pXQ1FI9zrsLvBlOFMI3lc4RBVSt4lidi+m+nXosX2Wi1QULAgTLq2LF2Bp8sDDbwF31XRx1aQ8p762pOkObYFJ2DDRUc31EZmYndTSFUtIRJEAjmMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjRt5IdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34B4C433F1;
	Mon, 22 Jan 2024 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705941232;
	bh=AnT6KpLa3u0hFMSAd/NwItFYFy+ZRbXGode8jH6ETD8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=kjRt5IdGhxzArXLJpc7SCLmDDSIaA/2Ig5oh1se3IdMxwIjOcHR3M1UCRwhDxEo27
	 iO7Nvo62o3vYAkRD/LDE9Fzk9kfqlX8mgMc7++bxkQdyJi7jLhxJ8qjTE6iw6iJEZB
	 7GZxxuL2Vyl5equD2BF7VEDUT86/Ccc/eTEJCN/0X2DVeSzWx6hFZEuxcndZjcz+Cl
	 dJNVm6fRotlWc/LKC81A7HMGwUYxcRwbA+Z72irYKK3fEElvSa3ZazTcxbvUqQ2SUD
	 K3WuV9vDhdDKt3H0G02Am/UjvNjwMju2oUgbQouT83KMYdz/tmyuyFRpUOUkidRGcW
	 MigK+IxDxKYRA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240115182017.1610055-1-krzysztof.kozlowski@linaro.org>
References: <20240115182017.1610055-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Do not override firmware-name $ref
Message-Id: <170594122964.63484.11012665627670215684.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 16:33:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 15 Jan 2024 19:20:17 +0100, Krzysztof Kozlowski wrote:
> dtschema package defines firmware-name as string-array, so individual
> bindings should not make it a string but instead just narrow the number
> of expected firmware file names.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Do not override firmware-name $ref
      commit: 059870e53aa06831f1ccdc5e9cf29f933cdf284e

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


