Return-Path: <linux-kernel+bounces-101342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC8587A5C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B0B1F2365B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A509E39ADE;
	Wed, 13 Mar 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnqDNsvA"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7039860
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325426; cv=none; b=OP0UystlLE6ZPXTDHF1JJABBcepnoSOuTQLr/isR0VaUClB1ZuVc1AS/BPyjMqOJ0CWhgRUcbFtknLal4VVrLLHSHOuzm5zhiKwX8YTNbfJTJgDJC5CD0LCFtn7W25brVOcDTCzowW9u7CZ0/pjKX5/Z9mYgXiwRLvjAKmYKEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325426; c=relaxed/simple;
	bh=7HxkYOHdvLa3vDWYcxeLYbaF/zPaQQMSyz4PwtWYdlI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=An00uQRTW32EdrNr5y04ZLNzc1ShgQRgL+w+ePHiK6queXDWtk2wrEfPkg7vJ9m/n5dsWa7bzQ1GA2HogPK1rqr8jdSmUWjVwAGmgiDRePK+fnOHM4FjWAtdbqCsm4NXx8zBjam6yXjSusUUEgs/fxV9Z5gGf6dnfdiarrtaMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnqDNsvA; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a1fa3cf5eeso430797eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710325423; x=1710930223; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bg+zFCejMNEntTHWqdq6Zt216uKhJFYmi4RiiUYU3I8=;
        b=bnqDNsvAotdDwqneLBCYZfAABKEVJowNUo6tvZr7WxZIPkc2Sd5ZiibqgEL9Q5mFCm
         F0f4tjlWynSBy2W1btu5/8Q0O1C+ATTJOdzkbqCnUtU5lXIRqdzznUKQ1+Ux1Tu48q70
         12s3iXrhnsd22D1mYbzC6a5sdRmERCE52JBiAIGyADuQQ5EqSXK3aiW1RCcuT5HLHF4X
         +vqbnP3sSXhrFpuHj8p4yJgXVdJkDgP7dO11q3NlAlC4jxB+WUHyadLpYOUu49FPtqk0
         mBz5HK8ORF/frjmr6D8GLr54fjLTLv7hKuyMZTqoCcH9YM24uBe/gzlofY83Wi90FpJP
         3lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710325423; x=1710930223;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bg+zFCejMNEntTHWqdq6Zt216uKhJFYmi4RiiUYU3I8=;
        b=IMG7CvIgY1Q+P+yx5NLqx6+A7kd/vLFNCm+MuVRmw5j6F5CpUrOrUa2r/K3V7uypVK
         mE3gPYr850ODRTtkoHGoLX96oXiwO/2ve1JMtCppjTXxVuAA2wxugCjsSphULrtiYh0p
         B4A/ny9nVSTTjsyj9b6qC0U5J6O7ZTZrHQjDuMJprQ5OfhVlcgPPaFBdEYWFiLy+ALuD
         H0UDs57l7DuMI29hWc+4IRRa5XaWqjiKdgSsCCK8rjaI1gEOc/IaDgBqWYOyUvpEN1Iq
         fktd/8WNPjuZx/iFOIYt6toHvtTNDIe5O3mEnL/+pEINxLxbbaukKsu9qhb1/M2dbWfs
         SP1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOxH84idfofW/bBq2NytvVIzmyhwx2Jh/VkEBXmSaJar9eH4gqChdJoC/EfKwWXCXFh0IcXUOjCEDjsdPKl5oMRFcOJz1ujOaRm8zJ
X-Gm-Message-State: AOJu0YynrOxZf4OBgWsnvr/vm80Tht7wbCtYEmYsJQTpX5YRJvPxzfht
	L8UhnNgWd1gVDlfVEYZLvApLrNqpI1IULi/joo5PEXz40BjGxb61
X-Google-Smtp-Source: AGHT+IEzvOD7FNKQGGcWoTqnHsGpNrL0vp+14BGND2U9/27MeFjrArd97tKs/A3AgD8Ii7l5esAXsQ==
X-Received: by 2002:a05:6870:1643:b0:220:8cc7:253e with SMTP id c3-20020a056870164300b002208cc7253emr6651488oae.22.1710325422770;
        Wed, 13 Mar 2024 03:23:42 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a0010c800b006e685c36d41sm6178544pfu.55.2024.03.13.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:23:42 -0700 (PDT)
Date: Wed, 13 Mar 2024 15:53:38 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v6] staging: rtl8712: rename tmpVal to avg_val
Message-ID: <ZfF+qu+CGHlpHrtY@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rename tmpVal to avg_val in process_link_qual() to reflect the intended use of
the variable and conform to the kernel coding style.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---

Changes in v6: changed variable name tmpVal to avg_val against a clean
staging tree
Changes in v5: changed variable name pct_val back to avg_val, as agreed by
Julia and Dan
Changes in v4: changed variable name avg_val to pct_val, as suggested by
Dan
Changes in v3: changed variable name tmpVal to avg_val
Changes in v2: added a period in message

 drivers/staging/rtl8712/rtl8712_recv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index a3c4713c59b3..1fabc5137a4c 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -861,7 +861,7 @@ static void query_rx_phy_status(struct _adapter *padapter,
 static void process_link_qual(struct _adapter *padapter,
 			      union recv_frame *prframe)
 {
-	u32	last_evm = 0, tmpVal;
+	u32	last_evm = 0, avg_val;
 	struct rx_pkt_attrib *pattrib;
 	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
 
@@ -883,8 +883,8 @@ static void process_link_qual(struct _adapter *padapter,
 			sqd->index = 0;
 
 		/* <1> Showed on UI for user, in percentage. */
-		tmpVal = sqd->total_val / sqd->total_num;
-		padapter->recvpriv.signal = (u8)tmpVal;
+		avg_val = sqd->total_val / sqd->total_num;
+		padapter->recvpriv.signal = (u8)avg_val;
 	}
 }
 
-- 
2.40.1


