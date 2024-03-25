Return-Path: <linux-kernel+bounces-117629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585D288AD7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1293F364DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9CE13B594;
	Mon, 25 Mar 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/NN2qq8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5612F37;
	Mon, 25 Mar 2024 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388683; cv=none; b=AFvtL+BEKc+JN2j2Kjly9x2GN6q88RRQzTGXgw50gRb20wuluUe4B6t7VbEaIAkcQKQpNexlw3XO0Kv6MEJ4OKPBk4QsagN0zLbLiJNzJh6D8+haZ+arsjam5oLyMbMo0ydHXD/k/qMhC4fghzD0IGGIOi2whRmAEUL+SL9Ct1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388683; c=relaxed/simple;
	bh=rPSUAYZgdv7a8C2b5PiR+O6lxIRYgH67RHKxnr7YXJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PeDcmXh/qP7CS0cF83AVL2OFGYhManCMhgVZnf1LdSccYFCWHISu9ZXqm+mnqZLPlTuRw00Y7oDvDRaezx8f+469DVRSo2kgoUsC/i/lfcZs4SE3Ls9k3hTK/cDJKNHWOX2Lfa7doUulXDlbyqPo7OXCJ1sA+OXAKHI4t1FM7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/NN2qq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F896C43390;
	Mon, 25 Mar 2024 17:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388683;
	bh=rPSUAYZgdv7a8C2b5PiR+O6lxIRYgH67RHKxnr7YXJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=D/NN2qq8tbvY2SMm04yZloUs4yy42fXwUQUriiA1lVPN/bqAhvDfST75qhabl7AUN
	 jnKS8lIAx0sjHqC8mlEw+odSsEMeKdwU0QtuW6zHgrirBYLL3CAyhFgHpoz+tWA23m
	 T6qbTvloXbFV532Dn++uKG9lcB4zZ3L3q6ZoEi4/pn6sG3xA+mo05qxuJR6N6Bhwxp
	 eKum0Sh6Joq+mMShjyyrPdrisf+uBectSvHiCV/5zMzWjXSOQkT4EZ/sFtvpr8L4mV
	 SUbwRdjzYRK+Mb5XB4m4KgxL/nZkNBn5z5/y/LKlTbz670caWt13E3r6GmzgtDQ+Ya
	 xsbiu5FhHMSLg==
From: Mark Brown <broonie@kernel.org>
To: frank.li@nxp.com, ping.bai@nxp.com, lgirdwood@gmail.com, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, Joy Zou <joy.zou@nxp.com>
Cc: kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20240318095633.4079027-1-joy.zou@nxp.com>
References: <20240318095633.4079027-1-joy.zou@nxp.com>
Subject: Re: (subset) [PATCH v5 0/3] add pmic pca9451a support
Message-Id: <171138867999.327260.14277082785648331600.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 17:44:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 18 Mar 2024 17:56:30 +0800, Joy Zou wrote:
> The patchset supports pmic pca9451a.
> For the details, please check the patch commit log.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: dt-bindings: pca9450: add pca9451a support
      commit: 0f3b73eb1440d18d2236ac660d4aa76fd726bec7
[2/3] regulator: pca9450: add pca9451a support
      commit: 5edeb7d312628961046eec9b26a7e72f44baf846

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


