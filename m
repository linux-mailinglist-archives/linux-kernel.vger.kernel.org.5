Return-Path: <linux-kernel+bounces-127966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E18953C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1481F24BA0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843367A705;
	Tue,  2 Apr 2024 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxxA+F4X"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6A335A7;
	Tue,  2 Apr 2024 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061943; cv=none; b=pDclyoMILk8x73Z3+BSJfW5P14FmPbE3onvc37toYeCu0c/NlVz4Jtej25K9aTqnuMc/0/CaI0/Zuhx6DVxuj5Z2dU2VZWjaIfUpjpqlGFZrYMaP6RDCK8c8e5DHYFUB00DCRhKahNN3BRPCNrZIOYHRGxM42I9DRQTqUlEZLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061943; c=relaxed/simple;
	bh=0vaw1GFhhhzPHB1+ERUheM/ykQ5WliXyfzQBmILS9ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sxSjYjTuPBrxhf/I00yMn3BIjO2Zohn5xAP5xXSBmIPwoH/Kc+eWfJnNUYYmzykDxIbvAhaz+N+EMp1QO1qCoZr72bnH2rdtEtE5RSypkZqyQ2DJi+ApfaeiyHl6XqrNMbua06PG03cn/nXX7NqBnpnJB18zIf4lAj5Cj7Dy0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxxA+F4X; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ea8ee55812so5025775b3a.0;
        Tue, 02 Apr 2024 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712061940; x=1712666740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KmxO8jkSPJDfReP4Gy4yPtubDgLo4IL5/YODqwlo3d8=;
        b=QxxA+F4XRY3LtuvB5OdwZ3U8wQLRW7HvGTeP91EKddDFVNHPM3rZlPAd3WBfaFhqV7
         07P6hsZUsbBQKAh7H21veRFHD03P5YEuaVZTsMW9PLvaWKlzbxumuvFXQuIyp3usgXo5
         /fOzGXB2yxJ44nnZoasP93kAeGtEiE0r2NM0I9PP9a3YQnXNG2RvNLwKxcweCkaZCDFl
         L/GYJEotgAZNFrHiDWr+aP5fdqDCkSSIWnWL1jxLUAHeccV3c5ZTuY/Xa3Jin8F6fITz
         55Cm/Y/Dx20HlttkK7ztSuvE+sS8FvKrTMSjuFoPEjpt9HqKbKbBqyEYGHp3l8Rjx7rq
         m5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061940; x=1712666740;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmxO8jkSPJDfReP4Gy4yPtubDgLo4IL5/YODqwlo3d8=;
        b=KxRrYYcdzEuMUpSWMikM+cs9HalWe7lwUTYny5eSJTVOFOXBGCFb1MaLVqPWQ5IxiK
         CCtHcRlPc2PhTJ3f50Sdg/HsJHBHX2JanFuf5qO2sEekOLNU/K+ijDOGIwMir/JVSnCU
         iXMlSn1CSCtU4jMYiY1RKjXzaey5ozKPTr4prBCXt7pBE7IGUCq5WhX6IUGLDAoeDmd5
         P7RqPkEOqrOVcztRjW4QqwNIa0TmerUHMM2C+IE5/a1Kr7Ry3304MnbdM1xMtOmt0QTU
         PHbADgKc/bxi7Pfm/Idol/qc9p52AJfWiOK4SuO5dl/ZmA8G7TyhF6u2/uwXq6ND3nrD
         nhlg==
X-Forwarded-Encrypted: i=1; AJvYcCVN6k/z2cKZBh+CORGOYkEzCRJBbWsSxLp76T9wmOI2nAh+b4VrbzRC/TyoLnnKWjjM6bsh0JJMy7F0a8G0ypa9eCVsXD/ojjZj8W4UPfDjR5a1flhRuOnfLoaXzuikEWPQ4YgA
X-Gm-Message-State: AOJu0YxFYfAO5f/sppAjxYT31WbSQiqO6QfUwHE4Ki1EO0w0FWR8S3cv
	f13pz402haWBvgi7XIFlmWaxCBcD8P4orRb3cCBr/rBPmChuzkXsa8DPrCIv
X-Google-Smtp-Source: AGHT+IFVzd6eUIP+OPmGmZis0tDFQRnDEc4TSe9GmjxBJUWfCJDIWVRdu0rUeEQVcBV8AzFP5crJOA==
X-Received: by 2002:a05:6a00:1da7:b0:6e5:faca:3683 with SMTP id z39-20020a056a001da700b006e5faca3683mr14537167pfw.26.1712061940326;
        Tue, 02 Apr 2024 05:45:40 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:ba1:283f:ce3e:1cbd:c25b? ([2600:8802:b00:ba1:283f:ce3e:1cbd:c25b])
        by smtp.gmail.com with ESMTPSA id ey12-20020a056a0038cc00b006eaaaf5e0a8sm9734647pfb.71.2024.04.02.05.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 05:45:39 -0700 (PDT)
Message-ID: <b208ddca-0615-4641-9147-1d19b7684d25@gmail.com>
Date: Tue, 2 Apr 2024 05:45:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 1/2] net: dsa: microchip: drop driver owner
 assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/30/2024 2:10 PM, Krzysztof Kozlowski wrote:
> Core in spi_register_driver() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

