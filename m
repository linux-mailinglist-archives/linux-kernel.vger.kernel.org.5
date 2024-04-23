Return-Path: <linux-kernel+bounces-154384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535DF8ADB75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064A41F22481
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B94912E40;
	Tue, 23 Apr 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWKtVIWy"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174C6FC18;
	Tue, 23 Apr 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835228; cv=none; b=RoRinJpLNfnv9Ar3N5W7D2WgTaG6In6FtxsSrkBvsJEd9C12rKEjHeH8afRfqkzDrjwrDV9Pl/mGRDIPnInDDGmQcN3JiadGp522519xvsLj2yvx7DH4SI5qpEDYpuVFPAT+FVSF645rwxHeqWYJYawr39EcNX9TnO6QD2wwOs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835228; c=relaxed/simple;
	bh=8uMzQyWJm5Y6tVm722cv22TcEYfdMGHPWQCXt/bK0jM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNsZiEpXB73vnhU5HgPvCAG2xPklTziISBdvZbPfgxFZCWT0ctnTMrwUODN63xh4lVTuXeT1SA2cJoCZef72iMOdt8i85ZbsFLxy0M3hIccioFbAyUQP4EjymRycj14F8ao5UrEf8vB/2yy+xWqffO0dMN+bw5YOSK84xrdXAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWKtVIWy; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78efd533a00so351519085a.0;
        Mon, 22 Apr 2024 18:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713835226; x=1714440026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/X3oWVdwceQfK7JUbUass9+jsVy5WEkRvYuO9s5FjoI=;
        b=HWKtVIWyLLY4UkJskjIIXOmK1wYYxOS0HGaV8AUm95Ic/wT2JgIYIz9I5gIXpZ5wo0
         gSoJYiH6c/R1kunAuD0ng3OYHytGwqIo1Co2LEbKalterG+65yxezM5V42Zpqu8aWiK2
         B018X7QqaJ/bUHNwj9IDNcKCvdz7p8U6z5jaNl/ibXtUYHj0q9X/PGPTj6+CTk0BGWOz
         sBSEa06aoaI9KR8AI2KFCf/iknl9T2mDMBY5wC5n/5rRL6tYAnt+ztEneLxUhBvnxcnp
         na+cqB0PjQDOcr+Yq5Xl7Z5QecpanXQYD45rWOXQFQhc6rVZIcNE++NVuy2fPC9sYV/x
         NrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713835226; x=1714440026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/X3oWVdwceQfK7JUbUass9+jsVy5WEkRvYuO9s5FjoI=;
        b=WX7ny5kIO24Qzoyw2+ezipw0cXjIZDj5KoiECVz7HzT+5ElX/MWswjOJ74NiTMZHKP
         n2C4p48gvdIJi4mTH/m4IeE94/h5/kQaJQyrye6kLSje+Utrerevm7iXJEmkBZ5Av4NS
         Et+aDPZNaNmpOlRF0LxgIKDUw/jZWvdQr/49gP3E8Sru36fqzbtOmNwaQDgx5HSwnOVD
         19PkImcs59Y3CL5gJKBftcGoToQB++Sl6LNuocuhOL+dkYbGFIYuH5vwUB+UZGCLddF5
         qb+1wgY3ZfaY4VprWau5Q9UQkYDFDjo+nSWNP0beEEqsZbHB60x2fQNzCrXeh0hAS+dG
         nYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi823t2uKTZnZen9/JfniGmoLQB5euL9wmlWNAuKTmHwkUr/Af0STiDd4kEiWXpiZXpBw7dTwTlB7poev8O5xwJbQHqxZt1yDp8aM9mwiuKHbXANrYDNSPN+GAJNjJZk2S1MZJGFYSApE=
X-Gm-Message-State: AOJu0YypEaW2lNZWwgja33TTCLM9r6gDiPI7NPTQqWqolNjGjZZJDBfP
	vl3RFlcYaL09taAK56c4wxeeHgHo5Rf4vFEzDMA7IwcEr2ri5BI3
X-Google-Smtp-Source: AGHT+IHNrFNlRd8vHin4jO4b0/uHrTcFQKkQwjaNMI1A7Rs0w4RKZLqx3b3gXukSPNY57d4AO6waKw==
X-Received: by 2002:ad4:57d3:0:b0:69b:63d2:6bc3 with SMTP id y19-20020ad457d3000000b0069b63d26bc3mr10704024qvx.5.1713835225910;
        Mon, 22 Apr 2024 18:20:25 -0700 (PDT)
Received: from sheunl-pc.ht.home ([2607:9880:4327:ffae:7c2b:7751:30a3:52c9])
        by smtp.gmail.com with ESMTPSA id p11-20020a0cf54b000000b0069b58f8c33dsm4813265qvm.45.2024.04.22.18.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 18:20:25 -0700 (PDT)
From: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
To: deller@gmx.de,
	sam@ravnborg.org,
	tzimmermann@suse.de,
	christophe.jaillet@wanadoo.fr,
	u.kleine-koenig@pengutronix.de,
	julia.lawall@inria.fr
Cc: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH] video: fbdev: replacing of_node_put with __free(device_node)
Date: Mon, 22 Apr 2024 21:20:21 -0400
Message-Id: <20240423012021.56470-1-abdulrasaqolawani@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced instance of of_node_put with __free(device_node)
to simplify code and protect against any memory leaks
due to future changes in the control flow.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
---
 drivers/video/fbdev/offb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index b421b46d88ef..ea38a260774b 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -357,7 +357,7 @@ static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp
 			par->cmap_type = cmap_gxt2000;
 	} else if (of_node_name_prefix(dp, "vga,Display-")) {
 		/* Look for AVIVO initialized by SLOF */
-		struct device_node *pciparent = of_get_parent(dp);
+		struct device_node *pciparent __free(device_node) = of_get_parent(dp);
 		const u32 *vid, *did;
 		vid = of_get_property(pciparent, "vendor-id", NULL);
 		did = of_get_property(pciparent, "device-id", NULL);
@@ -369,7 +369,6 @@ static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp
 			if (par->cmap_adr)
 				par->cmap_type = cmap_avivo;
 		}
-		of_node_put(pciparent);
 	} else if (dp && of_device_is_compatible(dp, "qemu,std-vga")) {
 #ifdef __BIG_ENDIAN
 		const __be32 io_of_addr[3] = { 0x01000000, 0x0, 0x0 };
-- 
2.34.1


