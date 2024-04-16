Return-Path: <linux-kernel+bounces-146152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7077A8A6165
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2124B28222D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6893E1C6B9;
	Tue, 16 Apr 2024 03:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXoshhOp"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB471862C;
	Tue, 16 Apr 2024 03:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237414; cv=none; b=WhC0HM92Cf2wRck4bRA+QlrurWt2pSLbgXaJVqABqN3SPuoUKXH6BHRAJx13R32iz1NLV2UrxvhqQy7u5srzOW4JNCImAW+obd3yU0R1j2crPRv9+D24cCg83Q7IpOX/sCOzjobodA/ozzV2m99HVzh/Jwc13RxtNr/sChR1MtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237414; c=relaxed/simple;
	bh=IP6VT8eDRdbw1bmE8R8GFrhgxSOo7uUT+zH5dbw9MG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bQcoNWIIioaLcZr8Jy4fv/2FEAV9W2LiwoEu/yT6T7zgCbfjtMrSHfFKmNLhXtNG7UCA7MR3BujtdPlqbMubOnRmKGraIZpZE3WEIFx2n5Vh/xbdGxL1cz3bCdLxgtp+yuVtGd1+Er46qmPnQyTxEgN805SDvHpEmQpoyTxEgl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXoshhOp; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6eb848b5a2eso764537a34.3;
        Mon, 15 Apr 2024 20:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713237412; x=1713842212; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OfAfxZQ2oOSLxgpuAwSaqkeow42p+JVYy0cCJMME+k4=;
        b=PXoshhOpAAL8w0aTWd2WxoyRHMfk0QytIEr3KfgpLI+zfmCB4Faez3sLZMtnZmV6Xm
         3IHLQY/OxX5v4VuOfINlN2L/a5oIJSwAdgTJc1q3PuJ8FfFjgWHktHXnUsY+hbUzsQpi
         WHp52W78/n3hd8arOMi8a/ZSGCUkX7Z1SHdPcvnvEGGrrtb0y1SoXL44kNIlLd5YXT2x
         g4WzOH5nJmQevAXPEqPwwE4541HfzbuoRgTSrpXH+bmCNqU2h0tfi2evHhK2IZ9LPkip
         PlH2Zgwiu5pKX+CODZr0czSLWof8SC1GIqBNqL62pbZDXtRmKt2tLayhRZElnN04TRk0
         DM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713237412; x=1713842212;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfAfxZQ2oOSLxgpuAwSaqkeow42p+JVYy0cCJMME+k4=;
        b=DixjYT41yTmhRRxbh4QNtoZJ7OIgR0wiwCmEaIamWFCNumqF4uWowP6deBzNL+wngd
         j7cYjWanB5NMYOy8TOcPW97xdks3kvTkZl23hgjW5xecyDqSKftf4SKhffCIaiDz1JKO
         uAt0GaYrp/UmfITajoxD7NrqPy83ic/mneaazSItU7QDGQ2CI58zeVvwTtzZouAFFID2
         mvam/eElHTa6IBpzJNhTP129jfgA69HZTJ14pZxS7bobcamQzRhIVlq5wAMY6Jk/2XmO
         xlH7TMsx1kOpjLupJJ/ZT8TLaEwK2CAdLBnDavoiSgIaVOolmSw54iKhwWySSqPI4pFu
         4rEg==
X-Forwarded-Encrypted: i=1; AJvYcCWdnAiJWgQVwUEuR585zfMLNOEcbXCbPP58TKCsY5Gsb15S9b9y+b6J401soTIW6ojI8n/Tcs67mKxyJlEu5+i3ot8fAYf3m9FK9TMcGoX13sXRW6HYz8U6EYWpOWFid0AUb0zxCow1fKaw
X-Gm-Message-State: AOJu0YzcjbK5JhHNcigViWeE0XapOiMiV2aNgju1JHCSKLnKXel9qhz0
	oJU7x7VThlvGA8hsyUyG2yoKidnZkLXFMQLy1pxdN/v99zX96SOe
X-Google-Smtp-Source: AGHT+IH/xrGHPv69fYUkZUs1gT+mx+8VcOP7E2bGDXaloBNA4L46xfkvc3RBGGnjAyO6cmul5NUsXA==
X-Received: by 2002:a05:6808:8eb:b0:3c7:1054:b1b5 with SMTP id d11-20020a05680808eb00b003c71054b1b5mr5686580oic.55.1713237412333;
        Mon, 15 Apr 2024 20:16:52 -0700 (PDT)
Received: from localhost.localdomain ([43.159.199.34])
        by smtp.gmail.com with ESMTPSA id t8-20020aa78f88000000b006e7243bbd35sm8278832pfs.172.2024.04.15.20.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 20:16:51 -0700 (PDT)
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
Subject: [PATCH v8 2/3] serial: port: Add support of PNP IRQ to __uart_read_properties()
Date: Tue, 16 Apr 2024 11:16:37 +0800
Message-Id: <7f4ca31ef1cab4c6ecad22fafd82117686b696be.1713234515.git.albanhuang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1713234515.git.albanhuang@tencent.com>
References: <cover.1713234515.git.albanhuang@tencent.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bing Fan <tombinfan@tencent.com>
Tested-by: Linheng Du <dylanlhdu@tencent.com>
---
v6 -> v7: add a "Reviewed-by" tag
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


