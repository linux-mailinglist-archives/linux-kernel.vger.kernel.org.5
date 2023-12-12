Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C8C80F00E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376660AbjLLPYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376637AbjLLPYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:24:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9FD0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:24:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-33340c50af9so5807767f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702394668; x=1702999468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kJqu+bnuU5nR5DAckFzswh1FRnTgmkHhVyfgizfqp0=;
        b=u2F61MQYGrf1m2mz0riVsRLpCO1pVKcXda2NtltxL5neu/hBdeqh7YSVlpFjSdFmNT
         Ff7WiI8Mf23ASYqZp/QGRNta5S/2T2+yCnF2tjAsmyChDAGc+7bu8JbXsfnkgaLEVNZD
         yfl19xRBC805MmEYuvctC+XllguVumRwSjIzFI4fXnD8mJO8py9MUzUsBaVVfFFAyRqG
         pRVmT7EEOic11pN7CsOoxStwrRAX3fwfEiF/pKLfsNJTvSGaRRfxzcP/l7qLVVJcmiD9
         EhDRfBCN4fmoQaMPVV8tHKMJly/I4O0SD1aOVFhJs7RyA3mhFkKKcSZNvj0l2BbQDcyH
         zPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394668; x=1702999468;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7kJqu+bnuU5nR5DAckFzswh1FRnTgmkHhVyfgizfqp0=;
        b=R1y41XRQ8SX6VNZsVd1qMXVSQSnlbk/KOozavkh2bNLcSuHmlZqh/MVX+8zNLB1Yug
         EKUrgNii0ultE2i82XGOr8Qpq9LV31QZZvZEr+AxH+z3ri2vFvMDxfr0KuMxmMXA7S56
         3go5Z+ZgKti8QO2WDA5igClhOKu3ZG5uSZOdOQSBIiABFjCO0loRmYIYEGqwNyfp+4IN
         pqh2srXIwiRlEy7RkuDOWKdgmpZdq+exUvYLQ75jXNB4w0gJaYwVPDiewQciw3InuKQO
         ir1DHi5l4UJC3QOCTrYeyH8KUuVW7pkFA9/JeRHpYgUjr5Jv08pSMCUXBk7eO747X4mp
         VNaw==
X-Gm-Message-State: AOJu0Yw8EaOJ0pNqC2GK3JYXJizj1CKKsw7Gxhn/I889PBPA3xTbR0rX
        Tqvoz9V2fo93SQlzFZPyE1WXPg==
X-Google-Smtp-Source: AGHT+IGVUMU4MGNHLX2arXPoCoNvGtb6iFKt5mx3GnV2rGFLW3lAZYKfzlX61YbymRc9/kLhEpxWNg==
X-Received: by 2002:a5d:61ce:0:b0:336:3651:62a3 with SMTP id q14-20020a5d61ce000000b00336365162a3mr122093wrv.9.1702394668020;
        Tue, 12 Dec 2023 07:24:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5894:fa62:26b4:bf82? ([2a01:e0a:982:cbb0:5894:fa62:26b4:bf82])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d54cf000000b0033635d121besm725476wrv.52.2023.12.12.07.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 07:24:27 -0800 (PST)
Message-ID: <44c2d671-a915-49ba-a584-83d48e6c808c@linaro.org>
Date:   Tue, 12 Dec 2023 16:24:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] soc: qcom: pmic_pdcharger_ulog: Move TRACE_SYSTEM out
 of #if protection
Content-Language: en-US, fr
To:     Andrew Halaney <ahalaney@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231205-pmicpdcharger-ulog-fixups-v1-0-71c95162cb84@redhat.com>
 <20231205-pmicpdcharger-ulog-fixups-v1-2-71c95162cb84@redhat.com>
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
In-Reply-To: <20231205-pmicpdcharger-ulog-fixups-v1-2-71c95162cb84@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 00:05, Andrew Halaney wrote:
> As specified in samples/trace_events/trace-events-sample.h:
> 
>      * Notice that TRACE_SYSTEM should be defined outside of #if
>      * protection, just like TRACE_INCLUDE_FILE.
> 
> Fixes: 086fdb48bc65 ("soc: qcom: add ADSP PDCharger ULOG driver")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>   drivers/soc/qcom/pmic_pdcharger_ulog.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_pdcharger_ulog.h b/drivers/soc/qcom/pmic_pdcharger_ulog.h
> index 9d5d9af4fbe4..152e3a6b5480 100644
> --- a/drivers/soc/qcom/pmic_pdcharger_ulog.h
> +++ b/drivers/soc/qcom/pmic_pdcharger_ulog.h
> @@ -3,14 +3,14 @@
>    * Copyright (c) 2023, Linaro Ltd
>    */
>   
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM pmic_pdcharger_ulog
> +
>   #if !defined(_TRACE_PMIC_PDCHARGER_ULOG_H) || defined(TRACE_HEADER_MULTI_READ)
>   #define _TRACE_PMIC_PDCHARGER_ULOG_H
>   
>   #include <linux/tracepoint.h>
>   
> -#undef TRACE_SYSTEM
> -#define TRACE_SYSTEM pmic_pdcharger_ulog
> -
>   TRACE_EVENT(pmic_pdcharger_ulog_msg,
>   	TP_PROTO(char *msg),
>   	TP_ARGS(msg),
> 

Thanks for fix, it is incredibly hard to understand how to properly implement it...

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
