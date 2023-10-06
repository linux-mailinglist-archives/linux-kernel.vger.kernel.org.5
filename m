Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784D97BB19A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjJFGjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjJFGjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:39:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3471CCA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 23:39:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-503f39d3236so2198755e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 23:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696574352; x=1697179152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/Oe20eq5hm/+Em5p9d3iI+mb2ITB6meerwxw35smVY=;
        b=bKUhhjIZ3JvKQ6ynZei8EwOLUguXajBjKNTXfmPXMWk/SwDP/3fxYWSi+CnZhn4GaS
         hnBoZ8AJB2OzHylMSnHUhNjIeU9C5aKyNuiqI4JmplwfHG6ztrbO/EJoVDTuvEszF4Mu
         xIMRib0jxKPXxmIBgAwkEXvtaYRuA9ZIHHu5Mg1LmXXvkHIhZKMo0XJ5o6ruaEYB+5bX
         1mRmVQQWWrA3UZNeJ23BaBpvp8Irh3zbxEKfq233S4S9jdAb4lwfoc98FLPAcnPoZJdk
         V/jSV4tcyYlbl0P3MPnck24KEfgVfy9z1J8UrPdNlyhbLFLIsn1LU57VlBZuWg107H/p
         skbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696574352; x=1697179152;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W/Oe20eq5hm/+Em5p9d3iI+mb2ITB6meerwxw35smVY=;
        b=MM7b6o0PMza0uJ51QX2gHwxdhENpq/jSWSRBwuCLzap74AB5I/8urZ+m9gOPIxZQ7j
         jp1KaIkIlvSuokdOIDVtDV/RrlFaXIw/qtylTKUNgg6xoxwMArEj3/wZifjqP86ogcxY
         5NKcSooHA0OVtVd5qJT6rxZq9vlUQKRL2qtonByTKLARm3VNoZkFIhmPrLFXjVYvOmWC
         +WX5Zo7PcEIS0UAB0JunvNVUzsstdlukvQxSxlywnqRHSjD6MAa6kmt0zPUqcrgEFOGe
         abqT+1zUMJSkRBYrdyRRrjaAIDyPb6a5eSr0+aV8k907FGYH0eo0YGt+L90WitnHMUbz
         LD9g==
X-Gm-Message-State: AOJu0Yz7faVKsyDRdz+x2obCft77Ajaa9DMu7yH+LErNkKhHMWyMuHtc
        c10fLxFe3ciAM/Us02lL+ZCs7w==
X-Google-Smtp-Source: AGHT+IGDgHi+Dqi7dzq19URpX2w0CDyuB/8q2REgQRlKgwGayqgeuRpXDzX5nux46VGVeMRQQgdWjw==
X-Received: by 2002:ac2:43cf:0:b0:503:655:12e0 with SMTP id u15-20020ac243cf000000b00503065512e0mr5995373lfl.50.1696574352377;
        Thu, 05 Oct 2023 23:39:12 -0700 (PDT)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c211400b0040642a1df1csm3042793wml.25.2023.10.05.23.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 23:39:11 -0700 (PDT)
Message-ID: <bbca1c2f-2b7e-4132-a23e-12bd41abfec5@linaro.org>
Date:   Fri, 6 Oct 2023 08:39:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 0/2] arm64: dts: meson-a1-ad402: Add SPIFC pins
Content-Language: en-US, fr
To:     Igor Prusov <ivprusov@salutedevices.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     prusovigor@gmail.com, kernel@sberdevices.ru,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231005195543.380273-1-ivprusov@salutedevices.com>
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
In-Reply-To: <20231005195543.380273-1-ivprusov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2023 21:55, Igor Prusov wrote:
> This series adds SPIFC pins description to A1 pinctrl node and selects
> them in AD402's SPIFC node to make sure that muxed GPIO is properly
> configured.
> 
> Igor Prusov (2):
>    arm64: dts: meson: a1: Add SPIFC mux pins
>    arm64: dts: meson-a1-ad402: set SPIFC pins
> 
>   arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts |  2 ++
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi      | 12 ++++++++++++
>   2 files changed, 14 insertions(+)
> 

For the 2 patches:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
