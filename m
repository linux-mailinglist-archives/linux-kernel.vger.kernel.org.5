Return-Path: <linux-kernel+bounces-37489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAB083B0B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA231F27899
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A2A12A168;
	Wed, 24 Jan 2024 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc0M2Dlv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008A12A143
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119889; cv=none; b=HLCDtv/5vFyKyh0D5nNzrcGYEiF/B+xFZ9qD/RD8muZKcWKn08L653hK6349fEiKEZGqvRGMVDcv0Zop0jUxNpXFsVx7MvqVC51i5PyiTZQzZTCWSog4YfZe8mfV808Nmts9sURUfMTltSbh6Khkhetsps7xDe1gDuXstVyjOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119889; c=relaxed/simple;
	bh=M/SvjKa3NWFAUdAx0o5eriPvq1jr5K+9kQRZKrjksHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bJ1BTzQhlNr0OppHjQ9V/l3Bi78mH7dFq156LYN2kzlUx0VLB+q6wsj7aqwTL9MMpXNfY03/OKaCbxOL5Kz9QKOhd5luomvW6sVsKRq6SDpNL61tHJZHlEkm4pwZU2AcMrlmP4OVbjn4JKxAIJmnXuQbwH55imnSkt3G+dQGSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc0M2Dlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253C3C433F1;
	Wed, 24 Jan 2024 18:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706119888;
	bh=M/SvjKa3NWFAUdAx0o5eriPvq1jr5K+9kQRZKrjksHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Pc0M2Dlv2lD85jKGbGID5MchSuDGqVsVeFXHikzdysQqUyKrD9yOmjoQCE/we84ZZ
	 GNj4J4LEJ4sCHzguw+3+KX/tHqGDWAoEofNTSb86C+zrY66nnOq4CRgpG0dF2ZBsNd
	 HOEQ0GHkZSXKZXaFAOWGSoivsbdR5gomp4PD7nNPpvcZklOk4s7zOI1Cs3/eHNoQKp
	 LbLE60FJFijW9UmTDvHClLAr3EQzaH3GxksNu18v06zjH8kgtsGLNYoD9eJ+xJa8Fp
	 vrP9WX1moHeiMTrmCrLUfreVh1+fjSGb3XXqkDxioIeeBr5CXQKpPJYc60vMan9L6d
	 rBJ3VMy8sJBAQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Herve Codina <herve.codina@bootlin.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20240123165615.250303-1-herve.codina@bootlin.com>
References: <20240123165615.250303-1-herve.codina@bootlin.com>
Subject: Re: [PATCH 0/1] Add support for the framer codec
Message-Id: <170611988686.57208.13181794312584439477.b4-ty@kernel.org>
Date: Wed, 24 Jan 2024 18:11:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 23 Jan 2024 17:56:12 +0100, Herve Codina wrote:
> This patch introduces the framer codec support.
> 
> The patch was previously sent as part of a full feature series and
> was previously reviewed in that context:
> "Add support for QMC HDLC, framer infrastructure and PEF2256 framer" [1]
> 
> In order to ease the merge, the full feature series has been split and
> needed parts were merged in v6.8-rc1:
>  - "Prepare the PowerQUICC QMC and TSA for the HDLC QMC driver" [2]
>  - "Add support for framer infrastructure and PEF2256 framer" [3]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Add support for the framer codec
      commit: a9a0303dfe3fe2bc04512c4ce6a589131845d386

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


