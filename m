Return-Path: <linux-kernel+bounces-123621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FBC890BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3D22A619A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A5013B5BC;
	Thu, 28 Mar 2024 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmihVNw4"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12FE13B2B4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658765; cv=none; b=opbdK4RxX1BE9H/EILCuhQhrQdoafB9biG6rxX5xurOiP/bYQrxOrJMp0OnUJcJcX322BcBWqlyoBwnWOubjuuPeYhUiu0bKdVwqjzRtfXPkX3fXpC8tnQTcALU8b6koptZO+l44gfMJBWZQA/08+81uFpNZIhQAZ26aYX2ZrEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658765; c=relaxed/simple;
	bh=PfP/LX3Ev4ZUehDhY9UJfJ74Jq7QmGOSjpUQvMiYxco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Brr+nRDvmNgLYiofQPF5YMmi6Cvq7nr42nZsH44N9q3A1mk9P4IKqiJTeaE5qDsNN4uHSnxwJPkfH7++EeduFPH/eCk83DXko7JXZpSmMC2kyA7RvW8eZ6mflKVGBpdFWgT2A3bvn9v2HW4HbOnq5fUVTKekaB7sOrsr5n2FyJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KmihVNw4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d6a1af9c07so15807721fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711658761; x=1712263561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYeSOjYCYletYyTMoe7CAWFQDjjR31kHZRvMnXWUDgk=;
        b=KmihVNw4YL7Tuq+7YhileiB47aRtemh8/J7BeQGqMJxqrhxezE9f1hVdd+xYAqXjxG
         ihNUQprPgCJrExHfSM/aoN1ffzqdbsL/3RMyD368rs3SYn7LRMvoYUcrxfYAhc0mxo50
         LFGvKukV4yewczGx3vOmjlRpWlfiZTuo/FInkghSSbYiJbsaXB3lXoXFXb6JAg5S+PH+
         kItcNqihRAPhpcWVvK7xSN5JyAjlPT350kWk0rSijVKvQfZSQZQpHkCewTHfpkh4Cura
         qrYcpADKlBFhkHcr5yaQbqh8oazKBgyJVIXTN8Xdc9c90yfOsbFmLXUP4psx8I9urphl
         ATow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658761; x=1712263561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYeSOjYCYletYyTMoe7CAWFQDjjR31kHZRvMnXWUDgk=;
        b=Mi4XUPsqG8VMvqcAMVCZl6Ao6U+hGYn62B/j9Wt1/o+Dj5KNObKCdM0uyt0Tx1tHwE
         uMZZ+UR/K7l+gr7MJYfqUpedPLc+/vAtjWkxIfvgzLgMZRmXJjx055tTxzT+W1VVbEzs
         S1+OdVSJ2D5gEYsqDxRd5vHBqOVP5XCcvYJ64XawdlhI36H8R/epRMxkqR/KD44ZUgPi
         B8Nb9JFEn7PqP8SUctWFvD7bqjCHNqjOkRX5i43rWKiZS90l+wlcGPIEhmzkuj21Z0Gr
         IesPwreW/e2iOOc2rjfI25eqppfEizOAp7A8C9m6AuLLAm6hI3376M+TA1HsWC9A8cUE
         /9PA==
X-Forwarded-Encrypted: i=1; AJvYcCVTA5CHGmJvCjXlDePWNWNpv1OJDLWhzqhoJfhNeacvsu39JRR7a5sHSYBRF5uBCXCnlPZfcpG+8AYLKcU0AfMqk2uAQdhHSREeSbc3
X-Gm-Message-State: AOJu0YwtKhelzBc8ACasSzePlXmEKexwkfkZ9rvItmi4V4QQPYgatJpI
	2Y/PjSVXvpUHgY/vUp6qBz3DLkTSvk+SYK70qOFmUDV5FFurJE3BwkIhN+Y+xgL9SNJgyEmPTmy
	S
X-Google-Smtp-Source: AGHT+IFvd4/nk37r7rVjow21GdS3wGb58FM6tY77/OHE81pF5KHG9dM3xOb66fow38EUrgKLOcyW4Q==
X-Received: by 2002:a2e:94d0:0:b0:2d6:eaf0:87b4 with SMTP id r16-20020a2e94d0000000b002d6eaf087b4mr173678ljh.11.1711658761219;
        Thu, 28 Mar 2024 13:46:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041497459204sm4762697wmq.12.2024.03.28.13.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:46:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 21:45:49 +0100
Subject: [PATCH 5/6] scsi: st: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-scsi-v1-5-c86cb4f6e91c@linaro.org>
References: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
In-Reply-To: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=625;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=PfP/LX3Ev4ZUehDhY9UJfJ74Jq7QmGOSjpUQvMiYxco=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBdb/KToSvZh1tplwoBiPz/6g7+MTtAPeJ3Mz7
 J6OxB0uUK+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXW/wAKCRDBN2bmhouD
 1+uwD/9RIGyMDC4NkTCcZceZp1g4yQiblhlfVg5AjfocnBtkJx5plBQSRH7qTG0DwIfLrSch3el
 ZrlAsCFRKO6lDDh6Dqj4wVjJMmjWS5Z57rnqJKO4P9g+cA5K/NGtLcFmidCwdCz02m+dp296Hn1
 RIGjL/SGFEW6Tw2wD/ikOwJX+hGSM9ccryPWaQobKOPEaSAV8aaoTLfMOd15X7UCMUiApWOAsjv
 7TKg0eQ7CeWLxc4l/8YHT4i/Wa4fMNsrWl8ePZCntYQ2OghXMHoEnR9Cljd844NRlkkXxDS6pjc
 Jhd2SscOpR0DVt4amCnuihrWmGS6So1vIEF0bacBPEuyPcvG5sxwA/OPCRFuxEC6Gejq9az3wI8
 l7yZfjjdvRnOdeldBUkvgQHKNihDuism2eMLdO6qEjNQCHNHlp+HoI7b56sm1QLNGPLNXrxywPU
 OYDimeGmit+RCZCYm/m1YDzGUEV/aGOJ+rpIsLEKQcbTYDGq77RB/aVg/rH6dwm6B8Ee75IQ5YS
 Uh5uxBqeW3Cgr9+/TUVQIkAt5v0NDFqvAXEWpxxjLMrmM0hJ+17tVKXMc0DyAIrx4nH3+gdIFVt
 eG2aubpzjmltdyc69Y1EN6UNFcxrIc0VrOcNNKUTcfEw9K9VOxcLb60z+aEWviRZTObNKtqQ27J
 ydKPwW+Q/u1foXA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in scsi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/st.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 5a9bcf8e0792..0d8ce1a92168 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -206,7 +206,6 @@ static int st_remove(struct device *);
 static struct scsi_driver st_template = {
 	.gendrv = {
 		.name		= "st",
-		.owner		= THIS_MODULE,
 		.probe		= st_probe,
 		.remove		= st_remove,
 		.groups		= st_drv_groups,

-- 
2.34.1


