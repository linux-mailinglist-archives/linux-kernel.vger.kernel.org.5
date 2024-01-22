Return-Path: <linux-kernel+bounces-33706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2072836D80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B341C2670D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE10768EA;
	Mon, 22 Jan 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIMtk+0f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30FA74E38;
	Mon, 22 Jan 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941229; cv=none; b=S9ClxrWBurCd05ueV5ijeU5EtdnaJWpP+Gopr+F0495yIOzx9bycUzGFZ72pPTkfij3ceNbS5674ftsWs+r8br6mWx8KOOtWfgOEwrdLgnz/yTmCXm4Uncv311dOuUsXXVOF1GXEN6iHREf+AZdDm+vw1Ibzk/KyRwgI8aq2lD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941229; c=relaxed/simple;
	bh=hgeJSGoUaeYNIXL6Xf7WNoNvNTqsR2jfZ2ooRLMH4xs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JWfv9ud9qMuFbUfTO0P+pJKfmF1ufaEsewaQVX7pq3sRnaEkfb4Cu8RRTgvc9xRN5sdD8kW5TVNVzSqMJtHOlV6qFTgTVUaywPKoeSZxMcLAdak/IR9L9RqlCvFm9BSJGYj8jn2DebaqJKid/msGMN7cI11YrwDFdXI3yYfBuu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIMtk+0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCD9C43394;
	Mon, 22 Jan 2024 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705941229;
	bh=hgeJSGoUaeYNIXL6Xf7WNoNvNTqsR2jfZ2ooRLMH4xs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MIMtk+0f6FZKxMRfLtXWFObsVJQNiu6ShGqdHx0dQry2jbI3RPeKK1lZZ+R5MylX0
	 zPbxi9+3RQ8Y3iLZR+3j/shXv1UfLf8d8mXFHZq6Fzwy4ESPr11vKP839V88ytv4jx
	 pWx5sDjGfQyGt7XrYZedf+/rjD/EQG6H6ufK72ZvO5IMOeYvxAfh1Ai7YqviMnkWEV
	 Vxo7tqLbje/jJb4WixrAI4i+I0dhp9ubriyh97EyGFwMQBkcaISFmKX+dpKIlZ7a3c
	 fiiVv76dj0UUfYhOZd8b6mavME7kpe8PLUN3pK2sqIE0hu+Fj0UzZHNd8gXp1Yp/E9
	 io2KbUP+VdV7A==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20240111045736.7500-1-rdunlap@infradead.org>
References: <20240111045736.7500-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: p1022_rdk: fix all kernel-doc warnings
Message-Id: <170594122789.63484.12376608294945016367.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 16:33:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Wed, 10 Jan 2024 20:57:36 -0800, Randy Dunlap wrote:
> Fix several kernel-doc warnings in p1022_rdk.c:
> 
> p1022_rdk.c:70: warning: cannot understand function prototype: 'struct machine_data '
> p1022_rdk.c:90: warning: Function parameter or struct member 'card' not described in 'p1022_rdk_machine_probe'
> p1022_rdk.c:90: warning: No description found for return value of 'p1022_rdk_machine_probe'
> p1022_rdk.c:129: warning: Function parameter or struct member 'substream' not described in 'p1022_rdk_startup'
> p1022_rdk.c:129: warning: No description found for return value of 'p1022_rdk_startup'
> p1022_rdk.c:162: warning: Function parameter or struct member 'card' not described in 'p1022_rdk_machine_remove'
> p1022_rdk.c:162: warning: No description found for return value of 'p1022_rdk_machine_remove'
> p1022_rdk.c:187: warning: cannot understand function prototype: 'const struct snd_soc_ops p1022_rdk_ops = '
> p1022_rdk.c:199: warning: Function parameter or struct member 'pdev' not described in 'p1022_rdk_probe'
> p1022_rdk.c:199: warning: No description found for return value of 'p1022_rdk_probe'
> p1022_rdk.c:349: warning: Function parameter or struct member 'pdev' not described in 'p1022_rdk_remove'
> p1022_rdk.c:376: warning: No description found for return value of 'p1022_rdk_init'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: p1022_rdk: fix all kernel-doc warnings
      commit: 90050b8d2e1556238d4c69abc11270de523bf955

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


