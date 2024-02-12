Return-Path: <linux-kernel+bounces-61151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882BA850E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACCD1C20AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4F2749F;
	Mon, 12 Feb 2024 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdmLEvrA"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09D7469
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707723079; cv=none; b=JYNJcU7JDzTip7sl8maC7GJWAOKFcevmdmeaH26+/KYYlciET/jQxC71WmEqL65b2igkC0IP9O+nLRBHSvTdMlnDQVKImm+DyMJzKykwwwgDMWE1ixBgHBW8aF7/Ti8Cb5vbPOmX4Fdb4ppuLGuggMQzuBZDKpVfZs5d3z4O9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707723079; c=relaxed/simple;
	bh=nw5jsh6DLxcro34EWTNgqNj+TF9LR3XE1X+cfRK2wCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9kVttV7jF3ksjvFk7g44N8ZlUkJewFVOZ1eoPbfpN8vypTi9H3J6M4EHTZt4ME2mf/YaMzDL0r+ixEeoml6TUcTnf83hxv+cyYJ7vaWPy5cYBtKSIDnlPuMjRoKBZB4QLVNjTlG9yi/dkwBxrf4Jo6wOuGTYESDAf+3ig2uBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fdmLEvrA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410ee8ed663so896835e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707723076; x=1708327876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jS2mp67+TTcdfHEF0i7Lkkf6JiH3JGIEMkEQyAmniQw=;
        b=fdmLEvrADi/ec6m+MlIEG8i4fc/Jp3b9W+3MmAJiAjOmN9GObZRySWbwRsVzUzFvr7
         5+eqVfd6FwUQo2+WfIisvuMWHSw5bksmaIEaojhtiN0+lAVyv2nSJHvp2m5HrkIURvgw
         H/Y1Y8hkoeXzW/TkNAil2leXQYFQKrP0EkwJJlH8HpofiTgLOMkZ33m88vP/P0mSFDEm
         rZMVP94HkYjHC7+/l9TuNcha2M1S9fOf+Y+v9Iu5fTM8S3famVJGBwW20RPgJrH00VH/
         VqF36oCsKuzhiYqIoxk3+yMAa8RpTxvuW86+SpsYu0ddFInIcVK+CXRJ19ZmCx9+W90l
         I3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707723076; x=1708327876;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS2mp67+TTcdfHEF0i7Lkkf6JiH3JGIEMkEQyAmniQw=;
        b=i/dz3sMU06IqNSVyTIyLOZjf70+PzFxxHDfotYmHYX6bm3Y8xhrfpxWmjS/cCUGDw0
         6LMLxKVgOwIURqWMy7g/fUYklSqU610BtmAKOej61YEU5Aq/xv4QICLN+2Ys3/5kw5/7
         mI0NMkZ2bo1kvLAQY2WcZbLKSd1j/RlRAqWZ+oPRJRdVDs0yV4ecMekRLAr/A89R+YtZ
         LfXG1Hblw6a8lw7LxtfscHJQs9uIYdYjuENHrOUlQpPRNFnXjtOVcorOU1IaNnh3ZP6s
         Oa7likTRQ8YBP3e54NaApaQRna+oRFRJvs1X9TzGI15bRKU/O1Zh+ucpSMhX+csC+8Qf
         NHiw==
X-Gm-Message-State: AOJu0Yzk5HGiQ/43H7bHlFLi5t8mzeVlIn9ATwk42H+pmT+W1jGyMFM9
	5uDH/GGHVu64iS8GZS1x0JhzDfEC4q++3HrXxZcqgHUHu5E/EWiwti4mZWpLkfY=
X-Google-Smtp-Source: AGHT+IGinZD/S6dstgb41nxMt3v7DIHfzGUQ+DPhnFk4tiwYdpiRxLHMYj1MvdqeyAKOu+R/5npD8A==
X-Received: by 2002:a05:600c:310f:b0:410:f582:6675 with SMTP id g15-20020a05600c310f00b00410f5826675mr272998wmo.26.1707723075672;
        Sun, 11 Feb 2024 23:31:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhK/RnPFnOehJo3yRrxyufYFNurxi4Q62ky07SVK6LZBZaS1K1Eocu0GeUvU45KJisSvtz0ILnBdu7JpyuOrN84qxB+pLswj9rRbinLYE20pDHzRDyIqbjkWW23ydCXmZm8OLYBX9PLvBWMTi6fs8Ywnya1rbdr4ayff7C998Nz4mvEuNQidcQv8g+SYS3gnrgCIGBZDrOQtpjdhZDG0e8eRYvETm/kLyzgOfcgCV3gmeCOTS7yCWKGq4Z
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id d16-20020a05600c34d000b0040fdb244485sm7801137wmq.40.2024.02.11.23.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 23:31:15 -0800 (PST)
Message-ID: <b7726526-0b0a-4d3d-bf05-b1065d361cc2@linaro.org>
Date: Mon, 12 Feb 2024 08:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: s3c64xx: make s3c6410_subsys const
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240211-bus_cleanup-arm-v2-1-3de9e8af7cbd@marliere.net>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240211-bus_cleanup-arm-v2-1-3de9e8af7cbd@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2024 16:57, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
> a const *"), the driver core can properly handle constant struct
> bus_type, move the s3c6410_subsys variable to be a constant structure as
> well, placing it into read-only memory which can not be modified at
> runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

I just noticed you sent quite the same change for the same subarch.
Please perform changes all at once. Squashed.

Best regards,
Krzysztof


