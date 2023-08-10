Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C456A777FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjHJSBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjHJSBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:01:33 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6DA10C0;
        Thu, 10 Aug 2023 11:01:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686ea67195dso898720b3a.2;
        Thu, 10 Aug 2023 11:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691690492; x=1692295292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JoXLzjGi/iLguEZkDKCbxYQhyAAHoV9nL8nrSqpg4FY=;
        b=YwXhuvp8VMBqRhu/Ax+rXBuJ95fHDTPZ1s8/pXdkIIpPSipcd/d53KVOCoEofFic9W
         V/9DmbNTsGJd61jw93oe8CRz1OiRMJS6sbRm0U1ESGpAadlsaurTSj62ZS1AJhYZrAIO
         zG9v39Uo6nEjCJB7Ip3pokiAfqi2gznB0nqPkvt2fwEl18uiTAAS5MUIm5h2JMykGGKQ
         q3DClG+rdQ9J7sgn+jZVVZjGgnNdaXOH3dJU04D3nvoooSfP0pq67pZymESSLVTHG/Xa
         ejuaMXZsgLxnLErxDG3afMn72XuwpxWn1qVQ3PaFJ4SUMiT9o2hNgt8aPkMVrY9rX/UK
         b0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690492; x=1692295292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JoXLzjGi/iLguEZkDKCbxYQhyAAHoV9nL8nrSqpg4FY=;
        b=hgLuuGa8wnuGWp0Ds+oe4/OG2J6oduTG4QMhjbg2wpj/lYCBiEcZDq58n7tanSVXqg
         N80zUVmfBTvuLe4Q5KRu0YO2FWvNYEDIyWs6uVDQva+j8oUymPqd11w+Fq0WxeYV61DT
         Dhch5H8n8R9oOoMAWYlvBmBJkxvl3dlHBxoJRDvGqlAwisevWiXp44pGtpXu+6v7isGz
         Pw0HegI1l8rkx3ImTR18tzJc9EnsI8Qk612dHyj+hJAXT74wcQv0h9Tur2OEqKYDhx9x
         UJoGcHjieEi65EvNY3vriSjbndIxNetUYQM2BZDVCHte16Wa3RRdWVNb5Af/p03qJYW1
         mG8w==
X-Gm-Message-State: AOJu0Ywi10/cRXd8mQH1XU6hbUjQEPtP9pp+FovQGJeCCxzzxO6H3FSM
        aQSxZVSLzKNxrIvT0hXDf/9JI8eHvVE=
X-Google-Smtp-Source: AGHT+IHJYYKuWVHTmU0a/0HYDIkQFgy6HOLdjSIHLGPmF2bKpzDzVMzOznPUopVPgCLn5n48Ldv6Yw==
X-Received: by 2002:a05:6a00:1994:b0:67d:22a6:2f54 with SMTP id d20-20020a056a00199400b0067d22a62f54mr3374763pfl.31.1691690491666;
        Thu, 10 Aug 2023 11:01:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b005d22639b577sm1806394pfn.165.2023.08.10.11.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 11:01:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2322cf5f-66e2-cba1-a95a-83bceb3aa2c8@roeck-us.net>
Date:   Thu, 10 Aug 2023 11:01:29 -0700
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

Besides, those function names are _way_ too generic for public symbols,
and even more so for exports.

Guenter

