Return-Path: <linux-kernel+bounces-136384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EB789D37D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D82B22CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019DC7D09A;
	Tue,  9 Apr 2024 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqQ1LQUd"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF67C6CA;
	Tue,  9 Apr 2024 07:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648637; cv=none; b=P4KbyTrL9i61eHKvM9CDvdf6tNnJjsARQeTFMJxmeoGoFhABNse1A3WsTpczlx6babi9evPrM7TfG96+rG+zT0O6t92gyxl1DxKGDENLf8q0KK1FwBZQqQuIuAtGtcItOj+4+dUj/Bb/sDe6BLLkLEwKxHtEy5v44mT0RO9uqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648637; c=relaxed/simple;
	bh=w0Z0P84vxqSmx39NUsYXq/qGnGd2RcUjYIVp1R5MhG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CO/SCc79DcAR212XlkjWC5x2BgBR4c/P630Oj0hUWxOmRMn56um7h5VZ6Lxc3Kpl7Ztg2KYvTjWj/BDl/doDOpi2HrWEoBncD4Js41ohnWvTdV6950R5dNRb9V9Ec3FVQklkCUp6DPDebW45KKF6WZCYHYS3HzMt8wpSPUbl0/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqQ1LQUd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e455b630acso8134485ad.1;
        Tue, 09 Apr 2024 00:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712648635; x=1713253435; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ONFD4/Vc6YR7CCQ0n+d7jmlTotuvow43AhDgWdDDx6I=;
        b=RqQ1LQUdNT7P5q3OJbrmD8bWQEbVo1PEur7XHUSkaTNLHfmQjd6ONyxcxzq/zd0aZf
         cc2Cs0BpV4FCrhyLEV6VhH1eBLVz8NTw5uRmRTrwX/54KhtUryRCdGYOMp4Vr2VwH305
         8NfoMFEBg5DTXqARk4xfEZoTKHf870UvaG00gr4QYDU0tJgsg78hq1/Qn7WBhRJZe35v
         GLYHxBpohfoos44fCJGbtF0m/dkGHhaG1ZiSh/yoKMWZPrgYjBzWBcwhUelru8DPDAzY
         mdqJ10krxyUtojUhTnSq9NCK8xb7E2h0kzMY35CwP7clzzff35qd73I8jcsVFUSa1OID
         t12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712648635; x=1713253435;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONFD4/Vc6YR7CCQ0n+d7jmlTotuvow43AhDgWdDDx6I=;
        b=t/OkaEBeAVfCGxvqLAe2t/3HKffIDch2ih7wnBiWideeCZdDmAka1vMlTmsTjJZ7sN
         n8SxGlRJeAW9yWyKCVUSm0I0/jbTrytTMeaLq5JpBTbHX8jnM3ia6aS4yk125hzqFWK/
         KURRpgFVeEpxowUh08jx5uY4NarmhDa7AYRPx5euvi+LtPkQsnKFmegMx7jpbf4Iqgk4
         SwT+dws0E40aOCTModkD6i8qk/ELH0NWUY3dVK5grG5aS1uu295upw12H6+zxpdW2+wa
         n5F2OEEYH5jlOsU6GMcqdTT+Ck5xnPpuMA4F/kEbNUnbDvRKybm7h43tyG2WWdHUb88E
         CwkA==
X-Forwarded-Encrypted: i=1; AJvYcCXNAUDcexYJA9BDHgt+bZ6vc0LYEO0uvwKID3SnYrUhs21kxz1OWH0we1F+LJG+GcH6vMKpBHJoI9GSp+5Y95sRVkZo8VcBWGZn5OI3tknF9eNgdhI3jsVDYXttNdM81SMyvt1Dqu/MVcMl
X-Gm-Message-State: AOJu0YwP/83KVhroWV6clvcQ/95hgJVvtZ881j8irDKnPfYGP/bYOOEx
	64rbLZp6D7kLpIsO+zOG3w4jtxTQ2RzD/v+K/Gpz/y2yUjSWQxbl
X-Google-Smtp-Source: AGHT+IG9f4mfZYnvm8ROpu5/UudNC3S46z1v8L7mwA165lyQ7y+oj0sj+xask7LQmgHgzOs+8CwZEA==
X-Received: by 2002:a17:902:da81:b0:1e3:dc0c:1bb0 with SMTP id j1-20020a170902da8100b001e3dc0c1bb0mr7864871plx.1.1712648635342;
        Tue, 09 Apr 2024 00:43:55 -0700 (PDT)
Received: from localhost.localdomain ([43.159.199.34])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b001e424ccf438sm3458975plx.97.2024.04.09.00.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:43:55 -0700 (PDT)
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
Subject: [PATCH v6 1/3] PNP: Add dev_is_pnp() macro
Date: Tue,  9 Apr 2024 15:43:41 +0800
Message-Id: <f8f216c4a36d2266b4fbf48f95793c44f13fb506.1712646750.git.albanhuang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1712646750.git.albanhuang@tencent.com>
References: <cover.1712646750.git.albanhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Guanbing Huang <albanhuang@tencent.com>

Add dev_is_pnp() macro to determine whether the device is a PNP device.

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Bing Fan <tombinfan@tencent.com>
Tested-by: Linheng Du <dylanlhdu@tencent.com>
---
v5 -> v6: fix the issue that the cover letter is not chained with the patch series
v4 -> v5: change "pnp" in the commit message to uppercase

 include/linux/pnp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index ddbe7c3ca4ce..792921c06594 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -502,6 +502,8 @@ static inline void pnp_unregister_driver(struct pnp_driver *drv) { }
 
 #endif /* CONFIG_PNP */
 
+#define dev_is_pnp(d) ((d)->bus == &pnp_bus_type)
+
 /**
  * module_pnp_driver() - Helper macro for registering a PnP driver
  * @__pnp_driver: pnp_driver struct
-- 
2.17.1


