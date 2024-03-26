Return-Path: <linux-kernel+bounces-119821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402A488CD58
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B56E1C2E029
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC5013D27F;
	Tue, 26 Mar 2024 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eb/8fzo0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA213D265;
	Tue, 26 Mar 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482023; cv=none; b=BT4ONRTZHGZ8CLiFkYvhS+wD3y7jP8znHTXLtAxP7xN2Etffk6RuZMT7H0Ee+Xv1nXDjnzAxhFbRQUpUgu+FubTBhaSatsFHtTgBAy9u/HPR54W69+uT0DXmvNf1TKAZ02rw3V+yWoIlHbjBygLEm2dkw5HhHZC1x6/Eq2IK8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482023; c=relaxed/simple;
	bh=uSqvDhj9B952JToi5VL34sNCznAoHgfyEhJAjUhjfD4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P1SS5uwv0kxYGuURk6P+j2o4RZwPQiOtAVWCMPaFS4x5KhASfYqNiQ62IKwChxS/yrygCjbN4pUSqZZ/TBAJq964bIuWl/w44YqzVFAHVOutLASmrwU12NH/6utbugpwVuInw0oG7XCuZoQz1vHuEITi+msgsaWI83v6QOUBZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eb/8fzo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158DAC43390;
	Tue, 26 Mar 2024 19:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711482023;
	bh=uSqvDhj9B952JToi5VL34sNCznAoHgfyEhJAjUhjfD4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eb/8fzo03WGpnZufwM6MUoiC2Q5Hb8WLpf3l7Iqyt/tx1aQpauV1EXWarBhyZGtnu
	 sbACG0VuDG4FJszAzIb/iem7tSzVDB9S9It64OYqUlzQ8kegJlHzvg8NM4YZw5CP3V
	 cHB+wwQAWHSm6bwDrZSFoY8j1DR/Oi4C0ymM3lrenuy8zHMAw9j45iW/vUzzYFGszw
	 QcBMwVOSBY+L4RI83Tni0d5B+giqMd5JKZISaO6ey3uH9zl7+rpj+tVGi1l6TQXnPY
	 pWOhEzpqY0tAcOrl25B+5OfLQk8oUHkYggYAjEHHWs1Beq6Ywi7DlMgJU711NAbmAC
	 fkqGx9D7qazJA==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20240325143654.3305498-1-andriy.shevchenko@linux.intel.com>
References: <20240325143654.3305498-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Message-Id: <171148202182.195485.3428083891126732883.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 19:40:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 25 Mar 2024 16:33:50 +0200, Andy Shevchenko wrote:
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


