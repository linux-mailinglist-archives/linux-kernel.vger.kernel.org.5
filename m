Return-Path: <linux-kernel+bounces-167164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D569D8BA521
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958621F23A08
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D607813FF9;
	Fri,  3 May 2024 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CauWnbYL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E64812B72;
	Fri,  3 May 2024 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714701803; cv=none; b=YwDAa0yUI53cyR00TGA/WChrY+X/W2bY4WYCLzKpLQtTWkqJQwWnaaMhbbw/w1kgfFyOu8mTCsBjbD98JuE7Aucz3e8O/COMgxP9cte6EI0E6MDXyUwOSX34Mq6aP4RDR3BORWz3KVytlhaWOwGEmglefojxHKtLEVBJQxrAp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714701803; c=relaxed/simple;
	bh=yzUC1PbS3juaZMLuVQwmd2iOKk3GFJovJ2DnpWpOHDw=;
	h=Message-ID:From:To:Cc:Subject:Date; b=gveNr3hdeYxbcVHLeG+OL2qKH8IzooY2QXCD4x0UPz+wVADMMAPkEXD5M3MBNxNorTNFXkSCw7FpJrzV+rsZnf0bRYhVlxWrtBXs7SP4wabS+ik98vABd5BPtyC9vXChziojQgj5CRA8oba6ONTh6CWmd54Eho3evRJc4glXMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CauWnbYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1E1C113CC;
	Fri,  3 May 2024 02:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714701802;
	bh=yzUC1PbS3juaZMLuVQwmd2iOKk3GFJovJ2DnpWpOHDw=;
	h=From:To:Cc:Subject:Date:From;
	b=CauWnbYLrHmVy8vgFIpURVoeqUHXK2aCKt9xUUevwTV/qBZu6eFCjY0F6mBi0kCP4
	 To7YyuudH3cfUa6SwvQ4F4jTTlfrP5mdRg8slheb0irHKz4zda3uACtEBj08Yn6FE6
	 VjJ6UkZdXRFbN555DHhgGcxr1ft+dUl2PmpEd42ngeybcurxXNEGY/IS3nQMmXjAoc
	 LtfRsXoZwxyGu+2Km+gZuxLXn9UEwLgpAKX4SjXymHgkAdk6dpbNZHYV3qO2OB7+d9
	 GcBosSfak9hAegC3tRS/0U1n6p7105QYysFhT4nwjPjMebp3ecc8VYsnreh2v4qtL+
	 R1t9yeA5PCW3A==
Message-ID: <5fbf754d3bc37a9d4f8c81c7adf78e11.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.9-rc6
Date: Fri, 03 May 2024 11:03:12 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.9-rc6

for you to fetch changes up to 4756fa529b2f12b7cb8f21fe229b0f6f47190829:

  spi: fix null pointer dereference within spi_sync (2024-05-01 11:02:48 +0900)

----------------------------------------------------------------
spi: Fixes for v6.9

A few small fixes for v6.9, the core fix is for issues with reuse of a
spi_message in the case where we've got queued messages (a relatively
rare occurrence with modern code so it wasn't noticed in testing).  We
also avoid an issue with the Kunpeng driver by simply removing the debug
interface that could trigger it, and address issues with confusing and
corrupted output when printing the IP version of the AXI SPI engine.

----------------------------------------------------------------
David Lechner (1):
      spi: axi-spi-engine: fix version format string

Devyn Liu (1):
      spi: hisi-kunpeng: Delete the dump interface of data registers in debugfs

Mans Rullgard (1):
      spi: fix null pointer dereference within spi_sync

 drivers/spi/spi-axi-spi-engine.c | 2 +-
 drivers/spi/spi-hisi-kunpeng.c   | 2 --
 drivers/spi/spi.c                | 1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

