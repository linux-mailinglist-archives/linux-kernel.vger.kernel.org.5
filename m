Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DBC778015
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbjHJSPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjHJSPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:15:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124172718;
        Thu, 10 Aug 2023 11:15:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso1915524e87.2;
        Thu, 10 Aug 2023 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691691332; x=1692296132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHTmSLH18ZieAXbWyRp9gaSEWxvQuArU48jM7LRzZSU=;
        b=IA5sWRDSeXTW2n01lyEDBLPpFT6dsjGTdkysd/vCuUFc8klKS2X193tWX6X4MrCy5p
         rsPiW6D8YpzkWv1VUsXRdI7BFO228h3M1R6UOj62h/SkzI/x8dMVzS9pddEtpVvMOz6Q
         s3Phqi0lJKhm9uwL7I0hfQrLhadj+PMWmMyNRTLVl+4kkyUlL0gWFHj4qVaVJ387VqJk
         Va7hqeROhdyhTJTyZoUjWRJIeYFZ7LyupZy7WKvJlrQYkqJKBoWI4zkUBa4BUuvIXVcO
         7R6ZdqEgu45DvZzhYApwAj0W4rJheeq2ERefxxyk6cL0GQa5YWdJel3v8Iqp7khcCUUw
         Nk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691691332; x=1692296132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHTmSLH18ZieAXbWyRp9gaSEWxvQuArU48jM7LRzZSU=;
        b=hYk6I1M7r7iV6TF+oMB2KZf9PhQtMZ70E5eGbChfqFm3iDxBk4/8gIUdCCdg97hnXC
         e3d0Zr0Fv31NHPKa8ImsSO5ERn5B66NTnJa5rB5jsqGHciXLxzTN0I1hoxhhL2T3LdFj
         /8NKF20xkm3OWPYkS+Mz/ExGW2ASPuijTDv11yohrg1fbD/7+U8AUKodrFA8N5qLqcs+
         meqVSWJuhse5C+ylR7PJsHl/BqtrSuWxGbepAkWm8l0JH0pZHUhj93mrWAKKKaPFfzGP
         9IMnrYZZIaJigg5wEtK3cdVDzjP+8fREupkj09vWTs0ysTdsN3MxfR/U+gidfs0AyJds
         BcPw==
X-Gm-Message-State: AOJu0Yxn+8RnSSUmQ9PxU9eI8GryXPndNairLvTQTml3wKs5C0HVuMX/
        sR+uAn3sFrPx5uQXjMWWK8g=
X-Google-Smtp-Source: AGHT+IEjJa/JtzKG9l6FJ43pIZz+0MCfvVWKDhvHqE1i/cXYYG4FEMAodjXL6+DCyDiepuSju/oI0Q==
X-Received: by 2002:ac2:5f92:0:b0:4fe:1f27:8856 with SMTP id r18-20020ac25f92000000b004fe1f278856mr2147011lfe.7.1691691331937;
        Thu, 10 Aug 2023 11:15:31 -0700 (PDT)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id r25-20020aa7da19000000b005233625e7a5sm1092467eds.75.2023.08.10.11.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 11:15:31 -0700 (PDT)
Message-ID: <e7bcf401-991c-808c-66df-65664940bf22@gmail.com>
Date:   Thu, 10 Aug 2023 20:15:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     savicaleksa83@gmail.com, linux-hwmon@vger.kernel.org,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (aquacomputer_d5next) Add selective 200ms delay
 after sending ctrl report
To:     Guenter Roeck <linux@roeck-us.net>
References: <20230807172004.456968-1-savicaleksa83@gmail.com>
 <c151d464-da26-4c53-ba7a-d16bb8fca949@roeck-us.net>
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <c151d464-da26-4c53-ba7a-d16bb8fca949@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-10 06:09:13 GMT+02:00, Guenter Roeck wrote:
> On Mon, Aug 07, 2023 at 07:20:03PM +0200, Aleksa Savic wrote:
>> Add a 200ms delay after sending a ctrl report to Quadro,
>> Octo, D5 Next and Aquaero to give them enough time to
>> process the request and save the data to memory. Otherwise,
>> under heavier userspace loads where multiple sysfs entries
>> are usually set in quick succession, a new ctrl report could
>> be requested from the device while it's still processing the
>> previous one and fail with -EPIPE. The delay is only applied
>> if two ctrl report operations are near each other in time.
>>
>> Reported by a user on Github [1] and tested by both of us.
>>
>> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/82
>>
>> Fixes: 752b927951ea ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Octo")
>> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> 
> I would have suggested to use fsleep() to avoid unnecessary
> sleep times if they are small, bt I guess it doesn't make much
> of a difference.

Will keep that in mind.

> 
> Applied.

Will this patch perhaps be marked for stable?

Thanks,
Aleksa

> 
> Thanks,
> Guenter

