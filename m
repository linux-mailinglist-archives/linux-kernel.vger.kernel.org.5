Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3074F780739
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358628AbjHRIdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358616AbjHRIdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:33:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39280E40
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:33:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31963263938so584980f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692347588; x=1692952388;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAz6pPcjIbO7M4ErEDvnkCbBFuK+dTm4MKz0WfT12Qs=;
        b=amB46zDznbpEv1hhlz48yf5hFt7WQdjgYkARDnoetEA99O9D9QPGbvMN7+vEKaGNTO
         +WugWo4I9yj93YW58+z4AqnXJo17cKs0Xsz03PDNNtkIAYPi1yIt5xcrGNVQgsWC5VVH
         uKO2HvxVIXIOQZ1PrA8/bnYIP5nojUHHoxVj2xzk9jTQE+Qo5EGvOLGG/UW7j+4FRXpk
         mKDk3tS2UlDbwzsu/aLQJ2zfcaGWHieo7sjiVjkVKtqqAb0IBOxrCtLv8XVclsL+JnJN
         LhPXD9WpHLCg1S24nGSF9/abRYIj3ugGRHp4KuKguIw0+SRLaBDueWSjmqkHp4rZE23g
         Tv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347588; x=1692952388;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aAz6pPcjIbO7M4ErEDvnkCbBFuK+dTm4MKz0WfT12Qs=;
        b=hPh6tYOGrv9rIEUuqpw4Bkslj6R3mTn35lhE2NUBoG8mqWZCrHDHe67sJrHn+7JZOg
         3cdX9RZQZ8Ar36qVbEkl0iuFCtzIS+aLqr22ZfEOMEFmyY35/08ya7/IDIt6/6XkAEwD
         hTLQ7EdD55j8+3riqjnMhymjQVHlG3oyEHhTDNgwBmv2YvkGn+t+gFYzOUnwdU5L0ILN
         4ux2Fl0WDPecvmgDNRtN8dO29ZcXJvXskLNd2+aEH/RxwRI4VXU8LfDufLlRG4Emq+X+
         OWSz6D+U+VkDtocVJVTL7ZQ/RKNgywAOpFpZBmf9T/zBeRdzPd3WDEZ7NZIBtyjuIj2s
         UyLA==
X-Gm-Message-State: AOJu0YwwBMFpJOG2fiwLvpMNqQRcbWh7HqRLR8kaJ9ths4QHRupUq/6Y
        YdmWtnEMT5/QUbE4YeRuvq/zELNfw874NctPJnJJOg==
X-Google-Smtp-Source: AGHT+IEiysdNKHU6e1jOHJwdYmSc6cMKD0VVl3kI/OX+UGpo9rGHWR5q03uk569XonrYyZgxg48H3w==
X-Received: by 2002:a05:6000:18d:b0:314:1f1e:3a85 with SMTP id p13-20020a056000018d00b003141f1e3a85mr1475664wrx.61.1692347587538;
        Fri, 18 Aug 2023 01:33:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b9f6:39b9:fff4:e741? ([2a01:e0a:982:cbb0:b9f6:39b9:fff4:e741])
        by smtp.gmail.com with ESMTPSA id o15-20020adfeacf000000b003197e3520ddsm1959033wrn.109.2023.08.18.01.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 01:33:06 -0700 (PDT)
Message-ID: <077c330d-5b86-4797-b69d-0ad02f49978f@linaro.org>
Date:   Fri, 18 Aug 2023 10:33:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/1] Add add-maintainer.py script
Content-Language: en-US, fr
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <20230810185526.GC31860@quicinc.com>
 <4d94d0fd-72d4-0196-3a30-3e1efb9f5aca@linaro.org>
 <20230816171538.GB26279@quicinc.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20230816171538.GB26279@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 19:15, Guru Das Srinagesh wrote:
> Thanks for the comments, Krzysztof.
> 
> On Aug 15 2023 23:06, Krzysztof Kozlowski wrote:
>> On 10/08/2023 20:55, Guru Das Srinagesh wrote:
>>> On Aug 03 2023 01:23, Guru Das Srinagesh wrote:
>>>> When pushing patches to upstream, the `get_maintainer.pl` script is used to
>>>> determine whom to send the patches to. Instead of having to manually process
>>>> the output of the script, add a wrapper script to do that for you.
>>>>
>>>> The add-maintainer.py script adds maintainers (and mailing lists) to a patch,
>>>> editing it in-place.
>>>
>>> Could I request reviews from the other maintainers as well, please? Just to see
>>> if I should continue working on this script or if the `b4` tool obviates the
>>> need for such a script.
>>
>> I send a bit of patches but I use very simple workflow. It is really
>> simple, so simple, that I was always surprised how people can make their
>> life difficult with some complicated process to send patches... and then
>> obviously skip some maintainers, because of that process.
> 
> Exactly - this script aims to solve precisely that problem. It fills the gap
> between running `get_maintainers.pl` and having to manually edit its output to
> add "To: " and "Cc: " and somehow incorporate it in the body of the patch(es).
> 
> With this script, the workflow would be as simple as:
> 
>    1. Generate patches using `git format-patch`
>    2. Run `add-maintainer.py` on the above patches
>    3. `git send-email` the patches.
> 
> That's it - no need to manually work with email addresses.
>    
>> I almost always feed git send-email with addresses from
>> scripts/get_maintainers.pl. This tool would not bring any benefits to my
>> simple workflow.
> 
> In the light of the 3-step workflow I've envisioned above, could you please
> elaborate why not? If anything, it will only save a developer's time.
> 
>> For newcomers, OTOH, I would either recommend simple workflow or just
>> use b4. Why? Because if you cannot use git-send-email, then it means
>> your email setup will make your life difficult and adding maintainers to
>> existing patch won't help you.
> 
> You've mentioned a "simple workflow" many times - could you please share more
> details on the steps you follow in your workflow for sending patches?
> 
>> This tool depends on the command line and shell interface of
>> scripts/get_maintainers.pl which is another reason why it might not be a
>> good idea.
> 
> Could you please elaborate on why depending on the output of
> `get_maintainer.pl` is a bad idea? It's what everyone uses, no?

My opinion is that it would be a better idea to add a new output mode
to scripts/get_maintainer.pl than adding another script on top of it.

Or document somewhere how to use get_maintainer.pl with git-format-patch
without any additional scripts.

Neil

> 
> Thank you.
> 
> Guru Das.

