Return-Path: <linux-kernel+bounces-76976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A57C85FF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD551F22A59
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E31B155A26;
	Thu, 22 Feb 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwtNochG"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D15154C0D;
	Thu, 22 Feb 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622939; cv=none; b=QKFTXUNWU1G5LQUb3B9o8hT8mZpnZzc7YEwhBG0H5qo1akMwpgUerIxYEBF7y06/TadiHhKzE5jvswgZ87kJcU1MvUON8v2ffu4OTxw7/6kVpWX4zkYX1lP+9Lh8sTCzoiyZQhaTeKnq/iustCKU1ClSCovD+YgkeY7MgXUMjj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622939; c=relaxed/simple;
	bh=89BJTE1VNGHlaODQUR5LKLAHFPUTn40r7uRKqit+998=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dY+04I6BCo87VVnG+cLK6F3E/EBwsJdSw+dDuQSuZKBJF7eDMGbUQvnaFCS79ZqjNTr/z6sA/fWPi5TtgqE98Hfy2yocC6JYT+d/NwfiNNVt1hgYNEM5d4KJn8cbVlC4ULOhmTicT526tvi1kGwCIlj5bjAd0w3ocHu/gP2xIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwtNochG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512e25401d4so6160e87.3;
        Thu, 22 Feb 2024 09:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622936; x=1709227736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khv9+KIfNokpVMM/esTnCaqExwWkI++qqA09rctpJFE=;
        b=BwtNochGFSBJG6FuowgP+61V+wSiFQn3wr1ruu6khhPnVFR88i1nnMc+HadWMpDEEQ
         iG18YNWo+ZiZhzJ+uGfGeFcUjS95O61hxvIsKww5HmXHP6SW/tUqwZQwHZ7/QNeNPo6m
         gy5W/txmyVU7IqDxkrxZlo6v9tT9iGZ/n79MH1JhdEryn0lw28fILb66hFcF8XsTJ7gs
         rsfAPnl2gJA9YYdrwH+xCJ2uCLF9Ngevrl4ZpaLbfG73YgIDSdQWGluITWZMo1lZULmp
         ODJREAd+erj6a/Bk51ZqjQ4SVYLQoWJZQO6yN46xGGATxHws8BenqDEAQyBk1qKT34GO
         iNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622936; x=1709227736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khv9+KIfNokpVMM/esTnCaqExwWkI++qqA09rctpJFE=;
        b=e74x5SUrOuU0Wlied8+W0iiHpVO8Idh/ZG/zKVif/7tq2z2Cz6bX9yu5/lcOvFkIvQ
         SCZ9YaehqSX+pxPZOcOlOSxeC/ZGA4N0N/yUPtHOc0Nm7Hmzdk+5sRuObzAjH3RQufuF
         bQOHP+TF4UKj5HlXDGrwdvKGzru/FHTaiY4hMHQHHZSQJWbancQwg/DJthd7pBOn3AVc
         NYV+DG1OqUw8sqKVDSYRpxjFuxgzzl6CO/Wih0qzO74xCKEgO8719mtNve1X2Yd30ezm
         YErVttJZqNR6dqCc48+DsUsiu9OIBdRA2bNLq8MQ9JKg+bZFciWuqpswXSEt8DaGQBp+
         5JDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeHoYyYF1CINxpldOMuxotRzxXclOgLN8+yFA9uHGqIpogt7AzKEiAVQM3LSNEiKw6LN8hOvDyz9WvvV4NbjQrXKWvNZsujqkEaIBRNoZP6rI8I8P55Icn5PIKsOIHDMdN2mMr1q/g
X-Gm-Message-State: AOJu0YzVPv/wbHI/KMgCgI1DpQAyVrIOMOs5TGiFr6S6lW/J+G1V4dVs
	QfGuKvupvyecRFt9CgwZDAHVOrzIE74VRnVjxfMRyFXWKmN4ktRA
X-Google-Smtp-Source: AGHT+IHAeQ06NRqwLBvH6nkZS138x3359rU3OR97b6QY2vtQHrIdPluK7Hlz0i0zBoDVOiDUV/2KcQ==
X-Received: by 2002:a05:6512:3744:b0:512:c17a:2dee with SMTP id a4-20020a056512374400b00512c17a2deemr5134542lfs.54.1708622935615;
        Thu, 22 Feb 2024 09:28:55 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b6-20020ac24106000000b0051285ab4674sm2140739lfi.278.2024.02.22.09.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:28:55 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] spi: dw: Auto-detect number of native CS
Date: Thu, 22 Feb 2024 20:28:43 +0300
Message-ID: <20240222172853.25082-1-fancer.lancer@gmail.com>
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

Link: https://lore.kernel.org/linux-spi/20240215180102.13887-1-fancer.lancer@gmail.com
Changelog v2:
- Add a new patch:
  [PATCH v2 3/4] spi: dw: Convert dw_spi::num_cs to u32
- Fix some spelling notes (@Andy).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (4):
  spi: dw: Convert to using BITS_TO_BYTES() macro
  spi: dw: Add a number of native CS auto-detection
  spi: dw: Convert dw_spi::num_cs to u32
  spi: dw: Drop default number of CS setting

 drivers/spi/spi-dw-core.c | 20 ++++++++++++++++----
 drivers/spi/spi-dw-mmio.c |  8 ++------
 drivers/spi/spi-dw.h      |  2 +-
 3 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.43.0


