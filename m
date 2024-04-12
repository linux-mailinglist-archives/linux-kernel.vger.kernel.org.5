Return-Path: <linux-kernel+bounces-141756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462318A22FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B0F1C227EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD882107;
	Fri, 12 Apr 2024 00:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNdyU1Ch"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DB205E14;
	Fri, 12 Apr 2024 00:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712882473; cv=none; b=kFymivb33fQDDepspufrqgqu288N+xJh9b/tmUpZBbAEpiqumIQSFvtusZAx8f6ggLC6WXwRzyPw03YxX0uqTLcklCXJnHSbdsbmySFa7wP25fX7Wo64VswtKFcYwresiQ9HNJaGGykoD9s+Vh11Q8LxwinvNsrKjyoMpTM0XgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712882473; c=relaxed/simple;
	bh=tkAwC8xYx2SEMYsDRYYQ97QABsmy3xXHEjMopBbT+c8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W6Oc1qylgm7O8LMUKrCt4ehEaIJy7kx29WKZSVJZfOkhT6ONlNGUe0L2x8YMDQPTZRAs/F2HGaRDNpi8UysaRu1Lfrh64VZbsYxDdP35gVe5wT7SqT8M3k6u7uPBa8EQ/KH/uzyy59ga5IKeG/PuMuVRY6W79wK8ULvPgq3qSao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNdyU1Ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1D8C072AA;
	Fri, 12 Apr 2024 00:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712882473;
	bh=tkAwC8xYx2SEMYsDRYYQ97QABsmy3xXHEjMopBbT+c8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bNdyU1ChaQuXySi1UCUMOwqufaYdRlPh3Y+g2ASclM16FitpF0x3TWGfDh1b4j6Fy
	 gHaUvNHwpzh7tpoh5MlJIvdxgQ7QB9bdGEqtc2e4LlRSLbBsFxcu32AKqxs8QQ4nYJ
	 G0zWoM7HT3nh/8KFZbrkFzrefPRMKAGJznuW1aCAgpRYIk5gqFzdU6+oC7veRazQh4
	 sfUlK6sugnZjU8YhIgRPzJ9bzGlzP4h8B6GnwwWyDjk/y4kyYjSwNOa5urJ71yHKae
	 B4mHUlDFoh0s5DiLY/Ab29znpyGzR3XxqRZFzFGrjlFiK3P/JgyVpGTkibqXxqD6BU
	 SCLdwdeaZhlsQ==
From: Mark Brown <broonie@kernel.org>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240411142648.650921-1-sbinding@opensource.cirrus.com>
References: <20240411142648.650921-1-sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v1] ASoC: cs35l41: Update DSP1RX5/6 Sources for DSP
 config
Message-Id: <171288247200.110635.15927713546125669144.b4-ty@kernel.org>
Date: Fri, 12 Apr 2024 01:41:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 11 Apr 2024 15:26:48 +0100, Stefan Binding wrote:
> Currently, all ASoC systems are set to use VPMON for DSP1RX5_SRC,
> however, this is required only for internal boost systems.
> External boost systems require VBSTMON instead of VPMON to be the
> input to DSP1RX5_SRC.
> Shared Boost Active acts like Internal boost (requires VPMON).
> Shared Boost Passive acts like External boost (requires VBSTMON)
> All systems require DSP1RX6_SRC to be set to VBSTMON.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l41: Update DSP1RX5/6 Sources for DSP config
      commit: eefb831d2e4dd58d58002a2ef75ff989e073230d

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


