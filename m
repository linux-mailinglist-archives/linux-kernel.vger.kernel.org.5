Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7935769853
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjGaNxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjGaNxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:53:04 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7221991;
        Mon, 31 Jul 2023 06:52:14 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34914684b62so7014565ab.3;
        Mon, 31 Jul 2023 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690811533; x=1691416333;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+BGX12rEZmO+eX68NKoc53wkrA6jDJOTyW13wKmAQs=;
        b=gxFckBXvN+ViFd+2GkW3w28FV3UEeg30V3/Dt0TXduUWz3E3hjuulEetDl3dxRM+KX
         /B5VvCxwTH4kGk4qv1wCaznmJ+tmcf5BWOZuf2z+k54zaI4P8BWt94ZhXM4zgF4qMnMz
         ejv0MxDv6lKof4hVbtilG+D3adl0jlNN7cHneNz3327BGRZWxNyioPF+lnNuQ4LavQ77
         XAHC4BBv2mhn9bh0dsDzIaB2jxpWunDvz9Zym10W9pJzzDVlhPLYXQZb0FCLzOzIAo3V
         fbrfDTpq4r+g9A9w/EtcNw26icobnqwMLcBX7dHGBpmiJu4umptOh6UpoRMOyC0H2eYA
         jaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690811533; x=1691416333;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+BGX12rEZmO+eX68NKoc53wkrA6jDJOTyW13wKmAQs=;
        b=jnCyyfMfMzcLV34dvxK4/8yqs6N4j+cD72nhksTPOHcB72fNYbezGVuudqDiUhsOm1
         NFRTAF0W/ZgGA8RQr/Y6R5lDgcvknIdPuGBl5B6lEP/X+CHTu7MxVKBu21jmc9HFg5oP
         9qArVW5cbHAfZhSc6XNBKEZDl3C9LnWB6Ap5OZZhLPHXA/wSQ23sSr8NsWefDSOiutuD
         O5V5iODJbfgqH05b/WMCYn61f9NXocA7NjQmcyLU7o3KVROj+QNsMC27e+eNSfJx1Mmv
         AwfzhbkNVkf2C50zWaW7R7KSthAyWKDGl3A6nzevRD4rEsR4DzHHFneBgy6MJuvvfX0W
         FafA==
X-Gm-Message-State: ABy/qLa5/mswoHacXD954BnJgec2S2N7NR0aBZie7RXaMGWrjao860KD
        Mo/C8qJli4dzH/hNuXYGYDc=
X-Google-Smtp-Source: APBJJlHer3n3A7Q6OSdK0AlXm3MTs0aOpYkULQ2tOETxnKp4meaupWxFyOMrfhn7jAp4mya7JG/+EA==
X-Received: by 2002:a92:c54e:0:b0:348:d89b:268 with SMTP id a14-20020a92c54e000000b00348d89b0268mr10405126ilj.7.1690811533581;
        Mon, 31 Jul 2023 06:52:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h12-20020a02cd2c000000b0042b10d42c90sm3022784jaq.113.2023.07.31.06.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 06:52:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0080432d-f77f-7fd5-34fe-f8ae9bcc0c23@roeck-us.net>
Date:   Mon, 31 Jul 2023 06:52:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Vadim Pasternak <vadimp@nvidia.com>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230731092204.2933045-1-Naresh.Solanki@9elements.com>
 <BN9PR12MB53819FE51F98D80CE6F5A724AF05A@BN9PR12MB5381.namprd12.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD
In-Reply-To: <BN9PR12MB53819FE51F98D80CE6F5A724AF05A@BN9PR12MB5381.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/31/23 02:54, Vadim Pasternak wrote:
> 
> 
>> -----Original Message-----
>> From: Naresh Solanki <naresh.solanki@9elements.com>
>> Sent: Monday, 31 July 2023 12:22
>> To: Guenter Roeck <linux@roeck-us.net>; Jean Delvare <jdelvare@suse.com>
>> Cc: Vadim Pasternak <vadimp@nvidia.com>; Patrick Rudolph
>> <patrick.rudolph@9elements.com>; Naresh Solanki
>> <Naresh.Solanki@9elements.com>; linux-hwmon@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH v2] hwmon: (pmbus/mp2975) Fix PGOOD in
>> READ_STATUS_WORD
>>
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> MP2973 & MP2971 returns PGOOD instead of PB_STATUS_POWER_GOOD_N.
>> Fix that in the read_word_data hook.
>> MP2975 might be affected but needs verification.
> 
> Hi,
> 
> According to MP2975 regmap datasheet for STATUS_WORD, bit 11 reports:
>   11	 POWER_GOOD_N	1’b0: PG is active.
> 				1’b1: PG not active has occurred
> Is it the same what stays MP2971 and MP2973 docs?
> 

I don't have a datasheet for any of the chips, so I can not confirm
either way. The above looks like the standard definition, suggesting
that MP2975 would not be affected.

If that is the case, the commit should say that MP2975 is not affected
according to the datasheet, but that this has not been confirmed on
real hardware (unless you can confirm it).

Thanks,
Guenter

> Thanks,
> Vadim.
> 
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   drivers/hwmon/pmbus/mp2975.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/hwmon/pmbus/mp2975.c
>> b/drivers/hwmon/pmbus/mp2975.c index 28f33f4618fa..27bb39370662
>> 100644
>> --- a/drivers/hwmon/pmbus/mp2975.c
>> +++ b/drivers/hwmon/pmbus/mp2975.c
>> @@ -297,6 +297,11 @@ static int mp2973_read_word_data(struct i2c_client
>> *client, int page,
>>   	int ret;
>>
>>   	switch (reg) {
>> +	case PMBUS_STATUS_WORD:
>> +		/* MP2973 & MP2971 returns PGOOD instead of
>> PB_STATUS_POWER_GOOD_N. */
>> +		ret = pmbus_read_word_data(client, page, phase, reg);
>> +		ret ^= PB_STATUS_POWER_GOOD_N;
>> +		break;
>>   	case PMBUS_OT_FAULT_LIMIT:
>>   		ret = mp2975_read_word_helper(client, page, phase, reg,
>>   					      GENMASK(7, 0));
>>
>> base-commit: cb7022b8976e3c4d12cea2e7bb820a2944e2fd7b
>> --
>> 2.41.0
> 

