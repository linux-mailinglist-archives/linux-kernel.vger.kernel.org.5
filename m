Return-Path: <linux-kernel+bounces-22617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAED82A07E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F261C22846
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDF44D5BE;
	Wed, 10 Jan 2024 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kac6Ecfx"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4134D5B2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so50766715e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704912784; x=1705517584; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8Udsj305jfYXf+ANpLqSmYsA6MVtaE/P0L4mlkgDYI=;
        b=kac6EcfxexHE+TPOY8F6yMMroPMrx4DVbQlE3xgum2G07zKztN2trWbVeDrKdvatph
         3SxyVbGDcmn8lAZ1wFp1snw/E64/sCCxcQpr8s+q9VO4NZfC7Xssh1zFMjqaQEES2pXs
         P7v/xNqS/hqn+EjTM3oMZmhxUL+2lHd+19QdKql/ir3H94Vu2/nNbL/s0dg+Zg5i8YJP
         vqayqO4VhgCVd7LvTHObjXNYv5uuSiaIUFcTP0QpEixSKTNGO+ESqoZchGmf8yEWQT7l
         uDR1k+LEHE2dgp1eVxFgfFYk0ZxYqnBIMhzxEFHXijogsLPbfzvJXZxpgl+D5+Oqp+cu
         mXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912784; x=1705517584;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8Udsj305jfYXf+ANpLqSmYsA6MVtaE/P0L4mlkgDYI=;
        b=MYJPxOTfCao4hwWp7r81C+MluUPu+2phPRJJvEsX+AZDq2q070+mbmLs4xASY6mo27
         XJ68pJthSnkQdct/3gM2E4lJx0BTbqU0h1bQTGBA59QDQORpesCaClSXsI6WHskrBTji
         E9t3lDWsjtXUftZ4bfVQHYH7uA7ol/+UVA9dpQ3CE/GTiH5O2zHg+Ss0VSi4QcTOfuHC
         Xdca1x7IFq8nQO/vNGabqfmW4F3mM/UgmnvFfJlsVDfYLK/T0qHFcFsde6M7O04sZbSr
         01JLs9YZCw3ZZnJxOK9nOCg4GGWB5w+raGjoAVNU+y0q3exQpV6s2E8zovncvzR8wpfA
         pkeQ==
X-Gm-Message-State: AOJu0YyfETr8M9jTaOFjfGJgOb6APJg0cBpcgyA+PCI19aYFT530/Pas
	DAbLtlFDIQ4VWLEBMkzvnnxd/9OwMvrqsw==
X-Google-Smtp-Source: AGHT+IFMqicPz1t0QvAqV4wJDjMeK/H8oTRRuHT1ganju3XBJ11l6ngH9PTevRnk8K+l3J6EJRTxBg==
X-Received: by 2002:a7b:c8d8:0:b0:40e:555f:12d4 with SMTP id f24-20020a7bc8d8000000b0040e555f12d4mr806449wml.91.1704912784519;
        Wed, 10 Jan 2024 10:53:04 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c500d00b0040e5a0515aesm1183372wmr.14.2024.01.10.10.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:53:04 -0800 (PST)
Date: Wed, 10 Jan 2024 21:53:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hans de Goede <hdegoede@redhat.com>, Henry Shi <henryshi2018@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] platform/x86: silicom-platform: clean up a check
Message-ID: <0402e613-446a-40d1-b676-0422f6223aa8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

"value" is either non-zero, or zero.  There isn't a third option.
Delete the unnecessary code.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/platform/x86/silicom-platform.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/silicom-platform.c b/drivers/platform/x86/silicom-platform.c
index 6ce43ccb3112..5cac698bf98d 100644
--- a/drivers/platform/x86/silicom-platform.c
+++ b/drivers/platform/x86/silicom-platform.c
@@ -258,10 +258,8 @@ static void silicom_gpio_set(struct gpio_chip *gc,
 
 	if (value)
 		silicom_mec_port_set(channel, 0);
-	else if (value == 0)
-		silicom_mec_port_set(channel, 1);
 	else
-		pr_err("Wrong argument value: %d\n", value);
+		silicom_mec_port_set(channel, 1);
 }
 
 static int silicom_gpio_direction_output(struct gpio_chip *gc,
-- 
2.43.0


