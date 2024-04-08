Return-Path: <linux-kernel+bounces-135792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C125289CB5C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005EC1C21758
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AAF14430D;
	Mon,  8 Apr 2024 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVkqRQs+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E741E489;
	Mon,  8 Apr 2024 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712599144; cv=none; b=RvgO0nP55dlkAtj51PQJo3vm/85t5ETcvYJEY+44YGSSXLvupEKZwojsjfbgNjSHWy9HUkSeVwxKsEiGsFSD7FRyAKCwnfDHqPsbuWVqU/x8bCFFSuROgutCP14q3fPLWwajhj7rGEOkiQ7DTLV9UuRNsDSj5glWPuC4pmsgbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712599144; c=relaxed/simple;
	bh=DMDhTUddn0z/kT6115csMSz16dwSMlBikZA7r7PGvHc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g4K6x/8JjiZf4SEWc1aeY+qOh7J+UjnC0UScNpLzloaHX/ih7yKXsz1eJ8MGhNTLK6B73mMEoJAkkzhAo+B0GAkQYDhnSv0Hh5aIwoNKCgzf5j3t2lXD/7LK5O2uc1N4CRQ1OhCm0ZEQeM7jx2dP9c5VcGqkaLPF7sqNVcL1DJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVkqRQs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31482C433C7;
	Mon,  8 Apr 2024 17:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712599144;
	bh=DMDhTUddn0z/kT6115csMSz16dwSMlBikZA7r7PGvHc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WVkqRQs+vE4iD1ZVjoNt5CwtkG0CGRrhP0Hon1ObKqaA/c0aX+A0fRpnhk9wD2pto
	 LZsrjdJ2pgn8XVTzms+dHEuCBG4bBaTvx/JHdj++E2CBj+vOw2VCKjvsS6WhDypNoq
	 wFZk+gimyZFlScbJPL3AODFCVQ1gDAJSr1jNESSAC9nBf8us8t+HaEBGtfwhJN4ozy
	 wtnLCVgG2hiIGgOBUIC+l03/jBSYTXa7JCA36D6D+zgkB7zVvOJD6I4PpSfBafVMB0
	 8Q17gDfX6MGxzHj4N7BpwLFgjTFG/n/O/ZPv+R4A2C46n7IRHiNuoASeuXwEaQcddW
	 w3T7EJTuWE/7Q==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
In-Reply-To: <20240408042331.403103-1-quic_mohs@quicinc.com>
References: <20240408042331.403103-1-quic_mohs@quicinc.com>
Subject: Re: [RESEND v3 0/2] Add support for QCM6490 and QCS6490
Message-Id: <171259914092.121643.12184524914448906569.b4-ty@kernel.org>
Date: Mon, 08 Apr 2024 18:59:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 08 Apr 2024 09:53:29 +0530, Mohammad Rafi Shaik wrote:
> This patchset adds support for sound card on Qualcomm QCM6490 IDP and
> QCS6490 RB3Gen2 boards.
> 
> Changes since v2:
> 	- Modify qcm6490 compatible name as qcm6490-idp. Suggested by Dmitry
> 
> Changes since v1:
> 	- Use existing sc8280xp machine driver instead of separate driver.
> 	- Modify qcs6490 compatible name as qcs6490-rb3gen2.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: qcom,sm8250: Add QCM6490 snd QCS6490 sound card
      commit: c64c4e3f789123e82ffae3404d108cf826c9599a
[2/2] ASoC: qcom: sc8280xp: Add support for QCM6490 and QCS6490
      commit: 5485c3fa96f78314207a30e81dbe270424d70ede

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


