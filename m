Return-Path: <linux-kernel+bounces-166875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 043698BA13C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34D7283F0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC54D1802BF;
	Thu,  2 May 2024 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e95T3MQ+"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95442AB6;
	Thu,  2 May 2024 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680080; cv=none; b=CB8OL6Ko5SoJ5nhyl1iRTUFLK/x4qLCof9mVp0aeiDyAum2wA/+VMiXAkWnAm5XqmJUA8PIajKH38tV/94Ea465nnRRDCSqRpNRT3uYv0lKmJXOEoAxHrbmZ8M+EEZWtEfS5ZYOJkDxAOzaMdHJQOWPt71LY/E3ux+srHkf8G/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680080; c=relaxed/simple;
	bh=rTBDgCqzm9I1eNIhz2jjJ+hF2kv0hFIJO1QBgNYCLzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fmF/8bQZlZObpKwiJYF75sCMGYas54SexWgfL3HNVBpiiJWxT+CRTwZL2NyzvH4FyRT9jao4Jf7uWhilL/eVnqCJ/rNU8Sq4oghLp0hgw6bzTtD9H6hkFefyxogp8g42Mj2/sQ6u4x6iT24cwuGxbG3glMPNPcz5hzRtwhdtjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e95T3MQ+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1eab16dcfd8so72687255ad.0;
        Thu, 02 May 2024 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714680078; x=1715284878; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaz8rW2sq3u4mWnq4w7bNSJ13vyEsIaZonXWAGwzYCs=;
        b=e95T3MQ+LQ9CYNyuyd/nfwMfPVgORSFWEnzXbiwxX+NUXZAZyqsSejrgiCPXLdJvU7
         lWmZ9t4nyg2lWZ830keQ6UzrGOETWzWhUYi/5RbmCfXpgPkkcMnVb4ZtcJTYuCnyEAe5
         /ZWA61cV8hY17Cqn7rECASpt2j10qHPBs2iLVpM99EOrU+B+zrCXnYWOnJtOuj5aZLfQ
         cDVIGvORh0NTR7FSNKizwcBFacdO+3uINRR3fsNHODu8UWTByTD59xfID9c0ff3VKdrQ
         7wTukWuiuWl7vmJjV1NR7JA/MmUZJ9JAaRnhFLWzy2VO/AuCwb7WX5ulIjYqYxVmEuIA
         FUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714680078; x=1715284878;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaz8rW2sq3u4mWnq4w7bNSJ13vyEsIaZonXWAGwzYCs=;
        b=pK7jIJcE/G9wDenNsyONG9HhlNJF2LspQ65kof1g8A1ZFPOqZYKGTSM9c+0byxogRH
         1lw8PF+OqSZjDi+OlLqGW0Iw/SM2u7jfDVOsA4jncCLnkPohPoL//xLGf1wvG++yAUq9
         gBfxWeZkJ45SpzOm2koW5pMYGN5R4M5mIJQ98anYK4WvKiASvc6JIi9HCfaBUfLtsCIY
         +1+WwltWCb2TkE9jg2m10yijculxJyElcSoMCHDzIpfceuBfikp5hthSLL0dY8KCNA1P
         juRukRf91krul0Af5WqfEZ4Ov6cEGBHcIp74rpFQwgkBBNAGUBmcdq4529UvsZcwO4k+
         MYEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjOBdk5E4WFvsyxiwXVuJqSJXVvlugOaLrRe62tAw0/EigSzJ9qaNoUs70vNgucwcmYrwzcMvxGLSdSa2ek1iXE5KhpBQQsAy3M5/D
X-Gm-Message-State: AOJu0YzZ9ctdXcHEWvZw7kEZYkQ/aXH2fBOZ9DWzGXbC7g7QGP7joKku
	O+5kVhNLlo2r42cFa4OGzvkCZQTonGcmog6oQN7Vh/nyU+xwaSgVhsyhTBYl
X-Google-Smtp-Source: AGHT+IFo69+W9OhD2MlkT00tcySGlmudG12kCBNx4rppmHaul9a8Wp/3Zo1K5hFmMcCmZomdYMRhxg==
X-Received: by 2002:a17:903:246:b0:1e5:d021:cf02 with SMTP id j6-20020a170903024600b001e5d021cf02mr870737plh.36.1714680077654;
        Thu, 02 May 2024 13:01:17 -0700 (PDT)
Received: from localhost ([115.96.207.161])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902c95000b001ecc3a62b7esm1732757pla.45.2024.05.02.13.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 13:01:17 -0700 (PDT)
Date: Fri, 3 May 2024 01:30:11 +0530
From: Aryabhatta Dey <aryabhattadey35@gmail.com>
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Cc: deller@gmx.de, tzimmermann@suse.de, sam@ravnborg.org, 
	christophe.jaillet@wanadoo.fr, javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] Remove of_node_put from drivers/video/fbdev/offb.c
Message-ID: <ipercce5fi5islpzglwkxsz5fyffooxz4cn4luxa3y25yfvawf@lbt46vliet6v>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add __free(device_node) to the declaration of the pointer pointing to the pci
parent.
This change replaces the manual clean up done by of_node_put() with scope based
memory management.

Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
Suggested-by: Julia Lawall <julia.lawall@inria.fr>
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
2.44.0


