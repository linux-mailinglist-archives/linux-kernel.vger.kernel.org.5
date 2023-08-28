Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C98378A748
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjH1IJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjH1IJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:09:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6290B12F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:09:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d20548adso2396207f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693210139; x=1693814939;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLZsoyLN2V6zeEjgSs7z9SwbGpqoJshuFeaBp+XGTX4=;
        b=FbUKoTCK/Dlj/T/VwW1M7VT/nULw5el/4BulwtgIiDM/E5WS0uvapBj733TVoRKa8G
         k+9pM7LH2/RwOim3o+kF4n+j7y2ArebNqBDkTiQB8Lu5pMC56oUYhApCyR5xdlrfGpq3
         iJ/lyic7DGoTprMmdpZ1OwbsL0XQF/9R+7C5ABxTkW0t+8BneqK5N592iRYSWkgxYqAh
         FNBHTDOr8bH3JIpoBRMdA7c3tKI/jVapo6QYY7qi3aw9aovlpiHXoncPyB1eninuB6cR
         Wb2xU4jfSS/VBMDNCuvuTpF87AOKospyBo6qzR6SrbY6oHGc7rMmg670aC/BtanjuXGy
         jORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693210139; x=1693814939;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OLZsoyLN2V6zeEjgSs7z9SwbGpqoJshuFeaBp+XGTX4=;
        b=di/e4tamCXjybfdKOSA5vH/2VrRZ9HZ7OPMtZxVhuMk60AWNW3mV/OnLnkVmMzIiTK
         BWPQhnnq04hYFYUL4A2m/J2xp35TUs3EJK52kKvvT2Tq12b/TOfhG7u77fxN1CXfs5RY
         xrNpz8ftfNxJGMM0mip4jjpY8F17gJOGREVADXGSDVJiFQuS4VjLofTButZIx699ZIpm
         bt2Rm+tdm7F7kEQZZMgoFnEAdv7YKfEm8x2U7eDSM0wCmCWDYgmlgXadL+GhvTvEimkI
         SPbeiqltBAIGrnMDzYSZ8dQO3djm4u2jdvaG6wopWCKi6NOeU7C2JNsciTVzH78FL5U0
         vc+A==
X-Gm-Message-State: AOJu0YxrEXArH6PqlFA7gTLYV5X0GGbLra6wQEqvTGRqnrhEEnIqVpzV
        c9zc9S0UkzilfjeKEjgkkTDtkg==
X-Google-Smtp-Source: AGHT+IEcd74NhdzXwD8zRGUwoczhltQODTJSK+rkWvP6JRnublXo8+DbChhzNHuB8F1E/uj4AYPokA==
X-Received: by 2002:adf:d4cb:0:b0:319:5677:f832 with SMTP id w11-20020adfd4cb000000b003195677f832mr18756575wrk.62.1693210138794;
        Mon, 28 Aug 2023 01:08:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5e59:c27b:747a:3f52? ([2a01:e0a:982:cbb0:5e59:c27b:747a:3f52])
        by smtp.gmail.com with ESMTPSA id q9-20020adfea09000000b0031c5ee51638sm9769967wrm.109.2023.08.28.01.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 01:08:58 -0700 (PDT)
Message-ID: <a6423f9b-ca1e-4921-92ad-092178139a01@linaro.org>
Date:   Mon, 28 Aug 2023 10:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] irqchip/qcom-pdc: add support for v3.2 HW
Content-Language: en-US, fr
To:     Marc Zyngier <maz@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230823-topic-sm8x50-upstream-pdc-ver-v3-1-aa7d9ab862e4@linaro.org>
 <CAA8EJppSceyxynBbbRO09DqnGVwW46CfJqfkdadZi_kfF++FBw@mail.gmail.com>
 <86edjqf73u.wl-maz@kernel.org>
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
In-Reply-To: <86edjqf73u.wl-maz@kernel.org>
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

On 26/08/2023 12:09, Marc Zyngier wrote:
> On Fri, 25 Aug 2023 19:43:34 +0100,
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Wed, 23 Aug 2023 at 12:49, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>
>>> Starting from HW version 3.2 the IRQ_ENABLE bit has moved to the
>>> IRQ_i_CFG register and requires a change of the driver to avoid
>>> writing into an undefined register address.
>>>
>>> Get the HW version from registers and set the IRQ_ENABLE bit to the
>>> correct register depending on the HW version.
>>>
>>> Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>> Changes in v3:
>>> - Simplify qcom_pdc_gic_set_type()
>>> - Used __assign_bit in pdc_setup_pin_mapping()
>>> - remove BIT() from IRQ_i_CFG_IRQ_ENABLE to be used with __assign_bit()
>>> - Add Reviewed-by tag
>>> - Link to v2: https://lore.kernel.org/r/20230822-topic-sm8x50-upstream-pdc-ver-v2-1-3035b8d388f7@linaro.org
>>>
>>> Changes in v2:
>>> - Changed IRQ_ENABLE handling based on Maulik's comments
>>> - Link to v1: https://lore.kernel.org/r/20230821-topic-sm8x50-upstream-pdc-ver-v1-1-6d7f4dd95719@linaro.org
>>> ---
>>>   drivers/irqchip/qcom-pdc.c | 61 ++++++++++++++++++++++++++++++++++++----------
>>>   1 file changed, 48 insertions(+), 13 deletions(-)
>>
>> This patch in linux-next broke sm8150. On that platform the PDC region
>> has size 0x400, so reading the version crashes the kernel.
>> I'll send a patch fixing device tree, but we'd still need to handle
>> this in a driver too.
> 
> Thanks for reporting the breakage.
> 
> Given that this has direct platform implications, I've dropped the
> patch from my tree until people figure out whether the proposed fix is
> the correct one and take the time it takes to test it.
> 
> Please work with Neil to post an updated series that contains the
> fixed support for v3.2 and the DT churn.

Thanks for dropping the change,

Neil

> 
> 
> Thanks,
> 
> 	M.
> 

