Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D5E78D35A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 08:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbjH3G0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 02:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjH3G0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:26:03 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F9A1BB;
        Tue, 29 Aug 2023 23:26:01 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-792726d3aeeso177061139f.0;
        Tue, 29 Aug 2023 23:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693376760; x=1693981560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7xbJc1r68PN8GsQ7bbtmLEqUkBNyKM4blhwGomh3nI4=;
        b=WGiyCgJDmf8Dtm1gpVA+UM6y/5jWlo9iYtOOUIaZB1fhpHqGAiDncqkusAEf6Cwe7S
         uXgkd6IcMtyI8OaKG4VxZkjtX2auiwQi36Pho/4oyVD8tm4P00/egUZLdXSOQT2A8hWd
         8T8z22GnuouTF6uXVls6LPKKgFttrE5z3W9kOz8ycyfoijixDB0+FNRgJwolkIvd0z4G
         sZSKQy5lYEVKbce9YljqF/jTvlQkF44ZCM4wo7yq4JFewdhR6xpcPfvZ774ykpMRTdw+
         8xlZSqlzOVYrjIKA9laa4CrhhG+WFqrRyyDARJDSQxZkQT3kVFVT4O3jaypE2Y155Hv5
         AO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693376760; x=1693981560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xbJc1r68PN8GsQ7bbtmLEqUkBNyKM4blhwGomh3nI4=;
        b=lO9xQFAjN4v47kzRYsaCLFtPczmVFaH6EE+t/AwgmGMELw28eCZK0y5XYNjKSBeVvy
         nV/dTBj84x9PckhLBR4iuSpCyQ/BMs8CaBJ66dY1s+VLxeEmLnPNpm1+PGcCsJiQq4Gz
         F3xqFCVokCxj0vcp4ravS7xYhdsvWdUx50oTT1eC915Nn+xnUJ+8HR7EmMBlsuqvGa6A
         JtDTHRs9fiPCnJIZDAMymMeM3neKoGtxFL3lqwV9RZJ8CA9aCPhVj3bdMouMbA13oQW3
         Z2sK0iLX0ExL7bDHaIum8GgX3o1etGy7dL9XZFpvt2Fh2gBUkmG18A16WiUU5UDQN6r8
         kqYg==
X-Gm-Message-State: AOJu0YzDpDMvjSfN9zW8opbPi1dt1dA3sYYZ5EGEwQRjKI92HAfy5rND
        PfPwkU5fDXFkOIy2/Y+ezPs=
X-Google-Smtp-Source: AGHT+IF2BFXcuV65Sil8IN/9tLakBbbH0aMEM/VOpAOmEba+qdMlzb3ohQzG3d/gZzsGmCqQ7ftIjA==
X-Received: by 2002:a6b:e801:0:b0:783:6272:afbb with SMTP id f1-20020a6be801000000b007836272afbbmr1718833ioh.9.1693376760389;
        Tue, 29 Aug 2023 23:26:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q6-20020a02a306000000b0042bb394c249sm3502711jai.38.2023.08.29.23.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 23:25:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a2353ce6-bd39-f5ca-ad81-63b061147400@roeck-us.net>
Date:   Tue, 29 Aug 2023 23:25:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] usb: typec: qcom: Update the logic of regulator enable
 and disable
Content-Language: en-US
To:     quic_huliu@quicinc.com,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_fenglinw@quicinc.com,
        subbaram@quicinc.com
References: <20230830-qcom-tcpc-v4-1-c19b0984879b@quicinc.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230830-qcom-tcpc-v4-1-c19b0984879b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 20:00, Hui Liu via B4 Relay wrote:
> From: Hui Liu <quic_huliu@quicinc.com>
> 
> Removed the call logic of disable and enable regulator
> in reset function. Enable the regulator in qcom_pmic_typec_start
> function and disable it in qcom_pmic_typec_stop function to
> avoid unbalanced regulator disable warnings.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Please drop.

> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
> ---
> Changes in v4:
> - Removed regulator_enable and regulator_diable from
> pmic_typec_pdphy_reset function. And enable regulator in

... because I do not see the above change, and way too much changed
in the code since I sent a Reviewed-by: to make it appropriate
to keep it.

Actually, I don't see a difference between v3 and v4 of your patch.

Guenter

> qcom_pmic_typec_pdphy_start function and disable it in
> qcom_pmic_typec_pdphy_stop function.
> - Link to v3: https://lore.kernel.org/r/20230828-qcom-tcpc-v3-1-e95b7afa34d9@quicinc.com
> 
> Changes in v3:
> - Take Bryan's proposal to remove enable/disable operation in pdphy
> enable and pdphy disable function, then enable regulator in pdphy start
> function and disable it in pdphy stop function.
> - Link to v2: https://lore.kernel.org/r/20230824-qcom-tcpc-v2-1-3dd8c3424564@quicinc.com
> 
> Changes in v2:
> - Add Fixes tag
> - Link to v1: https://lore.kernel.org/r/20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com
> ---
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> index bb0b8479d80f..52c81378e36e 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> @@ -381,10 +381,6 @@ static int qcom_pmic_typec_pdphy_enable(struct pmic_typec_pdphy *pmic_typec_pdph
>   	struct device *dev = pmic_typec_pdphy->dev;
>   	int ret;
>   
> -	ret = regulator_enable(pmic_typec_pdphy->vdd_pdphy);
> -	if (ret)
> -		return ret;
> -
>   	/* PD 2.0, DR=TYPEC_DEVICE, PR=TYPEC_SINK */
>   	ret = regmap_update_bits(pmic_typec_pdphy->regmap,
>   				 pmic_typec_pdphy->base + USB_PDPHY_MSG_CONFIG_REG,
> @@ -422,8 +418,6 @@ static int qcom_pmic_typec_pdphy_disable(struct pmic_typec_pdphy *pmic_typec_pdp
>   	ret = regmap_write(pmic_typec_pdphy->regmap,
>   			   pmic_typec_pdphy->base + USB_PDPHY_EN_CONTROL_REG, 0);
>   
> -	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
> -
>   	return ret;
>   }
>   
> @@ -447,6 +441,10 @@ int qcom_pmic_typec_pdphy_start(struct pmic_typec_pdphy *pmic_typec_pdphy,
>   	int i;
>   	int ret;
>   
> +	ret = regulator_enable(pmic_typec_pdphy->vdd_pdphy);
> +	if (ret)
> +		return ret;
> +
>   	pmic_typec_pdphy->tcpm_port = tcpm_port;
>   
>   	ret = pmic_typec_pdphy_reset(pmic_typec_pdphy);
> @@ -467,6 +465,8 @@ void qcom_pmic_typec_pdphy_stop(struct pmic_typec_pdphy *pmic_typec_pdphy)
>   		disable_irq(pmic_typec_pdphy->irq_data[i].irq);
>   
>   	qcom_pmic_typec_pdphy_reset_on(pmic_typec_pdphy);
> +
> +	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
>   }
>   
>   struct pmic_typec_pdphy *qcom_pmic_typec_pdphy_alloc(struct device *dev)
> 
> ---
> base-commit: bbb9e06d2c6435af9c62074ad7048910eeb2e7bc
> change-id: 20230822-qcom-tcpc-d41954ac65fa
> 
> Best regards,

