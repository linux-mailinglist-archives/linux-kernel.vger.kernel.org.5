Return-Path: <linux-kernel+bounces-94003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4CE873828
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D36284D0C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D99A132478;
	Wed,  6 Mar 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SF3fHshL"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE0131749
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733156; cv=none; b=qN/RHcw9aJ0caUOu9rGLXGt4Nndq+1Ppxdevsr2KrL2CShr9CNrshFoTx+9AYyeLiHdCPK21neBXXmBN2SueEB2TRDbDky581gHI+sqoY7ThgCoYlU5I5G/ijTBipEO4Cvbbyq3puoVrVdAyrCaUUBjbrD8NW4JTgQ1zLzJq/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733156; c=relaxed/simple;
	bh=NE9uz7ZBHC0eNJ7adCmd/UKg5wS6nfgIQyX+/EqGsD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iwi/v9jL3kGTbw53NYSewWRHayUAMddXxirk6jHjorzMzJcLkTpPd7FaUHujBaXY/rP+4cXGouHC52aF+5T70LR470rmYfrC9vYHE+M4s+WZHxm6sEVu6pcFJCobr0zSGDY/3u5iaJZC4IbzWLRZTtFBMLtf0x6dmSEtBqZ4/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SF3fHshL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412ea23a750so5655245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 05:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709733153; x=1710337953; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0YUTY+l2RgN437PUSLue8tToMPkzTitFlDucsO/DZvk=;
        b=SF3fHshLBWpMwhVf6yPGPRVxa6UiZEFQryRg7bJTgLXzGbSKgVWRbfJ1fnsoj+vhqX
         oTDWKHFBt+ft+9Gpu1F1yP7yP84yhTl92N4jSsCZSPqdZDkWHV3Smjh/cnQDmJiDBzYz
         xJ3Qu7rHOTVYxcexam8O2qawja+LdLyEgeEIzsY2Jvs1C9IGpbEtbRMVCwWa9seXh1zG
         7cYI43iebWetqZGwQCSXf7EZOBPtEI/koral7bFSARid2aCN9PAoIDhvuyaq31lJpos2
         fJXgHmji7VevsldnLryk3/DlL51+V/lDaFzD3SmwbzbPyIEgVeG4NQpXeCue0LTb+IPa
         x0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709733153; x=1710337953;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YUTY+l2RgN437PUSLue8tToMPkzTitFlDucsO/DZvk=;
        b=Y1Sg48Zfqb1LA5+RqjdBeBVTITQ1SOB+Vu9MkIxAimEfsxxIHb4UTti8K6AMw/d3/h
         YaF6ojoHrpQG+BOGoU9f8CaQi27f9iL57WhIgE5aDfy/QByGRYN9ARhrilRMc3idt7O0
         hi+B5J0g8pOVxYBUiQcxD0UVsdoYiY3pKjqE0bwMxShqd+SAucZs47VY7rRwdgnMlm1e
         vTpU+VqMuD4/NynQ306lZh787l7HdeOuR49kJhx9/qxVsFHjyoprCPZcZUC4UdKIlBMn
         j2sewdOVm5cVhQ7okkLfk3CVwhzBMFxj8oalYoYIIuARreWMNbLN0QR3oXr/Nq145T62
         jZ4A==
X-Forwarded-Encrypted: i=1; AJvYcCVRmiITs8k3I/oTK7BcYXsKivZEVwvOY0Tb09D0kVLWQxHmtke5LeS6qM3FQojhog9E9Mxxvbq31aynFQmUPhwi6xucxBSxWVh4cCpl
X-Gm-Message-State: AOJu0YyjE6ZgrHhgmHcMrc5QGyqWYhDzmBXfeWbiE4RURfMqPzRDiFOK
	Ta3t+tkSpM4ufjKrYfB16XsksnxydR5DbmlALIiGnD20lHxmjpELay+cHPTZvFzU5m0jlP5aUFa
	q
X-Google-Smtp-Source: AGHT+IEVdyAZQURDM9SrFLVnut8Vs6bokwqor8I0IOn+wmMlR2loefoe4428fbp744qhAQ3KAOLUmg==
X-Received: by 2002:a05:600c:1391:b0:412:e0f7:ef52 with SMTP id u17-20020a05600c139100b00412e0f7ef52mr5183535wmf.19.1709733153251;
        Wed, 06 Mar 2024 05:52:33 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b0033d9ee09b7asm17653491wrt.107.2024.03.06.05.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:52:33 -0800 (PST)
Date: Wed, 6 Mar 2024 16:52:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] regulator: lp8788-buck: fix copy and paste bug in
 lp8788_dvs_gpio_request()
Message-ID: <19f62cc2-bdcf-46f7-a5c5-971ef05e1ea7@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

"gpio2" as intended here, not "gpio1".

Fixes: 95daa868f22b ("regulator: lp8788-buck: Fully convert to GPIO descriptors")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/regulator/lp8788-buck.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/lp8788-buck.c b/drivers/regulator/lp8788-buck.c
index 712eaa6ff8ab..2ade249ab6df 100644
--- a/drivers/regulator/lp8788-buck.c
+++ b/drivers/regulator/lp8788-buck.c
@@ -430,9 +430,9 @@ static int lp8788_dvs_gpio_request(struct platform_device *pdev,
 		gpiod_set_consumer_name(buck->gpio1, "LP8788_B2_DVS1");
 
 		buck->gpio2 = devm_gpiod_get_index(dev, "dvs", 1, GPIOD_OUT_LOW);
-		if (IS_ERR(buck->gpio1))
-			return PTR_ERR(buck->gpio1);
-		gpiod_set_consumer_name(buck->gpio1, "LP8788_B2_DVS2");
+		if (IS_ERR(buck->gpio2))
+			return PTR_ERR(buck->gpio2);
+		gpiod_set_consumer_name(buck->gpio2, "LP8788_B2_DVS2");
 
 		buck->dvs = pdata->buck2_dvs;
 		break;
-- 
2.43.0


