Return-Path: <linux-kernel+bounces-123620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932D0890BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42E21C20DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAE813A415;
	Thu, 28 Mar 2024 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNNwSSpv"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF713AD1C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658763; cv=none; b=HmFU4oIcy1tNQsY97f9bojiw6CmWvLEmagKKp94PsNBv0a62+oOOLFQSvfJFBJQtnkVwD08QyyLhF8qMlm68RRw5HfWP9ArAHnpj6RipYc4VwFaaKD5+6FWQUCSsbilgaBUGILYH567eNszm0gVnHjEAI2SA814+S8dCIFXtlYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658763; c=relaxed/simple;
	bh=4Fz178QR/piCy1oylUTMuDaEW9dLh/iogDNu5WpJ05Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxQWKMDtZ8RSgPulxqt5qJQ2v0iaaJejbho8Sc91NJAGH1IDojanOU5gRkxCM8YuBakYUI1877ErypUkjwqi4EgOfL5PUHLXkpQDMOrxQML3yh3Mz+dKlYMqmHfYXdqjX71XXHFK73eo89FLvCTOFtXqUsm9nEKRWi0NY98Eibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yNNwSSpv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-415445d169fso7960875e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711658760; x=1712263560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gihd7cntoI/c9dKCWsDUCUdVda0GMecgJqmR9/ZB/JM=;
        b=yNNwSSpvYuNypMG7aBLrZOwmyc5IPJlvV6iKv4zqBYZvPqvDhOJBV3374KwyeLEBjM
         enGiSVFqfwmQUEOGZQPY2WES6ne80tNdOjzJSJ9dVoIGPDiHUk7SjDXx5dQ2bmkiSZmS
         ZVX0aMmuRAkNq+PZcdaX4jccwExEDPyJSzx78sXFA3Y73yoeDn8JFV12XCmJU3Cy4P5F
         ZrUrmv2VwBj+anFfrC1QPYwSVy7AhiEjwCxBkiP0+6dM6mvCSibUN5egMznK8fUN2qHC
         zE4HJnzn/BNpN82oQpOTyLRRuNjdsMk3XRgVv5J9xAieFxLmbf1EGEBPF2lZhDlmD+1h
         4GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658760; x=1712263560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gihd7cntoI/c9dKCWsDUCUdVda0GMecgJqmR9/ZB/JM=;
        b=kZPtJ/Ub6S/ZmH+Vvj1JgCYmQ6G8JMjRFwIH1zkfvbtdPrmQgieiq897hGM+GWF26V
         /d0Zph0E7QwXlGK97/EODIIzG+q1+5ZK3ss7P2TdSZA8IKDas6hKBDUri+Lsa1oDCFeD
         tLC52L6HpK4HGhqw/ZVC5xVvDS7eBYdnyCfrRVrozF/Bqy5LkKgNU9XwnPgo2IiLhZjY
         OyQTs+KVaJTeSwHoCqyRGXyx0tzzcaKjQaciiVhMAYFQIn5q8b1N6aPxZ5DGGS/LPSru
         oW0C5cKmaHkPKbMhuaKn/PruNeXX1MNS42+7oNkScmxp9SU4fC3HzU13etehrePW7lhe
         tOvw==
X-Forwarded-Encrypted: i=1; AJvYcCV0fcJvGfsNbkFxE87kaGnGfL7xEY4GegOd/vrib4u/7MfrSWvlepOAqad8OIk3IJEZa7dk9xNzB8TBCI2tXrM/BILWjhaIQRQFVgQk
X-Gm-Message-State: AOJu0Yy6atD2jVRuWbP637exWtul0WAxmMJz95MmvqTnahoyhuYJoIFa
	oS7nD1FaOqr9rU5lzSeWLf53mlwDegWQHt/sXPwOh4MRadHTjRf+3JAZJlRhMWrv4TfbOaLqUOu
	m
X-Google-Smtp-Source: AGHT+IFIld09eVWLoR912QMzlPipAzeDg7jl33IVXCQwpqaJJvkmoUuBfzq9qCgnmB/IJDmhPMrZ6g==
X-Received: by 2002:a05:600c:468c:b0:414:1eb:3010 with SMTP id p12-20020a05600c468c00b0041401eb3010mr304229wmo.17.1711658759914;
        Thu, 28 Mar 2024 13:45:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041497459204sm4762697wmq.12.2024.03.28.13.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:45:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 21:45:48 +0100
Subject: [PATCH 4/6] scsi: sr: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-scsi-v1-4-c86cb4f6e91c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=624;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=4Fz178QR/piCy1oylUTMuDaEW9dLh/iogDNu5WpJ05Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBdb+42KAcqRgn5Z2VbIu8bbhRdnyFNx2LZu3v
 KxbbucT+muJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXW/gAKCRDBN2bmhouD
 17T5D/oDY+G7rZG4gjc2lMsI13yuufpx9LdNJZeci5LgHYjWQ4o9zSkFZ3jj36LAJFMH+VujJs3
 oOfV1KGQQ9olmVbClqhLWE0dbpTyRumUzT0exw4aX8g2dtGwy5ALHUGppm7Lx++hwt18Fw8goy3
 K6jF2z5UWkIiWGBjtDulwoj9gti3aykR/5pN0zIc6XoADK7Nsp4Z0i896pNULRGwIwBIUUAS+PL
 JqsN0MTUpxUeoVL574/m+Zo1Z6d3ECzn86MA5U8WjRGRnsGbC45Ns36cW9NUf3gZNZYouXWUx0M
 iGOf0ngHZaVVyrL81OzuNgPblNMnQ7weyU7++Zlvc5fqMH55V44HRgN28WH4p8xRftIRh/wGZ8K
 cGGcotfCFOxn68+sKhTNPfUZLEpXQoz2iHl3VssfJ7Z4q5xQuQIHVv2i+7sCCfjLXhwJbYCWZYj
 bMfnBgLpUmR83RQ1XOG4uYQMzgyWIqPwc6AStwGoX57m0FPstizWVgf3NkyhrezotcAp7JXM3bj
 REoBsw+Vbbr02IqB21+GkBTHJVs9sv16QSdURaBqtQyR0JKvlozukWaWOhI1Urssmd+NtYyvQ/x
 jUhO0sRGPzI+IxSLyU/Oj5eewx7QTUAf7zM8SMmp8/Jg+pEGZEwbvt+hUrpGbvXvWkhEU+6u4d5
 QRJpVPeCg92RiMg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in scsi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/sr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 268b3a40891e..7ab000942b97 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -95,7 +95,6 @@ static const struct dev_pm_ops sr_pm_ops = {
 static struct scsi_driver sr_template = {
 	.gendrv = {
 		.name   	= "sr",
-		.owner		= THIS_MODULE,
 		.probe		= sr_probe,
 		.remove		= sr_remove,
 		.pm		= &sr_pm_ops,

-- 
2.34.1


