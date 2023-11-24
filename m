Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC00E7F76CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345351AbjKXOpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjKXOph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:45:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94507D60
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:45:43 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32deb2809daso1280166f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700837142; x=1701441942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rlwjJ/KXwyxOs4bJrCX4J/yUIaSw0CZF6vSsHNTewU=;
        b=LA4TZeH2ZekqFR9xp+Ge5LPFqY1KWarHQh6cEOwpHiUSEnHvOBCY1qy7xeH6/RW41Y
         4P7br1STCpb9+maz+9buOMXSCuA9uaxOc3vH9muFU7piQ9GOF+FqoLcMKzkq6GK+XzPL
         JuYP5ijTFReTYGV77f4xfXQWtZTkXcPXBSi4cSGY2bYMgjA3RQoVDkowERuRZYUSmRoF
         iEeD4HSPcJJOROYpIo/pOQUf6hhJ18UDqEy8SE20NG9dS2ShbihCtU5GvLRzBZrbMBUv
         fVDTCRa0sIliFqDOLw41UUc3kbW2SH3gV+HXhbE+E2HUFOZxjzoDO7apcUe6q0X9TMhx
         iqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700837142; x=1701441942;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+rlwjJ/KXwyxOs4bJrCX4J/yUIaSw0CZF6vSsHNTewU=;
        b=TbQ4B8t+32rnxHdim28D+2AuC0P7j0uDooA1wMq9xy7FYXBcLOzhI5RKYdYpCBykMu
         DHZWz44rrIMn80Jt0J6ziA7ljzF5gWLn5+UfPzid4QRb+QcYFVgmeb+qbBN+XFLf1eyJ
         kG7hRMbi8gDtRFdINFkqh9Lcw5GSoRf87nGRghXGqx02pHJpKDaOfJADIKA1fH2ag6Ko
         gNMX2kn6g2i0W5AX0uwm1sQyBZjQUdnF+Sap9L+2N+9TGbereuii94uN2CJyBnmlaSpu
         KmKhsguLVKy44auCuYYQ/RJP/uwH6h4jMf63aAqXX8gx9TBrmeHNsGfNukhF1lkN3SNN
         gctw==
X-Gm-Message-State: AOJu0YyXLoiocvj3q+2aNIDRKcRdidnvm2A3kX+NgHYY79fZzBPZNzcf
        teR1ofnr7ONw+8cf+Pnwx2eKpg==
X-Google-Smtp-Source: AGHT+IGlqE3ztd4VccZrqzlaEyl8+aN4JopsoscrrQaRhl6IxnBq4wdAmomOGsmqb5zRiPTC+v5Seg==
X-Received: by 2002:a05:6000:b4c:b0:332:ca0b:578e with SMTP id dk12-20020a0560000b4c00b00332ca0b578emr2125621wrb.27.1700837141963;
        Fri, 24 Nov 2023 06:45:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4611:6dae:b5a3:b6a4? ([2a01:e0a:982:cbb0:4611:6dae:b5a3:b6a4])
        by smtp.gmail.com with ESMTPSA id i2-20020adffc02000000b00327de0173f6sm4511051wrr.115.2023.11.24.06.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 06:45:41 -0800 (PST)
Message-ID: <5e1479e7-a353-4ccb-93eb-a74efc4bdb17@linaro.org>
Date:   Fri, 24 Nov 2023 15:45:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v9 11/12] DONOTMERGE: arm64: meson: khadas-vim3l: add DSI
 panel
Content-Language: en-US, fr
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        Rob Herring <robh@kernel.org>
References: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
 <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-11-95256ed139e6@linaro.org>
 <bn5tpzvohmgac4m46fruxbi6quja624tm2fefyj7f3ngo3enno@2ueiodd6qxbd>
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
In-Reply-To: <bn5tpzvohmgac4m46fruxbi6quja624tm2fefyj7f3ngo3enno@2ueiodd6qxbd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/11/2023 11:52, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Nov 24, 2023 at 09:41:22AM +0100, Neil Armstrong wrote:
>> This add nodes to support the Khadas TS050 panel on the
>> Khadas VIM3 & VIM3L boards.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi   |  2 +-
>>   arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 74 ++++++++++++++++++++++
>>   .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts    |  2 +-
>>   3 files changed, 76 insertions(+), 2 deletions(-)
> 
> Generally, those kind of patches still have value. Now that we are
> accepting overlays, could this be converted to one and merged maybe?

Yep I was thinking about that, I'll probably do that,
some new boards will also need overlays for DSI panels.

I'll probably switch to an overlay on v10.

Neil

> 
> Maxime

