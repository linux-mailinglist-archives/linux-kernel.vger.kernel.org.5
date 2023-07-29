Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3557767FB7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjG2Ntk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjG2Nte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:49:34 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5614228;
        Sat, 29 Jul 2023 06:49:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so4462869a12.3;
        Sat, 29 Jul 2023 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638551; x=1691243351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O04QG9kAZVwzjXX/GQxt685W7JymGMktW74tcgO3RaM=;
        b=MpXzBGrJ39RVNDvPRqo5oZlqKTo10qCY2Q29U/2sGubSCMrb55k3sRmti2lp/6bhRG
         cgspOCkt2bwak90XdQhcJItWoISAmAiouAWfs3wAsNsOp0cSPqweSx3FHcwrRMCDRpa5
         qI843BJVJpMPVRKW6uyiiBqOnOG1OMTMnWUFLkSQh9736PLSjvZzEPEpLELEKYUwD5up
         AQe1AIVJRhes27gfP8XY+Aq50MHoiC3ALyLN1uq/tpXYXf9gtK5YZb5uICdZA6NVFlzy
         VPrcTIFQQoe+tKSK3C/WGYt+VKToM5iAqw4YuohL9xoSw6UhGhkF+VRgXn37yenEcLtv
         2b9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638551; x=1691243351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O04QG9kAZVwzjXX/GQxt685W7JymGMktW74tcgO3RaM=;
        b=iGHH14MXcsZ2pcTjdLKx1FXmHyy9fxmScxoFs6Jjxi2hUofqX9dvE2jp/45kT2i2Ao
         388bOr7A+L80GkUE8ZtdAf4pa6T6Tpk0momfcBxRj3XvNZgu4qmwo0+CM82/LrTTEYN3
         vvVtZvQqykDfiq4pTkHhxXqwulp4fvoZlnRw/gGRfJlfTo3ONR3V0ZLsp3VElhxM3upC
         KuS5CVwewnAge9x/6SvQG6rEpf0sPMW0hBDJMXKJAQPQYkRI2zh6kshrmmfNvmWHVqsw
         5HQ/q8U/KlszBYqYv4ceAUObPYK+iO1uQD9bhyN/TSEa1zvKVeeagrYhXfTxZJELVSRJ
         d2cA==
X-Gm-Message-State: ABy/qLaAFMNOZR3TPpjvvEiV5MQUzpMdU4CBsNGDf4E4drjT/O/7V9dG
        UYZUqZDk9oZdYX5VL5LBp5Q=
X-Google-Smtp-Source: APBJJlGTe2b77A93dBgPdasFLw1Hgh5Kjq6lrvVPHzW19cgDg7Ir76oKJCLGV+qQqNTab0db/sOLdg==
X-Received: by 2002:a17:907:2c77:b0:99b:484b:21b5 with SMTP id ib23-20020a1709072c7700b0099b484b21b5mr2717704ejc.8.1690638551535;
        Sat, 29 Jul 2023 06:49:11 -0700 (PDT)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906408700b009786ae9ed50sm3278710ejj.194.2023.07.29.06.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 06:49:11 -0700 (PDT)
Message-ID: <a32106e8-b0e0-97b2-391b-a654f7c5affc@gmail.com>
Date:   Sat, 29 Jul 2023 15:49:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     savicaleksa83@gmail.com, stable@vger.kernel.org,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add selective 200ms delay
 after sending ctrl report
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
References: <20230729112732.5516-1-savicaleksa83@gmail.com>
 <5b988c94-0de3-95fd-de39-66b52a59cdd6@roeck-us.net>
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <5b988c94-0de3-95fd-de39-66b52a59cdd6@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-29 15:44:32 GMT+02:00, Guenter Roeck wrote:
> On 7/29/23 04:27, Aleksa Savic wrote:
>> Add a 200ms delay after sending a ctrl report to Quadro,
>> Octo, D5 Next and Aquaero to give them enough time to
>> process the request and save the data to memory. Otherwise,
>> under heavier userspace loads where multiple sysfs entries
>> are usually set in quick succession, a new ctrl report could
>> be requested from the device while it's still processing the
>> previous one and fail with -EPIPE.
>>
>> Reported by a user on Github [1] and tested by both of us.
>>
>> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/82
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
>> ---
>>   drivers/hwmon/aquacomputer_d5next.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
>> index a997dbcb563f..9cb55d51185a 100644
>> --- a/drivers/hwmon/aquacomputer_d5next.c
>> +++ b/drivers/hwmon/aquacomputer_d5next.c
>> @@ -652,6 +652,31 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
>>       ret = hid_hw_raw_request(priv->hdev, priv->secondary_ctrl_report_id,
>>                    priv->secondary_ctrl_report, priv->secondary_ctrl_report_size,
>>                    HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    /*
>> +     * Wait 200ms before returning to make sure that the device actually processed both reports
>> +     * and saved ctrl data to memory. Otherwise, an aqc_get_ctrl_data() call made shortly after
>> +     * may fail with -EPIPE because the device is still busy and can't provide data. This can
>> +     * happen when userspace tools, such as fancontrol or liquidctl, write to sysfs entries in
>> +     * quick succession.
>> +     *
>> +     * 200ms was found to be the sweet spot between fixing the issue and not significantly
>> +     * prolonging the call. Quadro, Octo, D5 Next and Aquaero are currently known to be
>> +     * affected.
>> +     */
>> +    switch (priv->kind) {
>> +    case quadro:
>> +    case octo:
>> +    case d5next:
>> +    case aquaero:
>> +        msleep(200);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>>       return ret;
>>   }
>>   
> 
> This would force writes to sleep even if there is no subsequent operation.
> Please make this conditional by saving the most recent access time and wait
> on the subsequent operation. I would also suggest to store the wait time
> in struct aqc_data to avoid the switch statement in the data path. An example
> for a driver doing something similar is drivers/hwmon/pmbus/zl6100.c.
> 
> Thanks,
> Guenter
> 

Thanks, will take a look at it. Please ignore v2 of this patch in this case.

Aleksa
