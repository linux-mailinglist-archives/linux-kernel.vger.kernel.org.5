Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B53878AF72
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjH1MC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjH1MCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:02:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03423125
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:02:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so2539697f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693224122; x=1693828922;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4LOFGk83zQX2KrDyKlNIv7kPex2iroC/9McWaOOjU0=;
        b=ZXr8y21bnezTCJzPWE7dly1U/ZSIStQt3th/zy5ZBa3oUkT+oFgZhVpS1QSt+hkJCP
         RtkHcTyv5pH383Kgx3uCouF6cmpzVgAT0YpJWQuuJL0eRE47UzLmHsNn+kL2kb170i9l
         JHAz2SFf9vvbuVI6D42t+LHOvwVprfAodOm5jY04vZQwcabP+MiCSCXyhg/e65zO9sho
         VvxQ6980Uk78nDBFtUorU3hQS8V3Ek1YtUvFrRVI2ufcW9EOJOrUCZD2DsATKLno6lmF
         WFgzoBxgxsuyz98o9tMugTGkXCHFmL2iSew6IndX3UVnRdOBNsJKzlk/Xa6qLgkXpvHr
         a51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693224122; x=1693828922;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G4LOFGk83zQX2KrDyKlNIv7kPex2iroC/9McWaOOjU0=;
        b=VPrg42iLY6xXHzpd3mGLD1EpMy/wZN+38TmX+BUTm6vZX/nRfZnI/RFrrMrI9DTIAX
         sXwFhioIBFx3hvxaD5KN+uDLX6xq2C7j400MvtrmTjfzgzYGAnWKij00pJFYO+OhsZrZ
         G0k4hnt6qb96T15Cvi7TEZxl62NSI7KHXcIQdBtHndTP9vcC4TNKcAa0OPrBdIiZPnYp
         bM5Txzo7HPLSbEtL8Ak4sAFRNNVHR97BsCDc/OMLm39SVH5BvU/1weebG03hQJm4Jad0
         fxbQbzaKYYh9dBZB/l2LSokcLgPqo3ku/xo9VvJ6D1IxcA9IgO2SKTxKz80yLRS5csg7
         jerA==
X-Gm-Message-State: AOJu0YwFtWJVsHyibo6X4q8IpW2QiRpINEo1Ar5aopc+mdQ7lG5+LBqy
        kxgrEbz8/fTN/hlEXDp80QON4A==
X-Google-Smtp-Source: AGHT+IENVciCxp3fUi00y/5js/oyS7KUS1Q7KDVmD/4Q2caHzdsynkrA78S8StsnqqQ3IH0sPtEBuw==
X-Received: by 2002:adf:ec48:0:b0:314:2e95:1ec9 with SMTP id w8-20020adfec48000000b003142e951ec9mr18493673wrn.10.1693224122279;
        Mon, 28 Aug 2023 05:02:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5e59:c27b:747a:3f52? ([2a01:e0a:982:cbb0:5e59:c27b:747a:3f52])
        by smtp.gmail.com with ESMTPSA id l11-20020adff48b000000b0031c3ee933b5sm10323520wro.108.2023.08.28.05.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 05:02:01 -0700 (PDT)
Message-ID: <b9972273-97c7-4b70-833d-c4842cd612d5@linaro.org>
Date:   Mon, 28 Aug 2023 14:02:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] irqchip/qcom-pdc: don't read version register if it
 is not available
Content-Language: en-US, fr
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825213552.1646321-1-dmitry.baryshkov@linaro.org>
 <09d89b1c-8c78-7671-a385-99c6a8910fde@quicinc.com>
 <CAA8EJppmn5hM5=zdkQoaGAYghw822vP8YoW0wQsNmAZY0v7dtA@mail.gmail.com>
 <865y4zfppf.wl-maz@kernel.org>
 <CAA8EJppkJ1s=yjruBm0mntGQ4NBGut2jMLFRtZr6KquA5zn+=Q@mail.gmail.com>
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
In-Reply-To: <CAA8EJppkJ1s=yjruBm0mntGQ4NBGut2jMLFRtZr6KquA5zn+=Q@mail.gmail.com>
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

On 28/08/2023 12:18, Dmitry Baryshkov wrote:
> On Mon, 28 Aug 2023 at 13:04, Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Mon, 28 Aug 2023 10:46:10 +0100,
>> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>>>
>>> On Mon, 28 Aug 2023 at 12:36, Maulik Shah (mkshah)
>>> <quic_mkshah@quicinc.com> wrote:
>>>>
>>>> Hi Dmitry,
>>>>
>>>> This patch may be useful if there was a case where some PDCs don't have
>>>> version register populated/available,
>>>> In all PDC versions, version register is always available but due to reg
>>>> size not good enough in device tree for SM8150 it failed to read.
>>>>
>>>> reg size in device node must be expanded if its too small to access all
>>>> registers and i think
>>>> additional check in driver to check if size is good enough would not be
>>>> of much use.
>>>
>>> Unfortunately, it doesn't work this way. DT files are ABI. Even if we
>>> change the DT, the kernel should continue working with the older
>>> version.
>>> Thus, we have to add such bandaid code, which will keep the kernel
>>> from crashing if old DT was used.
>>
>> You're missing the point: all existing PDC HW have version register.
>> The fact that the DT is crap doesn't invalidate this simple fact. It
>> is thus perfectly possible for the driver to *ignore* the crap and do
>> the right thing by expanding the size of the mapping, rather than
>> falling back to the non-versioned code.
> 
> Ah. Interesting idea. If that's the overall consensus I can send v2
> doing this. Not sure what is better though.

Please take my PDC 3.2 patch in the same set!

Neil

> 
>>
>> There is definitely precedents for this sort of behaviour, such as the
>> ARM GICv2 probe code.
> 

