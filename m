Return-Path: <linux-kernel+bounces-123619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7462890BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14551C31039
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A8813B2AB;
	Thu, 28 Mar 2024 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiEGMuqs"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C26E13AA5F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658762; cv=none; b=myfes7BnEe7VWBoxFLOvCR5ovPndIw2zp89uezNWdmfsLGvf8s5y2/t2NgBF6FO134rqMMsA6A5w1ZYz+b3D6zsVPmVFdGdRzXaLVimAuiRVN+dWCmShZ3OnBhVgqGzXJShpxC760NTAJqVDg6Qkon7xAcc4/8CZYBsAVc3lDsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658762; c=relaxed/simple;
	bh=FyCdxpH9XjiLZuhZusE9nTyiM24GT6Niq9ahMAepkQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J/4QdMHZA9nw8NqOBZdinj6UH7PxkD1uWSjJV3IB6R87qh4N88JfjrM7qYOVTAevkxvlhSf2t1DDUI/+dlHxelxygh+S6w6x9sPiBQH3wH8udJ4ZirHqvesgTp9/8zDFUVdZdIXNFrRmUTrZ0Faveckxq2GS91x08mr7GcGfZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OiEGMuqs; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51588f70d2dso1573266e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711658758; x=1712263558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Vek/NiKwAK+DDj3owjWRVLp6pIhVHeMYaXJdc5o4EU=;
        b=OiEGMuqsyNKowMpjVV5sVMRWi6jSZFw7MPwWTwiNyqZYn+C3Mxp5Ahd8EjMKd6KZPz
         1yGB8V/nVzjZgnr3AiKf8yLhExp0CgMrGtwZTPaC7pOY6fRtRJNuN8klH3eUCljA300j
         5lTYOsjaKQs//5BRQHmbW4nqf6lfcz2Tp0XdP/QTub2QZhiWSOddyJGGqHGYKfWaC2fr
         s5Ec4cgW3Av9xVcq7UPQOuxpqR+4+GyhzOmXg0DshlVorigk7NvondxzCDum1K/S3nud
         zInVQM5tzQIQJPSbxk/cO3DyWqpAtUEqN51CpESrYDtKr5sVk6tSAS5GgizTEAamOUd2
         qWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658758; x=1712263558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Vek/NiKwAK+DDj3owjWRVLp6pIhVHeMYaXJdc5o4EU=;
        b=h23FEKicQf72OZ7WZVCEfVCV7DLW1oqiyW+PmJ18DSweXRsIL/bZnGX4bks/pYBrXw
         rg15mHT5yweQ6feZabHdJLjWmzQzjr7sZqMgZKW9JjdVXYikofI05ROGQ+fcjdvbYk9O
         iaNeXwE6L0lzfRy2/1QnvhckG9tDqJ02TR0dLPBY9IbvDwLDFdvRuXMcbKrwlRXfVy68
         NJuAD+E/OETtXUQiePUWUDrNa06+5P1049h0ezk8VYaGHl4suuqF0kjVX5kU0TIXrrmA
         ybFzFFYOHlg0F0gO5BGsfrzczOuCb04lS+whm3CCp0DbP/zq+5EMVVY7TU5K3i6w+Ao9
         kzBA==
X-Forwarded-Encrypted: i=1; AJvYcCXHPJlwkyUhCsv2zfh+puL5u+3cUoYFmE53i0395ahRds8+cnLuifW/vVetnjAwA4cUj4UX/nxlgFRo8hcvw5ulgrR1v0poJbZ6biQ2
X-Gm-Message-State: AOJu0Yx34DYTB9GqVmgk5Hqfh8pNmyn6A+6ZqT0KPEJCiqz0EeTbXmVa
	9AYo9k4BhdWID/XtaKw0f9Culf06vZSX1kp6y+oN3hZC00E7vjbjUtIFd04mFanz6oC/5a74K7q
	v
X-Google-Smtp-Source: AGHT+IEyjo4w4ah6WxoLmcgMbUjY6TtZEug1AgN4ONCl8yW8X3L1Wk1pKNJLDIO1BWpZ4Pl/N/JjIQ==
X-Received: by 2002:a05:651c:221f:b0:2d3:f3bc:bb65 with SMTP id y31-20020a05651c221f00b002d3f3bcbb65mr219874ljq.11.1711658758369;
        Thu, 28 Mar 2024 13:45:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041497459204sm4762697wmq.12.2024.03.28.13.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:45:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 21:45:47 +0100
Subject: [PATCH 3/6] scsi: ses: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-scsi-v1-3-c86cb4f6e91c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=619;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=FyCdxpH9XjiLZuhZusE9nTyiM24GT6Niq9ahMAepkQg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBdb93iiqLckWCSKqHjac/3/Uf4LKLHI5MKt6m
 aVo06zoJ3CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXW/QAKCRDBN2bmhouD
 1yzmD/9R3FUYr5ESxPbI2jXJHHC02UB5y6MLe+jEYvFu1qpCAlFKAIXT/rlCaCWkSYYXgObWrOW
 dpd7ozKitOl1MLFAwoeN5IRCL6jaJkKwQ0ZTHNL0j1dLqQBeKcqObzjHoK0/ouklOuto0EPIfI9
 kOlMWLbe2s1Vj7d6R+7QJeljl/+4gcEqeFLUCESuAb3z/5QXgwWwRanFIQnyCEfGPttJRtWOuBU
 AplvKtc5TsaHrCrqrAUqV5JdneIfFzGnekNC5bUOMJA7zbrcYxEywleCm+dyMYY4XHK94BUGYSK
 l1zLMvwnbxCIJPyRhL/M68a8WWDE58xUE3qC2YlSU3KtmdCZ/Um5vm7PkSJizC4qauyCGkv3cGe
 q4YknuS6PFOb0z+kWCnbYlLDSrSMRMCjMxuMJEhgGkVSgPHJQDLbt1TsitBsdfMwZIH8tbQy4jh
 wMQYCJFcmmrBREi64cftGr1T1Msa8OE23W4kDqz0TmYX49eJ7AllL1tbVyQIku18+WC2Tj4+OPM
 lCTwjdaguhAqpwL9AMiJWJI6omYyIkrd1j6yLAXXSTScoIQKIuC6tVdQk1NljW2WsvtfUe7oueg
 Q2R6OSRjJbBZv4e5sIJ/uRqUJ1yD/m9r2kA9LnFgaD+qz+IgXf2nVwOerZMvxC9PRF6Da27s6eC
 V9NRkPUV/R85PiA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in scsi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/ses.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 0f2c87cc95e6..e22c7f5e652b 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -908,7 +908,6 @@ static struct class_interface ses_interface = {
 static struct scsi_driver ses_template = {
 	.gendrv = {
 		.name		= "ses",
-		.owner		= THIS_MODULE,
 		.probe		= ses_probe,
 		.remove		= ses_remove,
 	},

-- 
2.34.1


