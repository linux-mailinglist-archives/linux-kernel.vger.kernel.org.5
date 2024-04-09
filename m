Return-Path: <linux-kernel+bounces-136386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3013C89D382
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8B91F218C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B837D3E0;
	Tue,  9 Apr 2024 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zvpv4AvA"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F47D07F;
	Tue,  9 Apr 2024 07:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648658; cv=none; b=ZzFI8uRFc28/zuD3CzhqD0Q/UPi7PIDWnejg86a9ehC7d/AEsRD7t+NGOn1UqJ1XHBaZWDl1AOjTR5deIx/kbvjkGuP1M8N7/Q+2DGw+3Wto/kpRcXqMG/Bi6e+obnvHdFkP9pQ8v0nTV5RAFlMh0R0UByXZ9QxfBS9T9FaBCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648658; c=relaxed/simple;
	bh=eMjsm+axSa9dba31ZbkHgkcUo0FWbw22zKllG4mNmB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I2gVwlvwZQ9+ycgbKJKOEuO0s34Q+wz6WbLsfxr4uJ71QlwhxYeLE9KiiRM0QVsJMaUb1RRsP6yOnUycaaJL9SuDE/PNzN1vyyOnJl0ZSPex1xYZS4j6nvC653pICMu9aSIZMQmdoM31U2q4THQ5OrByp+jBFO6yYH7k20Z75hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zvpv4AvA; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c4f23d23d9so3219794b6e.3;
        Tue, 09 Apr 2024 00:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712648655; x=1713253455; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4get4IE/kyR3VAiCznQKvRJLeYXGzh0Wcyxj/ZAznK8=;
        b=Zvpv4AvAl5EI0hcwPgR/Lf0KcIBOf8jjlRmjtsRUJKVdEdGhXfwb7pqty2GRN9hJXy
         jhpRxmbwUFry0UXI2myTlBJFpZQgvJxDVCVSAUFa/2sHFhfIIPnvuiVX76dwPr6icVtT
         H52a7SfsDbKtpxN7F8IJ3KpgnwDUarTVPwv4vD/AhgI5ogVHsenYk2eSNXruGD40OY+/
         KaVwLhNCMRzDE9oRJzBAhJTEnKLNsRSHTm13Sd+Ri1tUDflsYTDmXL9jh5meqFKvtD9B
         iWcXo6NE8bKHzG2DSAm7jygdZrRs+UvvtcXX4oUWQM++eU7Ks4DUvKL4HoByHiUlZI0F
         GyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712648655; x=1713253455;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4get4IE/kyR3VAiCznQKvRJLeYXGzh0Wcyxj/ZAznK8=;
        b=eSdAhI1L80UXWl1c1A3ZSeyAttC+xoBjkhLOBHjFiIEdblskHxrXwUHW8MJe5Yrjlt
         asOTEqdrZTE2a3R9TlwtcY/0XnZ43X91UtqJbWSm3qWLs3kGEErBAJrRqt7ZpxWHjMLo
         SDmih9xeujJzwF6/J3Qb/2kz8DaGueX4qBvSxPMPD7oq9wA3ekkJu5txaWKPKk+qPPuH
         vc7lFhy3Qn3fXmgSdcvDYsjTrARrbSiWt0zMVgrf57jE3ba4Hjw+DV0ogdmebxJUXymb
         ks6IYESVTikoTqmv+rb2qIjCMMct2tZzHbh8fdRI6ii4z0Pfu5b/FcZaIHhD4X/+avZ9
         wTMA==
X-Forwarded-Encrypted: i=1; AJvYcCWRrOPdHxqD8jyowygXY97JBsFei9Jvrwu664CU1frZUn76FznXSXXbOznRYA0ct/O5E++9ySDxnolKqfpT+7h5Ml5yEe4dgWDi1b3Y6jrEo5DQcmabiUT1Z5OkoyQK1TbjhoNIZnS3Nl6r
X-Gm-Message-State: AOJu0YxLJA9moQQl4BdwGjrIrXn81SNscUL55dZehFGwp2+1Z8nciBXx
	ObrrX30Zpt3nmodgnBfzZG9AjyS/O+XvAyj5w4z9G5OlX7OO92mC
X-Google-Smtp-Source: AGHT+IHrjGyawYS5iBR5WVccVfDrwqzLQUgqXLkZthbBAde8zskxc5v6Ws1jPrpNVJwrvS+B4wlXuw==
X-Received: by 2002:a05:6808:1790:b0:3c5:e901:e3ec with SMTP id bg16-20020a056808179000b003c5e901e3ecmr8690122oib.16.1712648655560;
        Tue, 09 Apr 2024 00:44:15 -0700 (PDT)
Received: from localhost.localdomain ([43.159.199.34])
        by smtp.gmail.com with ESMTPSA id ll24-20020a056a00729800b006ed97aa7975sm237818pfb.111.2024.04.09.00.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:44:15 -0700 (PDT)
From: Guanbing Huang <albanhuang0@gmail.com>
To: gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com,
	rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	tony@atomide.com,
	john.ogness@linutronix.de,
	yangyicong@hisilicon.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn,
	albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: [PATCH v6 2/3] serial: port: Add support of PNP IRQ to __uart_read_properties()
Date: Tue,  9 Apr 2024 15:44:00 +0800
Message-Id: <e6dc33e399f119e6430bca48223cb2127930939b.1712646750.git.albanhuang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1712646750.git.albanhuang@tencent.com>
References: <cover.1712646750.git.albanhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Guanbing Huang <albanhuang@tencent.com>

The function __uart_read_properties doesn't cover PNP devices, so add IRQ
processing for PNP devices in the branch.

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Bing Fan <tombinfan@tencent.com>
Tested-by: Linheng Du <dylanlhdu@tencent.com>
---
v5 -> v6: fix the issue that the cover letter is not chained with the patch series
v4 -> v5: change "pnp" and "irq" in the commit message to uppercase, modify the subject
          to start with "serial: port:", modify the location of the header file pnp.h 

 drivers/tty/serial/serial_port.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 22b9eeb23e68..8504bae1d2c9 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pnp.h>
 #include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/spinlock.h>
@@ -221,7 +222,11 @@ static int __uart_read_properties(struct uart_port *port, bool use_defaults)
 
 	if (dev_is_platform(dev))
 		ret = platform_get_irq(to_platform_device(dev), 0);
-	else
+	else if (dev_is_pnp(dev)) {
+		ret = pnp_irq(to_pnp_dev(dev), 0);
+		if (ret < 0)
+			ret = -ENXIO;
+	} else
 		ret = fwnode_irq_get(dev_fwnode(dev), 0);
 	if (ret == -EPROBE_DEFER)
 		return ret;
-- 
2.17.1


