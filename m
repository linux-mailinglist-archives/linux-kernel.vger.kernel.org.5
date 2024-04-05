Return-Path: <linux-kernel+bounces-133666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC1D89A71B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77851B20B21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D4C171072;
	Fri,  5 Apr 2024 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es8U/96J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B49117555B;
	Fri,  5 Apr 2024 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712355668; cv=none; b=YTtiCIz/REHVIM5NeqyCs6UO5bmBDZ5HfqMegUgWeQ5fJu0d4iwjh8Opi6qrZdqyV1t9Qnid5lXGWH6XCTF6NwKlVoIEQB7YL3RP4nVu8H7PuTPkV8bVJZWpxhjKrqqAE60OhSFWW/IABxa1bxTOXntOm2qu5kJfkD5CWCnI0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712355668; c=relaxed/simple;
	bh=weyVrY2rEhWcsaT9IB3fJ10/jNueaYJp5tsvKZBix0k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=vBXmuetfd0sZgKEYzJEiaNalqDhUZt4PbUEzIRhevmowRnycVLRIFbUr46LqftdaJ/smyAo3gsCpanp1jyFYyyeRORu1sZLXzukUIRAVtJmRMSeN1fhxd1WxYZqVWQLInGon5ik8onXGxvFpj5bAeR+iElA8F1l7WxSxa5CW0qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Es8U/96J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E94CC433F1;
	Fri,  5 Apr 2024 22:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712355668;
	bh=weyVrY2rEhWcsaT9IB3fJ10/jNueaYJp5tsvKZBix0k=;
	h=From:To:Cc:Subject:Date:From;
	b=Es8U/96J4kdVIZhBVExohQSRr2uZhT7tlzsBUnkpgLBs4fHonpnucQnIW++3Zguoe
	 YxWF8F9ZeSdtNVZGxoYdvF0zfWIKF7iSWsC2rJCr5wP+2IbaVfeKS4ZY1Tpc4cGW62
	 Ij4siMyAvHr8qsUWQrmar2lLkU4dw7Q/xa57fnDnYeIHbZYcZAYMG3FNJ+USLM7rEE
	 P4XRPJaTyQN2R5MmpYAgwYYYjgg0pZMBcVLT9ajh9OSN0z7OxvJ/NYRZezczT1ivTa
	 Scs0pvCBzBZIuQRixy5PDujxaRDXVmCThWEZHTKCkaHmGTD+KPPmwnTzvmLd0eLMU2
	 ZwiJ1IPaSk8pQ==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.9-rc2
Date: Fri, 05 Apr 2024 23:20:57 +0100
Message-Id: <20240405222106.6E94CC433F1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.9-rc2

for you to fetch changes up to 1f886a7bfb3faf4c1021e73f045538008ce7634e:

  spi: mchp-pci1xxx: Fix a possible null pointer dereference in pci1xxx_spi_probe (2024-04-03 11:04:58 +0100)

----------------------------------------------------------------
spi: Fixes for v6.9

A few small driver specific fixes, the most important being the s3c64xx
change which is likely to be hit during normal operation.

----------------------------------------------------------------
Carlos Song (1):
      spi: spi-fsl-lpspi: remove redundant spi_controller_put call

Huai-Yuan Liu (1):
      spi: mchp-pci1xxx: Fix a possible null pointer dereference in pci1xxx_spi_probe

Jaewon Kim (1):
      spi: s3c64xx: Use DMA mode from fifo size

 drivers/spi/spi-fsl-lpspi.c | 14 ++++++--------
 drivers/spi/spi-pci1xxxx.c  |  2 ++
 drivers/spi/spi-s3c64xx.c   |  5 ++---
 3 files changed, 10 insertions(+), 11 deletions(-)

