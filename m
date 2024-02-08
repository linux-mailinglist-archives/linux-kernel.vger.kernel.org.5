Return-Path: <linux-kernel+bounces-58660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED5484E998
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4146E1C249A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C5F39879;
	Thu,  8 Feb 2024 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c874SOTU"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC156381BB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423695; cv=none; b=j02U+jT3uR1AVMJSS4dGRngsJ7Hvn4hd36VvAgMskRhNVLdLe2kK5yhGps3h2fYs6B4XxDuUMOSlHmssgWgxR/C/QTEtb1MGCnbBOt996czIWZ8LCsF5TSRM3VqdAx+FDihCHwbMyh2vBAHUk7TDK68eAogyN507/l7xhiEGNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423695; c=relaxed/simple;
	bh=nAC72y9nCMt5M2rE08cy+EKifsJkNi+UqTztF2InwRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GkBBD6iUYQ3mJP0VHRox9+yjR23O54xlYOouUSHd3Cwhh+1oU8jmc5QYY5R/kVBAElxD9Ep138rErUQPIyC6HG9pFMLH+kr6DdFU9UYI6xGD7rhyF4quDCOmplVRmPhP8RUaAG2hXBg1qEG9+dXfRedSrhX6f9Pl/oVEjVCwzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c874SOTU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4105f6fbdd9so868055e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 12:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707423692; x=1708028492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PBI5LRHcyQRwuQ0BEhkOCNkk7+RE/U9Dvca/0tT/hao=;
        b=c874SOTUF87vEzGsq8sxZxY6i2sfgEamztaAXr8QumK7Nn2D4lLDD69BlxoAXBCZJy
         +9VpLKkvki/bsIPo7TpgsSq+B+tgsqewe0thch+QdExY4OaHjRoBWt5/h6qQOJZq+/wr
         o81LrKA1jc7PtcC4zGB1kHAm/gFFdcTvJKBuQaUrKlAw4M9Y9nsx3QfHaSZjZz25/9v6
         t/C2DgFinsOEDIcVJzdK94MfV10h4QivOtL5gwsYqU1ZjUtnqeB/zHBOypAQXqyy9R0k
         nR0hT6bHCawLQVS4NT1GJYEQYH3lO5eJhOMExvwpwCgEnRiIv8hohqom3pq4gGFbNPQs
         Gw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707423692; x=1708028492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBI5LRHcyQRwuQ0BEhkOCNkk7+RE/U9Dvca/0tT/hao=;
        b=LBRDm1Xi7WlMQ0I9T0aumxsmN5CxBQBV1hLb9RtnvqEM8HW9+itZcP2h7Ovxh5lVkp
         wMVUzhE8LbFoaExLYTg8uOgw5Gxk/5p9nrirs7DdKSMLv1ttOo8hhGaSqBdfB7xk62LW
         +pLg0cmotK7SK9q6G82UpIJmNVXTxyqDLecXWxHSytAwpO0aVYCPfJ5UuuV/yXBK2aJG
         Lh9Z/PorEEysFRA1eim1wS9ma04vIQZvD8UZjOnUPukhGSx+PyDqRQbmyYatziupzvv/
         p2X6Il85UGp1RMVEV5pqUQIrOSdmAeT+bRKxc+ydZiPUKoNc/5ThHPFaLsNxrOrHWzDH
         UR7g==
X-Gm-Message-State: AOJu0YyiYeNa8+yro8YKTMSr1psJe6ZbjcCqBZ+X2+mLGPpMW7lqvdLC
	FIPMyRVHsFuX6ZFnYJyPkRNbHmr4GuAqIYWk29YnAFmKg/4iKrVHTQh4cqsjxug=
X-Google-Smtp-Source: AGHT+IGgCcdVRGnutU5fTG8uDEif2vfAlh0ueCVlWS7VS/t1D1IMKVE1DdfA2YKoimKFWOcqPbZ9AA==
X-Received: by 2002:a05:600c:4710:b0:40e:491d:ac80 with SMTP id v16-20020a05600c471000b0040e491dac80mr362706wmo.15.1707423691933;
        Thu, 08 Feb 2024 12:21:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVltGLAGIQEyOdJ+4hn6i4tgQYk7lxb00ec+Frbzuakr9ELE5HeuwP54FDewuoxP1lBNfE6mTlaQhadJ7Krgv/4LoLCd/rDtoarCOVA
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id fs11-20020a05600c3f8b00b0040ffe1ca25bsm353289wmb.21.2024.02.08.12.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:21:31 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] serial: amba: use typedef for dma_filter_fn
Date: Thu,  8 Feb 2024 21:21:29 +0100
Message-Id: <20240208202129.630242-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing typedef for dma_filter_fn to avoid duplicating type
definition.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/linux/amba/serial.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index 9120de05ead0..ea3646e7a803 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -15,6 +15,7 @@
 #include <linux/bits.h>
 #endif
 
+#include <linux/dmaengine.h>
 #include <linux/types.h>
 
 /* -------------------------------------------------------------------------------
@@ -223,7 +224,7 @@ struct amba_pl010_data {
 
 struct dma_chan;
 struct amba_pl011_data {
-	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
+	dma_filter_fn dma_filter;
 	void *dma_rx_param;
 	void *dma_tx_param;
 	bool dma_rx_poll_enable;
-- 
2.34.1


