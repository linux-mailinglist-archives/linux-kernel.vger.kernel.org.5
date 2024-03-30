Return-Path: <linux-kernel+bounces-125832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A174E892CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188371F229F2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303DA4AEEB;
	Sat, 30 Mar 2024 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEP0c2Uh"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2142AB3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711828200; cv=none; b=ENjS7wQYriEnRzRDU27R85OFpx9cTjxYyqHjNnjl463qIwxGUqCYlDBnXOXKk13vj6Ag4SSoj//9aMq8bZGl6tE2x5wTe4XO8QtOfV5C9l7+Dv7VMiY5GY6aCvjG9f2MCAcwdRjhcBDjxo0YvcCoL9lPge+OOuwWerfRGkDRIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711828200; c=relaxed/simple;
	bh=v3LCWHdD6COiKx5GT1EpzgxmaPTkJTQwaRwt2hz8Q4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKI/oR0MdlioRFeZ7buscZ1wyrotu8uMKDfqKp8MW2z2ZAyCBK9WS6Zm74aXd5OacfbmxPegOL0G+OyQ2q6unvBmULZrO0NxmzGlemEVFf2RuhSxE/SNNmIbsDl/PEZS8BxsxceuOh0yh9U6a4KQ8pTWEKe5cCDGGza2x7N4SLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FEP0c2Uh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4155f5b8cf5so595115e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711828196; x=1712432996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsNJgKamHqNuLGNVWu9ddLUl1Ncqtm7rSn5kGPjfhAg=;
        b=FEP0c2Uhvu4s4u0hzLI55PXM6WPY19FmwM9UyZ6HApPxRtkTN84PVW9bkNfo8iFGPA
         Y74VXTCpcf5/96GcXqjquOQIRQBH3CdAVxhPFu3Ebh+nzzomVYSWbZTzrOKYx063FxAt
         Oqqs1xL6fCvOK/4SHJX//Vm50ljEybSXD9Le7WSFhruGXDng8q6SrlJzPpfru4W00UHk
         tRTYaJtsbYsiIrwLgGWI/D/+44BryQQx+GFvfq8YukuwEtZCzlAuCbpGMpw01k5iVSnI
         XG3wkDMr89go0NaZTCwaM6sKviIeMYEG1Px/ZqYcSFVi5+yVDwEf24n6KfZZXBdDWQwn
         Qd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711828196; x=1712432996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsNJgKamHqNuLGNVWu9ddLUl1Ncqtm7rSn5kGPjfhAg=;
        b=I91IY0goY4RCnSn4hTz067yC68Jh/NSJK0bKYbk+s/ZwJzJn7qNWLC5Zehhup3WAzw
         dCTLFVM0aCnjuuUAlGJ0FVJReMjxHElY6lgOb92ePu331HGbhjxCFkPJd90DTZ8bIUwx
         9/gQPsqtJqczdOQt0n3zuqaIpN9rPGKFftM3VZpSJGmnO7f16QLAtJ6KZO68nGCEXzPJ
         WgbkaJucje6ZMMOtuIGcMr3jzuUJH/uwXQXv2cblkjAsJVXifqd7Zyc5/U7xMvowb79r
         TLBvg+rHWSkeynto2Qufe25IKf5VrAfj3HyUK7aPxPQHj+0qWCCDSXjt4M36PLvxHgmm
         IGCA==
X-Forwarded-Encrypted: i=1; AJvYcCX20Dv9RDFZF9RkBxFzGVo3zcSjOV4NfYL6m9X2+a/A+30KLn8vhtSfKctv+UjBdxC+qKIeobZ+HbkOKcKUQhtPe3pfVge49GwDj5vN
X-Gm-Message-State: AOJu0YwESY0yjbH07QPzXCAlbrS0RByT2p8ZcxTf50hZZOxCKHHVsf+i
	P5b6ZL0pbqi8Ugi0kZSuwbs9WhdSjHx+KMVJPQbKNTquRPr3LPDEDItTfE6tnNR6D1g2xJnROYi
	C
X-Google-Smtp-Source: AGHT+IH0guaC7prUM+RXr7HbqGAqDBBwq69TcKrnmar0p1wAyp/wJrBQZNUBYBffmmIT+Wrf7xWoRg==
X-Received: by 2002:a7b:c408:0:b0:414:66d:db7f with SMTP id k8-20020a7bc408000000b00414066ddb7fmr4569506wmi.10.1711828196656;
        Sat, 30 Mar 2024 12:49:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b004148b9272a7sm9571616wmo.0.2024.03.30.12.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 12:49:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 20:49:48 +0100
Subject: [PATCH 2/2] firmware: google: cbmem: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-module-owner-coreboot-v1-2-ddba098b6dcf@linaro.org>
References: <20240330-module-owner-coreboot-v1-0-ddba098b6dcf@linaro.org>
In-Reply-To: <20240330-module-owner-coreboot-v1-0-ddba098b6dcf@linaro.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=680;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=v3LCWHdD6COiKx5GT1EpzgxmaPTkJTQwaRwt2hz8Q4w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCGzfNRl5IuxePlMuY5U33wD5kTny95qVok2oN
 0L21+F7fUeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZghs3wAKCRDBN2bmhouD
 11WuD/0S022EzzJMKz4FhiEqd1VIJULYBr0mqEFtt0/IGU/WlxdkuvFrYU3zO81ZpV2lAkqDAW6
 /lrpmMotoGu6Vng8BQJp4j6YjTjg86LRu6Ikh0WVfj1ERINztCMxCeudLqVdA5Msj9/r4iZTsuS
 IoPyZ42ryJ8aaCsQ006ZTxrqqsV0wY5LHUihrgdNvAP95UMq5Lg368n8WkMSpg8OuK2N9xrdsPK
 P86oqq7CBULlpmHJ5cOTjiRHVAA5oTgV/uCygrsMQDLuwmec4lLMPvEHw7ylFsZqmesz2ZXqItm
 hiA5UpM7orfPLZUhxva0nHHThwdW5kwajm7jh1qDG1eJoXJaDsJQWdOGrNKcRSs12VayXjEo3/o
 /FQPyeA48qigx8SiLgQo7KvUj2y1NvfCrDmtyCznNIFiMuNSr6OjMjwmal6hWD+qHA+e44SYmAT
 yonEaUTu8AtJSdcPrS2fJLhTFKneWqGIoNS7ALi+aM2rutak+D8/VMui5MB3QGf3B5egps9HytD
 YDYvSJfasGXmc4JYAbBncBf6R7y/xDyS1+pc23r6+ulMq8E2O9UgkTjElb4mhomxEc7hPTp+kF7
 P/1DSYezjq6QOTTDqHLyrhL/mDx05rppzxvAPVcjFO5ejq/sO05VWkZuRtycr8pqDgdGwY8+MRg
 +LLhsYJGTBAe3lw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in coreboot_driver_register() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/google/cbmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/google/cbmem.c
index c2bffdc352a3..6f810d720f4d 100644
--- a/drivers/firmware/google/cbmem.c
+++ b/drivers/firmware/google/cbmem.c
@@ -124,7 +124,6 @@ static struct coreboot_driver cbmem_entry_driver = {
 	.probe = cbmem_entry_probe,
 	.drv = {
 		.name = "cbmem",
-		.owner = THIS_MODULE,
 		.dev_groups = dev_groups,
 	},
 	.id_table = cbmem_ids,

-- 
2.34.1


