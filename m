Return-Path: <linux-kernel+bounces-119145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3DF88C4C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264DD1C613D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81AB12D765;
	Tue, 26 Mar 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RctuSQs7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831D12D752;
	Tue, 26 Mar 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462219; cv=none; b=SWXYNF9rru/YgMAKld1eYTcuysMtpPX2sMKYXV71Prvo6juVYRVAMKTaDCgl5SOhcx/OP3PffTwCRJOFSHj4YeDFGwRw1cZl1bOGGU9jF/t+QAKoiqueV2w7xG94nB9qysOGXLlbDnFGzxCULNfbjkAkkIvA3f8631G2J0tTWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462219; c=relaxed/simple;
	bh=2ai8Am+tAXrFzT1ggWJHakOixG0+KZCWlpUeSszQ44g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jntk1+uRt3QHzGoHB8BtteQt24SoHKlaCExHL/vvAokO14Elo3JDFUWKjXzU0dYF4hTNnY37xzc7h7LfzxKULRlVUTtMqRTYYD+/hmGUaVwJzFObyNqhqToiwANnwTVKdfITEQ951IwyVj1zkKgbQ+D8zZhRiuNsgBMvEVjxOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RctuSQs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BEBC43394;
	Tue, 26 Mar 2024 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711462218;
	bh=2ai8Am+tAXrFzT1ggWJHakOixG0+KZCWlpUeSszQ44g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RctuSQs7IPtY63Nq5kuxtSZhw36G2ffG/2Bn52mnKW9FwiTXmYJl8AsenNmXbvMAq
	 F3kse3abeXNNq/9D1zV1GunRlzZkxiVx2WQmCyNN48Y4gDFh9UKhFqrivE7nDLHhbm
	 WaLQNboOZyoTqiRteH07pWIZQi1+y3FeISYxrQJrKrxPR3DN/87jAyHuwokMJVNsWe
	 daOqnUjq7XH3gV4w2lI7epNhLQn72/dYOkVKcHYzlVP4fioJS6N/46sNwtMRhH6G6l
	 nQ2+CLnXyooS1ONb2L6CiRYQDGpbeokbqsmELCxQqTPkFOKlIWvyF5exkt3Qm5053g
	 hCrs0UoWmTe4g==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, John Watts <contact@jookia.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240326-dai_mclk_hint-v1-1-653cbd2d78d9@jookia.org>
References: <20240326-dai_mclk_hint-v1-1-653cbd2d78d9@jookia.org>
Subject: Re: [PATCH] ASoC: soc-dai: Note valid values of sysclock direction
Message-Id: <171146221713.96138.6449456122956204470.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 14:10:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 26 Mar 2024 22:48:00 +1100, John Watts wrote:
> Clock direction is marked as 'unsigned int' but only two values are
> currently used in practice. Note these down in the documentation.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-dai: Note valid values of sysclock direction
      commit: 1e90a846493c716e3e6b4d901fc0844e9eea6430

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


