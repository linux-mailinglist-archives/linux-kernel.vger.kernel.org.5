Return-Path: <linux-kernel+bounces-79033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC9E861CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B34A1F2315D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C030614535F;
	Fri, 23 Feb 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGcPNKSZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228012AAE0;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717025; cv=none; b=PkRVM8T0b/WITTI7FXpJPQJkhN4iz71sDc0sis25CuJgp8ybuvSsb0W5MR7JQxtIFmDLW3QBZjuOy0fQjYITsPETCTvVEGOZ9W9RRbvV3eQGSyr3FSFGw5UAKPlthZZOhY2BXjVEuQqKEMbHd1h8tcEhUYDkMt/5v9+wOYoIk30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717025; c=relaxed/simple;
	bh=1FvHo9ZAqFnYQ8+JzpM97RGyfU19vXDAXyiInWFH3to=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n0yG/1/WTolKIUi+qB5THr5yeKqiKILUjf5xvpKLQbGM7f0ddD7bPesSjsDA2MQAwzkl+k/RaK1O3epOJsBbYRGceyzUYodQzVoNxtq76NtvG9QfZfkWd7GESGBeCgyGIOhuOgh74i13OBGh9LzrHtOwXAZxlOt5CsNsqnZutKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGcPNKSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96C61C433F1;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708717024;
	bh=1FvHo9ZAqFnYQ8+JzpM97RGyfU19vXDAXyiInWFH3to=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JGcPNKSZsGCtUWEX2qEdV8p/t5Et1tS2t6AcLIFAunVLmlT5oFVKIY9InzxLMnB3U
	 cNS34KNgZPMb6Z43XTF21JOU74WlDyDS9JXQn0qrtPAYKwppGyG2PgwRZtgfyAsuNI
	 6LLwc8yMxTrECFRwX3JOzSZZ+L2wHPIJyOqqsIxto4cxadeSNWf1zsVPPIQS7NPn4N
	 C/hRCRtwXFmPaFknp/vvcRZrdxmiRb8DrXoRemTKaULnwfUrqn2kaxlJNxE2zoZ029
	 MqZPYFvIMhicxoC7lebjNC53+7O9gkq041CNtVQxTU9BtYnTAeMJQA1lBdEKIUws96
	 WrOrXCxG/SVug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FC3C5478C;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Subject: [PATCH 0/6] sparc32: build fixes for all{yes,mod}config builds
Date: Fri, 23 Feb 2024 20:36:46 +0100
Message-Id:
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM7z2GUC/x3MwQqDMAyA4VeRnA2kqeywV5Edoo0u0FVpmAjiu
 6/s+MHPf4FrNXV4dhdUPcxtKw2h72B+S1kVLTUDEw/EHNHlg4ud6LvUOTJKzjh9LSdHEhoopoe
 GKUIb7FVb+Z+Pr/v+Ae9UgjtsAAAA
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, linux-parport@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708717023; l=1522;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=1FvHo9ZAqFnYQ8+JzpM97RGyfU19vXDAXyiInWFH3to=; =?utf-8?q?b=3DOFnhZ7qFaVRY?=
 =?utf-8?q?iAb/ePV4/EKaLsohB7PongJrPCQXAqPZ35oim3gVrrekQ3I1NJ3unFNJfEnR2G6s?=
 y4Eguzo1Bt73Ka8AN51+alJxGvzS42SSt5Gjy9Nu0m3rc2TXMMGS
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

This is a small set of patches that address build breakage with
allyesconfig / allmodconfig.

This solves some, but not all, build breakage.
The parport fix depends on the previous patch, the rest are independent
fixes.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
Sam Ravnborg (6):
      sparc32: Use generic cmpdi2/ucmpdi2 variants
      sparc32: Fix build with trapbase
      mtd: maps: sun_uflash: Declare uflash_devinit static
      usb: host: uhci-grlib.c: Fix build, add platform_device
      sparc32: Do not select GENERIC_ISA_DMA
      sparc32: Fix parport build with sparc32

 arch/sparc/Kconfig                  |   6 +-
 arch/sparc/include/asm/parport.h    | 259 +-----------------------------------
 arch/sparc/include/asm/parport_64.h | 256 +++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/irq_32.c          |   6 +-
 arch/sparc/kernel/kernel.h          |   8 +-
 arch/sparc/kernel/kgdb_32.c         |   4 +-
 arch/sparc/kernel/leon_smp.c        |   6 +-
 arch/sparc/kernel/setup_32.c        |   4 +-
 arch/sparc/lib/Makefile             |   4 +-
 arch/sparc/lib/cmpdi2.c             |  28 ----
 arch/sparc/lib/ucmpdi2.c            |  20 ---
 drivers/mtd/maps/sun_uflash.c       |   2 +-
 drivers/usb/host/uhci-grlib.c       |   1 +
 13 files changed, 283 insertions(+), 321 deletions(-)
---
base-commit: 626db6ee8ee1edac206610db407114aa83b53fd3
change-id: 20240223-sam-fix-sparc32-all-builds-0a0403d6e1b3

Best regards,
-- 
Sam Ravnborg <sam@ravnborg.org>


