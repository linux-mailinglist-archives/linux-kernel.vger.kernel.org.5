Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A188679CA25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjILIgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjILIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:36:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6C1B9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:36:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so57394895e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694507802; x=1695112602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDYOCa6xctYXF6LIcPiJ4hYpbG9p0QfDxLuxAJn4eSc=;
        b=dFH3rOEnTvW4hE+7mn+iYALQTnvQjZoRvb6LqpBqG/AgQCoyLW5EdfCLdzIPoUiT4A
         kdBLnL1wiDN7HE0tyL9uEWalAl1Rt8NisnSvQfADT61Q8fGHh/sbLZRc633mFeNO8caE
         fZSMbrAYJH/xmZ5kvbeaU1LjckFLIQDknbG9a6dlX+UspoUVlwYh4dUWG0GpPubfymwm
         d/skBcg2u032Bf4Qk7LgDzJBUqua9TDMX/iXA4sEjtp5/MjiMz3+q0+SSIRwK6lxkjDM
         O16N2Yc7A7Nb06E9q3LN/GcSNGUlOKUt+gfwcq0Nvv7ObZ+diht/6iJspu4vgR8UPt9a
         lSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694507802; x=1695112602;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YDYOCa6xctYXF6LIcPiJ4hYpbG9p0QfDxLuxAJn4eSc=;
        b=vF5W4QLsbdgvHsl0DMEk0+NE1LlDvOoktdk2CRyT7uJ6fULzOrjhdZGFRZ8jXiI4bO
         7XVQrfmiBp4eiqSjMVr8kfg0OwNGwyZE1EF1MtTJG71A1WGs3nFNNztv3QoncC03K54Y
         7PknbDZsh/6yZdcUJmacELQ+V8zv/tJpaQqWh13hYvPMkp7dZwyBz0L10g13gufDesjD
         e9QhhN4vg1lzACsZCNXBNdrWaQYmBsIKNKkKA48I8eaqhq0uDi8WeZrh5HsAVTcOO70v
         +fHgRFWNfSrTqERasgW4acz2W9gfRupFsf5Cy0xroHf0656Uivz5SwazGcEFClAjmSH4
         XvSA==
X-Gm-Message-State: AOJu0Yx4fhEpLTf3DzLTCEmB0boc8o6u8eWJGbHthL3bIA3GImL3NmEE
        5qbQOp4puKFlqWXZEpv2sMrphg==
X-Google-Smtp-Source: AGHT+IHFuzosoThYKD/AZNkdK3+DmtTy0iulfjfbmAF8jtEnRCTfTfP3MynNUGectudSMe3tSUQfmQ==
X-Received: by 2002:a05:600c:4a11:b0:402:bcac:5773 with SMTP id c17-20020a05600c4a1100b00402bcac5773mr10099570wmp.38.1694507802214;
        Tue, 12 Sep 2023 01:36:42 -0700 (PDT)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c294a00b003fefaf299b6sm12171135wmd.38.2023.09.12.01.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 01:36:41 -0700 (PDT)
Message-ID: <5bb7dc93-66dd-4b7b-8c2f-89a9b249daae@linaro.org>
Date:   Tue, 12 Sep 2023 10:36:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible and DT bindings
 for Amlogic C3 Reset Controller
Content-Language: en-US, fr
To:     Zelong Dong <Zelong.Dong@amlogic.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kelvin.zhang@amlogic.com
References: <20230719060954.14864-1-zelong.dong@amlogic.com>
 <20230719060954.14864-2-zelong.dong@amlogic.com>
 <f7b72ee90009f6749700a7bd79a3a63786a82a32.camel@pengutronix.de>
 <55cbdbba-39c6-7415-37db-97d2c35412cb@linaro.org>
 <076b59c0-7585-ea98-014c-cd70f92df002@amlogic.com>
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
In-Reply-To: <076b59c0-7585-ea98-014c-cd70f92df002@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/09/2023 08:37, Zelong Dong wrote:
> 在 2023/7/31 17:17, Neil Armstrong 写道:
>> On 28/07/2023 17:49, Philipp Zabel wrote:
>>> On Mi, 2023-07-19 at 14:09 +0800, zelong dong wrote:
>>>> From: Zelong Dong <zelong.dong@amlogic.com>
>>>>
>>>> Add new compatible and DT bindings for Amlogic C3 Reset Controller
>>>>
>>>> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
>>>> ---
>>>>   .../bindings/reset/amlogic,meson-reset.yaml   |   1 +
>>>>   include/dt-bindings/reset/amlogic,c3-reset.h  | 119 ++++++++++++++++++
>>>>   2 files changed, 120 insertions(+)
>>>>   create mode 100644 include/dt-bindings/reset/amlogic,c3-reset.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>> index d3fdee89d4f8..f0c6c0df0ce3 100644
>>>> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>> @@ -18,6 +18,7 @@ properties:
>>>>         - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
>>>>         - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
>>>>         - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
>>>> +      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
>>>>
>>>>     reg:
>>>>       maxItems: 1
>>>> diff --git a/include/dt-bindings/reset/amlogic,c3-reset.h b/include/dt-bindings/reset/amlogic,c3-reset.h
>>>> new file mode 100644
>>>> index 000000000000..d9127863f603
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/reset/amlogic,c3-reset.h
>>>
>>> Given that this is only included by
>>> arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi, should this header be
>>> moved to arch/arm64/boot/dts/amlogic ?
>>
>> Maybe I missed something, but since when should we move bindings headers to arch/xxx/boot/dts/vendor ?
>>
>> Neil
>>
>>>
>>> regards
>>> Philipp
>>
> Hi,
> It's been a while, how will we deal with this patch ?
> Should we let this patch apply first? If Amlogic reset bindings headers need to be moved to arch/xxx/boot/dts/vendor, could we apply it in a separate change?

Please rebase on v6.6-rc1 and resend with all review/ack tags collected.

I still don't understand why the bindings header should go into arch/xxx/boot/dts/vendor.

Neil
