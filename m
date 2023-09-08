Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D3479874A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243278AbjIHMqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjIHMqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:46:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A81FC0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:45:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4018af103bcso13103975e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694177154; x=1694781954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYX11k0FRo9C71kWAlZsFSHlpklxSuOAfDFjS017gR4=;
        b=o4VKzK6/EoEe/I3BcW0Pmgjql1x+wMHse+s1StMCdCgtlpCjAw6sFn1Qpsnxcj9SEy
         RAYshCU9G+vEvsQ08bxK70015BZrRBg6fEDXq0zHEkl76GZoqT6iE087FJHZqhsJms35
         PbsOZpQSK9+eJEXL/xejk+hbwOj7eNjP5FxGfdbqwthTJm7E3bxZ2elEBAJbEofm4c3R
         brf3LE0+TXXaemMmb4+ccWBO7J6mEX9wuVehWo6ACEdpTKb8XfYddCJrpigSJdcIyZ8X
         3NuAEL/TP1UE/NUJ6nVwWz5+oFvlUMxa5el2J8U+Y8cIEzkiqJNV7dHquyZSBIEFMwEd
         fXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694177154; x=1694781954;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qYX11k0FRo9C71kWAlZsFSHlpklxSuOAfDFjS017gR4=;
        b=RtpEByJcTPfPkiYKESxamq/LwvcVzjWRWiUlFtwbI7CqAErWXK3LyIRsgsxRyVQZby
         kU+tw1XwhwqLoK90RntiYEaEzYduhcPToGI298cxn8wDSDKX/Thg8BWdmD17jUb4V8xj
         KqefENp75VViewjDumXy0dsEcgmCmkfrC7PfbxZkbmd3yTuMQOR7GLHLQoC7SSewslqM
         Nup7vNhDmmWMLPUTTUK5mMlLWvpVtNkyvVNXBr4F64qCC1Ol+VwRr8qmOmA8vSwx4ATP
         F2VoL9QJVo/A/faY07o90djEFLcfEIARgYOhdBpf+zpaNGEe+ICxrtUGO8v1ATqS9Hpf
         47Yw==
X-Gm-Message-State: AOJu0Yxt6Bz2FR5Bm1h/0SLqFXX3gwlqxF+pe3lv1gicYn814l7uIa+Z
        YFtNOX6j5Pl8OgALNHhh0bV8nQ==
X-Google-Smtp-Source: AGHT+IGHePJhFFJiEaa1GGpoPTB7/fI52CufaQApdzeN8l1+CLj6k0KAU+tqTR8boxgF7HkxVuJzpQ==
X-Received: by 2002:a05:600c:a386:b0:400:5962:6aa9 with SMTP id hn6-20020a05600ca38600b0040059626aa9mr4360296wmb.11.1694177154279;
        Fri, 08 Sep 2023 05:45:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5f1a:ed04:d131:cda4? ([2a01:e0a:982:cbb0:5f1a:ed04:d131:cda4])
        by smtp.gmail.com with ESMTPSA id t15-20020a7bc3cf000000b00402be2666bcsm5188357wmj.6.2023.09.08.05.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 05:45:53 -0700 (PDT)
Message-ID: <4303c141-30df-4a2b-aba7-f11a98db9941@linaro.org>
Date:   Fri, 8 Sep 2023 14:45:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V3 0/6] Power: T7: add power domain driver
Content-Language: en-US, fr
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org
References: <20230829020404.4058677-1-xianwei.zhao@amlogic.com>
 <82001107-3e72-4cc7-b7d4-8ca1a840b508@linaro.org>
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
In-Reply-To: <82001107-3e72-4cc7-b7d4-8ca1a840b508@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2023 14:40, Neil Armstrong wrote:
> Hi,
> 
> On 29/08/2023 04:03, Xianwei Zhao wrote:
>> First patch is that remove C3 some power domain ALWAYS_ON property.
>> Second patch is that add driver to support power parent node.
>> Third patch is that turn on power if initial power domain with
>> "AWAY_ON" property state is off.
>>
>> Other patchs adds power controller driver support for Amlogic T7 SoC.
> 
> Please re-send to Ulf Hansson <ulf.hansson@linaro.org> and
> linux-pm@vger.kernel.org since this driver has moved to the
> GENERIC PM DOMAIN PROVIDERS subsystem.
> 
> I'll take the DT patch since bindings patch was reviewed.

In fact I'll need Ulf to provide me an immutable branch or tag with
the bindings in order for me to apply the DT patch.

Neil

> 
> Thanks,
> Neil
> 
>>
>> Changes Since v2:
>>   -Modify subject.
>>   -Define PWRC_NO_PARENT UINT_MAX
>>   -Remove modification that transform is_off into 1 or 0 using !!
>>
>> Changes Since v1:
>>   -Fix license from "GPL-2.0-only OR .*" to "GPL-2.0-only OR MIT".
>>   -Modify T7_NIC flag  "ALWAYS_ON"
>>
>> xianwei.zhao (6):
>>    genpd: amlogic: modify some power domains property
>>    genpd: amlogic: add driver to support power parent node
>>    genpd: amlogic: init power domain state
>>    dt-bindings: power: add Amlogic T7 power domains
>>    genpd: amlogic: Add support for T7 power domains controller
>>    arm64: dts: amlogic: t7: add power domain controller node
>>
>>   .../power/amlogic,meson-sec-pwrc.yaml         |   3 +-
>>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   |   6 +
>>   drivers/genpd/amlogic/meson-secure-pwrc.c     | 127 ++++++++++++++++--
>>   include/dt-bindings/power/amlogic,t7-pwrc.h   |  63 +++++++++
>>   4 files changed, 185 insertions(+), 14 deletions(-)
>>   create mode 100644 include/dt-bindings/power/amlogic,t7-pwrc.h
>>
>>
>> base-commit: 413f5c02929bb33042bbc4ee233166550a5fca70
> 

