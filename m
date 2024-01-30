Return-Path: <linux-kernel+bounces-45028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D73842AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E3D1C2144C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66391292DE;
	Tue, 30 Jan 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIgnMAAc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF8726AC6;
	Tue, 30 Jan 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635054; cv=none; b=aYW+/Y5dbN57GufBjjFOoMIxCjSSd0g+x2BkKMRBy4Bx1BAHJhPgxmR/P7RXmNsCa0Ro7nEPuPWFZeuUWjScW8Urbp1/ciAHZqmTudBNuE+JK0bcGgS031+nGRpKT+ie0tqzcil7beDP7WxlRlkJTrDmofnmQux6BZFy+yFQNa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635054; c=relaxed/simple;
	bh=MnZBnXfxIIxuDyaKPabyaRiPDaKlbXQ7jfRPYg1t358=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VebBtc7mOZV9f58L3xTpncaMXV0fj9pKcoOstk76FFTVhZj2bIEn0pYEh40rpKXh5NscQ0EWZAuQHSMajii9VH3Azz/9RAJW7aeMAtioap/hYR4EwM6NEMq5DG3KMAEhhv19mfNbTQzykKoktEudCn+m9JHjVYkNYUrQ0h7fnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIgnMAAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628E0C433C7;
	Tue, 30 Jan 2024 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706635053;
	bh=MnZBnXfxIIxuDyaKPabyaRiPDaKlbXQ7jfRPYg1t358=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qIgnMAAccYlmeMW27BgsXrAO+T7DIHaqc4iwQGmaEIOq8IoCjobyVyYBHYSuW5ye7
	 w+hHsaUILIJEXwWGLmfYY7E87gxhe85Gjxqg/WLyz2wrqUAxgpZ/vuSB5BnDEvDmhK
	 W0Cj6SqfdWytj+pu8HJGSOJ7n1AKtBZxbi75TcAlLdedXDjGoWlhiYQ2Po7aVLYILR
	 a1Yfs+ScI1F0b/dxpcrxUoSqffrxoiZuXLxizyIuohYQ6y6NdQihNrgaUd83AmXY1g
	 LrV+Ymn4HkKX+0Ldur0xpAtr3VLah90RMetsmrB748i7i6AAC84m9zx+BWcGH/S9l+
	 qbDRuSITlTYuA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240130150822.327434-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240130150822.327434-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] ASoC: sh: rz-ssi: Fix error message print
Message-Id: <170663505112.44782.17133777488665631333.b4-ty@kernel.org>
Date: Tue, 30 Jan 2024 17:17:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 30 Jan 2024 15:08:22 +0000, Prabhakar wrote:
> The devm_request_irq() call is done for "dma_rt" interrupt but the error
> message printed "dma_tx" interrupt on failure, fix this by updating
> dma_tx -> dma_rt in dev_err_probe() message. While at it aligned the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sh: rz-ssi: Fix error message print
      commit: 9a6d7c4fb2801b675a9c31a7ceb78c84b8c439bc

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


