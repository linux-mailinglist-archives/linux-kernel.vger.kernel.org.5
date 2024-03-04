Return-Path: <linux-kernel+bounces-90388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93286FE91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D67B2368A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926938DDC;
	Mon,  4 Mar 2024 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZF++zhKW"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2736AEB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547126; cv=none; b=KP4bnhy08gJFOFF/1UwaIRz91ItTEffwsVsiazp938EQ9D5b5L6daWDdWLxh/ll0d9dWLunSlDq0+2AJSYm9m4ME1mAsjPaYBByEEP0eoEKYaCewzZbh97rwAscjbG8aOtktcaXkF77CtoPn/mciUfzAXh8sn5mz6FQqAtEnYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547126; c=relaxed/simple;
	bh=IQiBIX1ptsqUCh17mmsk9JR1+iQzH5+7RhWBq7Lbzeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLuwvOThUcImCevVMEOrR4hvzN4zR6DCV8xWAzPnEKrjuJZKal6dAwxnIr/h9f32w/nhJJaS827vTXalI0/KqA1DeEwZrHVV/MzQKMTp5KHeKE+hIOTj8PzD1L9vTzQotmvv0Tpi1YItV6jbxRJUDkv1ZS3OP8xyUE7Gum0nrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZF++zhKW; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56657bcd555so5419435a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709547123; x=1710151923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkscxkyuLKmNGJ13PCRB5gPU2riBC6Uyvc9FkqhiTrI=;
        b=ZF++zhKWxiOJzapXn9HafgVxReE2bOHURe9BcEtLuTJMDVzCO+XDbAy/Mkk7r+ZUIE
         dKoXXDOmB5l9TXaH7NFc6UfZI1JUDs5J296h44Kdq0hOQNvKsI4BFZrHGdhgO03reRAM
         tmPwk+VMx7VlRTVqNhC6hT/SxkV/1jeb1y9PTe06vqj68XdMdfUPwQWwdLGgkbxKV+G9
         8FFLwdlwAB04XD0veNVAV4ImwinpIVZAsuvn5n/XMz4GQT0xtmBxlNOvsaVLal0g6diR
         z7gImo05oSVUvCOcfdOF5jN3EIbWuMovZlSJ5WAIzPGNUNxHbFpf+vg1ZVS/FuiS8Udo
         LOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547123; x=1710151923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkscxkyuLKmNGJ13PCRB5gPU2riBC6Uyvc9FkqhiTrI=;
        b=lw3ygBKhlTufG7HduiYFasEsP9diQk4qqil/x4l02a4o7ui5GcHNsDTJ1IM36kYDwA
         zewJBvbgDuft8YilS6c8RF//RDl2EU86ytRp6otrhYZ/OyfEJQjw2WdsZaPWfsEonC4X
         Graj3L+4xRq4WMIihkP8thhv0W4wrTQsaA5wZgh7vzMUvrwXtbT0LpeNneaH1L26vsQz
         jPrNpDMM24fI397SUhrn/yNNqPwPO1hHkxNcKKL/hKMkHHaoFk3tXTZmZPLwzo1dzvwv
         rDKjc+oz/t44ZBOryqSFTueZ+kArGnNPUi8fRKGbyOxHZHuD9NteZYVjY4d07HCHUyYm
         mnrw==
X-Forwarded-Encrypted: i=1; AJvYcCUpPLE8x2HpQ7NRIoepbqdIjJUcxxVCgxj8bxcqOOwu7JopH6U33Bz2x5dBdcS0CM7cyo/x3uohmWxqRrWlFy3NhdgOtY1kfAXwHQJA
X-Gm-Message-State: AOJu0YwftgQJJwEpaSN2LOTLDDV8pSpgBnPAeO81GfttQeiCqyCjyaEo
	mon+x/WZn8mWDuEPgA/0GIxUbJayvSwT0NRAvMhd+/DyovDzt4Svmy83YpArsUE=
X-Google-Smtp-Source: AGHT+IGrR48vptQZf+rBErBNW3zRh8A4eRQbm5RBoTdBYRzBDUp2kfXMSXqolT28sPSNVPFt+B9itg==
X-Received: by 2002:a17:906:1c90:b0:a44:86d4:70a1 with SMTP id g16-20020a1709061c9000b00a4486d470a1mr5679948ejh.59.1709547123118;
        Mon, 04 Mar 2024 02:12:03 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ef11-20020a17090697cb00b00a44bc99cd89sm2938481ejb.42.2024.03.04.02.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:12:02 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 04 Mar 2024 11:11:44 +0100
Subject: [PATCH 7/7] backlight: pandora_bl: Drop unneeded ENOMEM error
 message
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-backlight-probe-v1-7-e5f57d0df6e6@linaro.org>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
In-Reply-To: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=861;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=IQiBIX1ptsqUCh17mmsk9JR1+iQzH5+7RhWBq7Lbzeo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5Z5mnfBQ5T6LEu6wSHreyeIddxcFaUtThG5hR
 a7P7xtBFQOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZeWeZgAKCRDBN2bmhouD
 1+bBEACC1mknggxkpb8buuVG+0wI2sOUPaDlTNanVp8VneZ1l/BNkKBQ16feuUhfuQwjRbtWsUf
 ZuSeoXHhpFP4r86SdVkbEVDk2lHP0KnDRoyq62CN2cvKV/jH1gOV+dRRjQwaQ/+1O2GMx0mPbDu
 iaqhbqb5oqrns4Ycj+pUyBUD0pjID8r0TnOsriFXB2OKlIj30CaBhcaq8P6ChS8t7bP6qgDjSqs
 jUOVa9GFE0IiX7CJhIBtOO7Uk6GaQ12WeQxZuikLzwrGgiv9PCvohPt6a9xgmqEyDchFF/V+IwX
 SXAHRzQdkez8EzzNYFlwKbaRtTOzF9uPqZvzLJowH+HXPrBowr7kCJ0XlBosRMxlNkeGPjGC8zF
 klwHa4J6M4rQnL27yx8qzkeaTjuHw2OCKdyrBEFikRSKRNWw0tVjgKWdmMJ5uP7LXnLGxiK330C
 UbwI0ZPdFqScbrPDf83rLA0+DP+abdH2Wr9o0vbFTuEW8NxPwqys23rwj29dj7O3Hdw5okM306X
 kMaeqS5zhQ0Oq8XJrf6wUIGnGJkLS9anoWh5FJTS+xQWg0V4kfM1v3bc7klOT2G67xTXllFT3gG
 TAkA+gLn74eZZxkaYbAwdLovsbQnn1Ey7Zoui+W7wRwR8NgCwbgKmETXcsNMbdkRGvXyAstq/Sh
 X7Mj1VxLbKE+uxg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core code already prints detailed information about failure of memory
allocation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/pandora_bl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pandora_bl.c b/drivers/video/backlight/pandora_bl.c
index f946470ce9f6..51faa889e01f 100644
--- a/drivers/video/backlight/pandora_bl.c
+++ b/drivers/video/backlight/pandora_bl.c
@@ -114,10 +114,8 @@ static int pandora_backlight_probe(struct platform_device *pdev)
 	u8 r;
 
 	priv = devm_kmalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(&pdev->dev, "failed to allocate driver private data\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	memset(&props, 0, sizeof(props));
 	props.max_brightness = MAX_USER_VALUE;

-- 
2.34.1


