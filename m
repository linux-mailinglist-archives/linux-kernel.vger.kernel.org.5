Return-Path: <linux-kernel+bounces-122733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF8288FC31
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F20298831
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9835554656;
	Thu, 28 Mar 2024 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dhi3Kyho"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02571DFCB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619645; cv=none; b=gcSJwCxkiptW5kyK4MDOwyE4FkaubPXHi6NTktFzehP3TLtnHFhaTRyjKJouU6ZgH1qWt3dnPcff0ldDeqKVynWbE1AXEUGjryrN3L5aIKuper9d25h2N9kpJ5/n8NVC8JReB47EU11CpjrpZkXyI3eEUvel8mY+L6kQMlj8dWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619645; c=relaxed/simple;
	bh=yYDNUot13y8C3ZJ+iZrI0rAfnoRfIoL4ETxwLJIdJ1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C/rXfaaxVkaff6Y9RVWU/HilPFiXqUCP/Zwo3ouAdpYRJ628mwEdRMr5umktwIXxuX9b37pzEyO0Q8PBQsEdwTF290fXQeGsfjs3vt3G6Ud/P3r5MHnxz4IcxIzaPM7HsV9D8J/rUCJeZ+rRPDRJBXnWzRymW42TzperzBbWnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dhi3Kyho; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3416df43cabso499503f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711619642; x=1712224442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qR7L2zsTQZFBtjYk0D8hXAaerXX/BB/ioIDe3/j49Fo=;
        b=Dhi3KyhoLAFgAjSDZkwQ/9/fOO00Ok3p26stzK6iBc65g45d5fks7Y0mSIg/xhZpg8
         u4aqLiDnuMthIPey++uJEOXbx2wICT4Eh/ZODi1/h4BowmKTo/7J4gOGBu+yYs2i3EBw
         WDwGFe2UIx9occdHK3637zTRgaQKlJ/tajAjLG1l+oL7JjpcakbgjW8Dbo/oOBlPh9W+
         EwpzMEV8yt4WvnX3BXu4zlGtdacM4eMeVUwFlhiEjon0lLIEnwSSjg8j1H39H7EDgfap
         xmJUCvCD58rAFSUpHkhIP+N651roInQrfMGxjokeh1q2qYIxqiGZTvbEoM0EGuBC3T+s
         R9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711619642; x=1712224442;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qR7L2zsTQZFBtjYk0D8hXAaerXX/BB/ioIDe3/j49Fo=;
        b=HxoVk8AwcPE3T8guYke6+RKVmz6h86m1SzVjnN52+hs+bCjCI+eJFplQ3kdQYkIoBb
         dOzWvQ+N72hXsZz2sj0MBsDMPpo67xDeCEfA51vQnCKp7pBLX8c+TpDYH/CH+yIMJbZg
         lQDg3mwOEwaJZAwxQWHsEruesu3aFPB00Trojc99v/rF4pghTgAdCwOlP0Cls580SLbm
         +lI7gz3XrUEHHeuZ3viD82XkX1r0yzvk6XXyIi18z+XYRzRPy77lY4o4WyvHWQrjPPlb
         pamniD3MWYkUXMOEQizTPuv0pflvcg6R7YOBuTYRahsCtvo+DKkgSIy25EZl22AfjsMl
         rmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCnlXQGumws7cP1Sc+rico4n2rZWaXmzbgbJbG8BaOE04gB4kqxFc6FJuLwOgYbn37TzHQ8isoUKb+IGYHWnatK0EfsAOW64yeSm4t
X-Gm-Message-State: AOJu0YyWbS5p2TZ3M/NrQrI4qwR4ziTR8icMFthh3dPUjSHo3eke4oOG
	vHb+yhFYHBj5WDYS7f4pNtnCZITFXVXgdWOdYdTWezyR5Kzg4/BRtCmyRObznJ5E14e/Reyy9RT
	g
X-Google-Smtp-Source: AGHT+IGxp7E2/LIC9lCPGAz/YYMslQUnBPVeT64Qu+NHwS+JRYtYdMeHw6/t9lzCSZb1vU7Q3sGO0Q==
X-Received: by 2002:a5d:6e53:0:b0:33e:8b95:62d9 with SMTP id j19-20020a5d6e53000000b0033e8b9562d9mr1722982wrz.23.1711619642166;
        Thu, 28 Mar 2024 02:54:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id i13-20020adfe48d000000b00341bdbf0b07sm1295194wrm.50.2024.03.28.02.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:54:01 -0700 (PDT)
Message-ID: <93fc47b1-ae44-4eb7-b799-9227a019c7c8@linaro.org>
Date: Thu, 28 Mar 2024 10:54:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next][resend v1 1/1] nfc: st95hf: Switch to using
 gpiod API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326175836.1418718-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240326175836.1418718-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 18:58, Andy Shevchenko wrote:
> This updates the driver to gpiod API, and removes yet another use of
> of_get_named_gpio().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


