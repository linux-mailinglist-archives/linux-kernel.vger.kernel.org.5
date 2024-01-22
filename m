Return-Path: <linux-kernel+bounces-34212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E5F8375A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026B11C23561
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6E148CCA;
	Mon, 22 Jan 2024 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOEkwOQI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71646487B8;
	Mon, 22 Jan 2024 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960458; cv=none; b=G/9rTsTQf6y4eiAYj5oRGgGFkzYQ/2jQK0Ka4qn+6YvRia1Syl4jUiAeQD+NIDSEM9FXUKcZnUx86IEXu5UOZfPp+DKhVnrRxBnfDtnSkwt2C6Mbys4dfq3OUOXc/FVr/6E0ecUiVHewmn8cuCjOyoli5Pqb3oiXZqvKdzXzGhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960458; c=relaxed/simple;
	bh=4Bz1DD90hbSr+QDM9o6ei83T0CBo8SWVx1b2kI4unKA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eZ2OsgrwHeaMIi7dYaS8wqY6Q7HUFpMgonqGMc1dEZsNA4TXHwEg/K/a8d+ssCWVg2xcO0V0H7hIyRKx0FwW2eEFk92PbQFDLhMWTMOFJ/Icqaey56HWunNniahtpRQSOlzJlAkNVKgPonBIrgaMuwx6q/EuBsoGx7yb7+u9UdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOEkwOQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6B7C433C7;
	Mon, 22 Jan 2024 21:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705960458;
	bh=4Bz1DD90hbSr+QDM9o6ei83T0CBo8SWVx1b2kI4unKA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SOEkwOQIN1dYHbkNB3myXMNJEhBKc3YUqOCR9vip3DqnSpcgpcH1rAt4RCMqAWG9X
	 y5x/2qKyui1xbBzG1xCsy6igPtTiitq/jW5atXchbWcoPg9f6BOd93HlD+bka5ipcU
	 x7sA15g5iIpdLj8+tr5hFRdMX1JCEQ55tptqTzYIW41AcE4Zsk9Km4hbGoNEKTT+8L
	 9APIss2jLIx9QVetrAv1jWoDR8G6l/Sgkk6jVdHHSPsRlIkz7vsxIfwNzmWDxSMmdX
	 vhpb4/qokfGY0Pn0o/54HdJI329fVknYf8/LP8RR8T+m/EE2ea4JSY6x6NMt9kbrJX
	 mLc0gN1p1N6iw==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240122181819.4038-1-johan+linaro@kernel.org>
References: <20240122181819.4038-1-johan+linaro@kernel.org>
Subject: Re: (subset) [PATCH v5 0/4] ASoC: qcom: volume fixes and codec
 cleanups
Message-Id: <170596045583.161959.6600754837297158632.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 21:54:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 22 Jan 2024 19:18:15 +0100, Johan Hovold wrote:
> To reduce the risk of speaker damage the PA gain needs to be limited on
> machines like the Lenovo Thinkpad X13s until we have active speaker
> protection in place.
> 
> Limit the gain to the current default setting provided by the UCM
> configuration which most user have so far been using (due to a bug in
> the configuration files which prevented hardware volume control [1]).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/4] ASoC: qcom: sc8280xp: limit speaker volumes
      commit: c481016bb4f8a9c059c39ac06e7b65e233a61f6a

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


