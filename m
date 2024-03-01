Return-Path: <linux-kernel+bounces-88237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD0186DEF7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AF91C22506
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC51F6BB52;
	Fri,  1 Mar 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgSscS3S"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55C6A8D5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287662; cv=none; b=ct19pRxGplPOK14Qp1xuzbrOoLB82OEGYCh/yh+oRAzbLcGFzvez0Rqy8iCenp0jL+IWzUvNSRTKlDRQq/jMr9U/txaxy1GZ6WdyFTJr7RZ0goUXnoOD6KvQcHwQPTNDYNe8KoG4zJeG9EahCWz5eteZDSyYjT0b9cdaIrqW9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287662; c=relaxed/simple;
	bh=T+CeEodRAGx5wTa5V2kHse2MzIoJ34vXtnubphzB1Do=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rlOuz2WlFLPHAE6hy7F01kRCj6I8y35kvMNRQK868+VAqstaEs0TEZjxK/5ocuvlPvloiR7nj892HWe1bPGfp4v7iT7MpyAoJFvmzVZ7Fg1HCdKlMCg9NchEtxuGpWzVJi2kWOxWsivxPcJ/hwx1IPUIzpKq5fP3GVYLz62qlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kgSscS3S; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d208be133bso22082291fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 02:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709287658; x=1709892458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BUPZXtRPhnydBr3X5VYxad+Y/Ik9MF6OjDOuWG4R5Aw=;
        b=kgSscS3SLgJ3mLjYQkAMwK54ruVzmgkJrXjReySkGX3F0OjHpOIdHPPSudKw7d/sYe
         lZFcrxg6mgdCzr93kmvvr5qdfYQSdDb0qBc4/RpAw2UmtddAy68dWcOaAefNpyNIOVCp
         pkWeaDtHA2CjX5OZwuh2zPwXnc9O7SihFx9jB8JbAs2bmWF611LCDsyPobKOQvgjqVib
         U9Yf5+mi4ckX2cZ0UwJXUFRcyEbgxtMyBN7XBlkUDx+3l4uy0jrsHuoueJBFXl1hHRzH
         WiBWh5+gE7SojNh/fH7ssBiGxzfJCq5C88SvEqZk8+vqk0pCGSXsgmunjeu6f4AlhJvu
         hdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709287658; x=1709892458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUPZXtRPhnydBr3X5VYxad+Y/Ik9MF6OjDOuWG4R5Aw=;
        b=Wjo888z7bfMST0rb43eMwyJHdwajJi5FdUNgsNI1btE+jPZwq2XAIr0Nt9ZkjovrTp
         dP2Ntf8q+yPd01ZHTuQlfPYYmGpu9qtVztyibNCKEhgcAcUjvrLMDI8UI5Ixg0AJtiaL
         lkJODO9aQ6eM+wnRn7NrlPjGrVFMS7/H7wpskCbRJdRVNRC6BvjzErZ6J2WSD8Filklz
         9Gdb28lIPOBNbLFSkl1JTS3DGcuIhrxAPhkMf3oCZu3a3wiRBFw94CwjlqqzCmObYSgy
         /cSHzb/4INVGHrtt52aXBEiTMsgXvt3PECnHGjnSP+SbXW6dQssc9cZZRfNblGyEUbx5
         zrpA==
X-Forwarded-Encrypted: i=1; AJvYcCVuaOMh4IimRMeIrSAJsjjXPwpyRPNzfpI1dXJsH/2gAvGV8/a76/euJClaB6hR8aNXHDPNngMJ+oS0Dj8avM4SO/fJxsrRCI9M9yKZ
X-Gm-Message-State: AOJu0YwGBFp8R0SZWamExpFNGKlrihtGEOcQ1Zn1ZVrUUxVXC3oWA4k2
	ZVwY6c6us0+UlkQhOlu3iQan5dTJSB5nhL/zcM1T06eQn3z11QKz+116y8//ldk=
X-Google-Smtp-Source: AGHT+IFEV//EQP+uWHWDC+jyQET8gGjbngKP3FkjLTWfTZ2DjXgwAipWjK9lrHzmTVgLCnxZW1E4XQ==
X-Received: by 2002:a19:ca57:0:b0:513:201e:cac2 with SMTP id h23-20020a19ca57000000b00513201ecac2mr888999lfj.21.1709287658414;
        Fri, 01 Mar 2024 02:07:38 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a3-20020a19f803000000b0051323e9be6fsm565934lff.213.2024.03.01.02.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 02:07:37 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.8-rc7
Date: Fri,  1 Mar 2024 11:07:36 +0100
Message-Id: <20240301100736.3789777-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.8-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.8-rc4

for you to fetch changes up to 09e23823ae9a3e2d5d20f2e1efe0d6e48cef9129:

  mmc: sdhci-xenon: add timeout for PHY init complete (2024-02-28 13:41:35 +0100)

----------------------------------------------------------------
MMC core:
 - Fix eMMC initialization with 1-bit bus connection

MMC host:
 - mmci: Fix DMA API overlapping mappings for the stm32 variant
 - sdhci-xenon: Fix PHY stability issues

----------------------------------------------------------------
Christophe Kerello (1):
      mmc: mmci: stm32: fix DMA API overlapping mappings warning

Elad Nachman (2):
      mmc: sdhci-xenon: fix PHY init clock stability
      mmc: sdhci-xenon: add timeout for PHY init complete

Ivan Semenov (1):
      mmc: core: Fix eMMC initialization with 1-bit bus connection

 drivers/mmc/core/mmc.c              |  2 ++
 drivers/mmc/host/mmci_stm32_sdmmc.c | 24 +++++++++++++++++++
 drivers/mmc/host/sdhci-xenon-phy.c  | 48 ++++++++++++++++++++++++++++++-------
 3 files changed, 65 insertions(+), 9 deletions(-)

