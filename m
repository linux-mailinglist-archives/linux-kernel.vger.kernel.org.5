Return-Path: <linux-kernel+bounces-124667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BF0891B30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92FA28C32B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0856016F820;
	Fri, 29 Mar 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXCtlyo+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C7816F279;
	Fri, 29 Mar 2024 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715662; cv=none; b=Z5DJ/p62/nXOq4S2wKEASO5wJh1zTqGYfL24TDXoFZKE2MZfQJRyjfrri+5iMwc3NdGc/WoircjLBCK2errtRhto1J9tH4AWIxrBJ5n03TEE27DUOlRhmZwx9FV6Xt5FURrAJYmt+H5Rr60q2yidkbIadQUGrnKIeHHwoB6ElzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715662; c=relaxed/simple;
	bh=UkSbtjJEgl6LMa5fIG+nvr7Zd2VPGIy7T5ATeqgQtZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OM769R6x+JUSBhm2uhXhEa8XtC3edtCPygDkFqEMViOjdyS0O6ED5VEWYl6y/+ZXdUVLn0qGWjahH7EB23b+xSwj2OrGjyQx515yUxsZXEodQak85Ax/moniW5EucyaTn0HNTW1tZC5wLcSPmC4iaGkpniQhr6sVwElHLlaDdUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXCtlyo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6D6C43390;
	Fri, 29 Mar 2024 12:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715662;
	bh=UkSbtjJEgl6LMa5fIG+nvr7Zd2VPGIy7T5ATeqgQtZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IXCtlyo+WMkk/8TsFGvQ9+JheaY0DzeEwlol+q2U7O9lDy0ieEbs9pTIbyqxlWp6T
	 8VPZFI+FEXf+XyRPnX18hIWkzemebOKqkKOB1W2zMxCOno+MxVoKTdvC7E1d6dswXE
	 pHtwmqk5Okx0w5t6e8QJvvaX1X/FqBS0+phEODboV6O6b+xwDcOmqxXd99yZJ+Og4I
	 lfzCB1l5SJrdIbNigIRuuLV2gvVNvSTnQRJhSiVih/znGGjBBOssjY5CptExBqqMkj
	 skOweqDmLyevd9GV7Ri6SbMU76mra2RWIYhC+K71UtWVyvMJ0/pvRijjlSXMbop7+z
	 oKTa38SzkKifw==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com>
References: <20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com>
Subject: Re: [PATCH 0/2] spi: more tx_buf/rx_buf removal
Message-Id: <171171566104.8069.8819220461142954269.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 12:34:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 28 Mar 2024 15:51:44 -0500, David Lechner wrote:
> I found a couple more controller drivers that were checking if the
> tx_buf and rx_buf fields in the spi_transfer structure were set by a
> peripheral driver that I missed in [1]. These checks can be removed
> as well.
> 
> [1]: https://lore.kernel.org/linux-spi/20240325-spi-remove-is_dma_mapped-v2-1-d08d62b61f1c@baylibre.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: au1550: t->{tx,rx}_dma checks
      commit: c2064672f13344586234183e276cc4e0f2cfb70a
[2/2] spi: fsl: remove is_dma_mapped checks
      commit: 64fe73d10323e399b2e8eb5407390bcb302a046c

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


