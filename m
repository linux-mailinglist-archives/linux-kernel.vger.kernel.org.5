Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098A079B8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376898AbjIKWUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbjIKPEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:04:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E041B9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:04:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31c93d2a24fso4148901f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694444656; x=1695049456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBeRh4UL/KjS7sOnQvt2RLKcnJLFWHs8He3ceHHUyU0=;
        b=X6YKUbz9eShgTaUdXkXLxjjcPO3m11GYoXrOpfx+18wE2JsTQ2m13hQ0HTA3VeGJxN
         2k03hcCUOpgODK9KkqeV4Ol9NR//An0J/rvNrR7OcEDB8PgxV9x6Jg5ZAs0ZeWYkJIZF
         ZozmBOm8KU1+H9Vy5FCDYpO/Cor8EskhlDTH2UEq5usFvQk5QyPvvWGt/2i8e0AVlzsu
         TUWsGc9oyS/I5achrCiI24CD0KTgd+5aygm83blZBU+3P1Kvdyd/8p5BCOfeFWanqewQ
         XEnwJT/Lf2V/gELmLrribLLBmj4oW2tbYeLUoKLmZ9ow6lTpCzl2b7XfOXBrn5NB4LUD
         25UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444656; x=1695049456;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CBeRh4UL/KjS7sOnQvt2RLKcnJLFWHs8He3ceHHUyU0=;
        b=ExzfuXoNTet7vYkqclnl3GCGFcNKjXG2aRFk/lGN7Caw6VOWlDmaGYQc1MW9i8ci/Q
         o7TisE+4PqzD3RJJqSdotl0y3dhE8fMhklteCzrVL66Hr042a0VraKutpghYSLQGoZjv
         oBOhikPvH5KmQU/K79pT05nCXs6nOwMXrwZGNwr605CI+KNg+cOOXp3FQLJycSFpqloE
         NX8cmP4n1q48BbOupnLh+faknui+25tbXCMBflAtSfoMfW8lWEMUTly2qhP4A72muHBH
         0nz2iLtJXbkIHyxDxPk2ZmhO0CZZ0Zr+jB3C89/xQWQufvUDZyxk1cxhJl1aPdEKYPD8
         yHDQ==
X-Gm-Message-State: AOJu0Yzx1baRKNgz08HdMHCPWsak9WS6nTIuhblX+cQ251Stm4NpowiQ
        5DgMXTCryBYY9wGIZxNs9hQGlg==
X-Google-Smtp-Source: AGHT+IGzf5knanit7yknaBtEN0yONkhWmeBMadtWqyiRi3ZNLweDWoCrSEkgQfEZQMEz4SIdHEfD0w==
X-Received: by 2002:adf:ce0b:0:b0:319:68ce:2c53 with SMTP id p11-20020adfce0b000000b0031968ce2c53mr9380153wrn.25.1694444655591;
        Mon, 11 Sep 2023 08:04:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:daaa:8bc3:eeb7:ce8? ([2a01:e0a:982:cbb0:daaa:8bc3:eeb7:ce8])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d4809000000b0031c6e1ea4c7sm10249933wrq.90.2023.09.11.08.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 08:04:14 -0700 (PDT)
Message-ID: <d4db98ca-85b7-4e3a-a40c-43c37e1de6e0@linaro.org>
Date:   Mon, 11 Sep 2023 17:04:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V3 RESEND 0/6] Power: T7: add power domain driver
Content-Language: en-US, fr
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230911025223.3433776-1-xianwei.zhao@amlogic.com>
 <CAPDyKFqTs=mRnBRREbT+WFj_4qTLd8LTKigY_1TAZOqGGUKk3A@mail.gmail.com>
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
In-Reply-To: <CAPDyKFqTs=mRnBRREbT+WFj_4qTLd8LTKigY_1TAZOqGGUKk3A@mail.gmail.com>
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

On 11/09/2023 16:30, Ulf Hansson wrote:
> On Mon, 11 Sept 2023 at 04:52, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>>
>> First patch is that remove C3 some power domain ALWAYS_ON property.
>> Second patch is that add driver to support power parent node.
>> Third patch is that turn on power if initial power domain with
>> "AWAY_ON" property state is off.
>>
>> Other patchs adds power controller driver support for Amlogic T7 SoC.
>>
>> Changes Since v2:
>>   -Modify subject.
>>   -Define PWRC_NO_PARENT UINT_MAX
>>   -Remove modification that transform is_off into 1 or 0 using !!
>>
>> Changes Since v1:
>>   -Fix license from "GPL-2.0-only OR .*" to "GPL-2.0-only OR MIT".
>>   -Modify T7_NIC flag  "ALWAYS_ON"
>>
>> xianwei.zhao (6):
>>    genpd: amlogic: modify some power domains property
>>    genpd: amlogic: add driver to support power parent node
>>    genpd: amlogic: init power domain state
>>    dt-bindings: power: add Amlogic T7 power domains
>>    genpd: amlogic: Add support for T7 power domains controller
>>    arm64: dts: amlogic: t7: add power domain controller node
>>
>>   .../power/amlogic,meson-sec-pwrc.yaml         |   3 +-
>>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   |   6 +
>>   drivers/genpd/amlogic/meson-secure-pwrc.c     | 127 ++++++++++++++++--
>>   include/dt-bindings/power/amlogic,t7-pwrc.h   |  63 +++++++++
>>   4 files changed, 185 insertions(+), 14 deletions(-)
>>   create mode 100644 include/dt-bindings/power/amlogic,t7-pwrc.h
>>
>>
>> base-commit: 413f5c02929bb33042bbc4ee233166550a5fca70
>> --
>> 2.37.1
>>
> 
> Patch 1 to 5, applied for next!
> 
> The DT patch (patch4), is available on an immutable branch "genpd_dt" too.
> 
>  From now on, I will continue to put changes for genpd DT bindings on
> the above branch, to allow SoC maintainers to pull it in to manage
> potential dependent updates to DTS files.

Thanks, let's see how it works :-)

Neil

> 
> Kind regards
> Uffe

