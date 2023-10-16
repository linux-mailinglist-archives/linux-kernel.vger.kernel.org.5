Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331DE7CAB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjJPOdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJPOdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:33:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB8B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:32:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-317c3ac7339so4163364f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697466777; x=1698071577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MirTTMDBF2noGg1AFEV5Zt62GQyR/ng5/Y330ynh3s=;
        b=ZVhLTHNmvvCnlbKyQw7z1zpWq8NqJtZFaqCSVm78GH4TwaBWh3WFJ+Ul08VvznjCmM
         uGisGLIiK9t9buOCwZg3YJsoKZjcGszWrB6p52W4Kv7ZX3Nb2hjHblKc0LzVwreK8RkU
         e/z2mn1Mu50BCeGkI53ls2vPsRptgzYnWotoHynlRla66AllofWCEa7T54h/h1MS3+Yj
         /zR8UzBnl6Yw9evCLqOxyNBCDbeas3aXLI0RFCuXLp1cUK7oniQlhJGdwnjSZZDNHk+D
         leQKQHzdP3zDiA09HoRet99zN9L6/Dl1JgOoSaKvGecslHAM0I5Ct7NhxCQN1MfALOxh
         Q6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697466777; x=1698071577;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5MirTTMDBF2noGg1AFEV5Zt62GQyR/ng5/Y330ynh3s=;
        b=im7Jhjndf8w62r/4h1p+JWpXdS9NE6GPK07cGZyXt6tT9you3OghgKWUTZqtUSFI4E
         pu1kdN+w4urlldDDQRghvKNX/zl83RiTU+/6Y9En7VSHXktIYJ6u/QwHizSNsYt/HfIg
         JypGYPTReM/JdpESI3X4j0HNPncoYo2FUCnBQZQs6OeCTGBxmOankuhV1AIy9i0018OJ
         tpuCCDUkY2IZmofeUAtfe2f1vhjrc24aBj7BhD+96gBLqQVVvGNUT3e/BxlQdiNnETd6
         8sDfq0DKx4wzx5CbADKsPa1bbJBKOdDqEMv4nMM9FZ4+KtXwIm11spN0smnR/9tFBvtd
         i4ag==
X-Gm-Message-State: AOJu0YzUwqAkxtXcGT32axycA+LAiGHWNEyF8JR8gm7WWazpU6YmzKoG
        4fv7QPQrNiBW47GxBAkjR3LVLw==
X-Google-Smtp-Source: AGHT+IFk0Upybw+CNBvkb8f8bHryxWmhv+wiTfTAiv3+xIUVY/TgT74Vle1GgSWRTpx+Q/RrDa+FNg==
X-Received: by 2002:a05:6000:709:b0:32d:b06c:80b2 with SMTP id bs9-20020a056000070900b0032db06c80b2mr3538892wrb.0.1697466776794;
        Mon, 16 Oct 2023 07:32:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b5ab:4a16:fd45:8130? ([2a01:e0a:982:cbb0:b5ab:4a16:fd45:8130])
        by smtp.gmail.com with ESMTPSA id bx7-20020a5d5b07000000b003232f167df5sm1845522wrb.108.2023.10.16.07.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 07:32:56 -0700 (PDT)
Message-ID: <323ff7db-0963-4e63-94e9-551540dd6490@linaro.org>
Date:   Mon, 16 Oct 2023 16:32:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: usb: fsa4480: Add data-lanes property to
 endpoint
Content-Language: en-US, fr
To:     Rob Herring <robh@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20231013-fsa4480-swap-v1-0-b877f62046cc@fairphone.com>
 <20231013-fsa4480-swap-v1-1-b877f62046cc@fairphone.com>
 <20231016142256.GA2754674-robh@kernel.org>
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
In-Reply-To: <20231016142256.GA2754674-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2023 16:22, Rob Herring wrote:
> On Fri, Oct 13, 2023 at 01:38:05PM +0200, Luca Weiss wrote:
>> Allow specifying data-lanes to reverse the SBU muxing orientation where
>> necessary by the hardware design.
> 
> What situation in the hardware design makes this necessary. Please
> describe the problem.
> 
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>   .../devicetree/bindings/usb/fcs,fsa4480.yaml       | 29 +++++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
>> index f6e7a5c1ff0b..86f6d633c2fb 100644
>> --- a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
>> +++ b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
>> @@ -32,10 +32,37 @@ properties:
>>       type: boolean
>>   
>>     port:
>> -    $ref: /schemas/graph.yaml#/properties/port
>> +    $ref: /schemas/graph.yaml#/$defs/port-base
>>       description:
>>         A port node to link the FSA4480 to a TypeC controller for the purpose of
>>         handling altmode muxing and orientation switching.
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      endpoint:
>> +        $ref: /schemas/graph.yaml#/$defs/endpoint-base
>> +        unevaluatedProperties: false
>> +
>> +        properties:
>> +          data-lanes:
>> +            $ref: /schemas/types.yaml#/definitions/uint32-array
>> +            description:
>> +              Specifies how the AUX+/- lines are connected to SBU1/2.
> 
> Doesn't this depend on the connector orientation? Or it is both that and
> the lines can be swapped on the PCB?
> 
> Seems like an abuse of data-lanes which already has a definition which
> is not about swapping + and - differential lanes.

The FSA acts as a mux between DP AUX, Audio lanes on one side and
the USB-C SBU lanes on the other side.
_______          ______
       |          |     |
       |-- HP   --|     |
       |-- MIC  --|     |or
SoC   |          | MUX |-- SBU1 --->  To the USB-C
Codec |-- AUX+ --|     |-- SBU2 --->  connected
       |-- AUX- --|     |
______|          |____ |

The SBU1 & SBU2 are connected to the USB-C connector, and the actual orientation
to the connected devices/cable/whatever is determined by the TPCM and the MUX in
the FSA4480 with be dynamically changed according to the CC1/CC2 detection and PD alt mode.

But on the other side the orientation of the AUX+/AUX- connected to the SoC
is not tied to the USB-C orientation but how it's routed on the PCB.

This describes how the AUX+/AUX- are physically routed to the FSA4480 chip.

Neil

> 
> Rob

