Return-Path: <linux-kernel+bounces-94148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0FE873A93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D61D1C21568
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45DE1353E2;
	Wed,  6 Mar 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpy6c0Ln"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076531350DB;
	Wed,  6 Mar 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738559; cv=none; b=MIMCrs2Vu3y9ieD3GA39MtItQqtK2obvnHQXfWNP4p7kzdfi3Ut5xviSkKmoWIV9oXDgWy65f6lRH9L2vtJstzjVQTGQezCTV6ZhdEMbEEGKu3p8L1lSxb9vFBr85uaWczzSxYveGb3xFY1sLET4PTr6cF3qlKBIwuxMv5c1YIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738559; c=relaxed/simple;
	bh=K4mNCj08w5B9WhdrtZjpgOlIWD7LhssF/CfXpz3eP84=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YtuT74tikJ7gwhycvRVx1Gqwiil9Xva5hAMHvDGdxm8vZ+0wE0MTy5R91AqQvVdtwyDrCbIwrWIt2DqymNBrf6MybnnfX0XgV7OzjVhhS7E/ojdpoLDmmrH1iRstp+fQmgqt05EBsaUax+1F/xtExWd6c69lSPphx7OXWVVUrNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpy6c0Ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A01C43609;
	Wed,  6 Mar 2024 15:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709738558;
	bh=K4mNCj08w5B9WhdrtZjpgOlIWD7LhssF/CfXpz3eP84=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fpy6c0LngM2uOXckroCsfm+J4jRRCGLLcBI5dI+v9hxk2VLjr+Jf3Z37ylBbBCFxZ
	 rhkRSdqzRAKP8UJxqxpb3pRsPVd3S7qF/KeTcFdCv/dtDymmaLx+PtJ7Lmc7/lLtnN
	 jb9NRNgA7JU1dMiAvZD427oAJvD2ZKXfyLGe+nU38SVQHoTaVdwXrI+BGRxgXYTq0b
	 XsKE7tstCH7GPe1O205kUf5rPK5H2YRRAnSlK7rNb8zP5oxQvkFHi7y0TnhU3nFedL
	 pI+DfRal+XzPVzialdhDs0zsI9nCprI1f87YT5+7Kwu4HiHevhJBxV0lNhVV5aIBqQ
	 17abCexlD/YlQ==
From: Mark Brown <broonie@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org
In-Reply-To: <20240306-improve-asoc-trace-events-v1-0-edb252bbeb10@bootlin.com>
References: <20240306-improve-asoc-trace-events-v1-0-edb252bbeb10@bootlin.com>
Subject: Re: [PATCH 0/2] ASoC: trace: trace more parameters in ASoC DAPM
 events
Message-Id: <170973855626.169634.1190336120832781650.b4-ty@kernel.org>
Date: Wed, 06 Mar 2024 15:22:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 06 Mar 2024 10:29:59 +0100, Luca Ceresoli wrote:
> This small series adds parameters to existing DAPM trace events to make
> them more informative.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: trace: add component to set_bias_level trace events
      commit: 6ef46a69ec32fe1cf56de67742fcd01af4bf48af
[2/2] ASoC: trace: add event to snd_soc_dapm trace events
      commit: 7df3eb4cdb6bbfa482f51548b9fd47c2723c68ba

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


