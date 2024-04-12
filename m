Return-Path: <linux-kernel+bounces-141862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A258A245C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA98B21053
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171F417727;
	Fri, 12 Apr 2024 03:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku7wpXi4"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F8182C3;
	Fri, 12 Apr 2024 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892268; cv=none; b=XMQf4+Pqv9wfsvCcGQ8mqd6mUgV+LUCNk+iauH0tRUcjLgaoRzY/h6HPvFyPTMmcTuQs6qZhTys1S+/rcfItaFFcp8aP39+edm46avD4BD3YRYmnCCpoM8gARQpkYFVQEKx32abexMnq5aLGiEgDs2l9AGLAv7eYjejk6RpgwgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892268; c=relaxed/simple;
	bh=yZw4Jjq2AN5aMLxXNpw7l65AU8UStiEiNBekBWTKNnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BtYNRgEUlOY4RWgN4SCPQkn4T/N3J2lAmgo5OwN0I0K806Sn3ggGeLz+hn2jIzRLT44IUjgldGeUQCHyDzmp90nzuA8RO+ZrHdhGDc5A5Dk8sYo5L3SQgMt+mXtEYFZsnDEnCXPacoiHvTi+Qx4zU+JFbqUCOH9jUiZ4W5OWMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku7wpXi4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a53a4a283eso364235a91.0;
        Thu, 11 Apr 2024 20:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712892266; x=1713497066; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SvnG0oBIU6cI316sayoppBSPEOQpaDRnhL9Ex14LSPQ=;
        b=ku7wpXi458pC4dNh8aUdp4n9mhPh06h8A+EN3p/hrDjaprisW/dCbMoMpAeXb2wiEL
         ra/EMf6Kj0DvJmiw7M/0jZVHUeDmBac1zLyPe98Gf7qoAiaO92iDoCWLklDWxl21T7l9
         EwzD/skV3yCN1TjD7//1B6t1+nSH5ZQt63Zih4vu3HHF8qCzXYYXpVepKQlzJPIkuOZb
         aWgSgBHKWLQlEdWqopRIqAgqX31q9AhIXsVKMnCZ50VGCwCtA+BkUjwKFoOuFYenKEka
         i9ATUQ2H+IA+GH8SYNMazRgi8OI7pKYgrUkKpTvTQx+pZDGUMIBUbhAW8EVcdQ7XoGOn
         VIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712892266; x=1713497066;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvnG0oBIU6cI316sayoppBSPEOQpaDRnhL9Ex14LSPQ=;
        b=T1hWoIAS6abe1AtLnHhzDI2AhUti8Rm5mmPHFq3JgYzOEZcvcx/sgO2r/YTvov8rSj
         0kjlyzGgyaMRtVC9FV/H+mYmnUxQ2sSImXrwmDN99F9Pi+nEWE8H3YsLGxxICvWgyyMK
         VXwCJ1GmxDLZROYHHrkYCswHuGiBoTL1RWW2L5ng+T2V1cpJJhIT7YAsJ/nV+tqSTd8V
         ueJotBBnkH0ZikHFuYhNNFOyXAUuWR0OYfU9wgaAPgvGPcbPLr2b3RWdrX7lwygrsXxM
         Y01X8V9d6qZudsuuYfxDAleCSb8AyjtIBFfNby2ZDon+eyPcMJOGulhMUSF3M53nLbhY
         WuXw==
X-Forwarded-Encrypted: i=1; AJvYcCXFAwYg6hDeVGnNZnHBKQhkyTXVzmTr7EhqP5kx6zlZMy6HS0hRfuEwh9kOdusKodHg5dYvfs8fSS4aqmCwp2fs193y3/d8ZRcDVG+upGdXUzr9ntrwsZ+O31spzawMFsfBhjQGKNZJnSIM
X-Gm-Message-State: AOJu0YxsEZd68AhBeVVMGoYrO2Y4cFUewgdGiS7zn0lNuiXjg5CLRRGC
	inKPGlkwdg0cb0ZapA/tFCI7A5RrOaZ3Pznl3zXF3rF1ML0SwpcP
X-Google-Smtp-Source: AGHT+IHCtEPhlaKAqj5m6cf/8AGbOFoG7qLEIifTkstc9gu8pZVor5qAw3TSDH4UndgKuwIzGjtP4g==
X-Received: by 2002:a17:90b:1bcc:b0:2a6:a760:79f1 with SMTP id oa12-20020a17090b1bcc00b002a6a76079f1mr1379889pjb.4.1712892266394;
        Thu, 11 Apr 2024 20:24:26 -0700 (PDT)
Received: from localhost.localdomain ([43.159.199.34])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090a459300b002a2a845868asm1813035pjg.57.2024.04.11.20.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 20:24:25 -0700 (PDT)
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
Subject: [PATCH v7 1/3] PNP: Add dev_is_pnp() macro
Date: Fri, 12 Apr 2024 11:24:12 +0800
Message-Id: <41d35ec4ff287ad6ab4fe7360fc80fb604a12958.1712890897.git.albanhuang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1712890897.git.albanhuang@tencent.com>
References: <cover.1712890897.git.albanhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Guanbing Huang <albanhuang@tencent.com>

Add dev_is_pnp() macro to determine whether the device is a PNP device.

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bing Fan <tombinfan@tencent.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404100523.b06UvPSB-lkp@intel.com/
Tested-by: Linheng Du <dylanlhdu@tencent.com>
---
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


