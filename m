Return-Path: <linux-kernel+bounces-67460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08012856BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81648B23C09
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E821386A7;
	Thu, 15 Feb 2024 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9++1qVh"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0A134721;
	Thu, 15 Feb 2024 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020085; cv=none; b=fQV52bVYm3cPiWsJMWwgI3ox2q48jqddsqN6hARkK6SnwhCUyr0DG/StOPNEHGKx+CBBHPW/FtQt9yP59Ttug5lCpXS0ocjOVEcIfn9nwnpW9rDYl8ugIt2w55BachMmqhgIkoJC8wHBAE9iRidvUt4Z4FOLK5vDv2S+OhE40YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020085; c=relaxed/simple;
	bh=uOCFg9KS9aHD7BrnsfKkEPzwjTcKv414Q5O985BCAN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGCvAFx3wLdJkP3kbC0kh60lc4w+JYMuO2x11hYZS+afLz5Tg3Y+tECZVmxcs2SwMFOcIYgGH2a8jVmd1ePsdNiDrIsGDH9SQHO9WPxJ68PXZBADRZTR0iq6GVuDlCjiwvZabJR9S36fYIf19G3GKUqElP50DTqh5I0z5Xs6s8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9++1qVh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so1365286e87.0;
        Thu, 15 Feb 2024 10:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708020082; x=1708624882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DM527n3CwiSmkbi18txMgMFI0Ds898Ao/4BpV0UAhnw=;
        b=k9++1qVhkLFXpfrpEEGRrUVo/sHuDxRqQoyqYD4L2vOBMzv7nrviMyjZtpnEe2LGzt
         SH9VuNHdNcdmayXGaEcLdz8aodbIAU0VO3Clvs2dv8WrDjkq+CGQwNfYFIt4XJ9EdisT
         DCyIoNYSs5sOqxDsJcJxLKoRSLcFa6Aqk5sM18YpK2rZKlEweD/Mw3KT1JiYYDuyYBeO
         HSjwIBkEo/RSgKr/ZpXgO5T61atIwBOdiv1cuWfbedA4W9kZNy114cgaf+1lWetEIMvc
         sBKaYi8GbcF9uYZ4+MhPBlMXWZpcxOg9zXiI0Db1KVmuegOm+pPLL4pFlso25/xX6PcW
         w80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020082; x=1708624882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DM527n3CwiSmkbi18txMgMFI0Ds898Ao/4BpV0UAhnw=;
        b=vqui37qX3A/0R+tuvf11UiAa3cctPN2Y3VWS1lr8jKfL8KQboK5RrAg7MPndKkzsSC
         D+ZT8E7Z7jQx9+FFQoBZj3vs5UL6IhR4+rHeULNcRfhO4KJqAOstjus25hL8Xffk8a8I
         bBlxbRKrjm8fkvcmpLSCyXQ9g/mKbeHZQj0dSop0V605XpBX0AbuFR777sv9gj5kNnsn
         HK16ZXG+miwltToED2MNZauY1dU72ZtandWaq9YO3vJhMBOeoJlDe6XXOiWifL6o2shd
         svJhmXVtQZQRPpeB2iywhGubNAjQHvKpDFLTlpAM/07XjHri6cG0hmrFtme1V+O6FJNl
         M5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQv0VotSzGPJh3xo2o27Kbbf1BPNQ5qh/ktFu/q1Dzvoi7GIAIyx53qbfCzZdhu7LVBC6V7fko33LZ5wku7/j14HQQcTiFRABqnjujCzgLRetbaxwA4NheeqRZUHT9DyK/mXDpH0yy
X-Gm-Message-State: AOJu0YwCN6xDtd0rP+gKOLLdvYPStZiTcIZ4mJPTSOTllU10Ckx7lcxP
	+MG/K9yiLCjn3JXUTkL30XcufoShm4bIB60SE2Su8z9HR/6QDEMDiu6NTTKx
X-Google-Smtp-Source: AGHT+IGtQMCxIgDNt/1hfFSAOn80aZ2gfTiJWxYdpK24bhmzApCggv17tt//m98hX4Amq3Nlo8ugyg==
X-Received: by 2002:ac2:4da4:0:b0:512:8deb:6f96 with SMTP id h4-20020ac24da4000000b005128deb6f96mr425101lfe.67.1708020081674;
        Thu, 15 Feb 2024 10:01:21 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id x9-20020ac259c9000000b0051166fc7faesm319681lfn.75.2024.02.15.10.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:01:21 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] spi: dw: Auto-detect number of native CS
Date: Thu, 15 Feb 2024 21:00:45 +0300
Message-ID: <20240215180102.13887-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main goal of the short series is to provide a procedure implementing
the auto-detection of the number of native Chip-Select signals supported
by the controller. The suggested algorithm is straightforward. It relies
on the fact that the SER register writable flags reflects the actual
number of available native chip-select signals. So the DW APB/AHB SSI
driver now tests the SER register for having the writable bits,
calculates the number of CS signals based on the number of set flags and
then initializes the num_cs private data field based on that, which then
will be passed to the SPI-core subsystem indicating the number of
supported hardware chip-selects. The implemented procedure will be useful
for the DW SSI device nodes not having the explicitly set "num-cs"
property. In case if the property is specified it will be utilized instead
of the auto-detection procedure.

Besides of that a small cleanup patch is introduced in the head of the
series. It converts the driver to using the BITS_TO_BYTES() macro instead
of the hard-coded DIV_ROUND_UP()-based calculation of the number of
bytes-per-transfer-word.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (3):
  spi: dw: Convert to using BITS_TO_BYTES() macro
  spi: dw: Add a number of native CS auto-detection
  spi: dw: Drop default number of CS setting

 drivers/spi/spi-dw-core.c | 20 ++++++++++++++++----
 drivers/spi/spi-dw-mmio.c |  7 ++-----
 2 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.43.0


