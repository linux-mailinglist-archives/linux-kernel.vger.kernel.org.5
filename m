Return-Path: <linux-kernel+bounces-34224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38EF8375D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB97B23C55
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E3248CDC;
	Mon, 22 Jan 2024 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXcWNk4K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485C1482D6;
	Mon, 22 Jan 2024 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961234; cv=none; b=jQ2qBnIduDV4+YcvO7XzUdcYe3qNJ3br5FL7EyfLWeV1WjKhFKZP5T1UULLM0L1mOzR7JcAJRS/3j4U2IapkFIs2zovWYoMdpsFp5dNkxP0zXVdoGYQ9O+fWs3VMhTbnhNFwSuuDoOPCjzlG+mvpnK1U9urX6d7MVRW93VWK2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961234; c=relaxed/simple;
	bh=5MF/j81LXFvwVKaTRIZ3AcuPt/fT8M0ewY3gluhRo8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X+OiNmLUH2sh1XISc+sp0nr2//eX55lmf316Ub3kVGkSJua1OXxS75JpppcOPwL8uvuqkHhQgomvGGzC/JKAlqfPMPb582D/dbZ9oDPIpFjL3z5hHZLdPxDLMztcrVokp5xTw12XnApNizXmj7Yu5HoCIX20qMikEYFzW+JhpNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXcWNk4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47F0C433F1;
	Mon, 22 Jan 2024 22:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705961233;
	bh=5MF/j81LXFvwVKaTRIZ3AcuPt/fT8M0ewY3gluhRo8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QXcWNk4KydOkg7ZquDxWQh+zjEQ3FA5iaeieGPCPx+opzTN0yySQKRVHVYqiPz3O7
	 ni79geOEORdauf7c1day+fcwSSghTHuSsj08vr0S//k7RldJzfy+dGTrmqp02P8Jr1
	 JguIE2N59jjcWVYzw2NzuLctsQLy2D94pV9ZgrC2a6JZ6bjNnVPSd8uzVVvSpSElzF
	 xz7NwPc7f3fyD0nS2efGmq4hHBuIh6RrMyNnJuC2VpTB1GAdqGl+9a+X8VgdM1fE+9
	 wHn5AoXI39d3q7/CckjQvvyK+WDl+utYjQ/fHabvy6G1KdaSgd0u/Z4jq2ywXr3heh
	 tswiUTYeIe8pQ==
From: Mark Brown <broonie@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
 Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
References: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
Subject: Re: [PATCH] spi: Raise limit on number of chip selects
Message-Id: <170596123245.165612.16363580061714795777.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 22:07:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 22 Jan 2024 01:21:46 +0000, Mark Brown wrote:
> As reported by Guenter the limit we've got on the number of chip selects is
> set too low for some systems, raise the limit. We should really remove the
> hard coded limit but this is needed as a fix so let's do the simple thing
> and raise the limit for now.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Raise limit on number of chip selects
      commit: 985bfd36b988cd0e3254c5f4aa7cbe2a848403a9

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


