Return-Path: <linux-kernel+bounces-2161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ECC8158D0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB321C231F1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745B015E94;
	Sat, 16 Dec 2023 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKXJWqkh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780A14287
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35d67870032so10576745ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 03:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702726607; x=1703331407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ocRgCXAtsKIhDY46/sNAXTkc2BKnazpPIGLZ/doKpcg=;
        b=XKXJWqkhfagO4WVtlkNfglAkBEzIFfLHMyXNd7d+xxoc7f26dy7447Qj+qFLqyKBIe
         gdWwVypzgFWtBK9dXaGF+YRSKJC4EjjJ0A1gtfa2wZ05t9YKteM58rXyINlxHK3xnVO3
         OLQIjnBsDWDQ7BY6loFrAVCjxQcjhSVGaumpL8F3ukaGwOuFPfe2DZmnakPV7guY0Muu
         FINtF51CdVJFE5kwdLRtW4Wk4sKtJOCsX+oSS2q9c7csZTbFIbOR1huAEz6/yK2yLXaz
         UY5j61q3bwxLga/chHUGYxNcA688obte6Tao5jURvboshIQabFPLVKzEmcVqeGiTb86C
         06+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702726607; x=1703331407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ocRgCXAtsKIhDY46/sNAXTkc2BKnazpPIGLZ/doKpcg=;
        b=UJ7cC9IF4+6GIH/ARewM4tVJv/CZz8w9o6xmr9E9kS0/PvzCiNiEid/FQX1oHo/WvI
         zFrAR3abimNPcNmKQ5bUm1A+AvORulQl+gYzKT3LhJ+Ou8b+hOrSlLTTkZtSIGFyuK+t
         9Li2Ipb3iwf+yAdgy1f/dRSEImRPxDey4acUukQwBNewDamG0Wf55YGJJmMSGwJnq40m
         fXY/q5xoY1jTjJbmFrOJY8zNHs/bx+wXA3mcspGeVZwM4ED4drc1Mg9PxORee6QbSmTJ
         RxDitkdxh7fjWhROuqpI3gurEZQAFhY0G/+G/99dN5JaQ30BaYZlgRg2xeyCFbbVMsNT
         bCeg==
X-Gm-Message-State: AOJu0YxzVIduxshUSF0UFgROdVvt17TSuoJdwqOYqXi7SV6ynVC7kZ0t
	mTBbqLy4q5wW1TM2kiG4SYs=
X-Google-Smtp-Source: AGHT+IF+N7Bexz7tdLWcUJarav1fmFO0fqWWAeba5Apfcl2pQgC8kSDi30Q//cBzbgGdYCXBqmtv3w==
X-Received: by 2002:a05:6e02:1706:b0:35f:9907:280c with SMTP id u6-20020a056e02170600b0035f9907280cmr2517183ill.1.1702726607524;
        Sat, 16 Dec 2023 03:36:47 -0800 (PST)
Received: from attreyee-HP-Pavilion-Laptop-14-ec0xxx.. ([27.5.150.118])
        by smtp.gmail.com with ESMTPSA id p4-20020a634204000000b005b856fab5e9sm14481504pga.18.2023.12.16.03.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 03:36:46 -0800 (PST)
From: attreyee-muk <tintinm2017@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: attreyee-muk <tintinm2017@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/drm_gem.c: Fixed WARNING in drm_gem_object_handle_put_unlocked
Date: Sat, 16 Dec 2023 16:13:51 +0530
Message-Id: <20231216104350.12375-1-tintinm2017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, I was sending out the patch in a wrong format, hence sending
this patch again describing my changes.

Looking at the code and the call trace reported by Syzbot (issue link : https://syzkaller.appspot.com/bug?extid=ef3256a360c02207a4cb), I understood
that the issue lies in the drm_gem.c file in
drm_gem_object_handle_put_unlocked(obj);. 

As per my understanding, I believe that a warning is given out when the DRM GEM object handle gets
destroyed along with the function getting returned immediately. 

To take care of the warning only, I think that the WARN_ON can be removed with
only the function getting returned when the object handle gets
destroyed, without a warning. 
Or else, we can even have a message logging in the place of a direct warning which will give out the
information that the object handle has been destroyed.

I also think that the WARN_ON is given for debugging purposes and hence proposing a
solution if the warning can be replaced with a simple message log.

I am looking forward to getting help in this regard from the respected maintainers.

Thank You
Attreyee Mukherjee

Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>
---
 drivers/gpu/drm/drm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 44a948b80ee1..b6be9400cd11 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -222,7 +222,7 @@ drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
 	struct drm_device *dev = obj->dev;
 	bool final = false;
 
-	if (WARN_ON(READ_ONCE(obj->handle_count) == 0))
+	if (READ_ONCE(obj->handle_count) == 0)
 		return;
 
 	/*
-- 
2.34.1


