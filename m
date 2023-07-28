Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07688766F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbjG1OdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjG1OdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:33:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72283A9A;
        Fri, 28 Jul 2023 07:33:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686b9920362so1613324b3a.1;
        Fri, 28 Jul 2023 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690554800; x=1691159600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nS39q3yriw/0YOVPpGfxCJ/v+aliQLT6guvbckkgSnk=;
        b=pGPsp3uM3xvVs7kc2/6PcyZSGZXkS0uG3WVSLOoNMd+caFjMC235Zt/OSpKknN88rw
         h0jbrQFWD8wQFu2wNK43lHI8nEzbFWbNjTNoFcFtkG/JWWtFmRJuFi4ZMKpShp73Bsgk
         WRHfuaqUidCUPsXbagNCtTj0OY/Rrc+jOyOXTg+tMNGcdq7O2g2luTICGNfRn4v9jmO+
         sor6WOWjF/snqvRR75Pq1prjBVxwE3QjTprp8/hf9j1BHKsbbbEmRu3a2M8CNmLb1OLU
         NhwDLNkE5VzYeRwZAvGA3zIJWaDFPBAIoSoH/stdt34q8L9AIrPupfV9T1yGgXGq/Ay/
         1Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690554800; x=1691159600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nS39q3yriw/0YOVPpGfxCJ/v+aliQLT6guvbckkgSnk=;
        b=hrr/DkLAZGMqWSD6IgotllhEhqtBijX1I2Nc5cjpl4lWCUSCbGSbMDpKtcZDf6bywv
         Aar4AtXaXrCTHK9kqCNf9gMl1R5O9W2/pCjayJiofx1GkdSN80Hc7iBL9tME1voSi5MX
         s04pb4I8Q+S2pEoCDSPtt7dVk1ZX4FQ5owSWQHXM0CRyS4kHlNjQdoek1HhHYXUjuxOu
         kbl6/PF+skZc2RE2q6iEgWn6UdAmzQrzeE6V2BY4hPsqhys/ejDf6pZ/v7w8LPU7edAP
         RKbvYALxd8evDTFORITHkDims5APDhxYY9qWWRN7Tubj0mWoaEyYt8AogdgL8zQtAbBD
         c5ag==
X-Gm-Message-State: ABy/qLY+p/QwFMxbgJO2O0tUZ7C2KvG+vEh3WZge9SLdMy8tbpx44FyE
        sQZvxSktHko86ujCLuU5ztE=
X-Google-Smtp-Source: APBJJlG1C/qEqT9Q2rmPOPGRJrzGcBZ1AhPu3w3fv3b3CyPoVpcMfWqdD7R2DvOzg6BV67ts2bSfjQ==
X-Received: by 2002:a17:902:e5c4:b0:1b9:c03b:39d9 with SMTP id u4-20020a170902e5c400b001b9c03b39d9mr1851088plf.53.1690554800175;
        Fri, 28 Jul 2023 07:33:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jc19-20020a17090325d300b001b672af624esm3661474plb.164.2023.07.28.07.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 07:33:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <89500ba2-218a-a290-8211-8d4de3948b45@roeck-us.net>
Date:   Fri, 28 Jul 2023 07:33:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@nvidia.com>
References: <20230728082527.3531940-1-Naresh.Solanki@9elements.com>
 <1cc12337-759e-c932-0303-b1b78e254c27@roeck-us.net>
 <CABqG17jXyx4GQqa2M7w78r0F99FzsqpNhft3w3jtUGKuBbfCDg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CABqG17jXyx4GQqa2M7w78r0F99FzsqpNhft3w3jtUGKuBbfCDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/23 04:28, Naresh Solanki wrote:
> Hi Guenter,
> 
> 
> On Fri, 28 Jul 2023 at 15:30, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 7/28/23 01:25, Naresh Solanki wrote:
>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>
>>> MPS returns PGOOD instead of PB_STATUS_POWER_GOOD_N.
>>> Fix that in the read_word_data hook.
>>>
>> Datasheets are not public, so I can not verify, but the code below
>> only handles MP2973 and MP2971. What about MP2975 ?
> I dont have MP2975 to even verify. I'm not sure if its applicable.

Maybe Vadim can check / confirm.

Guenter

>>
>> Either case, this appears to affect most Monolithic chips, but
>> not all of them. Please limit the statement to known to be affected
>> chips.
> Yes. With what we observed, this affects mp2973 & mp2971.
> Will update accordingly.
>>
>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>> ---
>>>    drivers/hwmon/pmbus/mp2975.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
>>> index 28f33f4618fa..410b6eae6d02 100644
>>> --- a/drivers/hwmon/pmbus/mp2975.c
>>> +++ b/drivers/hwmon/pmbus/mp2975.c
>>> @@ -297,6 +297,10 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
>>>        int ret;
>>>
>>>        switch (reg) {
>>> +     case PMBUS_STATUS_WORD:
>>> +             ret = pmbus_read_word_data(client, page, phase, reg);
>>
>>                  if (ret < 0)
>>                          return ret;
>>
>> Please add a comment explaining what is going on.
> Sure.
>>
>>> +             ret ^= PB_STATUS_POWER_GOOD_N;
>>> +             break;
>>>        case PMBUS_OT_FAULT_LIMIT:
>>>                ret = mp2975_read_word_helper(client, page, phase, reg,
>>>                                              GENMASK(7, 0));
>>>
>>> base-commit: a4bb1ce5b9e3ca403c04e20ebeae77fd6447cb11
>>

