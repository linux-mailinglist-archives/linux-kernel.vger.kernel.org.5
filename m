Return-Path: <linux-kernel+bounces-54872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 434EB84B4A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA18B208D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D501332AE;
	Tue,  6 Feb 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO88s14R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D413329F;
	Tue,  6 Feb 2024 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221352; cv=none; b=OY7QhXmMKvnU3APmaOMj/jkzfQvMsrVUYloMy30o8GTJFcwLEpQnwXbQp36Mi2xvHHzrgsZXXvwFRFtEI01bFeHYo9Y4ynJIstOP+ZoInRSqr4Ku0w4kfrHOc24Q4z6yaTqVq1Wj2jVAoNDWj/0xVCFnzlor/9JYx0/hd6TRlbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221352; c=relaxed/simple;
	bh=qQim4pSiLZXeeio4DYXf7rA0VHmdXdFAs9UDtVEQTeo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sOsxTyoOFpn4a+Ud9iV/43020HIyFdP1uXbOKoW4VfZ08g30FkQL2sQB+Yvgj75PGSL+g6ytiAH7vReKMnhuiWCVueCOuNv3STC8hBLoG3PaLSkb8vlb2dVBQR0moVZ1HyT19enBwyZ/LkrCgqSQONa/cn8jyTAFKpQEQhU6ZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO88s14R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEC5C43390;
	Tue,  6 Feb 2024 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707221352;
	bh=qQim4pSiLZXeeio4DYXf7rA0VHmdXdFAs9UDtVEQTeo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OO88s14RXh0E5xwSk3HZmLtz6JvnbW9riemPyKSSISDOivblznBv2Gn+H3rsjVBx7
	 yIOmJ94fk7tR2X/pWPHFevhk+35BgA+W/h/piuqGkcBzEIEOax9oeLIPKo3XcVnsra
	 /1IceEdoFq9xz93LrwSAjsloI8V3bDTgV1jT8RSSBV6FUbCfqW0wNC8uTdNb668jri
	 206ruEgS7jTYSFas+4sKRJtt9DrrT2Lr6H5XTD6c1OaWW8f4ZR2SV7jVQEZYnQAty1
	 LhCN0weLzt8YiNR0WX2pRESzwhbcQbTZTlxGVGs0gNdrm5mVA8AY/JAEdOM1cE8qtA
	 60SXzZgBr2ibw==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240202213132.3863124-2-dlechner@baylibre.com>
References: <20240202213132.3863124-2-dlechner@baylibre.com>
Subject: Re: [PATCH] spi: axi-spi-engine: use common AXI macros
Message-Id: <170722135045.992289.1961001625365540188.b4-ty@kernel.org>
Date: Tue, 06 Feb 2024 12:09:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 02 Feb 2024 15:31:32 -0600, David Lechner wrote:
> This avoid duplicating the same macros in multiple drivers by reusing
> the common AXI macros for the version register.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: axi-spi-engine: use common AXI macros
      commit: 88c2b56c2690061121cad03f0f551db465287575

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


