Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD5798730
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242972AbjIHMkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbjIHMkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:40:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6FE1BF5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:40:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso20766175e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694176812; x=1694781612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AU2+QV4aODXtVs7q5YHeaRMbqDNd55USgbN27DWq/do=;
        b=vD/tOaFEYAEvFksnWJlFuD7XEM7Wr5Cq1Y4UbrPDVKBr8gFWS1zssmRfJWZKrxV7BJ
         1mxf3KbdkPhDFS4Sq2MauVhBeJhlcKs3GGWQADOGmYgGOggyrPWdZ6X4KBAgGhn+Wvla
         BlsCr5MRVNpnWslVGSAWNw0bhm+Yb8vb2HNDlGCmXYSQ3pGoB3OSQyZaD2vbtHmymNPL
         Ii2eBPrFWAQxBAy7QZj59vMrcU0yZm+P2nWb8i7CkKZMeTATGxzkVRGQL4VoVePajnRI
         MXD+dqZ+Hx5AEXtIIK0q7Br5O0wzkzv5lnaBig5SuuaZ2pR+y/Qa/iWy7v0f4rqVoUvy
         Q8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694176812; x=1694781612;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AU2+QV4aODXtVs7q5YHeaRMbqDNd55USgbN27DWq/do=;
        b=YE+JjpHN1lUBizqLpic+OWTKsRlyqtYM73/RZ2eJnWWovHvtnuxIeigWT0DnMObm0a
         rdktOkgY8ag6RMaPPSynPk3DIfYBhZq/NTiXSOW4UHMIBEp62goaVPbfktmIrRJEyy0D
         yFL4QYdqVfqa95fBvvLEAMDMJt96nGrmkEGufmwiWhwbeWs4PyXo+O9Y/uTteaSLrcGG
         tVKikDFVCAX50G5VGHqzsmakE32pWUHH8zCcmGHzRVkRDvOUL9NJt6FhFEKJIxrq/0h9
         nISbaXSfqg940trFVORGFnl6I409qiPIkc09XkIpqA4QbCcoZGfrm1EbpPVeuoJaRo4b
         mJOg==
X-Gm-Message-State: AOJu0Ywjw6iAxSL35GLTz/yQZxV35Xy73siw5Dwm1akAWlogU6LWGMDT
        Ay+yzfwkrqwi+ezq30JKNz46IA==
X-Google-Smtp-Source: AGHT+IEn1A3t/Z31ElsOIiIsqnkGtN+Eg1q91yWkXBCHpOTFYwJBqaz03nsf2vXzeiEMpEAs1KYQ7A==
X-Received: by 2002:adf:e54e:0:b0:31d:db2d:27c6 with SMTP id z14-20020adfe54e000000b0031ddb2d27c6mr4534802wrm.30.1694176811908;
        Fri, 08 Sep 2023 05:40:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5f1a:ed04:d131:cda4? ([2a01:e0a:982:cbb0:5f1a:ed04:d131:cda4])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b0031c6581d55esm1988726wrp.91.2023.09.08.05.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 05:40:11 -0700 (PDT)
Message-ID: <82001107-3e72-4cc7-b7d4-8ca1a840b508@linaro.org>
Date:   Fri, 8 Sep 2023 14:40:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V3 0/6] Power: T7: add power domain driver
Content-Language: en-US, fr
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org
References: <20230829020404.4058677-1-xianwei.zhao@amlogic.com>
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
In-Reply-To: <20230829020404.4058677-1-xianwei.zhao@amlogic.com>
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

Hi,

On 29/08/2023 04:03, Xianwei Zhao wrote:
> First patch is that remove C3 some power domain ALWAYS_ON property.
> Second patch is that add driver to support power parent node.
> Third patch is that turn on power if initial power domain with
> "AWAY_ON" property state is off.
> 
> Other patchs adds power controller driver support for Amlogic T7 SoC.

Please re-send to Ulf Hansson <ulf.hansson@linaro.org> and
linux-pm@vger.kernel.org since this driver has moved to the
GENERIC PM DOMAIN PROVIDERS subsystem.

I'll take the DT patch since bindings patch was reviewed.

Thanks,
Neil

> 
> Changes Since v2:
>   -Modify subject.
>   -Define PWRC_NO_PARENT UINT_MAX
>   -Remove modification that transform is_off into 1 or 0 using !!
> 
> Changes Since v1:
>   -Fix license from "GPL-2.0-only OR .*" to "GPL-2.0-only OR MIT".
>   -Modify T7_NIC flag  "ALWAYS_ON"
> 
> xianwei.zhao (6):
>    genpd: amlogic: modify some power domains property
>    genpd: amlogic: add driver to support power parent node
>    genpd: amlogic: init power domain state
>    dt-bindings: power: add Amlogic T7 power domains
>    genpd: amlogic: Add support for T7 power domains controller
>    arm64: dts: amlogic: t7: add power domain controller node
> 
>   .../power/amlogic,meson-sec-pwrc.yaml         |   3 +-
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   |   6 +
>   drivers/genpd/amlogic/meson-secure-pwrc.c     | 127 ++++++++++++++++--
>   include/dt-bindings/power/amlogic,t7-pwrc.h   |  63 +++++++++
>   4 files changed, 185 insertions(+), 14 deletions(-)
>   create mode 100644 include/dt-bindings/power/amlogic,t7-pwrc.h
> 
> 
> base-commit: 413f5c02929bb33042bbc4ee233166550a5fca70

