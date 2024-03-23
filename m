Return-Path: <linux-kernel+bounces-112229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592E5887729
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E241F22D3E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2415398;
	Sat, 23 Mar 2024 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh9TULn0"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082D81A38D0
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 06:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711174092; cv=none; b=j5zBOTwEVU+wrxdXvu+GGortc6YJufJ6TIDMaenGnKDqcgCsGzv86TFe5gBwVsBOXCjIrAw5ih3cnFLQcUmLQbZPWyTgVz69eQTWKmSjSdmnhzJx4RChIHSb8ZEY0upK0vLt/i2JhM0CdACxnLuzllwioRYL9ZK0aeQp5v3MqHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711174092; c=relaxed/simple;
	bh=A061M311bWcKVJUUnbDDmTAmuBX7wijJeIlLtRN/XJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CGPFRXUxiXefJX3mfBZylA+E+ppuE9JmVR0lAtcKf2IaOo7duUhHkPdfqV6HL6maz8QOyliBWMPEgMWsu359YTAD6I85AVCzDPzFUVmqgNDxqCUJVQ/rfNS01IM6GlL1L6iCGyvXxCw5vBJPG2swp0fvamiuGjObgyITqmJnlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh9TULn0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-414689ba80eso22781325e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 23:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711174089; x=1711778889; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LTfLYfPTszY4IxTtf86oi/uzbGzPl0sBWBERhXVz2i0=;
        b=Dh9TULn0nY+1h8yWN+R89N79xAGg3YY2lcRfbW9GKLSpr7DIxUY2cukdrpz8c+2NrR
         JBnQQ/OjqCQ6rWc/A+K26ic4JgCgOqaAbqcSQGqSX0WfvId/WVbaHZ5uIhCaq/l7lw58
         q36OS1G3Kwq+6NO65DAZPsNeu340ocSbsOW5rONyFPId+93IFZdgv5HgYOQGnJx9rKEh
         +RZv7rov0FsWjz6uE0s2KLT5L+YVoZqpZzvSxh3aaGYMX5dzYXPRjeo431RvWaRtU6R6
         eaCDfnNQWz8oDka9A0EyaYl7dtD8UJ2uX1yXVVmftaYxowAREduZKUtac6DF0gZKv9sU
         cNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711174089; x=1711778889;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTfLYfPTszY4IxTtf86oi/uzbGzPl0sBWBERhXVz2i0=;
        b=n5IRv/nl8UwgoetzmTNFoKkgmnvTvpZ6Qsx7jG6o6+QeCsj6qOj7Wc5auTn0xs4Iy8
         lryhPtaHrOh0tEtcnqbce6cgSTEL0TG6U3nYj3g79u4h/uLQEADZD0EjYTuVUB7Tsahy
         lW0PDOT++q0f2FgBb2Y2ebTqMpre2hQWXezUZ7N/wTCGV9QIJUv4m2s+plRCu9nNCOSw
         0wJR0zIh9ZIJWVfHahVi8zKw8j9LYxzRaOekIrZHc7Wn+/Mo9jEqQvx01OfxTpHX0bIo
         AQhO+bWAIscDeQvszEHYjoQVtQbROPIK4IbVWMfFSiBzCJajrjg+R4vy4KvRVpUKJtfZ
         znHw==
X-Forwarded-Encrypted: i=1; AJvYcCVrL+E0VJhTV4brwuciZGt3Tw6/rry7ElTUd88sMGCg9UNfbr1yPOVRv1MBAeYz3YQfHdKdNranqg0m2THXRY3y1m9VtuXNFsaMCQmM
X-Gm-Message-State: AOJu0Yzi53cntB/5+h0NPmIapz0fmxKG5bFecQH6nAdlLzAoa8huJ3RY
	BX1RkEz3qngdwybkIb8g2LKnWo11jK04vfhLnvicjp/sV60VNPOgvxIKWrfn7z4=
X-Google-Smtp-Source: AGHT+IG6APMQ5kyFm5i3LcQZPi8VXo4S0XM4PdNtSagvA/6Yb3JobCgmHUgjMp1g4eYs1k973S5QxQ==
X-Received: by 2002:adf:e28f:0:b0:33e:6833:8fa9 with SMTP id v15-20020adfe28f000000b0033e68338fa9mr1032710wri.44.1711174089020;
        Fri, 22 Mar 2024 23:08:09 -0700 (PDT)
Received: from MOLeToid ([129.0.78.251])
        by smtp.gmail.com with ESMTPSA id s17-20020adfa291000000b00341b7388dafsm2954989wra.77.2024.03.22.23.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 23:08:08 -0700 (PDT)
Date: Sat, 23 Mar 2024 07:08:05 +0100
From: "Felix N. Kimbu" <felixkimbu1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: outreachy@lists.linux.dev
Subject: [PATCH v2] staging: pi433: Correct comment typos in pi433_if.c
Message-ID: <Zf5xxbEpFfU5GMiY@MOLeToid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Correct typos in comments accross driver file pi433_if.c.

Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
---
Changes in v2:
- Trim commit message and log (AlisonS)

 drivers/staging/pi433/pi433_if.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index b6c4917d515e..81de98c0245a 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -10,7 +10,7 @@
  * devices, basing on HopeRfs rf69.
  *
  * The driver can also be extended, to support other modules of
- * HopeRf with a similar interace - e. g. RFM69HCW, RFM12, RFM95, ...
+ * HopeRf with a similar interface - e. g. RFM69HCW, RFM12, RFM95, ...
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
  *	Marcus Wolf <linux@wolf-entwicklungen.de>
@@ -68,7 +68,7 @@ static const struct class pi433_class = {
  */
 /*
  * rx config is device specific
- * so we have just one rx config, ebedded in device struct
+ * so we have just one rx config, embedded in device struct
  */
 struct pi433_device {
 	/* device handling related values */
@@ -647,7 +647,7 @@ static int pi433_tx_thread(void *data)
 
 		/*
 		 * prevent race conditions
-		 * irq will be reenabled after tx config is set
+		 * irq will be re-enabled after tx config is set
 		 */
 		disable_irq(device->irq_num[DIO0]);
 		device->tx_active = true;
@@ -923,7 +923,7 @@ static long pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case PI433_IOC_WR_RX_CFG:
 		mutex_lock(&device->rx_lock);
 
-		/* during pendig read request, change of config not allowed */
+		/* during pending read request, change of config not allowed */
 		if (device->rx_active) {
 			mutex_unlock(&device->rx_lock);
 			return -EAGAIN;
-- 
2.34.1


