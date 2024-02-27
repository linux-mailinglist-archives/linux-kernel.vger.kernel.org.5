Return-Path: <linux-kernel+bounces-83996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC15286A12D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C8E288A61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E1214EFEB;
	Tue, 27 Feb 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSh5QlaE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408F4DA0C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067117; cv=none; b=etE3fVGRsnfVzMXEfY0vXaVbVzAfgI1zBSysnAknK7INEyu4hlKLzmvd3kR/9Y4lTj0SqKYKJ3yOW1+H9BWPfk13XR+SNAilrU6fniWiKG+YoWsKnMT7HPMSRGK84+bjsPEk7EUKWPeSlCOGzgR6Lo5GQBvtGsUzuT6uiEwCFm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067117; c=relaxed/simple;
	bh=QhwLpnKe75p3FHs0ebjZdxIlXMliF5uLtZwMEXQcIOM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s9/zArH++O9qYRy1ckBL26KSgN9hiHF0rSGistH67RVvbvKv0CePLFOIKIK8rEt//cu8ZlxTpQT3BY71cb2S/5hPFbSrW1y2VnPlLkqumfOW2sR1tYi+8KVf96P5C7hTUh1wpymKUb6/gCMrkQTMSMNb3IMPG9YD81R20W2M/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSh5QlaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B627C433F1;
	Tue, 27 Feb 2024 20:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709067117;
	bh=QhwLpnKe75p3FHs0ebjZdxIlXMliF5uLtZwMEXQcIOM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eSh5QlaEklbj3USqjdl4SbrYSjThOhf0azwzjroNE7tRsAkFp/gXtAC5lPwk3f5RS
	 A3MiP4ou6kXf2gIt7Y+wa9TKziO9wmAXIxO86SaEbyFrHqtsECmgqw8NBM1b9W9IFB
	 I2ZrnJg3FsNVUBbOgwha7V/h3Td7Awa0fbkcnsbdKpsSA2iiU5qqFfeyQTFYnVakp6
	 EeH4wObiMF9QrZAQbbJxD5PNOHDu1NUtx3qlbWL3rLIqos0LPHV9LKooUxzLCODgbI
	 cEU6mKwtkvlfZ4uo4ac/AuCb5QBm+eLAB/X92Q8aXgqi/ZVhT/VhncTQ3fVi7ac+1b
	 rwkdbJ4FYuKAA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org
In-Reply-To: <20240227150826.573581-1-jbrunet@baylibre.com>
References: <20240227150826.573581-1-jbrunet@baylibre.com>
Subject: Re: [PATCH v2] ASoC: meson: axg-fifo: use FIELD helpers
Message-Id: <170906711616.430898.9659038339252148422.b4-ty@kernel.org>
Date: Tue, 27 Feb 2024 20:51:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 27 Feb 2024 16:08:25 +0100, Jerome Brunet wrote:
> Use FIELD_GET() and FIELD_PREP() helpers instead of doing it manually.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg-fifo: use FIELD helpers
      commit: 9e6f39535c794adea6ba802a52c722d193c28124

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


