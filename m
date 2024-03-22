Return-Path: <linux-kernel+bounces-111618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A5886E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FF42838F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4828048CF0;
	Fri, 22 Mar 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEKKpiQK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A412482CA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117915; cv=none; b=Pr5330D/BNaWfQS4BuXVA6qjSilMRQubxEjAJZsh4eMaYnR6IqUPa+yTXmBabiVfB881qBqKhYSd1EJ92nt7C29tYzvubPBy0AIekxTiM3pV18YQemVHnLg67f/XOT31Ry+T88LzRhqbAY31aSOn3dOrlhU3wP4lypxtvURi8vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117915; c=relaxed/simple;
	bh=vaISFqOyKttkiX1duztx2MynMhVd6tv6Ly/khLT8hVs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Vw1cYNrtS57K6OTnyWVvkQzfXqK+MH0f7Ke5iDLHEL3bRuhuT7DK+O5Ncp/u8jMMXo30SaSkUQ9zs4gM0p7sS7vYw9cEDyvLb1tKWz83CoE9vnQZQF0ztoE+47yKbK+bf4Zlve3gJxXeTBJDn/0jG7OIk2YyserXoutckLs8R5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEKKpiQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA3FC43394;
	Fri, 22 Mar 2024 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711117915;
	bh=vaISFqOyKttkiX1duztx2MynMhVd6tv6Ly/khLT8hVs=;
	h=From:To:Cc:Subject:Date:From;
	b=SEKKpiQKbniX5cz3tsPpPfhKdazxSvIlc3hQ25ShmcnwxhFybcCt35x6NI8E0HMBQ
	 9NtcAX2FucxGp5mpuz7hWnUwSLcnIaGuozDI7075PeCRo/NqXadUUYYTuXwxZMPHEQ
	 N+8xCN/YqHBKZS/xU3mtecrfQ0ndGNIx3JWRcqVgPPr2e+e938nqlnujipFiKS6i73
	 LGwq0V+CG1Or0j4GMUQL55q3o435viNQpBbL5tHt8TbfdQ/MtgSPeF2muqIUTlO/Xr
	 r1xungSen5nHnklehiY2SFsrTV3+bfkpu8dBjWMwu3uesFr9nsaY2p/pDRfOediiYR
	 R+l874k63L8bg==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.9-merge-window
Date: Fri, 22 Mar 2024 14:31:43 +0000
Message-Id: <20240322143154.BCA3FC43394@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit e6f0b08a036734552628ab788ecb528ca53814ab:

  regulator: lp8788-buck: fix copy and paste bug in lp8788_dvs_gpio_request() (2024-03-06 14:03:32 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.9-merge-window

for you to fetch changes up to e4ead3cdfd798092288f3a06b405cf98ded6fa10:

  regulator: core: Propagate the regulator state in case of exclusive get (2024-03-12 13:55:57 +0000)

----------------------------------------------------------------
regulator: Fix for v6.9

One fix that came in during the merge window, fixing a problem with
bootstrapping the state of exclusive regulators which have a parent
regulator.

----------------------------------------------------------------
Kory Maincent (1):
      regulator: core: Propagate the regulator state in case of exclusive get

 drivers/regulator/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

