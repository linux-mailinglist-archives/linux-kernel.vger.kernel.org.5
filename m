Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E2B7E6B37
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjKIN3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjKIN3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:29:06 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB4230D0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:29:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40842752c6eso6257035e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 05:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699536543; x=1700141343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6lBJj4NeOTlbTzOMMV3Vht/yRGVcOP2vUzfnCr54NA=;
        b=GZiJpeaLEZKQEBOMuNyM0oa2jRjY54GreheXU8MAGkJO+N3oMg78LLMtKIaDoC/gLL
         GoF8WOEwbiwypxKji3hkR2T2U6eIt0GebM/ChEbIVH1CBYKq+HAjrN80K0K707B8M8lo
         LrAO1BeoPW3+4qOMiRqI+tHzFWJ5Q5KTae+zWX7hSfRvEp21n1U7/JE8wFXpaaF5A3Ni
         HFLHy4i0D6alB1jIFX0E2MPCM+BFmhZcvwObuBYQ+IDO2yRJ1rRIKqfwxz/hPzhTlsKL
         bJlCqnDGKMgFmcyI8t5ptzsO7ZIQf1gFhYcf0vmwfiPsGWh1JZAlpsI2p4XVdf3p1TSB
         5aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699536543; x=1700141343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6lBJj4NeOTlbTzOMMV3Vht/yRGVcOP2vUzfnCr54NA=;
        b=U24QQJM+p8N3MQSZ8XpKhoBSs5oniNqlA3s/k2Atbc3fN9gO9MgUsdEHgESdyMkvN3
         udNZlwraVdZSrQZ8Bhom4bWGnxoGhC7LNsz4LgeeHBKhbDvlWzvZOytssfnOMt0ENj2J
         ff3Unt+phPVxbx88X/2fGgF+mqqYzIVlcML1hcMG8L6CS7+bDqSUy86ec/r7lciJl26x
         3PM5T1Mxa+MAXos9TbfuYoIQf/3y/RcmnmXKYVTWNz3sC18BtC6Zc9Cl/6CG/6hqtMv2
         7dhvi5mIfleu/evzJvxifydXO36EPhM4JbnNeQxmC5YLX7fuDJeDoKzNPJAnEXJiepTY
         oVYw==
X-Gm-Message-State: AOJu0YyEpC7h+7kMwSa6kFNMLP23aO/kbhiqYEeNIW+RAo+qfpljm0DX
        GFLGnGSaL8yzusIHzW3jDKFMpg==
X-Google-Smtp-Source: AGHT+IEz2E5ROHq7FzQOUSdgDqt0dBtEGV3u7QEbT82rj8kDTN+wurB8NdRa7RfMlwzRk8zXZ5MS8g==
X-Received: by 2002:a05:600c:35d2:b0:406:52e4:cd23 with SMTP id r18-20020a05600c35d200b0040652e4cd23mr4107757wmq.0.1699536543052;
        Thu, 09 Nov 2023 05:29:03 -0800 (PST)
Received: from [10.66.66.2] (9.ip-51-91-159.eu. [51.91.159.9])
        by smtp.gmail.com with ESMTPSA id f23-20020a1c6a17000000b0040648217f4fsm2052596wmc.39.2023.11.09.05.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 05:29:02 -0800 (PST)
Message-ID: <0edf26f9-46c8-4c9b-a68e-a92a78b5684e@linaro.org>
Date:   Thu, 9 Nov 2023 14:28:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: pmic_glink_altmode: fix port sanity check
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231109093100.19971-1-johan+linaro@kernel.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231109093100.19971-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/23 10:31, Johan Hovold wrote:
> The PMIC GLINK altmode driver currently supports at most two ports.
> 
> Fix the incomplete port sanity check on notifications to avoid
> accessing and corrupting memory beyond the port array if we ever get a
> notification for an unsupported port.
> 
> Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
> Cc: stable@vger.kernel.org	# 6.3
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/soc/qcom/pmic_glink_altmode.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> index 974c14d1e0bf..561d6ba005f4 100644
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -285,7 +285,7 @@ static void pmic_glink_altmode_sc8180xp_notify(struct pmic_glink_altmode *altmod
>   
>   	svid = mux == 2 ? USB_TYPEC_DP_SID : 0;
>   
> -	if (!altmode->ports[port].altmode) {
> +	if (port >= ARRAY_SIZE(altmode->ports) || !altmode->ports[port].altmode) {
I'd personally use PMIC_GLINK_MAX_PORTS directly but it's the same

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
