Return-Path: <linux-kernel+bounces-33720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00112836DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3322B1C26F72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B9958AD2;
	Mon, 22 Jan 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZXghkqI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1399758ABB;
	Mon, 22 Jan 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942174; cv=none; b=GloVpdWp2JJJdH/7bE2uCPBIUjh7IcWfprnFIC5NJDUeo1jagKlnaiSMbLG7oQ/iZUQ0kM1LIn+dJ7O2OhqRfErTLSah11ttQZzGgNRYkElN4wJlJ+b5qK2VKA+ySAx33k0P7EnfljZZHtTzhkRpbjxNpQ+csPFo3zGNPWQ2QLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942174; c=relaxed/simple;
	bh=ZWx120GF+mtkovrvKrkQnTHL7QRGC23VzcOTEmMjqxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MPo6qsIdAIU0Fj2YGU7kF16QnTfKnqqGBErgSP5f/1UBH/YbGRGDryavY7zpNdAW7hYfOEtrIkNa7j/V86OaSqKDOVCVsL2wDbbe4YKyvail3XhcRIl9jqgxoTxT8JRXTnbJqHVbkP6JSHlcGRKAhHje8IEvk2WaSSxMiFG5Gdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZXghkqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A9CC433F1;
	Mon, 22 Jan 2024 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705942173;
	bh=ZWx120GF+mtkovrvKrkQnTHL7QRGC23VzcOTEmMjqxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HZXghkqIolE1qQF6hEOhY70ikFFsjVKVG/ShxPnUb31xdT2lb6O7bzG2/SvoTYr4G
	 BtLvWSmaj3+xLw21ELaWNVmxyJ5Wy0RFo6zE6hdjkHMtHCdTq9nk0czByRAXDRd6/T
	 zxLMJ8w3eyQC4F1j+4Sl7FAeIHF9T7aWPqZYtcF6fzjlslj0kfV280IKtkS0iLHYim
	 CJ4tCYcJeZmk/q1ue8L/IzHt1B4ZPuGl8L5YpQxaLG/7e9DwidDvR7GEFMcEeIWcZ+
	 YneTh9dJWjQh8w8/Puv78NMu2yCq8drbFdhVe8SDWXKYY7rIZK2taTIkKeyw8sAfxE
	 xN9Kb8QI6d11Q==
From: Mark Brown <broonie@kernel.org>
To: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 wenst@chromium.org
In-Reply-To: <20240108120802.7601-1-zhouruihai@huaqin.corp-partner.google.com>
References: <20240108120802.7601-1-zhouruihai@huaqin.corp-partner.google.com>
Subject: Re: [PATCH] spi: spi-mt65xx: Support sleep pin control
Message-Id: <170594217171.69518.999967037682880271.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 16:49:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 08 Jan 2024 20:08:02 +0800, Ruihai Zhou wrote:
> Supports configuring sleep pin control during system suspend to prevent
> potential power leakage and additional power consumption.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mt65xx: Support sleep pin control
      commit: 4247d7f2ca564bbede54054da1f35a359bb061bd

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


