Return-Path: <linux-kernel+bounces-11431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9360B81E629
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07831C21D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10984CE12;
	Tue, 26 Dec 2023 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5+fac/o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F14CE01
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d5ae89c72so2264395e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 01:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703581576; x=1704186376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw+VgX6rqCZAGRRzrtKww64vKWB9C04MKuOvSYYGa4s=;
        b=a5+fac/oClxmGVsmJ5r8B9sHsuk00ee4As8tIjjNalHMsHUMLNoTbI1jLQplmOo24G
         SbJazcBFbyvKTHDHkzWu8MFwbHH4g2QgWXDza59ESEtWRnfwkwIF46rv/eCC3Wcm1PCm
         f9QV9hhc94djp5coPJbZIhT10ZfRE1z1e8/y5hl7fw07mH4pV2k0oOEjUMl+tqyWkZkL
         DCoWs6XEP+gt/POp9u+scrJAqMn06GzWonfTmDFcDagdTxt02bthvr03MXWx4ipU7SVb
         JS9+w91S5sQj/tweHwOOkAA0vbNUJARRJaJihMOS/wXIbZYQTTxPs6S8BBukD73+0AAQ
         jQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703581576; x=1704186376;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mw+VgX6rqCZAGRRzrtKww64vKWB9C04MKuOvSYYGa4s=;
        b=W1oqCEASZkONA1HKOgWyMipfX//RtkZq7s4VsvB3PNaQoFLxZ2+8hBNFGl2b2LB3yM
         /GbJEePWu0cwXWttcTeIgFT8Nfl2FbN0JmEbabVEu3Mrm7Lnbp+kDUQ2mEqL3lCESP0o
         Oq/bryKwAf11k84UZcbcvSw40do1E3U0t7mmy4O51P+Jya/2kRkVHoIlRDFsZ3Udc2QR
         qkyiHamRVL6o0gMY2SytCgky40D+jCjYQV7JVfu9+zuLnedC06Wi7vt9t+Jwe0SbHTMH
         kwbxJszmqlhLyGtK/4U66ICuNK+OyUFHLVVH74u4HrRGB/7bFggVKsZIfFVCZCxgzNuD
         QoQw==
X-Gm-Message-State: AOJu0Yyld1RvJ6NGNNyIG4v5FA6WZYH7O8OzPxmig1WFr8Zbdbl9Iq+B
	HdQ2PjLYczIwIEKyQF+z7UTm4yL/8l4wtQ==
X-Google-Smtp-Source: AGHT+IFYTSaAFvffZs8LIxajWYHYBvNoCA77G/7VNQcMc8466nMeN1w41mjxWXA79h/+fER61egMuw==
X-Received: by 2002:a05:600c:5248:b0:40d:5ab6:4697 with SMTP id fc8-20020a05600c524800b0040d5ab64697mr203623wmb.267.1703581576323;
        Tue, 26 Dec 2023 01:06:16 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id l3-20020a170907914300b00a23640f7f23sm5539636ejs.47.2023.12.26.01.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 01:06:15 -0800 (PST)
Message-ID: <cdb2cfb6-8385-4f4d-b49b-b04d19d4bdc0@linaro.org>
Date: Tue, 26 Dec 2023 10:06:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] media: s5p-mfc: drop static device variable in
 s5p_mfc_pm.c
To: Aakarsh Jain <aakarsh.jain@samsung.com>,
 'Marek Szyprowski' <m.szyprowski@samsung.com>,
 'Andrzej Hajda' <andrzej.hajda@intel.com>,
 'Mauro Carvalho Chehab' <mchehab@kernel.org>
Cc: linux-fsd@tesla.coma, linux-samsung-soc@vger.kernel.org,
 'Smitha T Murthy' <smithatmurthy@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
 <CGME20231224154454epcas5p311d2b74fb1809bb555a442d1bce82edb@epcas5p3.samsung.com>
 <20231224-n-s5p-mfc-const-v1-15-a3b246470fe4@linaro.org>
 <15d301da37c3$cff325e0$6fd971a0$@samsung.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <15d301da37c3$cff325e0$6fd971a0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/12/2023 07:21, Aakarsh Jain wrote:
>> -int s5p_mfc_clock_on(void);
>> -void s5p_mfc_clock_off(void);
>> -int s5p_mfc_power_on(void);
>> -int s5p_mfc_power_off(void);
>> +int s5p_mfc_clock_on(struct s5p_mfc_dev *dev); void
>> +s5p_mfc_clock_off(struct s5p_mfc_dev *dev); int
>> s5p_mfc_power_on(struct
>> +s5p_mfc_dev *dev); int s5p_mfc_power_off(struct s5p_mfc_dev *dev);
>>
>>  #endif /* S5P_MFC_PM_H_ */
>>
>> --
>> 2.34.1
> 
> Reviewed-by: Aakarsh Jain <aakarsh.jain@samsung.com>

Pleasy kindly trim the replies from unnecessary context.  It makes it
much easier to find new content.

Best regards,
Krzysztof


