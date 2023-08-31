Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBDA78E9E9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245459AbjHaKIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjHaKIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:08:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4971CED
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:08:08 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401da71b7faso6328985e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693476487; x=1694081287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCpnq7aTkrP6oGZGokzQr5svOsbyLm/8VLp04ehTh44=;
        b=KjiWyAQwW8uSpw97tiBim/oHNF2ugZlKEPlVH2uXMDUa3B0NUAA1p6vvEiK5IfJj67
         KkshtNzNR6uB+Hbev+/6gpI7GqNUVqMzT4Rer4o/tGVuq5WSxUgUCwXS/aE38Gpre9Ko
         9uAlRcg5DUs9cGRuCgMI5QmMxKVnh8mS5rMNhsbKYRY8hciF+lJ5FcjYSjCbK1hZURAv
         6qxJ/pkwv8JH44CoF3E1ppKl4WFPh3wg4MBT+Bx2GQoZwf0DD5Zf/x0oI68Flb0nCC8B
         YB43eHqSddqRFXOUuWfxv2OdrlReVYzjwClm7tfZMjIOWrRDL5UkSxc8LNHMDNwqBbx1
         qiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693476487; x=1694081287;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UCpnq7aTkrP6oGZGokzQr5svOsbyLm/8VLp04ehTh44=;
        b=J+xXRdW0x10vessoHYqdRxriLt4b/Het3UYYcymQZaTXIDWP8lHzE2leSR/RRcH0mj
         SHYDjEra1dBRRKp6zBlWRnrLOAv5mruFzXwzL8nxRCq4/MakP+LrXiPTcH0Le4o8wYnx
         2z1JHWtBEVxm5z308LeoGyYNwS6PByi0pRT9JPglwk+a+FdhbR8X3o+l55Wd4YzcqWyy
         WtMx8CyuMQGTREVxR3O2pZaWo+v+Mjjw+8AACLDkcXz3qtIXFVC5IDXOXtcP2zSvygbT
         m7gnttI+2H13XMSnKQFXrgYYWpUS4bGjHAOuyv1mX3dXdbSwgIq7cvDh4hVA0xVxVN/Z
         rTBA==
X-Gm-Message-State: AOJu0YxvTyEWDZCcAX12ZBg85WjnI9q0bZgcj3qcC50XJHpBjWDr5I6U
        JH94KKdwwnpo35ixxCi0VtoiNA==
X-Google-Smtp-Source: AGHT+IFd3DA6tS4vhMrtZ57vuU5iGyFjBZW5uDToqRzwYdb8V+dPBDV+YEtEP5mUSfI/5zrIey/59Q==
X-Received: by 2002:a5d:404c:0:b0:313:eaf5:515 with SMTP id w12-20020a5d404c000000b00313eaf50515mr3209458wrp.6.1693476487242;
        Thu, 31 Aug 2023 03:08:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a33e:476b:58d7:9689? ([2a01:e0a:982:cbb0:a33e:476b:58d7:9689])
        by smtp.gmail.com with ESMTPSA id i16-20020adfefd0000000b0031c5d74ecd8sm1674536wrp.84.2023.08.31.03.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 03:08:06 -0700 (PDT)
Message-ID: <eecf028e-5fd9-4811-821f-35e87955ef3d@linaro.org>
Date:   Thu, 31 Aug 2023 12:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] soc: qcom: socinfo: Add SM8550-adjacent PMICs
Content-Language: en-US, fr
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230830-topic-pm8550abcxyz-v1-1-3c3ef3d92d51@linaro.org>
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
In-Reply-To: <20230830-topic-pm8550abcxyz-v1-1-3c3ef3d92d51@linaro.org>
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

On 30/08/2023 04:42, Konrad Dybcio wrote:
> Many of the PMICs were missing, add some of them often coupled with
> SM8550.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Please somebody double-check, this was sorta reverse-engineered..
> ---
>   drivers/soc/qcom/socinfo.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 497cfb720fcb..067d28924ca2 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -117,6 +117,12 @@ static const char *const pmic_models[] = {
>   	[55] = "PM2250",
>   	[58] = "PM8450",
>   	[65] = "PM8010",
> +	[69] = "PM8550VS",
> +	[70] = "PM8550VE",
> +	[71] = "PM8550B",
> +	[72] = "PMR735D",
> +	[73] = "PM8550",
> +	[74] = "PMK8550",

I checked and those IDs are correct:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

>   };
>   
>   struct socinfo_params {
> 
> ---
> base-commit: ae782d4e2bf53b0b642ae860794f7a39470f995a
> change-id: 20230830-topic-pm8550abcxyz-73346b3ab9a6
> 
> Best regards,

