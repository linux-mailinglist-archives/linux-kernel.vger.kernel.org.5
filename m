Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897B980C7AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjLKLIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbjLKLIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:08:31 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5778BB0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:08:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso45643275e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702292915; x=1702897715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/RqXxfpj+JRqX9l19TDqZ+cjowYfkXBepIWo3cd1zw=;
        b=Aq0bQaLhEdnLInqp7awZqQQXpkWyxU69qxe7F49garzBXpv0EZU394HK9FK6sZgDni
         nMd56Ct2pWPmQYGV9fI9VO1OE63TQ3+c8YgFFVIQZYbWgQsi9VA/SiWpjfdXkvmh6nxd
         +KeaFEGf2FApkVQMTqz+FRWRRvKXhZEjK6GyuK1aAVp9yc+DQo0G0Jn43czB9+sl13Fy
         BOoVsbV4aaaUPExjiu7FfwZlxfa7qLv45HglpzntHVdB6N12XDmKvWVIVEYG3ZvT1YsG
         RgsncITsHMwoFGBabks+HXgu4spVx5gaNUX8Q76k6lbPcgznI4xclztJjt3wW9fj9y6y
         REbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702292915; x=1702897715;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/RqXxfpj+JRqX9l19TDqZ+cjowYfkXBepIWo3cd1zw=;
        b=Mi3OUI3w6QCk1EBYvqVXIC1LFQUZd/qS1vLPnNPlvK4YpI0RhvcAEhJ//QDeyIPLaY
         1kwMl6kdYPqmhl6AhWBXxczeYG7/7O8ZS/N4Z2DcM218fCBojihlNw0vGOt/tmFQR5cT
         VyTdw+IkBLieahiBYafgFQAc0E9RmF5xxI5jb576c3R7uCkHOH9ojGVJ+T+drsCZlHLm
         tjNGv64X/J5u93DV42aaMu/zDL0ByyfB6INGUNv1p3e27f5NtOP9jjxs4rf2DWaRbYFm
         5MWyRQz8ndikVuIGFwQqcxSItgqWCfGmdMUFoinzl2edVNCeRiFw63g8acdvm+PBit4C
         Z4lQ==
X-Gm-Message-State: AOJu0YwhjXRSPqHEmpsoAv3V86F3j6E+P3NzTNQ9lHmRLrK3JBilXrKB
        qKlNoa2YwowyF7ARwugvF6v/Og==
X-Google-Smtp-Source: AGHT+IEAVqD2pf0lIXHv9RUG24iG1TBtw72baJaE34DMMMFURDxTmpCN0F/Nfq6dzs2YGWB8K4YoLQ==
X-Received: by 2002:a05:600c:204c:b0:40c:2788:28f3 with SMTP id p12-20020a05600c204c00b0040c278828f3mr2094151wmg.79.1702292914759;
        Mon, 11 Dec 2023 03:08:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:302e:e0c2:d42c:cb23? ([2a01:e0a:982:cbb0:302e:e0c2:d42c:cb23])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600c450b00b0040c495b1c90sm2263608wmo.11.2023.12.11.03.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 03:08:34 -0800 (PST)
Message-ID: <5c85ff3c-3576-4415-a8f1-07d786201dc7@linaro.org>
Date:   Mon, 11 Dec 2023 12:08:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: amlogic: minor whitespace cleanup around
 '='
Content-Language: en-US, fr
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231124094739.58163-1-krzysztof.kozlowski@linaro.org>
 <20231124094739.58163-2-krzysztof.kozlowski@linaro.org>
 <4150bf8e-a48d-4d16-902f-a95f6489c6f5@linaro.org>
 <449d675f-e98c-4924-ab81-14a139081a97@linaro.org>
 <e4a163c0-5f4f-4c0e-a597-1ee06a84f3cc@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <e4a163c0-5f4f-4c0e-a597-1ee06a84f3cc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2023 11:38, Krzysztof Kozlowski wrote:
> On 11/12/2023 10:10, Neil Armstrong wrote:
>> Hi,
>>
>> On 24/11/2023 10:49, Krzysztof Kozlowski wrote:
>>> On 24/11/2023 10:47, Krzysztof Kozlowski wrote:
>>>> The DTS code coding style expects exactly one space before and after '='
>>>> sign.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>
>>> Please ignore, that's duplicated of my previous send.
>>
>> I don't see a previous send, so I'm confused.
>> I can apply this patch if you're ok.
> 
> This was the original submission, which you applied (Thank you):
> https://lore.kernel.org/all/20231124094700.58071-1-krzysztof.kozlowski@linaro.org/
> 
> Both patches here can be ignored (applied through different series).

Ah ok, right!

> 
> Best regards,
> Krzysztof
> 

