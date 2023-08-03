Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97B576EA31
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbjHCN0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjHCN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:26:37 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D151702;
        Thu,  3 Aug 2023 06:26:35 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373CUaUd005319;
        Thu, 3 Aug 2023 15:26:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=769HHGAF/6gRexcMz7wlX14yHSAscue5CPjDxlCcFNs=; b=EX
        0N59efnCEKZ2fu5sSysVtXhkt6Iyu1sZKmkXgPpL4tbmhJwuHQTdKv1KTptbDSzx
        HznLDiFipuLOnp55ODSo5vEgoaUOYd7HILQBNa8yatnDehNiAbZN/zKJdFLTBDAe
        kAj4BviRVWpCT8OJYLtpyl0I0Vk/9NrIyVkwoLwSOwriO7X3Zo94pSbzAcPjeeQo
        U+wxRIG8nPWq+J3sGJlEF/V0xICP6EMoRvfd6Bg0lVgJJRSU7jpySh50WY5Z5nkN
        Wi9RMe7iCKo9PWXmnGAVU2DzHAQOrb+Ig+ug8mbKORDe9KIK0lK6XoNlS0mGZMwt
        3jBi0d3pLALgEvq3LM6A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s85xr33bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 15:26:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D6BC2100089;
        Thu,  3 Aug 2023 15:26:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BD983222C9D;
        Thu,  3 Aug 2023 15:26:27 +0200 (CEST)
Received: from [10.201.20.168] (10.201.20.168) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 3 Aug
 2023 15:26:27 +0200
Message-ID: <6047bf29-14c0-c06f-3161-09e89a992b41@foss.st.com>
Date:   Thu, 3 Aug 2023 15:26:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] pinctrl: stm32: set default gpio line names using pin
 names
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230620104349.834687-1-valentin.caron@foss.st.com>
 <40b91e5a-0b25-c5e3-66f1-70e1d12f661c@foss.st.com>
Content-Language: en-US
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <40b91e5a-0b25-c5e3-66f1-70e1d12f661c@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_12,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Is the Acked-by from Alexandre enough ?

He is maintainer of arm/stm32 architecture.

Thanks,
Valentin

On 6/21/23 10:18, Alexandre TORGUE wrote:
> Hi
>
> On 6/20/23 12:43, Valentin Caron wrote:
>> Add stm32_pctrl_get_desc_pin_from_gpio function to find a stm32 pin
>> descriptor which is matching with a gpio.
>> Most of the time pin number is equal to pin index in array. So the first
>> part of the function is useful to speed up.
>>
>> And during gpio bank register, we set default gpio names with pin names.
>>
>> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
>> ---
>
> Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>
>
>>   drivers/pinctrl/stm32/pinctrl-stm32.c | 35 +++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c 
>> b/drivers/pinctrl/stm32/pinctrl-stm32.c
>> index 4b97bd00191b..eedbb9b97a65 100644
>> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
>> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
>> @@ -1275,6 +1275,28 @@ static const struct pinconf_ops 
>> stm32_pconf_ops = {
>>       .pin_config_dbg_show    = stm32_pconf_dbg_show,
>>   };
>>   +static struct stm32_desc_pin 
>> *stm32_pctrl_get_desc_pin_from_gpio(struct stm32_pinctrl *pctl,
>> +                                 struct stm32_gpio_bank *bank,
>> +                                 unsigned int offset)
>> +{
>> +    unsigned int stm32_pin_nb = bank->bank_nr * 
>> STM32_GPIO_PINS_PER_BANK + offset;
>> +    struct stm32_desc_pin *pin_desc;
>> +    int i;
>> +
>> +    /* With few exceptions (e.g. bank 'Z'), pin number matches with 
>> pin index in array */
>> +    pin_desc = pctl->pins + stm32_pin_nb;
>> +    if (pin_desc->pin.number == stm32_pin_nb)
>> +        return pin_desc;
>> +
>> +    /* Otherwise, loop all array to find the pin with the right 
>> number */
>> +    for (i = 0; i < pctl->npins; i++) {
>> +        pin_desc = pctl->pins + i;
>> +        if (pin_desc->pin.number == stm32_pin_nb)
>> +            return pin_desc;
>> +    }
>> +    return NULL;
>> +}
>> +
>>   static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, 
>> struct fwnode_handle *fwnode)
>>   {
>>       struct stm32_gpio_bank *bank = &pctl->banks[pctl->nbanks];
>> @@ -1285,6 +1307,8 @@ static int stm32_gpiolib_register_bank(struct 
>> stm32_pinctrl *pctl, struct fwnode
>>       struct resource res;
>>       int npins = STM32_GPIO_PINS_PER_BANK;
>>       int bank_nr, err, i = 0;
>> +    struct stm32_desc_pin *stm32_pin;
>> +    char **names;
>>         if (!IS_ERR(bank->rstc))
>>           reset_control_deassert(bank->rstc);
>> @@ -1354,6 +1378,17 @@ static int stm32_gpiolib_register_bank(struct 
>> stm32_pinctrl *pctl, struct fwnode
>>           }
>>       }
>>   +    names = devm_kcalloc(dev, npins, sizeof(char *), GFP_KERNEL);
>> +    for (i = 0; i < npins; i++) {
>> +        stm32_pin = stm32_pctrl_get_desc_pin_from_gpio(pctl, bank, i);
>> +        if (stm32_pin && stm32_pin->pin.name)
>> +            names[i] = devm_kasprintf(dev, GFP_KERNEL, "%s", 
>> stm32_pin->pin.name);
>> +        else
>> +            names[i] = NULL;
>> +    }
>> +
>> +    bank->gpio_chip.names = (const char * const *)names;
>> +
>>       err = gpiochip_add_data(&bank->gpio_chip, bank);
>>       if (err) {
>>           dev_err(dev, "Failed to add gpiochip(%d)!\n", bank_nr);
>
