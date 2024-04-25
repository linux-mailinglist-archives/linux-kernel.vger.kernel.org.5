Return-Path: <linux-kernel+bounces-158132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D79B8B1BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCB01F25139
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA996F085;
	Thu, 25 Apr 2024 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpSLDOjo"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516866D1A7;
	Thu, 25 Apr 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030404; cv=none; b=ptOIoKVwhn7Aq73aO0qZIrnOVsoH+x8a45DOQrnYpXe79XhJT2u0yW32UEiAL4W8qlxl+j4Yvxsj21+Jxsr36+Zgrg0gVL+DFZME3RgxxiGNM+uXDrSECLg+HSaI4GTRTnzPBe2rX6CwH7SkcHlQuXhyhkigJb+VLq3ioViXwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030404; c=relaxed/simple;
	bh=yQPp0irDE4bvJFs5/v3OhNF0jayHDfM9S++trAEJ968=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QSdFPYF6OcSskFh84F2kskEvfNELAV2KTo6+1Dh9Y/3LfUz4gVH8YVTIaxaki2p1jZwh5ceEPcnU7QmMLHV+gQP8Z92LT2PsYIXprp/nl7gtY0AGsKqa467/JI4DWj2lgbI7D4QC4LBMtJ8DDn+CZ7CTK/bUthWxBTJ1SnaZ0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpSLDOjo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a55b2f49206so308824766b.1;
        Thu, 25 Apr 2024 00:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714030401; x=1714635201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/IS4UqClkjz22+aZMyoD1TjebdAdftH51Mqj1OGGDU=;
        b=KpSLDOjoVBxMHzVKhlu/hpoXUN59H85XQOuLR7t20dJ8vqYVQzoTU1+dePHYe3Jyn1
         d2670ELu573SNa2G2IJOEDEDdlqFZRi2m1B2GI5OHEEIYFO1mfbSUCvU9cOrydMmKhbO
         Tcikjp6ZX29XEI3z2UUwdmTnQiSZpGtOl6skCYAonQzcYaNaOCn4sXM7RFv/2GBxwqxr
         UgkLPx4PoXqkBGYAs/P7FjzTHWgD1bX+PhoCmxjn4iUIWy7zumQYHMs5FSmBKKDZxOhR
         mygKREcJcwxX2ZlkSMMb983ZImcnbFHu/Jg8WsiRvxgUtGW/PSbPWRuifLMFDhKGPPbt
         ZySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714030401; x=1714635201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/IS4UqClkjz22+aZMyoD1TjebdAdftH51Mqj1OGGDU=;
        b=ozjaNmJaV235QpjqPzfwMdXGjZcsYK+ax+wa+FGI1ghzgiGqE+1TdTyUSDq0mLecpS
         L8NOzeLkB3WH4qA842aT1WiIkxr2arfAuVc3xwDFeTcqPNX0Anm+vGq5BkLpJOz49M78
         fphIoWtcBErGgDxr7NGQHOi1mqkTIsIJPq85nlz2046keIPTa7UkZ6060BHqcfOtSh3O
         jD3EfXopKYzX2IvKUGrfWVWFEqpJEPgd45P3PH6AbyO/tYUx5jNYqrF7WNkULmbjv5Mh
         ICED5HfISX8di5jDlmwg6CPLgsyIK3W4Vi1Agazx1byMeldY8uBhOSVU1NZP+kYgBFNJ
         EcyA==
X-Forwarded-Encrypted: i=1; AJvYcCWNng5o6SFQv3TdxJcdIm35aMYTCPfnHnbUtYhY68MIIIvvu6eAesrYWXkuAMAAsIXJiL8qwep8+OXjun8XYmhGYZL2jbekAsfDKbHTB+BMROionVlM5y/woWaf76u6dp0wpkRIOrHXC74=
X-Gm-Message-State: AOJu0YwXFq5GoRT2wMqWUGmqoledvJJX3hYEg7EXemDaxnvc2coEoNMV
	k3HOrA1KoDxs+yhLOKosvNtc2CH+PePuvYaR6LjDn3NFpW8g44+V
X-Google-Smtp-Source: AGHT+IGgxfLOcLJJ37KfJQwIItxW4Vy8K4tvhLaacPhtEsjx+NCKWwIFrIXL9Iwu+j5yah/RQJZezA==
X-Received: by 2002:a17:907:7da0:b0:a58:be5c:f2e5 with SMTP id oz32-20020a1709077da000b00a58be5cf2e5mr202046ejc.20.1714030401202;
        Thu, 25 Apr 2024 00:33:21 -0700 (PDT)
Received: from ubuntu-focal.zuku.co.ke ([197.237.50.252])
        by smtp.gmail.com with ESMTPSA id h3-20020a170906260300b00a559965b896sm6596790ejc.202.2024.04.25.00.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:33:20 -0700 (PDT)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org
Cc: Dorine Tipo <dorine.a.tipo@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	Linux-kernel-mentees-request@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers:video: Implement automatic cleanup for device_node
Date: Thu, 25 Apr 2024 07:32:54 +0000
Message-Id: <20240425073254.2608-1-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes calls to of_node_put() and adds __free(device_node)
attribute to the device_node declaration in offb_init_palette_hacks().
This reduces the risk of memory leaks by ensuring that the reference
count is automatically managed and decremented when the device_node goes
out of scope.

Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
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
2.25.1


