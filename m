Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22C576B79E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjHAOeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjHAOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:34:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BC72D42;
        Tue,  1 Aug 2023 07:34:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc02bd4eafso24207795ad.1;
        Tue, 01 Aug 2023 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690900465; x=1691505265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xHhRQmbCg4O3179y6cKPQtsJFD2KjC09QMqMZ11mBjw=;
        b=pFRravnTUXrhLKIMqlyFZuULcJLwXndfIzHJi8iy6c08xYIwEwfYZSQLguMdJYQBXK
         lmr3YkCfMvDRJ14aRGCZTvniwp7M3CtHtkRiLg9YZhJNb+JeaLt0UrY9nb6kcFSdAsgL
         jLzViZIUASjvSkTjukCB8Vuqu+LRSkszEQX1mCl+9+U+c2lnYo+QBWJ3dTZOu+EXwLIk
         SW1QN59g/ZNtNY6roo/gno6E78kY/QaCdW1JQP5xTbDm79PCrEnui5rKG/4RYvvpGBiJ
         P+8vqCwnlyy7A/ls1xZNCXXxDQfWQXxpnAIjsCb1L/0w6PFP9J5DmUh29m9Q99BitBkv
         i6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900465; x=1691505265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHhRQmbCg4O3179y6cKPQtsJFD2KjC09QMqMZ11mBjw=;
        b=WPJ4m1qYiIHe2tfmN+cQ8SBWEZmVquzc6WWNiNMr+C43oHbIA5wrfbSK0qu+UdCuMA
         4qYuhqqZKekUs2n2bnDaVgkJ0B5pIUu6RtKHRtq3SymEBuTI1X27QtDoXCWFTSX8pPNO
         wwlY8ys3+8upbhxtNw9sYEcz7a25kOcvj276htcP0S3C3YzXWchv+bgjOoDxvXaF1f3F
         YJdkYCAYF3kbDBHrZRw0brsO3gU4ftXptk01vDKPwzYPXciLYwjLYfDKkJk7iiwmbpkx
         +StIksLhQL21vkkvcJT/8EVrPuKaurlDE4kRGNkqLC+RlgaVUHCQddJv1FVljiFBmDTG
         Bq2w==
X-Gm-Message-State: ABy/qLbrsyy43Fjjvf2TUQ7CtBlHIb+05xIQKKNtfnUZhfmrbKLuJzC+
        frxK9hUjMVpxHZF+m87VDWw=
X-Google-Smtp-Source: APBJJlEkWwjbeNqMRDFAEgc80WRaBcX4J3hR6pzAIh6qSIal+TrOdrvKAahRi1oD5p2ynoH4uNgjoA==
X-Received: by 2002:a17:902:c94a:b0:1b9:e81f:fb08 with SMTP id i10-20020a170902c94a00b001b9e81ffb08mr17874697pla.55.1690900464923;
        Tue, 01 Aug 2023 07:34:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001b03cda6389sm10580261plp.10.2023.08.01.07.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 07:34:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b4097ed6-95d6-b11b-9c9e-edd6e8c51d00@roeck-us.net>
Date:   Tue, 1 Aug 2023 07:34:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus/tda38640) Add workaround for bug in
 SVID mode
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20230727091358.3274620-1-Naresh.Solanki@9elements.com>
 <20230727091358.3274620-2-Naresh.Solanki@9elements.com>
 <41a8ae4b-0f96-9f26-f25b-b1554b2695d6@roeck-us.net>
 <CABqG17jKoJ8FJdA-vpX8uda9yi_ir3f2FxFAiE7GTaVM7Mb2aA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CABqG17jKoJ8FJdA-vpX8uda9yi_ir3f2FxFAiE7GTaVM7Mb2aA@mail.gmail.com>
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

On 8/1/23 05:34, Naresh Solanki wrote:

[ ... ]

>>> +     if (IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR) || svid) {
>>
>> If you hide this behind IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR), reading
>> svid outside the if() statement has no value.
> svid mode check is needed only when regulator is enabled for on/off
> control later.
> Will align the code such that if svid_mode check is done only when
> REGULATOR config is enabled
> & if it is in svid mode then apply the WA.
> 
>>
>>> +             /*
>>> +              * Apply ON_OFF_CONFIG workaround as enabling the regulator using the
>>> +              * OPERATION register doesn't work in SVID mode.
>>> +              *
>>> +              * One should configure PMBUS_ON_OFF_CONFIG here, but
>>> +              * PB_ON_OFF_CONFIG_POWERUP_CONTROL and PB_ON_OFF_CONFIG_EN_PIN_REQ
>>> +              * are ignored by the device.
>>> +              * Only PB_ON_OFF_CONFIG_POLARITY_HIGH has an effect.
>>
>> Hmm, maybe I start to understand. This is really weird, since it changes
>> the polarity of the EN input pin, effectively reverting its value.
>> In other words, what really happens is that it is not possible to disable
>> the chip with PMBUS_ON_OFF_CONFIG in SVID mode, and that reverting
>> the EN pin polarity effectively simulates turning the chip on or off by
>> software. Maybe software enable is disabled on purpose in VID mode.
>> Is that really a bug or is it a feature, and is it really a good idea to
>> override it ?
> By design, SVID mode only has HW control enabled.
> This was with the assumption that PGOOD will be used for controlling
> Enable of another rail in Hardware.
> 
> Since my use case needs the complete PMBUS based control,
> EN pin polarity flipping can be used for controlling output.
> 

So, effectively, this is not really a bug. It is working around chip functionality.

That means we can not just enable this unconditionally in SVID mode after all.
Sorry, but it has to be configurable after all, with appropriate explanation.

Guenter

>>
>> AN_2203_PL12_2204_184108 might really help here.
>>
>> Guenter
>>
>>> +              */
>>> +             data->info.read_byte_data = tda38640_read_byte_data;
>>> +             data->info.write_byte_data = tda38640_write_byte_data;
>>> +     }
>>> +     return pmbus_do_probe(client, &data->info);
>>>    }
>>>
>>>    static const struct i2c_device_id tda38640_id[] = {
>>

