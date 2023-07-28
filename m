Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F234766F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjG1O0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbjG1O0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:26:06 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440BA30E3;
        Fri, 28 Jul 2023 07:26:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so1376383b3a.1;
        Fri, 28 Jul 2023 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690554365; x=1691159165;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jiAYhokEZcrTVzxMHL4xFUn+Azr4GzhtRL2PbFtiZek=;
        b=fmbTory/3cYy7n80ExlZcth5qoYwumkWkeH9jVO61kyL28k+zP/RA4kT8W7ffkF/w8
         IkSqomePnMJFSvvHY3XWlUBwbl+PC8cpHqoGJJIhwZ5kBgqXbTVzdVCvTodfh51ohTkw
         w9GU7IXZlFFmeo5JXM3RJwV4IMBTy1dmoQSRU80c5iok7zERhb7Jt/h6v7YNz6qtC8le
         O7luovCK5UMbyp2g3J9QtIg9XcFXFhifDv0sW2pVkuhUv6omwPSoQx/UjCU6vTPiho6e
         8/93WPnINm424J4oe++fQ+PLPNg0m/B4xJX4gMvbV4uOphdMGNoG59QecSdKIMUTcndv
         PtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690554365; x=1691159165;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiAYhokEZcrTVzxMHL4xFUn+Azr4GzhtRL2PbFtiZek=;
        b=b+pAU0MoP2CptsZJ4mGPoAma/xiGb4vqPFyRCp/csjTHK5lF6XawQsNghwg38dG7oV
         gutHNb8TddJVB6GTVSZ1v6sM51OMX/Ud8hhOXfQ6svsL4Ja1IQYTnq0OPPBBvfirGhYd
         8lGZkSawQZ6Q2jT8bxs6P5QyCyNuWjvYyz+Tctk0KShgZLEkC87MAfYi1+227jsns3mx
         7eO7POmjA6sUAjLZZ+ia260ch8vbnHL0Yv+oHPa4HLrXgmwJSVwHAKDeRMk4FJ5NWGo/
         Gf5FsA7WAkNFH2cpJFs7Ni5RIrmycj/WxD+5Qxw+nL3UEAb+YK8LnJMyXwMjFBZk/Q1p
         rNoQ==
X-Gm-Message-State: ABy/qLYrM+/p9GQ+LxT+/hJ9T2ZzMi0wq9o+Pfb1RCJmMvjyY8j6CXt3
        tJkSm6A/Nf8EGmeB9b6PD+rQOzvuTg8=
X-Google-Smtp-Source: APBJJlERqU/HsdiYX+vftDBFUxsU1Lkg2g5PrDtoj6HpURFThjN9d5z/umLp4m3qaXyPMrfdXqu4dA==
X-Received: by 2002:a05:6a20:918b:b0:132:c1fd:aaab with SMTP id v11-20020a056a20918b00b00132c1fdaaabmr1961941pzd.30.1690554364622;
        Fri, 28 Jul 2023 07:26:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r6-20020a63b106000000b00563feb7113dsm3455016pgf.91.2023.07.28.07.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 07:26:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f47d38f8-02e7-3269-2754-300be3d4036e@roeck-us.net>
Date:   Fri, 28 Jul 2023 07:26:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20230728082527.3531940-1-Naresh.Solanki@9elements.com>
 <1cc12337-759e-c932-0303-b1b78e254c27@roeck-us.net>
 <CABqG17jXyx4GQqa2M7w78r0F99FzsqpNhft3w3jtUGKuBbfCDg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD
In-Reply-To: <CABqG17jXyx4GQqa2M7w78r0F99FzsqpNhft3w3jtUGKuBbfCDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
>>
>> Either case, this appears to affect most Monolithic chips, but
>> not all of them. Please limit the statement to known to be affected
>> chips.
> Yes. With what we observed, this affects mp2973 & mp2971.
> Will update accordingly.

Please also add a comment that MP2975 is likely affected but can not be
confirmed due to lack of a datasheet.

Thanks,
Guenter

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

