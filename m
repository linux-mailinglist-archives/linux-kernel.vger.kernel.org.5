Return-Path: <linux-kernel+bounces-75568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5124885EB31
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E536DB27195
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0732C1272B3;
	Wed, 21 Feb 2024 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP/YHcbq"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84E3A29E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551944; cv=none; b=q0NV90N/zvYgAI9jURPj29EphHubNBZv5x0l+plTZ/eDPH6rRZP6cdJM7KFHJm1kO4UdpBdRLTNUsFlfkngjYl6uP1zPCucmXy2TVcZJJduHJ1Nq+uxBPNXhcFjSsd/UcAH/l/o0ssGkfZ1PbNAnsizDmuBCzHJR7j8xhuZ8HJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551944; c=relaxed/simple;
	bh=x3wrIfiS+4hMvoU1Yli9XWwwJhpuldzeGM9+2yOJ83o=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzLuwpZPYOk6OhMEIG8Z71T6HfgflTGVe2BHVhGX1RG4p33ywFx32lErV3GlHHHL3ocKh+GJpoAe765wyhA5pzwCF9XqGNeckKO0foSKW3I7/qM6HmtWeVPIP+HP58dj9nPh12qPUyhM4fRGKEZxuwFNKnMM2NWttKvTHBAdkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP/YHcbq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41244a8ae12so5484175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708551941; x=1709156741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3bIQ3iiFn1BJ2ioh1I8RqVG2EQ3pCkt6p5JTvGUIPbY=;
        b=dP/YHcbqKeAtTFYqEqMcPpfW0k65XpSeIubCwSkZ5/D2+gCsYY9l2/mYy7ISceaEbb
         mQFky831yoiSA10oYyD19Yv5pvD6e/B/qMHjGxvmoOFvmaoMdOX5HYdu9BhbHwK8tpcv
         wX9Skmct4FYA7dO0OotAx/xIzF0ETp3vfCLhCIlL1gJvoZtTsqTKOJyHw0iE5ltP95VW
         kieWwnuXyNv8dP5li04f8CAPapNGRFGD8pzfAAzBCifPBxHqyoVRcyqVIiGIEOJ6aXLM
         8g59sUoissiiLJo/n2tYzsZ8mIbLqI35sI5JEWliDcGLTDWpXzvucoYtmqOhiagvNW4v
         9sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551941; x=1709156741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bIQ3iiFn1BJ2ioh1I8RqVG2EQ3pCkt6p5JTvGUIPbY=;
        b=ds9nyOFYOvTa3Z4E2Yh5YWYqGH33ij8/qsYdW2H2lw7U0g8HvM5Vtc8gpwEZEmGQu/
         FXQygFkllmMblA8SwYtcw7ALGlPiEYBv52BYv/iLRF0bvB8Z4KiXcDsxKuRamX2nsn0z
         yy3r+o4F4NSSSqJKQDcNtwb/I4ZmSkTQhkzMo71xn4A2vjH56nyuotHf9+F5jd6W5/os
         04Hr9gcvJ0JtcxW0526U505CIKoh/4ZGaXtmjPZcsjLMinbn9CNROVk5/ffihJkfZIAd
         ZKGuPfrft2xfGIMkLadXwrTiv9tk/DdXmdTviSV06XzQ3EUZAEUKyEtQKTHD0nEJ0jXC
         GXCw==
X-Forwarded-Encrypted: i=1; AJvYcCVrt7xzn6cs9/5tfmfM/uyu6+Vt6bzeUCc9QM5PeunEHzrtqqRFUOIuJ9ubY6Zqnnz991m5uwXaQJEavBQ+hRNmwP0ai2y+durxlSTQ
X-Gm-Message-State: AOJu0YwIJ8HtHkPm4+BcUF3AMcxDyxmeaM3iVFwHjAZz7dOd60DKJFiR
	kCJPgEKcpSQln8cJurnB4ZbBw3TyyOH4htqounIsVpuL1ZF7ZlOKlf+IdPS8K6k=
X-Google-Smtp-Source: AGHT+IGI+OTlVEO7wIsXzAbhMQNtoGzHCywFwCT41xg8p1ig4AGa2ou95jce3cAxKesZ3FvlD4fmaA==
X-Received: by 2002:a05:600c:3b89:b0:412:698d:69db with SMTP id n9-20020a05600c3b8900b00412698d69dbmr5801097wms.2.1708551941036;
        Wed, 21 Feb 2024 13:45:41 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b00410ac2d6b40sm3854150wms.8.2024.02.21.13.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:45:39 -0800 (PST)
Date: Wed, 21 Feb 2024 22:45:37 +0100
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] staging: rtl8192e: Remove unused variables nic_type and
 RxPower
Message-ID: <96f8c089aefe6648dad0c68663211b375f016517.1708461563.git.philipp.g.hortmann@gmail.com>
References: <cover.1708461563.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708461563.git.philipp.g.hortmann@gmail.com>

Remove unused variables nic_type and RxPower as they are set and never
evaluated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 2 --
 drivers/staging/rtl8192e/rtllib.h              | 2 --
 3 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 07218edab746..e7494b548749 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1295,7 +1295,6 @@ static void _rtl92e_query_rxphystatus(
 		pwdb_all = rtl92e_rx_db_to_percent(rx_pwr_all);
 
 		pstats->RxPWDBAll = precord_stats->RxPWDBAll = pwdb_all;
-		pstats->RxPower = precord_stats->RxPower =	rx_pwr_all;
 		pstats->RecvSignalPower = rx_pwr_all;
 		if (pdrvinfo->RxHT && pdrvinfo->RxRate >= DESC90_RATEMCS8 &&
 		    pdrvinfo->RxRate <= DESC90_RATEMCS15)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 705b94f0911e..605bce803b5f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1500,8 +1500,6 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 	};
 	unsigned int count = priv->rxringcount;
 
-	stats.nic_type = NIC_8192E;
-
 	while (count--) {
 		struct rx_desc *pdesc = &priv->rx_ring
 					[priv->rx_idx];
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d764de9459e2..d238fce712a4 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -474,11 +474,9 @@ struct rtllib_rx_stats {
 	u8  control;
 	u8  mask;
 	u16 len;
-	u8  nic_type;
 	u16 Length;
 	u8  SignalQuality;
 	s32 RecvSignalPower;
-	s8  RxPower;
 	u8  SignalStrength;
 	u16 bHwError:1;
 	u16 bCRC:1;
-- 
2.43.2


