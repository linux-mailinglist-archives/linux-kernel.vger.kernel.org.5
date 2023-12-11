Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ABB80C3F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjLKJKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjLKJKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:10:21 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7BD100
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:10:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso17365535e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702285825; x=1702890625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1hHdtNOUKQtimSKcn02EUH8wMvcC3cjPEPTtQNRnlQ=;
        b=otgh9Sgeq6dYI5vXeUk1tGyj+R+yIbu1K/5gF8gbdpg+ReleRo+VoxO+aRmWHFc2Lc
         i0tkU3juHpCfOIzIwzCQ+SevYKC096RG5PzWOLnaee5LETNXBd/FdP2B8Brzfr1L2H/P
         be4pXnU97902b33X3s0uJEdKn4MwL6+5hbnpGjpssq4L+WwklQeT0JqflPssKHGXV6lq
         CYexZ5r2XvLvcVxfmkz4AkrrDnQVcnqgjkiVp8+Wxy0XKBfm4mqkovMU2ynZptnZPhoL
         CtIDWZl2QIdMYF67DOwtanb8jcvVuLh6wPT4G03j9xDhF5Qf1reT5FNdt9J3UWwQPfnG
         kmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285825; x=1702890625;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e1hHdtNOUKQtimSKcn02EUH8wMvcC3cjPEPTtQNRnlQ=;
        b=ntsMMA/nh5RgMORuR79lucAPwS9zi3GUsdYPL+7g85Nwxy8XCNqiVUjvX79y30K/kG
         zRvvVUYTNv6NMiQyli5MJuiAAXAFDWpVeHZbN+RxhzO22odPeJN627x7+QJMUuuuqDWm
         DY+56wq3Q/R3lvLafNqRR1CEJjbxqVbndshSLHjXqNxOHIX98A5XltyvadJL+LEh5rJB
         gRBTN8nD/6gTF5ERJtXlrinGWrEUU3CMxgdVB2E55RlYKr/ww+JyuQ/boZo7D+NKOr6P
         HpwF5jlcOpw1hFHkR5TTQYFVdoXb9GFMyWbU7xqsCgUZ8UnfnoxURN6W5KiqFiJbt2u4
         qPpg==
X-Gm-Message-State: AOJu0Yx8ttpZPxVYajYXURANstwb8R+aee6hWb6CewV5DEMGBcHz8bkH
        2NQzp0Jvm0EQ4EQNaWo57Tgr+/VLX1w/KR2jzipCXWEW
X-Google-Smtp-Source: AGHT+IH64u4s+nNS2hEACtXPcIntf1k/WlEVOEsxu7iP8inZ9hFuymODeAPuiTftKfdWL40tXRirWQ==
X-Received: by 2002:a05:600c:3411:b0:409:79df:7f9c with SMTP id y17-20020a05600c341100b0040979df7f9cmr2584703wmp.36.1702285824976;
        Mon, 11 Dec 2023 01:10:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:302e:e0c2:d42c:cb23? ([2a01:e0a:982:cbb0:302e:e0c2:d42c:cb23])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040c440f9393sm4627069wmq.42.2023.12.11.01.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 01:10:24 -0800 (PST)
Message-ID: <449d675f-e98c-4924-ab81-14a139081a97@linaro.org>
Date:   Mon, 11 Dec 2023 10:10:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <4150bf8e-a48d-4d16-902f-a95f6489c6f5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/11/2023 10:49, Krzysztof Kozlowski wrote:
> On 24/11/2023 10:47, Krzysztof Kozlowski wrote:
>> The DTS code coding style expects exactly one space before and after '='
>> sign.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> 
> Please ignore, that's duplicated of my previous send.

I don't see a previous send, so I'm confused.
I can apply this patch if you're ok.

Thanks,
Neil

> 
> Best regards,
> Krzysztof
> 

