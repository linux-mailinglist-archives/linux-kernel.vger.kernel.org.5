Return-Path: <linux-kernel+bounces-91876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55C58717C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3588BB21B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664C580C1B;
	Tue,  5 Mar 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pILB9NXn"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0215180639
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626346; cv=none; b=ClWG4dNhtznIm9HBtFBUM8MmVD72VYkf+5hmd4qJw5RntFaXr6NWhF+AuwtRG/UShu/j2iczGM6y8CsdvgzPB5MWcrerQhUsoxLIQ15Sxg2gePNa1bcjFdbpIjpI9g/G3xKeE1zp3Kj7YKAX1bTwGzxJ6S+wygefx9kF9KGfdlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626346; c=relaxed/simple;
	bh=YHeoQ29NKf22XZpaybrdYUUdK12wkL0lEB4GhWf8FTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XDa4a+i8euz0IzWqTNd7KxJ1FlN9mtKkTQ3BNIOlFJ8hZD7o5XaV6IxfXq+zwY1wEDy+MYHg7W20Pum+87+pFJ3DoqUfG7PBZVdM5DCHjFXSyP7rTF1JRVgNPjlkRZ3crwwmEKD6paRyQBub09KOxOAn/7Woer8UOLKAwIH42aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pILB9NXn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a44628725e3so672560566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709626342; x=1710231142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Fm6lCHtlVIF1F+K0N/OPMuiMCrX8DVXWnanpZaecTQ=;
        b=pILB9NXnIhHFh4XQLaoHRn0HXZN7TLGIwRq2XAjNoL6bb3QGlYLFEnZg+8KqnqCmY1
         Ok+R1MBNIZgnzjKwAWcdEWymPbiiUtlghQ5rKzXEpT2reZZtzK7xVT+wi89Vc5NxNtwT
         /YaM51xik8wIqw6c6wzviYPHszIx3fYtD5M+TLSwcNlUi0NPP9RUXmClqV3Q7hY7ZIqW
         xyWCA73FrX7yJgvuJINRIDuNAuhsu2Bwue58srH0CXCo8UnCVWQsWgx/EgeMl3J/QLMQ
         eaHgaOrvijdqUSMlq5jfalJsLBPwIcFWj4UpXDw6LqnUOkYCEAKRt/dmbb8YYpra8KB0
         Xc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626342; x=1710231142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Fm6lCHtlVIF1F+K0N/OPMuiMCrX8DVXWnanpZaecTQ=;
        b=pKvapuOVJRcvVMSthOZpfwpqwF2uRIw/9S/kMPOb4v/ECOtKk0yVINpAbGojNfrWbt
         NeFq5V0cmOC/71LiVV2JFizAykuonWiww2YnnEX7fJMLdZinmmkb+VQ2rj3bVLkKsq7x
         3lZFbAaghpffX+ig2V2f+7B3jo7ysK0qv9ZHatK9z56rTq3fqSbRwXsydEFYlIuRVx1E
         xLPcwCmLtKT8H6J9260lYQLAD9QkSSHQio3oqfVLBuvAs8D7MBaUPwkIgzHm0D3hNtJI
         VFEkVW42u+d1FhmV1QJ2oitwgyQPtn9FXa0u6cN+Fwi4YdoONRu7W941T+DWG9+UP4BN
         7iCA==
X-Forwarded-Encrypted: i=1; AJvYcCWczCIggsgyany1M2fZwdCoReEUpkcyJ7mlB3hA8Vhp6PDtw6XV1doEkRXpSMD0Qskj6BUmQc+3z1MVa9jjD/Nnm/YW0e5qnFztjlSf
X-Gm-Message-State: AOJu0YxKQo59gpEaWITlqXfzXqxofOWlnLyDqF9reDHT7n1rtxUdrzvH
	hhf0hhIVz6jNMoc17v5DuTmgnwn93fvLzg63uzIt4Exj6wtksW3PyI9ghLg/O04=
X-Google-Smtp-Source: AGHT+IFmQXq9OqnAqZ7n+ipcdaFFZ7KEXlOXnYPr+dCB5rotQlp6U8HU8sJNK8HhuEbg+62y8KfoNQ==
X-Received: by 2002:a17:907:367:b0:a43:f020:57ed with SMTP id rs7-20020a170907036700b00a43f02057edmr7581833ejb.73.1709626342374;
        Tue, 05 Mar 2024 00:12:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b005672a346a8fsm2761557edb.57.2024.03.05.00.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:12:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 05 Mar 2024 09:12:01 +0100
Subject: [PATCH v2 6/7] backlight: lm3630a_bl: Simplify probe return on
 gpio request error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-backlight-probe-v2-6-609b0cf24bde@linaro.org>
References: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
In-Reply-To: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=961;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YHeoQ29NKf22XZpaybrdYUUdK12wkL0lEB4GhWf8FTY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5tPaMO81r5PpyfYzgPlAboOMwxF1eOJg99FdH
 BQsx0i+aJqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZebT2gAKCRDBN2bmhouD
 17VTD/wMe9QVJLWWgoGJhpJgK0qfzqPtG2LHvEiQKHIc9p4TZH6iIk89FjqgbQmllt/sCIdLPzD
 5jCNPAb6QsYi5rBbHw9tXOW/fw/bA1XSeBdKReHR4xtnTd+Lp7ZEMe7thHzzhEXCEW+6AuW5Zh7
 vdcnvZPWJcVUV9QokX7gskQsHOTHg8M9L11ICQnn2kgJqtBvffsN4z7tRx0gFY2BFkV390IFTZa
 hHlBhzDWyYxYAp4I5M7OUld5ga37cX1lmBM8aWaC1lj+UoSNe1XCQPvo2mp/0U+hEZGCkCW9T5c
 d478MV6wl1sAsoVRUq1VmXpOYK8+oi8beiW5SF7YWtT5knT7Z99N/kfc/MPdrN8WqThf+6TE6oN
 Cehjm5fjzjvLxM6INXJn34dwTXkGgagvWLL9SQwrOtTMAx3h/PBIGINvCaOzapuZeDwCS4vfvp5
 CLS7LbPOYq/0XbEwySMM86UcHe7Is6dZHYqDXfMnEuxh5EPQUnDFiYrs01SINbxX5i/N8rT3ovc
 xaTofPHKif7mPAFTVBudQKQb0oQQwo14veJnxVLsXfapCKdnDEjrX4uqhtstonC6F3vNX9w97vX
 5gsi4DlkZSWtsii/UFMd1cohSPSSv9zx8VS2TAbTXmafKMfVKjf5caGdDisNEoGNN96UoujMDcp
 krxxRUqlxMNOQRA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Code can be simpler: return directly when devm_gpiod_get_optional()
failed.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/lm3630a_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 93fd6dbccc28..ac0a60e39e39 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -543,10 +543,8 @@ static int lm3630a_probe(struct i2c_client *client)
 
 	pchip->enable_gpio = devm_gpiod_get_optional(&client->dev, "enable",
 						GPIOD_OUT_HIGH);
-	if (IS_ERR(pchip->enable_gpio)) {
-		rval = PTR_ERR(pchip->enable_gpio);
-		return rval;
-	}
+	if (IS_ERR(pchip->enable_gpio))
+		return PTR_ERR(pchip->enable_gpio);
 
 	/* chip initialize */
 	rval = lm3630a_chip_init(pchip);

-- 
2.34.1


