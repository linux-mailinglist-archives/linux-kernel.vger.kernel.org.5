Return-Path: <linux-kernel+bounces-131618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61231898A28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A821F2DEED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717231370;
	Thu,  4 Apr 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqpwGViM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185B33EE;
	Thu,  4 Apr 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241081; cv=none; b=emtvEz54RQhvtv9hUTPOwQWNvScT1YBqutApfslbnCJRUExBmZKHDuJVY/BfspEncIv9Y8ZQb7iU8rbw1/EADcLWYPsRWNH9BjVGzMrda0WtH4nv4xBDliAmg2B4ZMte66Vo29n62dIMgtBIfXweWnSMt5hltm83srP4qF5BpRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241081; c=relaxed/simple;
	bh=Ew0qVCoEk5oCC/bKiRSVHHT4fMxz1dQQ346/Rx+dZu8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d2QYiUbj7mk2TnI3uPKvF/6EJoSHpGeRIw3MfKsUTnt3tWKRVN1eLyNXowqb+FmFvu+Lsa4xuqOX8X253PiLRN2jKy/U0RpiR1pCczP5ZzDHRhoNgrp6C3bOrkg2phJNVWqEjZ07I4nZq6L6cVmVG5o6eiRoOn1GoYukIz4QpUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqpwGViM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A7CC433C7;
	Thu,  4 Apr 2024 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712241081;
	bh=Ew0qVCoEk5oCC/bKiRSVHHT4fMxz1dQQ346/Rx+dZu8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mqpwGViMLyGi6NnLUetpokYMKOu39b1lYBEQObNKOD5OG2rHXQ3nRVecBx5XRMM63
	 4VxGZ+oSojVlexgfkeBtRrGKH1JsumV5ubOxLHIUz0OxyHJkjJMgrg5MIqa9RYvG6S
	 evotnDPRRs764b8VbZEQpVp22qnTn3sAZRE2PcJjLrNFkFGWjFa5WF78QwPAMA+A2f
	 y33S1HxWIviRncmZN1HsHv9ZvojOR38LbfU/DRCLRfdfy6RpH28Y2HfnkVuBqE+QBp
	 WiO1w3Ab44YlX2U48Nrq7XmSgGt0C3ZIFueozUyu3APb/4/O2/cipxQHTEYhMxWupf
	 rnSxk7Sv3NWzQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240404111953.99287-1-francesco@dolcini.it>
References: <20240404111953.99287-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] ASoC: nau8822: Remove unused member from struct
Message-Id: <171224107961.46716.14189956703769244988.b4-ty@kernel.org>
Date: Thu, 04 Apr 2024 15:31:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 04 Apr 2024 13:19:53 +0200, Francesco Dolcini wrote:
> Remove unused mclk_idx struct member.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8822: Remove unused member from struct
      commit: 9f1aeef4cbcb0e8c616e29cdce3232f9f102c2c1

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


