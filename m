Return-Path: <linux-kernel+bounces-109368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D5E881825
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EC51F215C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FF98565F;
	Wed, 20 Mar 2024 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqJvwi1I"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC196A323
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710964253; cv=none; b=ZbVUDeQ3dXvVJ3uedyRCpl7liHnV0WqaevU9aOTyWyD6IYlxI2p42ralM/DMZ7gceDPquMMexPEyEtY0fzyDwSIJVyx1S7lzHUF5yzMKG9HNF7OXNmKfGlDMNwn12ywN6BjdvdTf6itOSnMaFQG3OpxEJJXkCyrS6zEdqpbpTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710964253; c=relaxed/simple;
	bh=0/W7ESYmtis8SWzlUSewRHzPrYkRdMN/q4nnWZaZDFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bn3kRfHfbUv6iplE8BPAQTXj0/YyqmLztPXxdLc8le3ooDRFmcLI5pqPazNec2NWbmlJ5Tl0wuugAzGw+vTViWOzShL7bkgkwSBAgh5ywsfL9vg9gfB/xgSp22ub7Hy4YiYTKYG2O2h5cIoHMvZ7s55gCahZLdxfQLnZr3urEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqJvwi1I; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dffa5e3f2dso1265525ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710964252; x=1711569052; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRikpztEX2fwVvw9gSRXNm3qTKd29WgjYs5PneXIbLc=;
        b=SqJvwi1IlxmRaKAG4rXSiA8GLi/GPoRxz/0tkWseVBi3gzeTCgupK1MGP8CKvTAYeq
         j4QoNfRiLna0gN4WQHycqaO/+3x2xIbk+qc94IwSvDclaWmXSBk73AzfX6XE/RsqKt4C
         PVyu3NPsZI9j/jZ5coHArLe9pb6w/Dh5zwTOlk+yca6GlGAjpBSveBCywWJGe4cpyj7/
         g0nsl/cKpSCBBqLPwKc4pkz6zwZwcVw/4x1Uq0qgTWA6HIPOm9/ylC+1hibsHQ6xYr4e
         dt0yTrQPQQdwVIQpzfNHbvqAcFmecMXDC3y2h3TlHjdnNHMXPKdgRHUZSKmEeG78B9e7
         VxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710964252; x=1711569052;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRikpztEX2fwVvw9gSRXNm3qTKd29WgjYs5PneXIbLc=;
        b=ceYrroAtWDwVmuGmHril3E2EW7SswskQCvcaBWPpnwc0aqp/g35pDOZDDRp6CycS7e
         ahywEocoMFf6OOvBAgtyv6ML3sfoUR8Fhyj+stcUV2OfOZnvtrmThq8YWjV/A5XN7FbD
         ExiLLd/UV8uqOmTaTO5+UK8+f+5ppOQbdtfzGkeOY3TbfCB+wHv6ElQiOwnNeCh1BJq1
         NZWAJwcCvrscjvAo/r6Aay0gJ4EeSvlJvxbl68Il5/Dsj1A/MImYHyS8hVckAk/NsRNc
         M42zuYvYqtc9PkJwzTFrH4do1jEdU7r1LGZkvllz3xcaPT0IGcqktimPRoDqDu3/7yQ1
         8gmA==
X-Forwarded-Encrypted: i=1; AJvYcCWtrsmrJ1fmUXDE9y7F7pvM9PGOOleq3nyvKq+qVFr0Hy0Jxs3we1RlmxbM/yFCJM7+zLPfbteJyvYaNdORjanzElV1aaPj4Na7J6Uh
X-Gm-Message-State: AOJu0Yyu6HPu939bxqEO3R+yrlB3cgzeU5UKDboTOmYjy6nxa8+3bsG6
	A4HX/ZpYNeGTYQKtBeiPgvOQflxn3njkBn8+u6iTZRGq8cl0Js94
X-Google-Smtp-Source: AGHT+IHbRlTKqWtyyLF5oB3Uxpp1IauadFkrgFc+SRYJM579cvOlLYoldDBT893fqNGSxD1AdZGITA==
X-Received: by 2002:a17:902:d212:b0:1de:e473:55f6 with SMTP id t18-20020a170902d21200b001dee47355f6mr6219658ply.66.1710964251778;
        Wed, 20 Mar 2024 12:50:51 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b001defd1c0ca7sm7726001plx.229.2024.03.20.12.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 12:50:51 -0700 (PDT)
Date: Thu, 21 Mar 2024 01:20:48 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v2] staging: rtl8712: Change type and name of local variable
Message-ID: <Zfs+GKmt9hDZdWt/@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Change data type of local variable blnPending from u8 to bool and
renamed it to len_padding since it only assumes 0 or 1 values and
seems to add a padding based on wr_sz. This change also address the
checkpatch warning "Avoid Camelcase".

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
Changes in v2: Changed values of blnPending from 0/1 to false/true
and renamed blnPending to len_padding

 drivers/staging/rtl8712/rtl8712_cmd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index bb7db96ed821..f499bbbf5bf5 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -284,7 +284,7 @@ int r8712_cmd_thread(void *context)
 		pcmd = cmd_hdl_filter(padapter, pcmd);
 		if (pcmd) { /* if pcmd != NULL, cmd will be handled by f/w */
 			struct dvobj_priv *pdvobj = &padapter->dvobjpriv;
-			u8 blnPending = 0;
+			bool len_padding = false;
 			u16 cmdcode = pcmd->cmdcode;
 
 			pcmdpriv->cmd_issued_cnt++;
@@ -294,12 +294,12 @@ int r8712_cmd_thread(void *context)
 						     0x0000ffff);
 			if (pdvobj->ishighspeed) {
 				if ((wr_sz % 512) == 0)
-					blnPending = 1;
+					len_padding = true;
 			} else {
 				if ((wr_sz % 64) == 0)
-					blnPending = 1;
+					len_padding = true;
 			}
-			if (blnPending) { /* 32 bytes for TX Desc - 8 offset */
+			if (len_padding) { /* 32 bytes for TX Desc - 8 offset */
 				pdesc->txdw0 |= cpu_to_le32(((TXDESC_SIZE +
 						OFFSET_SZ + 8) << OFFSET_SHT) &
 						0x00ff0000);
@@ -318,7 +318,7 @@ int r8712_cmd_thread(void *context)
 					       (pcmdpriv->cmd_seq << 24));
 			pcmdbuf += 2; /* 8 bytes alignment */
 			memcpy((u8 *)pcmdbuf, pcmd->parmbuf, pcmd->cmdsz);
-			if (blnPending)
+			if (len_padding)
 				wr_sz += 8;   /* Append 8 bytes */
 			r8712_write_mem(padapter, RTL8712_DMA_H2CCMD, wr_sz,
 					(u8 *)pdesc);
-- 
2.40.1


