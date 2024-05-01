Return-Path: <linux-kernel+bounces-165356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 122C58B8BAF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57581F21D22
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D694112EBEF;
	Wed,  1 May 2024 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5AW1xsq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD0D12DDB0
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572494; cv=none; b=djacYxNEAstPS9NpVSwCULjhILQw0ZMPfNsb5RFU2U9Sw2WCWyyoj9hBTvlZYyBuTezz3HptuqjkLT7NzfHd4P9GV7/7zWZiy+iao5iavO9Zb7QM7+o6A868dq72lNoANxVJyYaXp3ZeQLjfxLXGdMpE5vuI0BYaBLpBlftV4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572494; c=relaxed/simple;
	bh=1jDeUeJLmpv60FQ7nprKVb4uOA4+rOAyc7affu0OBhM=;
	h=Message-ID:From:To:Cc:Subject:Date; b=tLkIoRF9NKv91L5I4kCSdKAXLQaSXkjO/PnLcMxDFOiOunWK/JTt/r/NRwb+kkRFDqvvEzha8+Bik3IpCxke/xlodWKcUyrfdUlTg9Zys2yzvV8uE101Axmwo2HFsIJKBSxQ+EHQnbNI+HYQy4Z143c3KGnv24tswuR5XMPkXeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5AW1xsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B228C072AA;
	Wed,  1 May 2024 14:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714572493;
	bh=1jDeUeJLmpv60FQ7nprKVb4uOA4+rOAyc7affu0OBhM=;
	h=From:To:Cc:Subject:Date:From;
	b=M5AW1xsqhtRPUdAFA11Voped6nVgsE/HUYqmMgpzAiU44EVgFMH9pSwZ/A75pZMJ8
	 wLbbCBo+3/2qR2FV+Bgw6ejDMwDdIhVjn28f+Bk7A1YjB5zAREt6Es+aD7egJ01Ryt
	 ymupFAxDceMj0M9UYgryz6QrAkicYA/qp6Y9BbUUoNun7uqpvcCyU6fIC4vovE4a0R
	 vGIbz/fa4deTqWKDORc0//kTOAjM3Q3hzDRkOAl/Lyw4QWu+Y2P0erEihBbNpxI7HT
	 jRUxcQrOy+R25r92BbpphMU/KWKoDFFBrm9FZGsEGG1K2YJrDM4aN0gCXhXfSAMbqu
	 1S9JcO5ftrtaQ==
Message-ID: <0bab863fc734774982e9d6fb4ae70211.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.9-rc6
Date: Wed, 01 May 2024 23:08:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.9-rc6

for you to fetch changes up to ff33132605c1a0acea59e4c523cb7c6fabe856b2:

  regulator: change devm_regulator_get_enable_optional() stub to return Ok (2024-04-24 10:13:30 +0900)

----------------------------------------------------------------
regulator: Fixes for v6.9

There's a few simple driver specific fixes here, plus some core cleanups
from Matti which fix issues found with client drivers due to the API
being confusing.  The two fixes for the stubs provide more constructive
behaviour with !REGULATOR configurations, issues were noticed with some
hwmon drivers which would otherwise have needed confusing bodges in the
users.  The irq_helpers fix to duplicate the provided name for the
interrupt controller was found because a driver got this wrong and it's
again a case where the core is the sensible place to put the fix.

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      regulator: mt6360: De-capitalize devicetree regulator subnodes

Krzysztof Kozlowski (2):
      regulator: qcom-refgen: fix module autoloading
      regulator: vqmmc-ipq4019: fix module autoloading

Matti Vaittinen (3):
      regulator: irq_helpers: duplicate IRQ name
      regulator: change stubbed devm_regulator_get_enable to return Ok
      regulator: change devm_regulator_get_enable_optional() stub to return Ok

 drivers/regulator/irq_helpers.c             |  3 +++
 drivers/regulator/mt6360-regulator.c        | 32 ++++++++++++++++++-----------
 drivers/regulator/qcom-refgen-regulator.c   |  1 +
 drivers/regulator/vqmmc-ipq4019-regulator.c |  1 +
 include/linux/regulator/consumer.h          |  4 ++--
 5 files changed, 27 insertions(+), 14 deletions(-)

