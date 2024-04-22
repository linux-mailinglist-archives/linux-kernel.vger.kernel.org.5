Return-Path: <linux-kernel+bounces-152938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7122C8AC65B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E49283216
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE540482EB;
	Mon, 22 Apr 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ntu66SdQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0704351C42;
	Mon, 22 Apr 2024 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773352; cv=none; b=H1dOrGTgMiouEmdQ/69sSfekd/Lr94QrpiaE+5ONt2sh0/NMTuZH716Eijqm49R1QL55oxCQfL6DC7D06Fp0jQ7gFy5CKE+XgtJ7mEOubBOTZEzO5NUfDBfUy3YnG2SSVYO6a7sRBahuziApDsrt79m0DtsVYDr9CgOsbytmfbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773352; c=relaxed/simple;
	bh=Shr409Fk8aEVa1W7Kl+fmJiGHlAFeZeAP4p3RS6tk+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fpalE4d3pBPIfWn9ImoncaRbEJckIeVtGtlSpYNjybHT8GyXy/f0PY1YG2egJEDRPEBU5UO1VEVElRoUf+LGGEpN6QV+cVkezUP1ZXCNIA8XZfDWwzbu8t+8CZt29csiBXcJORWNAHQlfkcDJAMDWm5KiPpfPMO0LVGgJEvAX48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ntu66SdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3678CC113CC;
	Mon, 22 Apr 2024 08:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713773351;
	bh=Shr409Fk8aEVa1W7Kl+fmJiGHlAFeZeAP4p3RS6tk+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ntu66SdQY/fxepIQGiULkIM/vnCJuFEZgXRKcLlbWOObmyGJDeWBVrhv98ZJ1rqgF
	 JfhUCU4XSCQs5ZQfS90Yt0tA4l30XfYnhkb9ja98o0MLiD3Or7tivevOUN1E+KVs2s
	 0qNMZWHMMhDj3P3Ao6pPkDLhvCvVA7ZYvwyaEln/gOX+KhE//xEqnmPs2VAvwOfd4d
	 zHOX86WljvHcKf5PaKY+6Gk8NQh7IBXW1FsL2qxNKDfLBhiXBZ7YtHdYA34moxE0ir
	 iYvDdmU4GIj89s9ARUlL0zctmsXyC7pE/1Z4F2wT4h8TKCiHc07IHJFzySqfEtLVBh
	 mW+2nkzHIeFUw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, 
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
 Mihai Serban <mihai.serban@gmail.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240416-vizdapm-ng-v1-0-5d33c0b57bc5@bootlin.com>
References: <20240416-vizdapm-ng-v1-0-5d33c0b57bc5@bootlin.com>
Subject: Re: [PATCH 0/3] ASoC: dapm: improve debugfs output and introduce
 dapm-graph
Message-Id: <171377334868.1755143.5418794002755398989.b4-ty@kernel.org>
Date: Mon, 22 Apr 2024 17:09:08 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 16 Apr 2024 08:00:23 +0200, Luca Ceresoli wrote:
> This patch series improves the tools available to understand and debug
> DAPM.
> 
> Patches 1-2 add more information to the widget files exposed in debugfs.
> 
> Patch 3 introduces dapm-graph, a script to generate a picture of the DAPM
> state inspired to vizdapm.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dapm: debugfs: add component to route lines
      commit: cbd9eed87107bb6d6e537e79aeea65399898ca41
[2/3] ASoC: dapm: debugfs: show the widget type
      commit: 5b1047dcf80b35bafcacbd10b57342d1a96139c0
[3/3] tools/sound/dapm-graph: new tool to visualize DAPM state
      commit: e7bb43898bcf54da7ffb4819a04c8428f7db24db

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


