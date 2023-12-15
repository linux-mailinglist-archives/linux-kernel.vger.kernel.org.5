Return-Path: <linux-kernel+bounces-611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B1E814385
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E29C2841F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3111512E51;
	Fri, 15 Dec 2023 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaXUyP1V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9DB125CF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c580ba223so4965635e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702628684; x=1703233484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sll+9qWsACg9WSZZSvDuRd5P7YLwP0CwcrFN2KVP0h4=;
        b=IaXUyP1VA5H5nrsQ0pqyW5AZHt3CtTGXED6BWicfF79d10box3Z4bGwYRqxpbHq8Tf
         rkj1Q5p3xI+r18z3ARIj10kn+8xJa53SPHAQks9OoaFYw0d9Vs/XCndLxhTuLSNOpSBD
         zvkQBhsGqwYsbh8RRVVZohE/j9gQn4OSbyMh+tdpwBqoqCo1U8Xt1+awxmcIrOCk5Q8q
         jwVIooPiKPqKwH/HUUpXPJo18rsgJ5+TrFm3Qe2B37WB0oECwwuzVbq3l5/Gt9+mFDSr
         W+VZVi5EB+w5Br66uKHWUZEmlKrbcEeZINz/+ISFsxSrGoWkVWck8jeoXhJ35oXSoZFE
         PF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628684; x=1703233484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sll+9qWsACg9WSZZSvDuRd5P7YLwP0CwcrFN2KVP0h4=;
        b=thuy52iDkZ1cp8vBxuPRmJIINQIjQsDvK4x2K+unIv/FLBSVb2Vwb1UBu0iEywAwJj
         zQPhy8tPpDaJ7jFIvjB5AhzZ3r+BWxqNVzhzJvv73Zm03rKbzlWH3QyvHL8wGmx5NMqh
         Oj/hBRLXxyTmiBQHsAqSon+fP8gi7nspVHEicqqpapUrolRRSkiCCTTPKbl1ryDTE/CY
         HkYCYqSgGpML9hj9UxrR5PbgQgN1/oKtN/C1Kvgh6AuFJ9YR9NKUcr2R9QlWYdVK5zjg
         krSRlBGQ0lEMeLUyJj+rIhMK2eO1D6Xd0EtpM9cKWWxgjuDD5n7/tzo1BwpyilpszeV4
         wUQg==
X-Gm-Message-State: AOJu0YyQ1Y8r9TxfX7l2YTj5PXHs+USp+S1affiznKuP8sBDD+gWAtXz
	gSxBp2G6+VDdisFORJV6hA9i7Q==
X-Google-Smtp-Source: AGHT+IFC8/hzB5AHQqnVCaSLspwYNhdYIQ/9XR47KJueX6t6Iyz+C59Le/39vFUnmejukr2l5BqFTQ==
X-Received: by 2002:a05:600c:1e0a:b0:40c:6c79:2a43 with SMTP id ay10-20020a05600c1e0a00b0040c6c792a43mr159046wmb.108.1702628684547;
        Fri, 15 Dec 2023 00:24:44 -0800 (PST)
Received: from [192.168.2.173] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0040c490db950sm17872657wmq.47.2023.12.15.00.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 00:24:44 -0800 (PST)
Message-ID: <120bf090-0c07-4971-a18a-a1b326f1b139@linaro.org>
Date: Fri, 15 Dec 2023 10:24:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mtd: spi-nor: drop superfluous debug prints
Content-Language: en-US
To: pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com
Cc: richard@nod.at, jaimeliao@mxic.com.tw, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
 <20231215082138.16063-5-tudor.ambarus@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20231215082138.16063-5-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I missed to drop some unused variables. Will drop them if everything
else is fine.

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index a708c3448809..92c992eb73d5 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3492,9 +3492,7 @@ int spi_nor_scan(struct spi_nor *nor, const char
*name,
 {
        const struct flash_info *info;
        struct device *dev = nor->dev;
-       struct mtd_info *mtd = &nor->mtd;
        int ret;
-       int i;

        ret = spi_nor_check(nor);
        if (ret)

