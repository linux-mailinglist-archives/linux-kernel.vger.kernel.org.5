Return-Path: <linux-kernel+bounces-89932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D721086F771
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CCFCB20B9B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD967AE67;
	Sun,  3 Mar 2024 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgKxOuyK"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5793479940;
	Sun,  3 Mar 2024 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709505304; cv=none; b=FBJRVNkG5ybQ3wlB1i9u/+m2/0Ex0AYcKGOqzFMaINKkLFYLum8db//ytQNgVo+GgnC7cZUc+nX1sj4A4INiNwvasMob8z7gpW4wsCskfAJ2ctnm+XEYWo3jB74S6VD0Fd4Qn3LtoHK6AaAjfPXnpLo0lfhDff2dYwEYJMucqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709505304; c=relaxed/simple;
	bh=KzRNp6psHX0hD9N5rUDVkaEjilPRdru5QHUov78Y6Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dApnVmaXiV1+rmx/CD11r/iWAbRfz7kN4/Y5E4EtNRLCt+c1u7weiO6jVpqh5TYqhD8wF8lwLcsmWVObKeU0o5YJK96TyLVFO0nPa8lyGsAtNWOR3Yv/D9snG48J1jHsHUyzgQqnGKsg4w9xqSuugJFw3KKiLy/lyWxMm3VW5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgKxOuyK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so819481966b.0;
        Sun, 03 Mar 2024 14:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709505301; x=1710110101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTzTPSFJJSI67HQWXkNrt6MJvZTP1w/baNKfj/xa8GI=;
        b=RgKxOuyKlTDT6cyoq0trRXWevfEsysTEuI6WU/ERYRXIsrhGkQi7WG8bPWPqJ3R+JW
         zaN+U45C/leY2heyEXO1yIQXDcCvsv/wejnVeN9qlYpUclTZEEWV/fdo7pc+cXjkBKai
         bEeJzf+aUR2wbzXXft0ZHugweIeGNnhQqk6oTyIrfcFd9PkioM+1rxz4NVxyV9agRoFL
         en+EZCUCy/8iDxxlS4pmIuPBbFuqYlDn7HS3+Qr1x71gUoCRrjnwvBdIIZt/aft9wdGf
         0Fs8+APv9rYSzqTY/d3ie1W52CHESdgf0trRHWd791yEaRgcMNkaDdTcxcoLWU6GjoN8
         hjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709505301; x=1710110101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTzTPSFJJSI67HQWXkNrt6MJvZTP1w/baNKfj/xa8GI=;
        b=FVo5nVdxbyow+2GbGIpw+ar4sIScJwZKU12fqSPtcZtv76Yq/PJi7UCazTIzHInE+/
         r109bJ5bbkVSgHbshyrmcn8Ral+ShEvgBB6LmvtjTi7RMcfLnibA8RkqSrUzJQidmsKx
         cJwebWr28va63sLNST/ypYND80hdv9QepuzCLeTM/ZlAWD42Rc582x4RBFOw/fDYGLFi
         MNXEHE5HXm2sUaPvFaAcw2givrGXuh02SIWmT5EdqYF/DjxUjLHtW1763wFrTTY/KuS2
         cfBwCr8UWwWPRPDw3BnToR33Yli3OfnrIAIv0mshmAnJ3Rx/JXmQM3MDpnYB6mugQfCL
         0j4w==
X-Forwarded-Encrypted: i=1; AJvYcCX9THh5mT7vFf/mIN0c1aHcacgVdISnYkVT0XgY2S1FeJ7eUIorlGCW9+19/1EnFlQM1IdgH/yQhfuS2z0VgJgBh2KqvxZ7cfRhjFwJpd6i7OjtdaBMbUnaoUQz9N0ajpa6WYuimas1
X-Gm-Message-State: AOJu0Yznlp4H8/fZ9DU3FD8VAcHz1xs889ZdP8c30calBK8LJV/GOv91
	G0ORVqlPPKR1jfeD8yrxAxI94n1jMKBRlzo5DxkTqkkF5iecrzGgTUtZZS7YCTjgRQ==
X-Google-Smtp-Source: AGHT+IGGAC31qGiya81QMwWaaqd7Suu+f3HVRiroMo/1cd39MIzF8wf4b4bttupQdAjvGyaP0hVAtA==
X-Received: by 2002:a17:906:7f95:b0:a3f:52dc:786b with SMTP id f21-20020a1709067f9500b00a3f52dc786bmr6504542ejr.23.1709505301306;
        Sun, 03 Mar 2024 14:35:01 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b3d8-5b4b-5188-4373.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3d8:5b4b:5188:4373])
        by smtp.gmail.com with ESMTPSA id v23-20020a170906565700b00a455ff77e7bsm82204ejr.88.2024.03.03.14.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 14:35:00 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 03 Mar 2024 23:34:39 +0100
Subject: [PATCH 1/4] char: xilinx_hwicap: drop casting to void in
 dev_set_drvdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-void_in_dev_set_drvdata-v1-1-ae39027d740b@gmail.com>
References: <20240303-void_in_dev_set_drvdata-v1-0-ae39027d740b@gmail.com>
In-Reply-To: <20240303-void_in_dev_set_drvdata-v1-0-ae39027d740b@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michal Simek <michal.simek@amd.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709505298; l=933;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=KzRNp6psHX0hD9N5rUDVkaEjilPRdru5QHUov78Y6Fk=;
 b=Bzh1VYpjExyTG7K74n2pcCvXv9d5Kc6pvz1eaZ+rOQpXrmWI1NSQzty72iMbka7PRrQ7erILQ
 riLgAilmW8CDt62Fwj13gjVXGVIAFQcEwK80bILO4G7qYOAJHnC5rVD
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The C standard specifies that there is no need to cast from a pointer to
void [1]. Therefore, it can be safely dropped.

[1] C Standard Committee: https://c0x.shape-of-code.com/6.3.2.3.html

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 019cf6079cec..3aaa4b4d9f08 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -636,7 +636,7 @@ static int hwicap_setup(struct platform_device *pdev, int id,
 		retval = -ENOMEM;
 		goto failed;
 	}
-	dev_set_drvdata(dev, (void *)drvdata);
+	dev_set_drvdata(dev, drvdata);
 
 	drvdata->base_address = devm_platform_ioremap_resource(pdev, 0);
 	if (!drvdata->base_address) {

-- 
2.40.1


