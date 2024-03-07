Return-Path: <linux-kernel+bounces-95396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677D0874D28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C11282F85
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03B8128836;
	Thu,  7 Mar 2024 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPrLV54m"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96485DDC9;
	Thu,  7 Mar 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810036; cv=none; b=TsK4ab+yhhcdtJZ9k0SXkahKduXXPtmkk6NXTTJn9ulnrg0yD0k6p/EAiFi2w3+YUWYMTiq5K83VDLD/Q0ovaVdrvFlVGzD6JoMDzC6au3P0V5G9g7voC+Sp9z1qeKyoo2hi7kDVtVSRgrER64DQQjvxDCfSDwItSJmvUzaFxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810036; c=relaxed/simple;
	bh=vzH93D4jP/qdyA1AdyLTY5J4mAvCYF4Oh9LEd1nqK1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iHXJY0E04c4BKzYpOZAY4zaXHnOdovzUrnoliSDMoaN/0ZTvef7Gx3gC/411NJGpeRQFRXzDznXF5gAf/O5u4qys/cBPUkNizK1eVesq8nsg9S6onrZieNw99bpvcUhdBrICBnXWutfut2V1ti457JcfA8y+tmo+x/VyU1kpGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPrLV54m; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e17342ea7so407340f8f.2;
        Thu, 07 Mar 2024 03:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709810033; x=1710414833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMTM+W302u0jntrzElYraz9pp6IOGybZeSVVmTNPZVI=;
        b=DPrLV54mHpyffnS1Uj0R3iXCdGRkdF5x/fuztpsNIanAPzv/iVQUOxYPerb9FbGGbq
         uZ+7f9aHAEj3GxFZse8AYEvgyuXQNxRnWP2vxit1rQmVWwtRmQFVwGlB2v0J8aaPo2L2
         Xtq2iwgmIM7qOJoCxqzEBBiKSeY6RsnMgtbo38ha0F79WmGFPg+WDluJ3qh/2DvKAQCZ
         H0nQ9hRbLnbwzj8G+yj3y14x7klOMTpwB868PinkNnylI/sER3aRlFDkWVCa1xNyogsF
         CijdUXGyXGHTgchkPoSdnc3sYZHbxUMcjiI/VlUjH3T5Ghw/9+VMJ7agf2I4O3M6LKwl
         HnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709810033; x=1710414833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMTM+W302u0jntrzElYraz9pp6IOGybZeSVVmTNPZVI=;
        b=Bu40FclSJFYReT4/L4R0JzXdUSY0sv8nwNyY63m195Cc+OD6PzOyfdl7j6X8FIxBLZ
         7zff46B54pTOxhXiNJz6ktl99wtHqa7uXEluTmDc5O78NXvEBHDOSHi7R/y0VCDNv2sx
         43RLgKt4QA8h8X+RXIVKLD9dgxoUY+l+V1c1VEGesOYyo0pS980bRECx7ao+mQ56GsnJ
         yTFSUrH2OA6GMDvo6lQ3vDgJGHweT6kl6gtZ405aNxgdatRPFZpvmeoukHmQIF5IJjI4
         lllYZj40abSqBP6Hh4HLv+PZT+HSb5TiVOqC/V3phUbkC5vlIatpAyqklaN73mRZMMM3
         F9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCX+8mJVT8hsWb6mMSuYJH9HakoEfkQ/Sp48k2f0aeHvjNnNXmZacu5QitkKpHbdXxA9GiMx8ZhRsW6rq6dVLnHCx06DQJL/HN+7lfS7dhPPvGN8ZbsxALksAJeVp035ONhyfGfxxVfK
X-Gm-Message-State: AOJu0YzFTMsWqjoYmu8lNxtWzLSPVSNtzQqVBhn6nwSX6nKwMwOVJubi
	cyFymx3CTJIx2dCimqzjHCOw7rHJtbKlzhhaf7h5JDkCkMBO3THE
X-Google-Smtp-Source: AGHT+IHvBV7sDcOnurRdoGtHENGsA5MWuFky9TsdX6SGRc40zvSZN0wPOrZKxDJvP0GqaMGO8NfEoQ==
X-Received: by 2002:adf:ef88:0:b0:33e:2f43:b35d with SMTP id d8-20020adfef88000000b0033e2f43b35dmr9539693wro.21.1709810032619;
        Thu, 07 Mar 2024 03:13:52 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bt17-20020a056000081100b0033e3cb02cefsm11067688wrb.86.2024.03.07.03.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:13:52 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined
Date: Thu,  7 Mar 2024 11:13:51 +0000
Message-Id: <20240307111351.1982382-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Function checkdone is only required if QUIRK2 is defined, so add
appropriate #if / #endif around the function.

Cleans up clang scan build warning:
drivers/usb/host/sl811-hcd.c:588:18: warning: unused function
'checkdone' [-Wunused-function]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/host/sl811-hcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 0956495bba57..2b871540bb50 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -585,6 +585,7 @@ done(struct sl811 *sl811, struct sl811h_ep *ep, u8 bank)
 		finish_request(sl811, ep, urb, urbstat);
 }
 
+#ifdef QUIRK2
 static inline u8 checkdone(struct sl811 *sl811)
 {
 	u8	ctl;
@@ -616,6 +617,7 @@ static inline u8 checkdone(struct sl811 *sl811)
 #endif
 	return irqstat;
 }
+#endif
 
 static irqreturn_t sl811h_irq(struct usb_hcd *hcd)
 {
-- 
2.39.2


