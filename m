Return-Path: <linux-kernel+bounces-50162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFF884751D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A4EB25D10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5009A14831F;
	Fri,  2 Feb 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1TRem4d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937EE1468E6;
	Fri,  2 Feb 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892099; cv=none; b=Lni3FipLb79EnU6Km2k10i9MJNKyKKR0bHQ5aCbHvlLdGwUsQ/Zwvjf5w1RpAm8tZl+6qppMoEyoiAQaD5nIpbecCotT9ZFLTdekNIeFy6zHwwT8UtLEtAEYfM3rrvISS8f1ObvI1MsPPWcMIR9A00YXcTgeuBuNMDzAC0w8BJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892099; c=relaxed/simple;
	bh=DkFzqq6VgEAoLrB+XtJQVcQtbCAEeTHJOKfjZ5d/3h8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dvt0AY1GE1LiUD2cJaA5SxpKqeF99p9HkY+MqtoYVYt4gQY9lRgbf8qeUBRL1yPWfChVSW5k7D3ixrRT3SQNOs64SKgW27rMCu/KLCHaBs019E/1dSs7eiiUnG16zvqVjvVd/HQGfXG4Ea5MYFzh79ao0dDh8XHDlIuc9FkGIus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1TRem4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCFAC433C7;
	Fri,  2 Feb 2024 16:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892099;
	bh=DkFzqq6VgEAoLrB+XtJQVcQtbCAEeTHJOKfjZ5d/3h8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L1TRem4daGdnoCi+xy4RnDOnGBX4Prm7Y8H0WvEJRsnXOIjI41rcCDcAlUI883BEr
	 OcjV75aHY7565ua6rSSJO12O/W1DW2o1pPB6eauC9fTOLiT3VZBm4B2ST1ruiuCxJO
	 T8pJPjsdAi4E9A+7RXXVwh/GX72sKTPNrq+PWRjh3Y127KtwL+ANwO1m1VxC0F1EUz
	 lNkxiuwVjHeGGW8p9yGDG1Gi6lKNZu5M1QofZjW+9GxRbq4Kd5HeHan9t9j62Z48Sf
	 pHOWVWNQXcYtXmA4drGyEHBXB308VAHtqA407CHMgHHsLHzlm/x32kQ3Rgn02Nj3sp
	 O6RyDcitz8qJA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 claudiu.beznea@tuxon.dev, Andrei Simion <andrei.simion@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240201161517.492162-1-andrei.simion@microchip.com>
References: <20240201161517.492162-1-andrei.simion@microchip.com>
Subject: Re: [PATCH v4] regulator: dt-bindings: microchip,mcp16502: convert
 to YAML
Message-Id: <170689209683.101360.163113279723632505.b4-ty@kernel.org>
Date: Fri, 02 Feb 2024 16:41:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 01 Feb 2024 18:15:17 +0200, Andrei Simion wrote:
> Convert devicetree binding mcp16502-regulator.txt to YAML format.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: microchip,mcp16502: convert to YAML
      commit: 64db3e8d7be00462ad95dd81f11cf8e3f0968d70

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


