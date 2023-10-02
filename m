Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9505D7B53EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbjJBNQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjJBNQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:16:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D21AB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:16:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32799639a2aso1644816f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696252595; x=1696857395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWDo7q3EDVsqoyDZFjdtucldBML3ewIDsZGKXI72Oh0=;
        b=z2rAX543bCjXWkR1zMH6QEHx8iizAPQvLA7mkjpZn0D85b+4VwUVDnaOntJIGZ49/s
         wKQCZYuiz0lVOG6JjEnCJGhmQVMQzEX6uL5bzj+rgvt5e9fVNrgHAfkxOotVGBGPy1Jj
         5EDxeVWQReGfUuK8AR/rE0ZQ9ypjmc7q6M3LI/jkcHB97Vzr6uMhnfhVmhCbzyAiAdZK
         5LlsNA4BKiB2jrp28Sg3JLiJa1aSR264Ldm97OA7ec1NVFHAGFMRcZXIyTK/6qbhP1Pq
         IXDeIhOOOCZ5X9NREOUax/xWoe8G6s1HEYMWllCdwBT0Fctb5O7tnhNapXC2LKBdRvBe
         /Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252595; x=1696857395;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FWDo7q3EDVsqoyDZFjdtucldBML3ewIDsZGKXI72Oh0=;
        b=UATGEZXwn/mzDEPMBmirZsJYzisU1zwhAsOM/pwVXB6HdOsmVVS9jggACs+6PTwknQ
         IKR4FesGOJtNdhqOUhV+HufrxXwQdL4bhIGaO+d+Fgf1Qq7cXRhUu/8JzP9CX64w6Kp/
         +ULe/7iwNd7Vmw3+6Z6IhL8ESWmsYQjbGyQ87H8ysKCjN96O1dTuFpKH95P7zQnLFGPx
         CVoUrjE5iqXMu2NxKJUzmvJMdDc54EEvE8+C5Zkp2hwIwI9ys934rfAvYpvjc1Y62w6f
         j5eGYjl5KmUlaClYfOCEItpuVr1ZjlzIyaTub/pgDRr+uffYOSbgdPEqHgPB57Bth0G2
         /F+Q==
X-Gm-Message-State: AOJu0YxgLsaASBYQlC2nNj/TBcKFdrAhCFG4KTqP7z1nugpK2XIg5Swa
        9Zj3d0SIxd1eztWD2ZgA8nhXLA==
X-Google-Smtp-Source: AGHT+IH1YRaMgaAtM513xAopB4+rMTTdfMaoDfgCFtdeVtdnok5h3B6f5PqHHIGZ1qgW2hNNxS1fRQ==
X-Received: by 2002:a5d:574f:0:b0:31f:97e2:a924 with SMTP id q15-20020a5d574f000000b0031f97e2a924mr9915840wrw.14.1696252594271;
        Mon, 02 Oct 2023 06:16:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b653:7e47:ffdd:9340? ([2a01:e0a:982:cbb0:b653:7e47:ffdd:9340])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d634c000000b0031773a8e5c4sm28056884wrw.37.2023.10.02.06.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 06:16:33 -0700 (PDT)
Message-ID: <07c9bde0-5c88-4447-9482-8cd9eaa3999a@linaro.org>
Date:   Mon, 2 Oct 2023 15:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 1/2] irqchip/qcom-pdc: Add support for v3.2 HW
Content-Language: en-US, fr
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20230905-topic-sm8x50-upstream-pdc-ver-v4-0-fc633c7df84b@linaro.org>
 <20230905-topic-sm8x50-upstream-pdc-ver-v4-1-fc633c7df84b@linaro.org>
 <87wmw5ch99.ffs@tglx>
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
In-Reply-To: <87wmw5ch99.ffs@tglx>
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

Hi Thomas,

On 02/10/2023 14:59, Thomas Gleixner wrote:
> On Tue, Sep 05 2023 at 15:19, Neil Armstrong wrote:
>> Starting from HW version 3.2 the IRQ_ENABLE bit has moved to the
>> IRQ_i_CFG register and requires a change of the driver to avoid
>> writing into an undefined register address.
>>
>> Get the HW version from registers and set the IRQ_ENABLE bit to the
>> correct register depending on the HW version.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> This S-O-B chain is broken. Who is the real author of that?

I'm the initial author, I sent a fixed version with cleaned-up S-o-b chain:
https://lore.kernel.org/all/20230929-topic-sm8x50-upstream-pdc-ver-v5-0-800111572104@linaro.org /

Neil

> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
> 
> Thanks,
> 
>          tglx
> 
> 

