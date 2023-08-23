Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5B27854BE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjHWJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbjHWJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:55:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0BA1FE0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:53:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3197808bb08so4902433f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692784429; x=1693389229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ugKvoqdI/BmY4Giag4IKW/muxrtUDZuFO0D6hrnFrDk=;
        b=M5lfefuiIsg0SQSt8WfuTyX1Byhk6R/yNfUZH+SF06PKDGH0xSO8vQ+gvvV+GOPgxq
         dify01zYmDAvfTjP1sFwciHBhFD1tEd75ciPLLlFjNhRufYhKLaSyuZz4NMJwvlUbAUc
         6YVBxcKeBJmFLcP9JZVzeFbjsA0+QJrhrYYKfAf1brXGiwWYhnuOvFp1uskYr3Levxnq
         aETtM5iv4wA3P+F9k8PbDaeUzpReHd5wUryBtri6NuCn7lf7nd/SYcyJ1P9gPSpVhBu/
         qv/1puOfwgZkntE6rb8IPPir4Y0NeWWgrKoTFAG/45pMjLEUU94JOfDplcP83qsSMBUc
         UQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692784429; x=1693389229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugKvoqdI/BmY4Giag4IKW/muxrtUDZuFO0D6hrnFrDk=;
        b=GqHPibvcx0GVkMocTJ8O+kwwFMz567RTlGv4fALK5uGXt0DpkWWgK0RVv4XFuEOPr6
         jia8tCh+VOhXVE45IsQFCrXOc6KxiNhfG4j/3fxbQmA0NkAmsEiWPmvBKHpO76lZ/A8r
         pBzqJr1bOj1zuWuheTZRiQb6IrgX7fF6N6PiHLHOgKNBzEJ23PXu75K1kXwv8/Jyz61b
         d3X8acjbtsbIGoSDHsAyYoyCtjZnfUlGUqaWi3Z0pVJgXoTLL9zw8svvJaXpPcGkb82N
         I90NEw2RPzbqRf7oPHDvAQwE9pEswJXXuszvh5Z8w41ImPNU8v9GTXHshhdCEOomKB1E
         50cA==
X-Gm-Message-State: AOJu0Yy3jpaXjJX0nYI2Fun1EsYK7LYv1xjiLmcZ9M+Vqo0GSoLELQrZ
        mVsm4CSNfZu+H0tcjtoYaf9pdA==
X-Google-Smtp-Source: AGHT+IEdsAnZq7NTAmTKSRMK4+oYDZue8c8UITI9cJ78mOPBaDZeztCK+DBG4DVJP4A1NzGwA1ziQQ==
X-Received: by 2002:adf:ce8f:0:b0:31a:ddb3:32da with SMTP id r15-20020adfce8f000000b0031addb332damr10552730wrn.22.1692784429464;
        Wed, 23 Aug 2023 02:53:49 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k12-20020adfe3cc000000b0031ad5470f89sm18537560wrm.18.2023.08.23.02.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 02:53:48 -0700 (PDT)
Message-ID: <64b2a748-ea86-f804-9f8a-881b0dcc7050@linaro.org>
Date:   Wed, 23 Aug 2023 10:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] usb: typec: qcom: check regulator enable status before
 disabling it
Content-Language: en-US
To:     quic_huliu@quicinc.com, Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_fenglinw@quicinc.com,
        subbaram@quicinc.com
References: <20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 10:15, Hui Liu via B4 Relay wrote:
> From: Hui Liu <quic_huliu@quicinc.com>
> 
> Check regulator enable status before disabling it to avoid
> unbalanced regulator disable warnings.
> 
> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
> ---
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> index bb0b8479d80f..ca616b17b5b6 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> @@ -422,7 +422,8 @@ static int qcom_pmic_typec_pdphy_disable(struct pmic_typec_pdphy *pmic_typec_pdp
>   	ret = regmap_write(pmic_typec_pdphy->regmap,
>   			   pmic_typec_pdphy->base + USB_PDPHY_EN_CONTROL_REG, 0);
>   
> -	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
> +	if (regulator_is_enabled(pmic_typec_pdphy->vdd_pdphy))
> +		regulator_disable(pmic_typec_pdphy->vdd_pdphy);
>   
>   	return ret;
>   }
> 
> ---
> base-commit: bbb9e06d2c6435af9c62074ad7048910eeb2e7bc
> change-id: 20230822-qcom-tcpc-d41954ac65fa
> 
> Best regards,

Is this a fix for a real bug you've seen or a hypothetical use-case fix ?

---
bod
