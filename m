Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0BC777FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjHJSAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjHJSAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:00:06 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F2FED;
        Thu, 10 Aug 2023 11:00:05 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a734b8a27fso867070b6e.1;
        Thu, 10 Aug 2023 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691690405; x=1692295205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8EfJjiI5CCRznpKCFp2Z5nEKWP1wvW3oIKw9fcrfYrw=;
        b=HRYo6xnQ+2c1b93UMvxxPlDOupR9Ri5jzP+pbq+/OhPSOgSjYLxMDkE0DIWiymnMyY
         0v0ZkTQrN9sYES+U5H5zdwVLknTb6TXztMSCC8LP9UT6CbgV5EmCzSc35+2bGgzGow3b
         w7EwVTVc2MpH2Gh5TpH/WFgwsAV4dLYrDeo00flZoVcZzjV6o4N3wu7aLuZGZdkDJNe0
         cnvRHa++dOxiv6aViEpIZghNkF1eLTVaLGzRNKlmN+5e4smXaGMeU7jEnVoY45Pj48KQ
         wJDt7zHyXUhIs1bIE2mhIo09YdBYkjEV1ka5Zjc5ovbJvDIpCfovSfMYzJfwqrnkmwFa
         x5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690405; x=1692295205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EfJjiI5CCRznpKCFp2Z5nEKWP1wvW3oIKw9fcrfYrw=;
        b=BoGrL/qzn91eBb7FouQcMOyhE+FdxBGbIOeKNIiQnU05tDca3Ei42puqhdxuRFH8VA
         L7iEZnAsSunqRqDml1YZgqBV3UQ0paEV2CjqnXN+0chcx8GbL19xg3m1ygXHDoxg2Ntb
         3COW8Ifr/zEBfc0+C4EZDMjKAh+hGJ0y8qS7+e5RQDGPAOpxj8WgRKficCZLggmTWmkv
         ZQsCOb/rdt0T2RdPbvblcNIQMFfhbe0kyQyEbj0EN89779jkVYTbOXvwoqZBfiCcxOza
         7BRlaSLzRkv6thyZaY/vWIQrLA91fh5zxoUNM4yDLFwgY3cZY9Ra40DDL/iMk3JJHc4J
         MaIg==
X-Gm-Message-State: AOJu0YxSc2lnNY/crVUQC5kbuHZ/3sWGzWUKKlbdO7+hTF4MA8czpbOw
        QvbvERvxoz5vxv1yjcmo0yTh0f2i0IM=
X-Google-Smtp-Source: AGHT+IHqBa5ZaBWBf4p6Xn4hXk0zEgEOpPM7QH9woU5ibNxcwUIHsOP8j7gUNXhqzGKDAYOyVEOT4w==
X-Received: by 2002:a05:6808:1523:b0:3a7:543d:9102 with SMTP id u35-20020a056808152300b003a7543d9102mr3794071oiw.39.1691690404777;
        Thu, 10 Aug 2023 11:00:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y23-20020a63b517000000b005649cee408fsm1861232pge.0.2023.08.10.11.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 11:00:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a44a0433-9afc-a73a-43f9-6489ecf2c533@roeck-us.net>
Date:   Thu, 10 Aug 2023 11:00:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Add Silicom Platform Driver
Content-Language: en-US
To:     Huibin Shi <henrys@silicom-usa.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
References: <20230718160104.2716-1-henryshi2018@gmail.com>
 <94cbb7d-68a-765-8bdf-5c8f8e41891@linux.intel.com>
 <PA4PR04MB922224D96319862CF987FE459A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <58da791d-866c-ce2f-94bb-1feff8506c2@linux.intel.com>
 <PA4PR04MB922238E924D10FE9A5B2625D9A13A@PA4PR04MB9222.eurprd04.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <PA4PR04MB922238E924D10FE9A5B2625D9A13A@PA4PR04MB9222.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 10:48, Huibin Shi wrote:
> Ilpo,
> 
> See my comments below.
> 
> Thanks.
> Henry
> ----Original Message-----
> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Thursday, August 3, 2023 8:07 AM
> To: Huibin Shi <henrys@silicom-usa.com>
> Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; hdegoede@redhat.com; markgross@kernel.org; jdelvare@suse.com; linux@roeck-us.net; linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-hwmon@vger.kernel.org; hb_shi2003@yahoo.com; Wen Wang <wenw@silicom-usa.com>
> Subject: RE: [PATCH] Add Silicom Platform Driver
> 
> Caution: This is an external email. Please take care when clicking links or opening attachments.
> 
> 
> On Fri, 28 Jul 2023, Huibin Shi wrote:
> 
>> Ilpo,
>>
>> Thanks for the comments. See my comments below.
>>
>> Updated patch will be sent out later after review comments from other reviewer are addressed.
>>
>> Henry
>> -----Original Message-----
>> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Sent: Wednesday, July 19, 2023 8:13 AM
>> To: Henry Shi <henryshi2018@gmail.com>
>> Cc: hbshi69@hotmail.com; tglx@linutronix.de; mingo@redhat.com;
>> bp@alien8.de; dave.hansen@linux.intel.com; x86@kernel.org;
>> hpa@zytor.com; hdegoede@redhat.com; markgross@kernel.org;
>> jdelvare@suse.com; linux@roeck-us.net; LKML
>> <linux-kernel@vger.kernel.org>; platform-driver-x86@vger.kernel.org;
>> linux-hwmon@vger.kernel.org; hb_shi2003@yahoo.com; Huibin Shi
>> <henrys@silicom-usa.com>; Wen Wang <wenw@silicom-usa.com>
>> Subject: Re: [PATCH] Add Silicom Platform Driver
>>
>> Caution: This is an external email. Please take care when clicking links or opening attachments.
>>
>>
>> On Tue, 18 Jul 2023, Henry Shi wrote:
>>
>>> The Silicom platform (silicom-platform) Linux driver for Swisscom
>>> Business Box (Swisscom BB) as well as Cordoba family products is a
>>> software solution designed to facilitate the efficient management
>>> and control of devices through the integration of various Linux
>>> frameworks. This platform driver provides seamless support for
>>> device management via the Linux LED framework, GPIO framework,
>>> Hardware Monitoring (HWMON), and device attributes. The Silicom
>>> platform driver's compatibility with these Linux frameworks allows
>>> applications to access and control Cordoba family devices using
>>> existing software that is compatible with these frameworks. This
>>> compatibility simplifies the development process, reduces
>>> dependencies on proprietary solutions, and promotes interoperability
>>> with other Linux-based systems and software.
>>>
>>> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
>>> ---
>>>   drivers/platform/x86/Kconfig            |   12 +
>>>   drivers/platform/x86/Makefile           |    1 +
>>>   drivers/platform/x86/silicom-platform.c | 1123
>>> +++++++++++++++++++++++
>>>   3 files changed, 1136 insertions(+)  create mode 100644
>>> drivers/platform/x86/silicom-platform.c
>>>
> 
>>> +void lock_io_modules(void)
>>> +{
>>> +     mutex_lock(&mec_io_mutex);
>>> +}
>>> +EXPORT_SYMBOL(lock_io_modules);
>>> +
>>> +void unlock_io_modules(void)
>>> +{
>>> +     mutex_unlock(&mec_io_mutex);
>>> +}
>>> +EXPORT_SYMBOL(unlock_io_modules);
> 
> These are unused.
> 
> Henry: This will be used by another Silicom driver, which source code is not pushed to kernel repository.
> 

Not an argument. Export it if and when needed. If that other driver won't be sent
upstream, the export should not be upstream either.

Guenter

