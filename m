Return-Path: <linux-kernel+bounces-119310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC988C6E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41761C63D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F94F13CAAF;
	Tue, 26 Mar 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMNxPmoG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3413CA9F;
	Tue, 26 Mar 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466865; cv=none; b=cqKggLcT3e2U7TiRGpPdqaXwac4RyQIqf+RT3nOFyaJRbMAnDnQOW5pY9S7oWVLDLh34QHqWDpkjxbRdA/zh+272KtTgU575IuVOCUX54pGAR31gHuVh2c6ybjFIHY4AHEBjxzsHHUTm4J1xfU4r8qkpR1Orv24ZoEA1rkCRKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466865; c=relaxed/simple;
	bh=Dv7kla2wXTBWaUFc8gXermZZFBwCn4/sPhbYUztwuig=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MW55uVjZW9IVMVjJB+MDlRtSo1CT3OSPgynMy1DvRo1toVihsJLCqGbdmMf4qwlR5u3p7kJuqSBL6CtW91/ytzNb2dhFX4lD904OYttRjOoOIjV119TRZB1f9zu+IRZv+0twmyFPEb04NMMx4eUHKnf3/QkdU1CFojybySwYiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMNxPmoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE75C433C7;
	Tue, 26 Mar 2024 15:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711466864;
	bh=Dv7kla2wXTBWaUFc8gXermZZFBwCn4/sPhbYUztwuig=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PMNxPmoGnIkKBoxMQ7NlvSusSDWPx4IQBTVlGLdiZB5Ydgg3IR9sSfFXFFvIoBrVV
	 tckzBX7YawyPRIpxIboyttm/BMHS6MpsBphw11xVj2qFiqaQdiqn8VkjkMu8052PI8
	 kZuNQ0/SMOslKDmWxS81GlEpikjbcTuTnPGksi77GqrrJ51JVImhkth4CpdGcO9Hlz
	 XPsqRDphqxclYhmEcfYyWsJPFqumvDW3fvvvIMwBXm8N5dDXT6dWL6lz7vdZrbCJoz
	 EizinUnbCcXRYVtbWxKbl+HsGeViDLfKro0uv95jmaiIbzQhwmLgAUzgh8v7FIYGBf
	 cXLQnInvJdCWQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev
In-Reply-To: <20240302140042.1990256-1-megi@xff.cz>
References: <20240302140042.1990256-1-megi@xff.cz>
Subject: Re: [PATCH v3 0/4] Add support for jack detection to codec present
 in A64 SoC
Message-Id: <171146686191.132239.8280140430376443574.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 15:27:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev

On Sat, 02 Mar 2024 15:00:34 +0100, Ondřej Jirman wrote:
> This series adds support for jack detection to this codec. I used
> and tested this on Pinephone. It works quite nicely. I tested it
> against Android headset mic button resistor specification.
> 
> The patches are a rewritten and debugged version of the original
> ones from Arnaud Ferraris and Samuel Holland, improved to better
> handle headset button presses and with more robust plug-in/out
> event debouncing, and to use set_jack API instead of sniffing
> the sound card widget names, to detect the type of jack connector.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: sun50i-codec-analog: Move suspend/resume to set_bias_level
      commit: c0454d31e05062b1c7df7eef21855ba1f56c5158
[2/4] ASoC: sun8i-codec: Enable bus clock at STANDBY and higher bias
      commit: c556814b926c3f16fdca3d18cac793ccf0d14c44
[3/4] ASoC: sun50i-codec-analog: Enable jack detection on startup
      commit: d5961e43b28668088087befbf4f7a043bd0ae65c
[4/4] ASoC: sun8i-codec: Implement jack and accessory detection
      commit: 21fa98f4197bb3365dda1417708b318f403c13c1

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


