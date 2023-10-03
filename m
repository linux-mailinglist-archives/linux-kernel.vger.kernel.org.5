Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C067B6250
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbjJCHNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjJCHNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:13:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA19BD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:13:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405505b07dfso22736845e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 00:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696317183; x=1696921983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3V6H7E6MABzUSTnDXLzcRuuIcpD2rL4vp8HMUWli4Q0=;
        b=yoi/kt4HxM2Vv413Jhn5v+7ciYTyti1koX29voNxl6QOj7YircK7KvEDQ4F3rTq5T4
         CVc/Tvm9R2zZnFQH4VPljz8I9IUGo4h5XyjMvpdAQNs1Mij7Ncqrmj7mEGSlbxRyagOA
         vjY6f3T4TKmsc0nfOA+VGbTS/fbDQxTJDiJanqmqOSlS/8Qwm3hRMacwpy8vbRaRDlot
         Er+r8eylP/so7RLMeT2XCz//RGy+tP1P3W5MkT+N/FYEaMf3ix288BKeN1qjgNK8J0yX
         idf9ASsR/u9DQhkLVMfeTXOM8WHCjdUDovGKtiW/bfKyTZW0rL6C9U6J+XNNNepNy7Hg
         pvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696317183; x=1696921983;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3V6H7E6MABzUSTnDXLzcRuuIcpD2rL4vp8HMUWli4Q0=;
        b=RkZRs6QjefPNUS0LAi1nSz1zQ0Kq6wMYs/dPDSEcEEiv8KED0ZIb8i7VYboPG6Q7ku
         9mXti4qiq8t6dW0amH0H+E/mFyyeVUwG8DAo/mj4uqU0wFiEJsq/d15Upv5mjNvyHdAD
         USyGtciAUtNnAHTcQ+Zhaeu+7DONGD/COtNqm1+2daznckYaKKyf1u73fTXk5wVYlzwZ
         DGVIwZEjA6ZCJCUbBVOHXKZOFo6Qdgi79zN0yan5K5CobEKEMnBKMxiUlvULNLhlgt46
         q1uTe5m1LMrjhkPyMjOJ5yyy5AI2CeUdLQDapX3CcihYdExNdhL8jKq54jlRmRSytx/a
         WM2A==
X-Gm-Message-State: AOJu0YzFR3IzTEo9CN4Uh9oH+WsbnW9hqGg3ScQhpRmCbwUHZ2xx/5vd
        QJnoqmtQXVqqxOIbK5Pelurs+Q==
X-Google-Smtp-Source: AGHT+IFojXzmGEY/9CK9lLL0H6XZ+p11DjOHaCyqO/FQBv127Syoxxzgqnh2F0dB/m2WdRetgkj7TQ==
X-Received: by 2002:adf:f643:0:b0:316:fc03:3c66 with SMTP id x3-20020adff643000000b00316fc033c66mr1279236wrp.3.1696317183478;
        Tue, 03 Oct 2023 00:13:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858? ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
        by smtp.gmail.com with ESMTPSA id o16-20020adfead0000000b003266ece0fe2sm832373wrn.98.2023.10.03.00.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 00:13:02 -0700 (PDT)
Message-ID: <a30c60f0-1710-405a-bb18-813ce30d975b@linaro.org>
Date:   Tue, 3 Oct 2023 09:13:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/4] usb: ucsi: glink: use the connector orientation
 GPIO to provide switch events
Content-Language: en-US, fr
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20231002-topic-sm8550-upstream-type-c-orientation-v2-0-125410d3ff95@linaro.org>
 <20231002-topic-sm8550-upstream-type-c-orientation-v2-2-125410d3ff95@linaro.org>
 <CAA8EJpp2_eW+YukTq3eAFGXxtZ+YWYVkzEP9Qhs20TxoXy-v7A@mail.gmail.com>
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
In-Reply-To: <CAA8EJpp2_eW+YukTq3eAFGXxtZ+YWYVkzEP9Qhs20TxoXy-v7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2023 19:26, Dmitry Baryshkov wrote:
> On Mon, 2 Oct 2023 at 13:21, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> On SM8550, the non-altmode orientation is not given anymore within
>> altmode events, even with USB SVIDs events.
>>
>> On the other side, the Type-C connector orientation is correctly
>> reported by a signal from the PMIC.
>>
>> Take this gpio signal when we detect some Type-C port activity
>> to notify any Type-C switches tied to the Type-C port connectors.
> 
> Have you checked, which UCSI version is implemented on SM8550?
> Is there any chance of GET_CONNECTOR_STATUS / bit 86 actually
> reflecting the correct orientation?

I checked, and no, the UCSI implementation is based on the UCSI 1.x spec,
and doesn't have the UCSI 2.x new bits.

Neil

> 
>>
>> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> 
> 

