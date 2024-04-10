Return-Path: <linux-kernel+bounces-138007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9B589EB09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09DC8B227CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34CB1F602;
	Wed, 10 Apr 2024 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="aOwoZ8q9"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C834F29CEE;
	Wed, 10 Apr 2024 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731257; cv=none; b=VQIH9Hr2l5YEOxZSWlwXSQ3gtrIX16vq7E1eBbemEcZ0uBNhFceIHBzAlp+KiO0attYkxNN5SZovmund6T7Q02Tv33QHRyJogMEfoGoTTDRgLEhFwOHD+frpKK0z4tfIwv4qFihxCnGSusZ3BOB7ecHYLb8rPhBqwxAks6sjJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731257; c=relaxed/simple;
	bh=7hYUrnoWxpf8qalg/aAuLUeCZM0W4vumG3VPC7KziA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6M6ag3ZqnPo3yy+ERIM+CVYT3suOdSCQSYvSXgk26+Aqt1m9N3h2CXNZOt0Za+7QgHCzew1wfdiSU2JshzzmL1pwKcH7+0zf4ETQ0HPCoASxzB+oLnbBfSGnYWVp5kRu4ptorsdsVOaqzOfIlFAumOJZsYXG7y+4DIlsMVMF+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=aOwoZ8q9; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id A040D6034B;
	Wed, 10 Apr 2024 06:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712731255;
	bh=7hYUrnoWxpf8qalg/aAuLUeCZM0W4vumG3VPC7KziA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aOwoZ8q9uWshMlHmTFTTwwSbCXrfI82u20Y1P3npst9j7ymKrpAHUverjhSaFmMix
	 Y71kgypRVDxjclybZN9FQVsMQJOojemS4YyavBySedBCbg4u8Cf/MKCZ7NrnJMty36
	 tcayCH1Yfyx3P98jUh9YIPUJq2XxlwHHWllSIxht8BK/BuRfY5CpI96Z6rLBLIJRQF
	 D7jAfhUijKlj7rs3pYpTVAuwMP84EVnr4FTd0bxUqkFo7Rhod+S4mmfZtzFZwLz2cT
	 hi2P84BE/Z+YaAMOiQhN+Zry7Ty30xXFBZa02mjAlc2OXcbnDyQ+fKJtmQNgAlM52y
	 smmBW3/BcpUqg==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] bus: ti-sysc: Add a description and copyrights
Date: Wed, 10 Apr 2024 09:40:06 +0300
Message-ID: <20240410064010.57142-3-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410064010.57142-1-tony@atomide.com>
References: <20240410064010.57142-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ti-sysc driver is missing coprights and description, let's add
those.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1,6 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * ti-sysc.c - Texas Instruments sysc interconnect target driver
+ *
+ * TI SoCs have an interconnect target wrapper IP for many devices. The wrapper
+ * IP manages clock gating, resets, and PM capabilities for the connected devices.
+ *
+ * Copyright (C) 2017-2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * Many features are based on the earlier omap_hwmod arch code with thanks to all
+ * the people who developed and debugged the code over the years:
+ *
+ * Copyright (C) 2009-2011 Nokia Corporation
+ * Copyright (C) 2011-2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/io.h>
-- 
2.44.0

