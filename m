Return-Path: <linux-kernel+bounces-144487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEC18A46F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8C31C21C82
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C89C17547;
	Mon, 15 Apr 2024 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QToCu0s/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E212E78;
	Mon, 15 Apr 2024 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713147985; cv=none; b=eHpOpd9TTSLzS1C8LDnNkKLP1NjGJCSzZzAUEUzStAY5/uRt/BZbPwQb6WkkIVklCgPjHBUai8NsbyuBHY1IEKeOhjat1QlA9MMWnkYgd7Jw6MslAGBgdHPGSVI/TptK5tNaOjgLY3n4pKgMYVhTYdmk8IXlDGwwFjNCdjuwxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713147985; c=relaxed/simple;
	bh=jhwG2TBFB90SEgA5EbacWDF8bEShgDBJ5++qlx6FbMQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ROOqSSgcC58DTV5AZMy2+Km3jX2ByJ0WF9Wo1h1+2WyCUSudlqjqk/tBp/WoNZnqwpl6o8c4Tl9vaZGaNSJnHAA2ZYxI4p0M6kOWnkNpgvZMtzbl34NjRYVdWgFvci7lAUyNEouOA9gdf712T4ANmCKMZePo3ZOrktSXpHD2wKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QToCu0s/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B46C2BD10;
	Mon, 15 Apr 2024 02:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713147985;
	bh=jhwG2TBFB90SEgA5EbacWDF8bEShgDBJ5++qlx6FbMQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=QToCu0s/3Va6nO9UEZ+RYEnb4ztCtvPIyVQO/mYXbTu6AmQkhQ4xQoqHpHMpBehaU
	 Vf4hHsWJ28x4GVqgI8BFgq1OofefAWbixkymbsqg9dLo19PZuszeXqIcRZL+PGzMZz
	 qET9IK3fl9vNKKNcpMhKbggNKTUx8LeaXb4RPFv/o8vpCadGn35/6hcRsR2nI4eAis
	 nQgnOrIr1QTU9/9MknnjV0ilpaoTtj0WlioZsJnVuy4fKxQ9qQP2kX5w83zquAxSBG
	 xAvund36CMnxVsTs0jJfwjCoSksYvnVemk8vKZ1XZyVxrx+kX7wdxRJi59uEwjKwta
	 bdQ+XiGmGWqSw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 shengjiu.wang@gmail.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1712894212-32283-1-git-send-email-shengjiu.wang@nxp.com>
References: <1712894212-32283-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: (subset) [PATCH v5 0/2] convert imx-audio-spdif.txt to YAML
Message-Id: <171314798122.1649319.16393301431287899272.b4-ty@kernel.org>
Date: Mon, 15 Apr 2024 11:26:21 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 12 Apr 2024 11:56:50 +0800, Shengjiu Wang wrote:
> convert imx-audio-spdif.txt to YAML
> 
> changes in v5:
> - fix typos in second commit message
> 
> changes in v4:
> - change the enmu to const
> - add more comments in commit message for second patch
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: imx-audio-spdif: convert to YAML
      commit: 62bef5df35a87d0f8464b1a8837540988cfaf5db

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


