Return-Path: <linux-kernel+bounces-146151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8686A8A615E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78061C21781
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114D817BD9;
	Tue, 16 Apr 2024 03:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3JbczBU"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621E17984;
	Tue, 16 Apr 2024 03:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237394; cv=none; b=t6Q+PkpcJRUE+d/Kogqyxi+j2RWEVG0Ei17RGOfpnkh/VnB/yFPI3JvC3ICXeB/DPKVI4izkkJUIey0Q5FJb6uVTDDt7hZINFaUyEpk/iTzzOgl2kxu/7/6/wrlTl5FiwSKewQvjg5okKrVMl6gznoC3+7S9+nPmDKRB/CoSVnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237394; c=relaxed/simple;
	bh=qshOwbkjhDK7IvO3CYwTpMh7IPQRdScQ9N0u1PaO7Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OU/ium+e4R6CCYC8GAbRthY2nWaq3vjLKeobi3Kjn/FGIn7EkDBgSxFJOyR96KkFV+IPtmODfD3WLnDddmBkflgWgtDwvvSriKlPkrL+4aJMROENSPehoqDHX83AXFF1736xffiU1FAowGJWsqo3CCeHdZm0KdpjIMl3Dr5yL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3JbczBU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e424bd30fbso30459245ad.0;
        Mon, 15 Apr 2024 20:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713237392; x=1713842192; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x6//tEox5KRG/WsekWic2QlpMO9KpZmieUBGRrot0kE=;
        b=D3JbczBUtMbkeCmoo5Mw0CWMtPyy3RYANxRgSlMpW8pnfyW0gPyHkN6p5LkkZj6tBD
         98p9vC0BFZ4QTUJ2b9cITGoCjf/hSfOT009HZuh4L/jvcF7cj0VEi5llBEJRYzHobaaU
         T5WHOKlqnxsqcUNwT2mx1rR3XFAdo85/tQ9m1cP8Wep+4gT1LQfElQC8M/nIo0TAVnTY
         jqdddVQCjFUpD+s1dOhwUDmHt1NVc2hNHEhFy3+Z3QMfn+8fF7LtrFS6V1OMeE+t37U/
         I/V49MntPlPg0p4EHVUJwJ+O681aFU2rIAQhSGeReIlF9apks4oA7xsjQf+WBH/9i0o+
         XOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713237392; x=1713842192;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6//tEox5KRG/WsekWic2QlpMO9KpZmieUBGRrot0kE=;
        b=Lb52T7TUgKOj+Ge85O5wWUg2C3C1OyB7JLtDb5l6lk9aciwDE/fNAH5sAUbIfJOzY2
         0Vh9Iyw/5mFrTTT8mUZ9uBgDb6bLuo27GHMoST9TauGGEkeF/USvXAruirCTfrhDHRZa
         jWtV2jEFX0Bqg2NVaSwly2B8ecJPEyxHEfV0JTWjvO0agFzHCQMhzOgW/Dlaz9P1sVUT
         f1hA7mfMQlCJB2ufe2ZWKn5M97RQhUdqSFDu4VWrF7ucKL9UXlm7Gxtku29nv1p/sL8F
         E9cdsEZhKEcOnC5LnvdsFR58/YMOgA//4/lPSO6SI0Wrt2xWsaR8R2LCCDCwpF4Rz2YO
         BnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBOWk0BIw+MFqZWH4Nt1lmGkirFOR3s85FmUkevYGrKHz1ABEavQlBCiS4zr5Kl2zrVuUH1idTdGHYIpiAUbJTLTNe4rqazBvApJu+59JY3Fy7nq5NjT5fUsz9vhV4KrIrRmyiUWmeqFGL
X-Gm-Message-State: AOJu0Yz+vgo9Cz/Yg6ypKSUIp5djzzE7PM3aB9aiMXxQOwU4BXoEDJJq
	hAA/m3kKJHNPYHhov9MOPbE0iu9lYrq6NJfA4sDtkSUuVw+Uqduv6bkiWQ==
X-Google-Smtp-Source: AGHT+IErcQB2hTwDoy8nQxydHHDljvB6Ftuj4nATNE1n7p/H/4kJ1ZAm7u4TdkoxNjEgqEY39zTbSQ==
X-Received: by 2002:a17:903:1c9:b0:1e4:55d8:e5f1 with SMTP id e9-20020a17090301c900b001e455d8e5f1mr15222562plh.5.1713237392350;
        Mon, 15 Apr 2024 20:16:32 -0700 (PDT)
Received: from localhost.localdomain ([43.159.199.34])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b001e78d217fd9sm2058496plh.16.2024.04.15.20.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 20:16:31 -0700 (PDT)
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
Subject: [PATCH v8 1/3] PNP: Add dev_is_pnp() macro
Date: Tue, 16 Apr 2024 11:16:18 +0800
Message-Id: <4e68f5557ad53b671ca8103e572163eca52a8f29.1713234515.git.albanhuang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1713234515.git.albanhuang@tencent.com>
References: <cover.1713234515.git.albanhuang@tencent.com>
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
v7 -> v8: delete a "Reviewed-by" tag, delete a "Reported-by" tag
v6 -> v7: add a "Reviewed-by" tag and a "Reported-by" tag, fix build errors when CONFIG_PNP is not enabled
v5 -> v6: fix the issue that the cover letter is not chained with the patch series
v4 -> v5: change "pnp" in the commit message to uppercase

 include/linux/pnp.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index ddbe7c3ca4ce..82561242cda4 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -469,6 +469,8 @@ int compare_pnp_id(struct pnp_id *pos, const char *id);
 int pnp_register_driver(struct pnp_driver *drv);
 void pnp_unregister_driver(struct pnp_driver *drv);
 
+#define dev_is_pnp(d) ((d)->bus == &pnp_bus_type)
+
 #else
 
 /* device management */
@@ -500,6 +502,8 @@ static inline int compare_pnp_id(struct pnp_id *pos, const char *id) { return -E
 static inline int pnp_register_driver(struct pnp_driver *drv) { return -ENODEV; }
 static inline void pnp_unregister_driver(struct pnp_driver *drv) { }
 
+#define dev_is_pnp(d) false
+
 #endif /* CONFIG_PNP */
 
 /**
-- 
2.17.1


