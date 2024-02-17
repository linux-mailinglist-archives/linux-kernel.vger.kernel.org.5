Return-Path: <linux-kernel+bounces-69796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5617B858EAB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5171B20E26
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D459A1DDFA;
	Sat, 17 Feb 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxuKwWga"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5AE200A5
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708165244; cv=none; b=LMuA/qMDUQaCDpIAExCSD89uCAGNa8sLoePf9EO/MSDkLt7xPaSG/IKvkWksxM2lUsqaLrkESpFqATd6S2+sMm3H+g4LgVACcRFs5QiEP+HDmlqJ9OPIAQvkL2BluuKtSv6MIP9KYDmA3373b3bSW9HcP/49kBQQz1bWMndlyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708165244; c=relaxed/simple;
	bh=VQjyUQKIbn7mEVA3FOH/WUj52SkVsMne6wvqLQBc6y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idaPfuAXFKFGGpPDfcDfcEqBxiENEb9ZQu2u9yZTNq6Uk+Q78/2WkGeKjlGTuEtBgC4cA5uBTg5p4MLiIvjpIIL2B9JE3yKAhvUIi+7QQ3gbkf6XFzdENP4YPRY7wq07ZzL4qzh79yo7tnedBIJrFdZ1e1CG/bctkmCL5WB5w9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AxuKwWga; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d2305589a2so627071fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 02:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708165240; x=1708770040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2HtFC7DBy8UXBSfjJEWGOAW/7YBWZq1oTJW9cuFiD8=;
        b=AxuKwWga49La5SDuBH6Q3PRv/U00htGaWJzl3J0afWDO4l35rg+OculREa/DJOqnMR
         SXxMdBPRa8C3UQPk9NO2v9bJnUQyBIqa/6oCGOoMl4Z7T7FKBSRiqMEbizOHhryPOsVK
         Q0dS/4zLJASV0bMoPi7NkUJaS/GA4Ai4Ux3cGUEKNsmgCZIVxNNqbOIlMmPRVWzHcCde
         gwRS47rXfr6uHXggRzjpQzcfyLI7Imj+K97QYQBFbxSfPHEdXw6/d/elUg45jvnJNJY8
         chdnzD53v2vqW07kc7eJitf9K78xSVye95DgCy9t/T/AtkV2cO1t3dMvoMWtRktkxpBG
         X7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708165240; x=1708770040;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2HtFC7DBy8UXBSfjJEWGOAW/7YBWZq1oTJW9cuFiD8=;
        b=MsqN4jSE4BjorlPbXpsPHtUFPZ10co6CGywUVbR/04iuR8JUuw1pa5YsxjuSHljoSK
         q6/oaL3gAYlDQ38311mcrncGjv+cekJKwRBiCM1bcJEQSKsUqJt+roxub2VTI7PUsNVc
         2515b+Qqhq+pL39AIP+hIgF+kkl9ufwkWjw3ovkuhJMtkETmtdOXkbpX7tIR0MNhdskJ
         q/xLk8UiKBnraOe+yzh/kulEmboH9tK0EXKTaOMGpgSD/sW0HFvsGpDgN5L8fYemPBOk
         xYrmm4kQLNjvqF27Jy6dPU/QpgBJVZHGfXyDPaHAeceJp1ybPPM1nDXPv50k9nXrjmOw
         QVDg==
X-Forwarded-Encrypted: i=1; AJvYcCWcn4yVZ+SD7ra4ds3qDZSx+JD7X0zu9C3juv+5Qi4EPB4SfGuYvaOcdtvq3X4FvKNwrbHzFWmLa/tz9UKxIYsYydvby/3GrauNiCN7
X-Gm-Message-State: AOJu0Ywu9z2td9VuRsK+Z7a1Q6zIUgWHuOnyIkv1NHzAe1EBr3BrbyVw
	3SIeGMX177/ehsD1WGJ9PeVD73hWXS71hW5PMsnZjHhCQkh5xFuGn4rO0AU8YP8=
X-Google-Smtp-Source: AGHT+IGquEMz25c27Vj8Gouis+jAtB47ep+KUh3aTYNC/omQeZjhA/tjbci6BdSMco6nb5Jdb83Gdw==
X-Received: by 2002:a19:ca42:0:b0:511:a100:b30d with SMTP id h2-20020a19ca42000000b00511a100b30dmr4502876lfj.56.1708165240313;
        Sat, 17 Feb 2024 02:20:40 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id m5-20020a1709061ec500b00a3d669a2055sm855029ejj.88.2024.02.17.02.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 02:20:39 -0800 (PST)
Message-ID: <c8cb8fd4-a67d-4982-b1f8-6fedbb7e9a4f@linaro.org>
Date: Sat, 17 Feb 2024 11:20:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] clk: rockchip: rst-rk3588: Add BIU reset
Content-Language: en-US
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: heiko@sntech.de, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 jose.abreu@synopsys.com, nelson.costa@synopsys.com,
 dmitry.osipenko@collabora.com, sebastian.reichel@collabora.com,
 shawn.wen@rock-chips.com, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-dt@vger.kernel.org, linux-arm@lists.infradead.org
References: <20240216094922.257674-1-shreeya.patel@collabora.com>
 <20240216094922.257674-2-shreeya.patel@collabora.com>
 <237e690a-2f49-4046-b054-3a878eed6748@linaro.org>
 <30d2-65cf5980-3-2ec9f500@242931553>
 <0c2f4d92-afa9-46f1-844e-994bd45924ef@linaro.org>
 <1b9-65d08800-3-19290580@120474537>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1b9-65d08800-3-19290580@120474537>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2024 11:18, Shreeya Patel wrote:
> On Saturday, February 17, 2024 13:47 IST, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 16/02/2024 13:48, Shreeya Patel wrote:
>>> On Friday, February 16, 2024 15:33 IST, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>> On 16/02/2024 10:49, Shreeya Patel wrote:
>>>>> Export hdmirx_biu soft reset id which is required by the hdmirx controller.
>>>>>
>>>>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>>>>> ---
>>>>>  drivers/clk/rockchip/rst-rk3588.c               | 1 +
>>>>>  include/dt-bindings/reset/rockchip,rk3588-cru.h | 2 ++
>>>>
>>>> Please run scripts/checkpatch.pl and fix reported warnings. Some
>>>> warnings can be ignored, but the code here looks like it needs a fix.
>>>> Feel free to get in touch if the warning is not clear.
>>>>
>>>> Please do internal review. The internal Collabora review would tell you:
>>>> YOU MUST run checkpatch. Then you see errors, so why do you send patch
>>>> with errors to the mailing list?
>>>>
>>>
>>> I am sorry but what errors are you talking about?
>>> I don't see any errors reported by checkpatch :-
>>>
>>> shreeya@shreeya:~/collabora/rd/rockchip/torvalds$ ./scripts/checkpatch.pl hdmirx/0001-clk-rockchip-rst-rk3588-Add-BIU-reset.patch
>>> WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>>
>> Here.
>>
>>>
>>> total: 0 errors, 1 warnings, 13 lines checked
>>>
>>> NOTE: For some of the reported defects, checkpatch may be able to
>>>       mechanically convert to the typical style using --fix or --fix-inplace.
>>>
>>> hdmirx-v1-1602/0001-clk-rockchip-rst-rk3588-Add-BIU-reset.patch has style problems, please review.
>>>
>>> I see the above warning but that looks like a false positive to me.
>>
>> Why for your patch it would be false positive and for all others would not?
>>
> 
> OK, now I see what you meant. Since we are touching the include file and C file together, this warning was generated.
> It was a bit confusing to interpret this as the warning also talks about Documentation which we didn't touch at all.

Really, no documentation touching? Care to check the full path of the
files you are changing?


> 
> Anyway, I will create two separate patches for this in v2.

I think rules cannot be clearer:
https://elixir.bootlin.com/linux/v6.8-rc4/source/Documentation/devicetree/bindings/submitting-patches.rst#L13


Best regards,
Krzysztof


