Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C880EFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376621AbjLLPRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376469AbjLLPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:17:18 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152CBD3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:17:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-33634d2e059so447858f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702394241; x=1702999041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8YuKmgtjcOo5ghSsyfWGTGiBzdewmSb7QQyN9+lne4=;
        b=VWtSpChT4CAzvi+8IapwWjexgKlzGo1mAGJM2Yhbv0aMXIbW7VL05LRg5mGSb1G7ZT
         ZRF1/dcCPWz8qAxzSe3BnE2QF//4sw1dkQPvM9SiQ+JhuX161EYnS+MgyHC/fISDMrrG
         CqS6h/JyhqENKYj7qk1NpueASMwlNdKuX4bkdvMvODrubxm8hvDD7U4YohTm/iwskAX2
         6Ox/nqRQoWW/yh0LmjuTtKqt5r8m0JVdl1RJMrJ3mOlbGNiYsmv8DXdFMsI1evGAwyjA
         0DJUFvSYW4HpbFy8RmjFxwE+yCXsio3WiKNvqpzsjIG8acC6273DzYzRNRC/Fhg3LYCs
         q4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394241; x=1702999041;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W8YuKmgtjcOo5ghSsyfWGTGiBzdewmSb7QQyN9+lne4=;
        b=SPq/K4ZxHSC9P3TAQ9Uofkp4spK9wt15SJoYhc7XW82RSmXIvcnbWe7dPn3gsuPLjd
         3dj+WoNIBgKvBfOvYB1Dqf11aRg98yR2h5OV7qS1dtGDJgzWt+cHUDTLCQ4KJFKV5/cJ
         GBUVxRgfSnYOcnAmgOJKgyVKCkbmfiO4zOfSBrl0d8kl6U2IQRrkd08YMTT55DwMpdnS
         LlrFjKsFRxQNwRsST1BW5PtUnrIGFgW3B41ioPaiVmrSzgPbolNRizQwsuPSTBMnrc8J
         7wNoNg2l9MbQzxhF44AlC5Dzd1koabYoqpnXJ71u0w8D27h98SRBwXCGp5Ql8GxQ/BJP
         PAwA==
X-Gm-Message-State: AOJu0Yw7UKfD1hejcy9YWVxtRHSCQH9rPBfSWyBYDzrFO0HuSWmRDJX1
        6U7Tc/jB1QFdLEbyWOQqUUmT2Q==
X-Google-Smtp-Source: AGHT+IGGsq3xnVRIoTD3L1WHLVjpSAuvhAyQXkd/+6NTYT40CZdtbcnUujNBOFj/p2R76gvXkJc/SA==
X-Received: by 2002:a05:600c:230f:b0:40b:5e59:c576 with SMTP id 15-20020a05600c230f00b0040b5e59c576mr3447915wmo.160.1702394241409;
        Tue, 12 Dec 2023 07:17:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5894:fa62:26b4:bf82? ([2a01:e0a:982:cbb0:5894:fa62:26b4:bf82])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d4c4a000000b003333abf3edfsm11015556wrt.47.2023.12.12.07.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 07:17:21 -0800 (PST)
Message-ID: <1de67bcb-1287-4082-b90a-5c68c8bb9aa6@linaro.org>
Date:   Tue, 12 Dec 2023 16:17:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v12 2/4] Input: add core support for Goodix Berlin
 Touchscreen IC
Content-Language: en-US, fr
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231209-topic-goodix-berlin-upstream-initial-v12-0-eaffaeb53fb5@linaro.org>
 <20231209-topic-goodix-berlin-upstream-initial-v12-2-eaffaeb53fb5@linaro.org>
 <ZXVgYuzE6jPPSfnZ@google.com>
 <be39f74b-e04f-48c8-acc9-cc818adfc4db@linaro.org>
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
In-Reply-To: <be39f74b-e04f-48c8-acc9-cc818adfc4db@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 15:43, Neil Armstrong wrote:
> Hi Dmitry,
> 
> On 10/12/2023 07:53, Dmitry Torokhov wrote:
>> Hi Neil,
>>
>> On Sat, Dec 09, 2023 at 08:33:40AM +0100, Neil Armstrong wrote:
>>> Add initial support for the new Goodix "Berlin" touchscreen ICs.
>>>
>>> These touchscreen ICs support SPI, I2C and I3C interface, up to
>>> 10 finger touch, stylus and gestures events.
>>>
>>> This initial driver is derived from the Goodix goodix_ts_berlin
>>> available at [1] and [2] and only supports the GT9916 IC
>>> present on the Qualcomm SM8550 MTP & QRD touch panel.
>>>
>>> The current implementation only supports BerlinD, aka GT9916.
>>>
>>> Support for advanced features like:
>>> - Firmware & config update
>>> - Stylus events
>>> - Gestures events
>>> - Previous revisions support (BerlinA or BerlinB)
>>> is not included in current version.
>>>
>>> The current support will work with currently flashed firmware
>>> and config, and bail out if firmware or config aren't flashed yet.
>>>
>>> [1] https://github.com/goodix/goodix_ts_berlin
>>> [2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers
>>>
>>> Reviewed-by: Jeff LaBundy <jeff@labundy.com>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> Thank you for resending the patch. I think there is an issue in how you
>> read and parse the data in case of more than 2 fingers. It looks like in
>> that case you are overwriting the checksum form the first 2 and then not
>> reading the new checksum but use some garbage past the touch data. I
>> might be mistaken though...
> 
> I carefully inspected the code again, and it's correct, otherwise I would have experimented
> checksum errors, which isn't the case.
> 
> First read from goodix_berlin_irq() is GOODIX_BERLIN_IRQ_READ_LEN(2) length in memory:
> 
> [GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN][GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE][GOODIX_BERLIN_BYTES_PER_POINT * x]
> 
> the pre_buf_len goodix_berlin_touch_handler() get is GOODIX_BERLIN_IRQ_READ_LEN(2), the we complete the
> read after the first read, but since the touch checksum is before the touch data, it works because
> we complete the data.
> 
> I added some comments to clarify the memory layout and re-ordered the items
> in the GOODIX_BERLIN_IRQ_READ_LEN() macro to show GOODIX_BERLIN_COOR_DATA_CHECKSUM
> is before the GOODIX_BERLIN_BYTES_PER_POINT data.

Ok I was wrong, the checksun is at the end, but since we check the checksum _after_
reading the missing fingers, the checksum gets read correctly and is always valid.

The first checksum check is for the header, not the finger data, so it may be
confusing.

I've added a big comment explaining what's done and how the finger data is complete
and where is the finger data checksum is all cases.

Neil

> 
>>
>> I also believe you are leaking afe_data in case of success. We have the
>> newfangled __free(kfree) from cleanup.h that should help there.
> 
> Indeed it was leaking.
> 
>>
>> Another request - we should not have anything in goodix_berlin.h that is
>> not used by the I2C and SPI sub-drivers, so the only thing it should
>> contain is goodix_berlin_probe() declaration and dev_pm_ops. All other
>> defines and definitions should go to goodix_berlin_core.h.
>>
>> I made a few more cosmetic changes in the attached patch, please
>> consider applying it.
>>
>> Thanks.
> 
> Thanks,
> Neil
> 

