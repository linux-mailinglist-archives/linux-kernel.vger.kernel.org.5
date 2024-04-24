Return-Path: <linux-kernel+bounces-157158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 878738B0D93
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73BEB20CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BEF15EFD6;
	Wed, 24 Apr 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ausG3j5J"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23EB535A8;
	Wed, 24 Apr 2024 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971238; cv=none; b=oobt/cugYzLKcSdbkpjPCXT1Tb0hbUFCzCbtkxWzjKPZpR1rlVbUpULX/3T9mrXC4PI0vatZ/DHTaJgjVMhVOyqdEjGWe7vMYTO5WujRGN68HXstYElS00Q9jCi0TMIbtVcoK1P+TQ4dgN/zAJlAT6e30jJDRu9DweyOFHeXZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971238; c=relaxed/simple;
	bh=9/WyWZri7t1w19wqk2qxZyuCvRVISQishqategGBjeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+Cf4WPj+C+fLnGFMGhn0VmndjPJDdQuQISLtXqY5+8ZfUSXtqfj5/ZZt58doBHHOQoB5UEJa6DHwLaqeC2cZ6k6vEh/hB3WdsZXjaEkqfGuhwyhMH7Xcb2iJSkRl+hPTPIzBcctjv3RwVBgOSzDkzDMtjXS5NHFLncS7tgDySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ausG3j5J; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516ef30b16eso8587720e87.3;
        Wed, 24 Apr 2024 08:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713971235; x=1714576035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNf8qhPDM8uJ/IIQ4MpkM7GqjrGdfnAXJf3g6Lf9Yzk=;
        b=ausG3j5JXINWXP1md0g2NcDarC764gBMFUl+3SR6tVZWjKV9Ht369RZbho17X8dtfW
         DtRPSfIWOCNpY22SFlemz+9WXVdmTd05ny8sWflnhtZjt/K11x8ISkZrBLSq0pU2IAuX
         RoB9nJ1RWQEk4QYMPYoSe6XKLlqx5MNZGVHCQEqi6xi9He49roZDLuiWxUr1yLjWHLBE
         n3v3pbCrHwXe29960ysNYQzQH0QfQgyD+ceEAwDnKo1ld42mC4FWllMJnjHfB/OyFIp2
         oI2AlZzwec33vvIKfM3bxfbjoDUyC/MpYpLdGo8QBud5au0W17yrRqL3kfu4VT4apMy3
         32Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971235; x=1714576035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNf8qhPDM8uJ/IIQ4MpkM7GqjrGdfnAXJf3g6Lf9Yzk=;
        b=AVFvoi67YBXy3NSvef0QsNQhvQY0qWI4BgM93JWmAhSoJXxBZczeg4TkeMjnKDNvcd
         QWct/44oA0K2WgT2jWZOlSIej0tuVIpCEiHj1oIdZREJoAO5OIzH+Q2df0ZrNUweGEKz
         DRZrzI6QrzM0meSJL/IUAjLygAFOtOZUHi29wquU0giWYiJf8aiGfNlp3NovWvmy22fB
         Pq3H22U2PF3Jc+GDO6KlXD+W/syI15sTtUNacrVT8/f5N6piVAoeKmHhWTG3235bqbpb
         clndt1RsBv/vwS6aDZYwBkcXMTtoSdOxaiWRh+sVld9x3GwXkkWMXiRzSD7gdmSLYd/K
         0Feg==
X-Forwarded-Encrypted: i=1; AJvYcCWWt6lwAXrZlEBVvEhtvkswXbGmbHWQJ74D9tLArNcTIyFS8qYhqAStVdbYUyfbkdsv6OZRpO9wsOAON791YBAJjgCdyxpY1qoRJ6KZU7ZObNfUrmfrJ3JvxoRyXFxuBTnAXylmIQ2V
X-Gm-Message-State: AOJu0YxktxltbGnhVglgyWNazh5qQ/cZopWdzk1ubLjpjl/gwZfKWOhQ
	k8fJBuR3ms5rzv447JQS3siM4Fa48iqXAnODkmk9nKaHCYKG2r07
X-Google-Smtp-Source: AGHT+IH2C6UPbn1LzX4kUDRrTTANLQ9nXXidbTFdKcdbfHJEZiNelgZFL4Uz3rwUPdmIl3zZc5dfGg==
X-Received: by 2002:a05:6512:143:b0:51b:5fdc:4e19 with SMTP id m3-20020a056512014300b0051b5fdc4e19mr1831043lfo.30.1713971234498;
        Wed, 24 Apr 2024 08:07:14 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id e2-20020a056512090200b0051b0f4e1b0dsm1207445lft.276.2024.04.24.08.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 08:07:13 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 0/4] spi: dw: Auto-detect number of native CS
Date: Wed, 24 Apr 2024 18:06:41 +0300
Message-ID: <20240424150657.9678-1-fancer.lancer@gmail.com>
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

Link: https://lore.kernel.org/linux-spi/20240222172853.25082-1-fancer.lancer@gmail.com
Changelog v3:
- Add Andy' Rb tag.
- Rebase onto the kernel v6.9 and resubmit.

Link: https://lore.kernel.org/linux-spi/20240416155257.22429-1-fancer.lancer@gmail.com
Changelog v4:
- Just resend.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
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


