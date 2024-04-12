Return-Path: <linux-kernel+bounces-141863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1203E8A245F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1817282240
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC661798C;
	Fri, 12 Apr 2024 03:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LU6AVIHK"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E218AF9;
	Fri, 12 Apr 2024 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892292; cv=none; b=e3pw5AxmU/bFBgMmGLn4aCfAo619u929hq/PYynFbHgHgHy4AGEeiCrhR1FYVktAQANEk9o+IvNIGsyEqW4ameDRW/OZrM8ZouKpE169hcHOLcxScNDaHUj5JuB63eeMVCGqPulwu9N17AZ8Gv08cjeNMaY0MnSSXdvvuUodYdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892292; c=relaxed/simple;
	bh=IP6VT8eDRdbw1bmE8R8GFrhgxSOo7uUT+zH5dbw9MG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EBljar6iawJEX9ayJN6A7oXccenUrp2clqbBO+pJ1uEOEZtfMkId+4kEEkr5Ft9xs7Fz3wfCIWYf+uPetCKvhnupXmttdhzWGzRYvnrOo51zte9Jdnxq92s3n53T3fh1ZwEHGcCk0uwt3TTj6qitIeig7Wpxi2Csdn/FynloIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LU6AVIHK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a53eda3272so304613a91.2;
        Thu, 11 Apr 2024 20:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712892290; x=1713497090; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OfAfxZQ2oOSLxgpuAwSaqkeow42p+JVYy0cCJMME+k4=;
        b=LU6AVIHK1ln7phY3euqrUntX6kKydNmgQ4k663kvozjNR1lsmXIPvBo2d+c3IUwL5C
         nC7wZIYt507bVXj29v5Fgw9IqTSyo+oGAj1qXtBf04d2ccZL0SfQyedCMTBcVwzWj9uJ
         zmDmV9DILSlqD41h2cvBWGOfPnMJ0sFYrKyRceO6eKdNcY5L+xcO7De1i2ucV4x7lg2q
         lAivmCO4isEV18IW1Jya2TsqloGY+u7y0J5G7Yp8yHGkdnFvpdeP9rUuA+TsRLBo8PTa
         irYQz4GTWwqh1O8ju2E3bWjGJYGQLeNyoevfk3SWW+/M7o/Vzo/LTc+p1BBiyegMpjpF
         nvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712892290; x=1713497090;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfAfxZQ2oOSLxgpuAwSaqkeow42p+JVYy0cCJMME+k4=;
        b=qBwRNVK8BwEp8CzUrEkStyUXbLnoxqIVkDVC0u7alktq14fSpMS2/rdFwj9gyYBX24
         PkkApclICy58DYjwIsDBUc2R2BRCZOXScyZTVBazABRtB1RHqJKYCWs0lG5CQs+agTPO
         /bVxot4lbQcW2bIgy/hIRBUKhYFkMeKuXTwLxcm+vJ8od0jFNPaaFgUnBVlcHfVxEA2e
         g4o8JUmbmnchwKdoNUiNGp1w3vIH1gkDg7CvjBi566n8v2ShD90EdOBzib01gBwfP+AO
         hGoktXcF9nQS9Gqc1m47wmn0UOC9QP7bX9wALoWeiFIGgdmMap4YMLRyFafIsapQqL0Z
         jeQw==
X-Forwarded-Encrypted: i=1; AJvYcCUmLISf1louDv3aA00SoK5UbecwcSjg8lzwTiNyJlJ5fGJbRMZsqTCrkYpoE3MsR9WLVngQ5u/BaU8O8Tmloxy3/NcCzqQMnhve0BCRt5bZ9M8y1Xf2/2WClLX2ZxBdi4Kzrmnm4tzySULY
X-Gm-Message-State: AOJu0Yyi+PTdA8E+8Qwj/oAMT4wfp5DAT9n3YFkw9wRl8aF3VKJ1ZqSR
	CsznTES0BUnVOak80DG4xBp+9ERkF0M7DphoaArpS3P4vJfPyVYd
X-Google-Smtp-Source: AGHT+IFBF4TQo9lpQg97wiRjqzlRudbtZGx4sY2yXC9yCRKikKLnSmD3iC2AwsTThUk7aCZYStTTdg==
X-Received: by 2002:a17:90a:ca8e:b0:2a2:9843:927c with SMTP id y14-20020a17090aca8e00b002a29843927cmr1271826pjt.27.1712892290294;
        Thu, 11 Apr 2024 20:24:50 -0700 (PDT)
Received: from localhost.localdomain ([43.159.199.34])
        by smtp.gmail.com with ESMTPSA id n18-20020a6563d2000000b005dccf9e3b74sm1512070pgv.92.2024.04.11.20.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 20:24:49 -0700 (PDT)
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
Subject: [PATCH v7 2/3] serial: port: Add support of PNP IRQ to __uart_read_properties()
Date: Fri, 12 Apr 2024 11:24:35 +0800
Message-Id: <814c5890d8613bfd890ba330c394e8d685c495b5.1712890897.git.albanhuang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1712890897.git.albanhuang@tencent.com>
References: <cover.1712890897.git.albanhuang@tencent.com>
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


