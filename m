Return-Path: <linux-kernel+bounces-31204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3514E832A86
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0461F23FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10DA52F6C;
	Fri, 19 Jan 2024 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDoe4Ad3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B654405FA;
	Fri, 19 Jan 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670959; cv=none; b=UZiYlOgFac+3Igxk2HABS8fxfP8+gix8SlCaCJ0z6KQVo4IfEhdQyit805TbkS7ijZ7VLjsAowDmovctUNeKqWz+BBi0F0Mux10WKMMugBFgwlqXt4xL1d2jvR5qIEZbpGI9dTa9q88GHOoNy0iBgDbuEx+gZBMd9S/Ek0Dc2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670959; c=relaxed/simple;
	bh=jUuvSPRb1KzIkupF+WSRRXjwNiO/NXWa+p/tLYl7mo0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=jyPYQrkYJfFyLhBWmBBhxuBm2r57tMGYkFQycrWn2DA/MsYgEFnrXq0PtVv+IpHpg3PEXPeDh+NTgVy2IlehYvX0eVhZkdzp+Pgd1fjNq+YRGHZ2WU8r6k6QWQCDRNmWMIlXQaTuDAOZZ/Xxyh5yHBruy4OftyMjhg8ikBjGO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDoe4Ad3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE19C433F1;
	Fri, 19 Jan 2024 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705670958;
	bh=jUuvSPRb1KzIkupF+WSRRXjwNiO/NXWa+p/tLYl7mo0=;
	h=From:To:Cc:Subject:Date:From;
	b=vDoe4Ad3I1+m46JOVwgjjRa71PcuuBuD15iOGW3KtU7tF+PfBK7MiDQYUgjPJcaMP
	 xl6LqhPMZtCsmNM+i3oORDLtORKkGfzoi9ziMjRRsEtgW/v61Z1PxOoaJh/Pve7+Ul
	 BgoUbNhAtWM/0LjWP1xCgl/P8LiemRDayI+OGVouZM2+bhszRhbChTpvSU3KtlBdF7
	 8V4nSWmXl4dHJyqebfv9WapfQCLOyNexxPQvnmWq0jzxqyBmuoun0T+UCIllkrY1u+
	 FRAEm7Sumt5I33ijsNMD0zAB1Xh7H/AohObRB/J4tyuw9xA92gKTbvYxhJIKT/wZH1
	 aYpzu3TBdOGJg==
Message-ID: <b4ca66ae22c11d163170c92db6c2470a.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.8-merge-window
Date: Fri, 19 Jan 2024 13:29:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit f6cd66231aa58599526584ff4df1bdde8d86eac8:

  spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc (2023-12-21 20:44:05 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-merge-window

for you to fetch changes up to 17dc11a02d8dacc7e78968daa2a8c16281eb7d1e:

  spi: coldfire-qspi: Remove an erroneous clk_disable_unprepare() from the remove function (2024-01-05 15:43:54 +0000)

----------------------------------------------------------------
spi: Fix for v6.8

One simple fix for the device unbind path in the Coldfire driver, a
conversion to use a combined get/enable helper missed removing a
disable.

----------------------------------------------------------------
Christophe JAILLET (1):
      spi: coldfire-qspi: Remove an erroneous clk_disable_unprepare() from the remove function

 drivers/spi/spi-coldfire-qspi.c | 1 -
 1 file changed, 1 deletion(-)

