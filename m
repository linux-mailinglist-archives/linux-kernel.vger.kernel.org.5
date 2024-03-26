Return-Path: <linux-kernel+bounces-119822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C8388CD59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F771C35AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C57413D2A5;
	Tue, 26 Mar 2024 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWBxELgD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53613D293;
	Tue, 26 Mar 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482025; cv=none; b=tVD8UtH9pq/BLgdJYrJsglHiLbQU6VEc2bD3jcgLdlm0NFimLEhzJWxd1Q9tZ5bUTKbu0eTHLgx1KqqPCW2YgvoqYab7X3on4iMvqbiTKWSLDN7YyB2Oo9joWQsGBLiv580KoUvnhW7AZd139KQP5Xq/1WTjRFRLtzpsMR63bUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482025; c=relaxed/simple;
	bh=x0TTBRigEsuZwoi8waGTwMiUmmSaW138ZPTL9PFeVe4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PAmr0OcDZuczOvK4SN14NyTl4RH28GqlJ6YPQcDn8gBhcyqTk3lZyRiREawcyNrTOjEZ3Z7V1cavRQUR9RM0BbVpphVFAS/hF1C22C3CSgFkz7nQMVjgnIS37LQ4huyVOd9nvB9qLgBz0FNIURChurAZAvfQgerXQ8NJYxnd4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWBxELgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8986C43399;
	Tue, 26 Mar 2024 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711482025;
	bh=x0TTBRigEsuZwoi8waGTwMiUmmSaW138ZPTL9PFeVe4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BWBxELgDsZ0DEW+f6ZFmjGZv+imC3IgkjGQ6idn+Vk50cKqPZeRrIqa6M1eddxIYA
	 Z74+W6g+4x0+5SVki4gnig7y1sf/2RM8eLTOuNbmaW1fkDl4/ZYRR4dQhDbd1NX5cc
	 aORv+96x3qCcTlrqZ6H22lItVrZwfdvxAhU58BGr2lCrXsM5TVqSV0sO5CBAq1LkWy
	 Xw7y1QbMm54RHNl7GIGr1TTrhy5LYUeplhD/wGUBNIEISVTGnv00SgPHTzyW/QXSd0
	 8ZsGHlF6kmB7kBA35V33ZDxbqw2vPz26HiZiNtbIKVokdrd0insLR+Xh7K7LE1tJIS
	 Px6LYnwhC799Q==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20240326171134.1414462-1-andriy.shevchenko@linux.intel.com>
References: <20240326171134.1414462-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Message-Id: <171148202361.195485.9515319942433271607.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 19:40:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 26 Mar 2024 19:09:48 +0200, Andy Shevchenko wrote:
> No more users.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-jack: Get rid of legacy GPIO support
      commit: 7b95ee0db7e0a7f99077f1b926323c7bf0d2e8f8

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


