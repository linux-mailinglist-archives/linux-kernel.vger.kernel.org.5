Return-Path: <linux-kernel+bounces-91247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905CA870BB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C238B1C21EB0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420A4947B;
	Mon,  4 Mar 2024 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV2kn3tf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EDC79DD;
	Mon,  4 Mar 2024 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584771; cv=none; b=EA3eUF7hhKKyIr0eGR5rqljUkCoxJGTXTyzEULl353Xcmq2wNt3jOHiykk/+wegHSkvnM37dxENHNHGnIYsBGYyZTLzQXR2DBscnxUN1Hm8e2h/QM3rzekiaumhPSNUawy5h4IkspiAJWFTffbVbK58EyAwKiA7zFQLHLBpZMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584771; c=relaxed/simple;
	bh=/Q/Cj/nBkg/QqHFrf+eC4SDBX6kh+bANTmDJ5SPhuWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bE8iHpXrxtNaaf645NlkuvlBDXXS1Ijtwald8EiYYciO7VGQKXGx6V75+4dDqJ1I4HDOnqDacKyE4Pg5yjjHp2xxNTGu1E9TGAm3ef2Wp8xPe/TjgisMVIURRJjOyqdDEaOY0XV6OxSRHTncBqIIGt6tx7CMlGSyPFg+bFyJwOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LV2kn3tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67150C433F1;
	Mon,  4 Mar 2024 20:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709584771;
	bh=/Q/Cj/nBkg/QqHFrf+eC4SDBX6kh+bANTmDJ5SPhuWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LV2kn3tfTPUrGnC5BY8Ca4dExMdBBzfXgGPeun3Lfl1EBty3+wLDNqbvSSnaO1Ba7
	 0vWGvKL9UhA0x4/B/XGEIGVlOXDQiE7eYUvrISV/G3oIQ3PUgbL1RzWJmbBi3fhDO6
	 n93+ew+plzEb7F8A1qlPnzgFPsdV9yrKmLRtQlZ4gvt15twlqAQ92/OJjLNFRsdr4A
	 3iG0szjuzIQcJMsigDmdeWcXQC4BuDO4qUeNR5zCQM047NWUDvgTFRXDpCeNeVrvQd
	 f+fr6q++lwEnlG3LNG6CG+U3vGlTNljmE+oAgdtLkt47cwh//kyJJdYs4Ur1tdFMdv
	 ITFsXQn1Uhx+Q==
From: Mark Brown <broonie@kernel.org>
To: Al Raj Hassain <alrajhassain@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Jeremy Soller <jeremy@system76.com>, 
 August Wikerfors <git@augustwikerfors.se>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240304103924.13673-1-alrajhassain@gmail.com>
References: <20240304103924.13673-1-alrajhassain@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add HP Pavilion Aero Laptop
 13-be2xxx(8BD6) into DMI quirk table
Message-Id: <170958476915.789715.6973674715872746011.b4-ty@kernel.org>
Date: Mon, 04 Mar 2024 20:39:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 04 Mar 2024 16:09:23 +0530, Al Raj Hassain wrote:
> The HP Pavilion Aero Laptop 13-be2xxx(8BD6) requires a quirk entry for its internal microphone to function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add HP Pavilion Aero Laptop 13-be2xxx(8BD6) into DMI quirk table
      commit: b3a51137607cee7c814cd3a75d96f78b9ee1dc1f

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


