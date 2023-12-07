Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8791809203
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443837AbjLGUEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGUED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:04:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4437C10F8;
        Thu,  7 Dec 2023 12:04:10 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b27726369so14655875e9.0;
        Thu, 07 Dec 2023 12:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701979449; x=1702584249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPdhFxsBVnkqTvS8ezSKamUWb7wOv1btcHzaU0R2xY0=;
        b=VsWDWIXJgDN5PH2TNUKRUcOgCR0lHtt16AZyl1LBSvwlTmjSXMo1Pa8g7XT5/dWArW
         5CHFwZPIOtTAKMT6xOW/C+9QutN4DuG93gZzkfgmCy6ZGqBGUqaiqrcYVDmoQAVw+amX
         vS2EYJQ47mTFFck6yQxgBWfrR6G6QLAGtwEGRpwTfumGnzZaCyqTm7I7Me5lMihiKxC8
         YEW8qzgcGbtB1toomWRbTBU2SD5uht821T/MEMB10fdBtNQOBgiCNsxFD8B94kdTndg+
         RQ1kgXy5gchkh2YVU3LgnSe4JQtod3T9TdQAPdyI/9Xs6RD2FV/GhrkP0SoPlp4vHchM
         xndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701979449; x=1702584249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPdhFxsBVnkqTvS8ezSKamUWb7wOv1btcHzaU0R2xY0=;
        b=lIFaeRFhZpHGiaWjsirWbKJFrmf1kMsb0I15NFDct1K7/t+hoc+DZqxViafyp1IJhO
         w/WB3CFqPwVt1nQMttjsuX+LwwAB41Zg+uIx8jsgBiPDt6C/3eQ+MnvdOSCUdkm/HALr
         Wu8pKi4OnhMgU8lJJu85vRgGbwYHiwN18zIR6/fM9gcEqTOgV310cAQf3qWeko5YOcR4
         uvyCoglz18EaIX6yq76BAifHZXWiq8y4JXI8C0/gBEo6IyVm2nbyD064dHsX+iBShc6b
         ++s51cPvBTH9KhjCJbOmdG4hxpx794CD61xsx0y3SnwOZWUIsvFSOPblonDuAn/e8+PV
         WfNg==
X-Gm-Message-State: AOJu0YwL1rakppDa9dEItDvZN6EHt5ZCCp/sCDx6hV0c/y+9t0uaqRFU
        EUQ7Zw9Q0fv2wmRBoyG2cU/cH61aT2RHew==
X-Google-Smtp-Source: AGHT+IH6S8jD+87WBwTSo5zB7IDzZ9wZV7qV2rAJaKhRe+OzzXyGb3JcmduBwrp1uFHBBhyLqK2Fag==
X-Received: by 2002:a05:600c:2146:b0:40c:2b86:8363 with SMTP id v6-20020a05600c214600b0040c2b868363mr690550wml.170.1701979448544;
        Thu, 07 Dec 2023 12:04:08 -0800 (PST)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090676d200b00a1d9733f2d9sm135663ejn.209.2023.12.07.12.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 12:04:08 -0800 (PST)
Message-ID: <f6522abb-885d-4476-bf27-5ee8b48138bd@gmail.com>
Date:   Thu, 7 Dec 2023 21:04:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     savicaleksa83@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: Add driver for Gigabyte AORUS Waterforce AIO
 coolers
To:     Armin Wolf <W_Armin@gmx.de>, linux-hwmon@vger.kernel.org
References: <20231207122402.107032-1-savicaleksa83@gmail.com>
 <ce3568c5-c35b-40b5-80f1-8334d1b3549b@gmx.de>
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <ce3568c5-c35b-40b5-80f1-8334d1b3549b@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-07 20:39:23 GMT+01:00, Armin Wolf wrote:
> Am 07.12.23 um 13:23 schrieb Aleksa Savic:
> 

...

>> +
>> +static struct hid_driver waterforce_driver = {
>> +    .name = "waterforce",
>> +    .id_table = waterforce_table,
>> +    .probe = waterforce_probe,
>> +    .remove = waterforce_remove,
>> +    .raw_event = waterforce_raw_event,
>> +};
>> +
>> +static int __init waterforce_init(void)
>> +{
>> +    return hid_register_driver(&waterforce_driver);
>> +}
>> +
>> +static void __exit waterforce_exit(void)
>> +{
>> +    hid_unregister_driver(&waterforce_driver);
>> +}
>> +
>> +/* When compiled into the kernel, initialize after the HID bus */
>> +late_initcall(waterforce_init);
>> +module_exit(waterforce_exit);
> 
> Hi,
> 
> I think you could use the module_hid_driver() macro here.

As far as I'm aware, hwmon will get built before hid, so a late_initcall()
is necessary for this to function when compiled as a built-in driver. Other
HID drivers in hwmon also do this (see nzxt-smart2 for an example).

Aleksa

> 
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
>> +MODULE_DESCRIPTION("Hwmon driver for Gigabyte AORUS Waterforce AIO coolers");

