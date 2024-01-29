Return-Path: <linux-kernel+bounces-43290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEC18411CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F002821D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB556F06A;
	Mon, 29 Jan 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmOdqQRQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCDC3F9E3;
	Mon, 29 Jan 2024 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551988; cv=none; b=EA3E1atsJijdH5UrmGzYdp48GCZIpGDjiN0UgW/NjM92qGySpbz462JvqvsoLSbJAY0VrSa5C4bI5yQUjwBSw554szdMlEfkCOnp6JPIGdNYEhVE2ceDsHvnSv63Uk6CZDZM47ZzQpYHYPL83mXzIk4LIHTUHnz1q4qlsnviFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551988; c=relaxed/simple;
	bh=u2QozD7LnyzCSm5BELpLWaOqEEfW4Er7azNLzRX6Ww4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bNEjci3u31dj+x0SRNzDobibdz8ZFquY/lK0ageb2G3AH7wje5uetfZ2gaSqMqBe1sNhhjkZLljQ2ekeIwRCvopj3RD6cvGIZUEWJ7YPFF+yFNVFsyjs41ZIus7JmNWT6xm8jpApn/Wiavy/WKv8PxfVtwkMsDiSjdcvBTDXdEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmOdqQRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CB3C433F1;
	Mon, 29 Jan 2024 18:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706551986;
	bh=u2QozD7LnyzCSm5BELpLWaOqEEfW4Er7azNLzRX6Ww4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tmOdqQRQvBS+fc5uIk5mzMmtiNFeXZt2qYtIhNFGBcLptme+HLoNvqire9l748F9H
	 ZVZxP/MMjQOgKlS9PKVdhzdLZ1MgRDxPXaYRZRqrgEM7gLchvedZecFgV99JTKzeGs
	 +M+IQuAwfaaw8Ucpb4ZTjYR7nOERZo5+841IyIjEDyOdVSyy7v7yia7EC9fGmWhs1S
	 EOaboyYj3X1jnI8uitAl43lt10gu2a6U2kO9dWBuJMpUstDkzcvRd4N69WiDfCR541
	 z9qS5+YwTo2uhs+35mtT4Xgqw6IPiQ3LkxgpS/wiPBG9e1zOU8rdXXnf7LouBNj/KM
	 BIQJjDyG6b3Sw==
From: Mark Brown <broonie@kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Linux Sound System <linux-sound@vger.kernel.org>, 
 Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Jeremy Soller <jeremy@system76.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Techno Mooney <techno.mooney@gmail.com>, stable@vger.kernel.org
In-Reply-To: <20240129081148.1044891-1-bagasdotme@gmail.com>
References: <20240129081148.1044891-1-bagasdotme@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI quirk for MSI Bravo 15 C7VF
Message-Id: <170655198308.64325.7818077761213434201.b4-ty@kernel.org>
Date: Mon, 29 Jan 2024 18:13:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 29 Jan 2024 15:11:47 +0700, Bagas Sanjaya wrote:
> The laptop requires a quirk ID to enable its internal microphone. Add
> it to the DMI quirk table.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add DMI quirk for MSI Bravo 15 C7VF
      commit: c6dce23ec993f7da7790a9eadb36864ceb60e942

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


