Return-Path: <linux-kernel+bounces-48075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3848456EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFF81C2445B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCBD16087C;
	Thu,  1 Feb 2024 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfEDY/aJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB052160872
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789146; cv=none; b=buN5nuBavfY0C1QSD2Lct3GyfrluLOmSbywIft6X1ZHtsFYUZKn21Ks29prxtwm9nmSnhw1wlvtq8MFpRPO71BeIWYSTEsUafx5/1InjzKgigc1Ul3pJYhA5Wc6DzsdIYpq3/k7a7nZuKD9Bam1bMPoXPB7VwHVrw/o56WXeUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789146; c=relaxed/simple;
	bh=L1pZgBy8XKVaEMmM3oAJoPPScR/wOkyGZkKhfGFN87g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gva8mG3smr76bsvOPuy78CY88nN3JMCMdenPmsvP/omdtdpUE7jf5VyoHD4EZ5/YcPVsDqVz8cMxCbvbiDUs352NdNpCIWO4cGFjzRPeX/EppoGUYPu1XOKPEXX//iQVgy3E42a1AXtuy1KS7UkE8boFC+ZOrmDPkOqfeRXqkQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfEDY/aJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1645CC43394;
	Thu,  1 Feb 2024 12:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789146;
	bh=L1pZgBy8XKVaEMmM3oAJoPPScR/wOkyGZkKhfGFN87g=;
	h=From:To:Cc:Subject:Date:From;
	b=sfEDY/aJ/PJoy0498zvYFlBY0vVk/SClbeUZE5Le3ep9P6TaR3mqZR9PEiEVJEXN7
	 iX+x6lY8pXh5u3+VWCTeP8x61IrQq+XKTDmsiH0TXKslUFYIRCSD6pJy7ek0+RXGKO
	 AinWTEJcKvGPGLX2TqiTmkEoEMQi92MBpSwcxuWU60dLMA9YB9PPOQPpoeLuvhs8sO
	 Y9VRG1cWljkYQ8aC6XR+5Ek/pRs2snYJBJgAEXpvHC0JuHEa6sU6dtxpnq8/FVg5yx
	 b1rMES5unR0IzT34NMh8/TujjDniNZKy2Ie1tT5enl4ch9CM4u0Lgzg9oIPkTkZ8YO
	 5YuJKdpDw7ojA==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.8-rc2
Date: Thu, 01 Feb 2024 12:05:37 +0000
Message-Id: <20240201120546.1645CC43394@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.8-rc2

for you to fetch changes up to a3fa9838e8140584a6f338e8516f2b05d3bea812:

  regulator (max5970): Fix IRQ handler (2024-01-30 15:27:16 +0000)

----------------------------------------------------------------
regulator: Fixes for v6.8

The main set of fixes here are for the PWM regulator, fixing
bootstrapping issues on some platforms where the hardware setup looked
like it was out of spec for the constraints we have for the regulator
causing us to make spurious and unhelpful changes to try to bring things
in line with the constraints.  There's also a couple of other driver
specific fixes.

----------------------------------------------------------------
Martin Blumenstingl (3):
      regulator: pwm-regulator: Add validity checks in continuous .get_voltage
      regulator: pwm-regulator: Calculate the output voltage for disabled PWMs
      regulator: pwm-regulator: Manage boot-on with disabled PWM channels

Patrick Rudolph (1):
      regulator (max5970): Fix IRQ handler

Romain Naour (1):
      regulator: ti-abb: don't use devm_platform_ioremap_resource_byname for shared interrupt register

 drivers/regulator/max5970-regulator.c |  2 +-
 drivers/regulator/pwm-regulator.c     | 43 +++++++++++++++++++++++++++++++++++
 drivers/regulator/ti-abb-regulator.c  | 22 +++++++++++++++---
 3 files changed, 63 insertions(+), 4 deletions(-)

