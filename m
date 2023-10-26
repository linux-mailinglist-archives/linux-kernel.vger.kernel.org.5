Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DB47D84F6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbjJZOmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjJZOmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:42:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC01B3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:42:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40806e40fccso6873425e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698331323; x=1698936123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBTq3tUneTFtyngE2KsPOx/aCroyGP8+hR+mE0hQyN8=;
        b=qXcNjvnmPfpEXEhE6tmK27Omg5pfl53NGKG5rfyDLNLbpDOx523jUcEkKuXT1BQuaB
         TRH8Z0fbd2Fh0sw7AFh0k17NA1xoVaVnhk4292F1KsaK5jfXFnsg5vtY7iNo6PkPUd2m
         kspNqqs/BCdzqS+cEyztpsjVrlFqXbH+MzHV9+uaxB6inTpqr7B5p+nCtGSwFeIyoNso
         xcOOdcwdHPcdpdgCLYb74oZ1Xe6M5oQsUVEBUtK1gaFyxP6UkUlWX+0pAnPk6sFwdP0t
         0mLxNw02JThi1ERr7/xRgbLCTdW0euLtPL2PSMrcOSwFCMuUEXataEDTnu1ZHdpYurRi
         YJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331323; x=1698936123;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HBTq3tUneTFtyngE2KsPOx/aCroyGP8+hR+mE0hQyN8=;
        b=fhpIdhUKm35+cEDnpWOaWGnri4Y806ZAtKmVJ+l9D+Vex25wZz57fbeQgPx6EBVdOl
         9eJjcrQ+p1GhXiIYkApOlWwKst0yQtdloZ5n2wZaKWGMNWjI/Ea0SMpbOGFzHb3iIR89
         H5bg/PoH+/iMbduubzjEKvH5T+xed6no4WSUrcPWmrbNGop7iHsr14e60XkDYf/unZFu
         3ebX7r6g4iegAa4gb5pHEDtqEPGnGHQE6dEgjx/4SS4FVw2rmzfzQmSGTOs+TMH8zdZk
         YgWnRghmZe3MvQx5WJHPe4Dc41etbgYnVrBEfNKf7+ay52oAFmYC/eqBkz+jzB6N4BZU
         Bn3Q==
X-Gm-Message-State: AOJu0Yx9dYAy9QeSGdJjoMcGqfA29clPHQdkAO2FGLmdjyrN2BNvZyLN
        BzhjP/XHC8bsXlNF/o/8E/2kHArk7mW5PVymMhVbEZGd
X-Google-Smtp-Source: AGHT+IHgpcFwHSm2zVcUODCW5JcshsHhtbkvJSp0EmQ1ldqTh2Z3SffwnMZ+PTTzMy37ZPdH+p1OfQ==
X-Received: by 2002:a05:600c:19d1:b0:405:7b92:453e with SMTP id u17-20020a05600c19d100b004057b92453emr15618178wmq.37.1698331323261;
        Thu, 26 Oct 2023 07:42:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f57f:eb08:d29b:8c9c? ([2a01:e0a:982:cbb0:f57f:eb08:d29b:8c9c])
        by smtp.gmail.com with ESMTPSA id bg9-20020a05600c3c8900b004063cd8105csm2790955wmb.22.2023.10.26.07.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 07:42:02 -0700 (PDT)
Message-ID: <7497e738-b9de-4dcb-90f8-06d6b1a86047@linaro.org>
Date:   Thu, 26 Oct 2023 16:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] pmdomain: amlogic: Fix mask for the second NNA mem PD
 domain
Content-Language: en-US, fr
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc:     linux-kernel@vger.kernel.org, Da Xue <da@libre.computer>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org
References: <20231016080205.41982-1-tomeu@tomeuvizoso.net>
 <20231016080205.41982-2-tomeu@tomeuvizoso.net>
 <CAPDyKFqEP50MBE0_t5tAfsrdx8EOy5MGQWqfX0a_8FA-3cJe8A@mail.gmail.com>
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
In-Reply-To: <CAPDyKFqEP50MBE0_t5tAfsrdx8EOy5MGQWqfX0a_8FA-3cJe8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On 26/10/2023 16:36, Ulf Hansson wrote:
> On Mon, 16 Oct 2023 at 10:02, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
>>
>> Without this change, the NPU hangs when the 8th NN core is used.
>>
>> It matches what the out-of-tree driver does.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> 
> The change looks good to me, but I have been awaiting an ack from some
> of the platform/soc maintainers before applying.
> 
> That said, it looks like we need a fixes/stable tag too. Is there a
> certain commit this fixes?

It looks good for me, you can add:

Fixes: 9a217b7e8953 ("soc: amlogic: meson-pwrc: Add NNA power domain for A311D")

and

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

> 
> Kind regards
> Uffe
> 
>> ---
>>   drivers/pmdomain/amlogic/meson-ee-pwrc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
>> index cfb796d40d9d..0dd71cd814c5 100644
>> --- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
>> +++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
>> @@ -228,7 +228,7 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
>>
>>   static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_nna[] = {
>>          { G12A_HHI_NANOQ_MEM_PD_REG0, GENMASK(31, 0) },
>> -       { G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(23, 0) },
>> +       { G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(31, 0) },
>>   };
>>
>>   #define VPU_PD(__name, __top_pd, __mem, __is_pwr_off, __resets, __clks)        \
>> --
>> 2.41.0
>>

