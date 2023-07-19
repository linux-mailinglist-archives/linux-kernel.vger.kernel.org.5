Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59C57596B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGSN10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjGSN1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:27:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF4E10A;
        Wed, 19 Jul 2023 06:27:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso42890765ad.2;
        Wed, 19 Jul 2023 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689773241; x=1692365241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vEZpNOYS9nfEBGq46i0VO/JDsbT3stpNrnYlf/F2Bm4=;
        b=G8vFs7rlJXCbgpn4q2delBk60nXYL9q0Qrzx234KnTpOjs1JPIbA2FQMBVxQXW3D27
         BD22ZYk8nL3ap3wHIHgmXAhTgCxB7uJDsMt1ojnGbfDJs9E3XWi/4GM16vsst2/iML/k
         DcovuDihH0Dv8GRLv00BVZuvv/lr/TmzA/M4Z6wxNGxlysM6qqwrestKAx0EhclxJWcS
         rpeitkAxPXYNgEGvbj9uBJXrR3VbTTflsmklPyy39sTQENEK4nXRmEWQZyuKp11JtqVx
         juORTCPYUbKyCbJ0OrFpuIe1Q4t1kVRDBUnyBZUdIkf2f2gDFbEebv5t7A0yV3zeRmPH
         MPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689773241; x=1692365241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEZpNOYS9nfEBGq46i0VO/JDsbT3stpNrnYlf/F2Bm4=;
        b=hTFLnKU1jg8pcc4bW9ZJ8/7zcbCYiNpmCvklqnKq8ODBfm2PnW8hjn/GNuPj4AL2GK
         3LsEU6J56t/coAitxUnFhPRRa5JtiIMHY7Ea+IBJVMy3xJI/3JjD9VgTtDM7G6eZKqRO
         Q5Ep/r60U3kPu742PwNvj4qRnvHkPkx7SJwcn9VUUVW7M0pbjhay9bF1vVG7JIrDJ8Yl
         SByz950pUj7Z2g+qauR9FYflGaDvAWHC/1DGPFbG67sWZV5KjARSB4wDgDR1IZm6pbx1
         LnSasMLJ6HNq+FjJIAwo5pQArPvSaIDuWq2p3Irr5Jd7qkQM6fdK296iQpWnDBM9cHNG
         Okjg==
X-Gm-Message-State: ABy/qLZEb9NQs/BGfsihfb5t6tHR8doc48e7HxwZLmAuefP0e6w0yD5+
        xWabakn+2MEGqGrYSrXSJAkTinHTlz8=
X-Google-Smtp-Source: APBJJlFRapaPzb9hBRolQi+w+L4XrT3Vs1fDe1kfE+rlHHKJYCo78EJMBReRRnmxZupD0fr374+44A==
X-Received: by 2002:a17:902:b086:b0:1b8:9b17:f63d with SMTP id p6-20020a170902b08600b001b89b17f63dmr2294700plr.23.1689773241404;
        Wed, 19 Jul 2023 06:27:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jk16-20020a170903331000b001b8a3dd5a4asm3946916plb.283.2023.07.19.06.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 06:27:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <160cb639-5081-ec50-2c41-fc31502107a2@roeck-us.net>
Date:   Wed, 19 Jul 2023 06:27:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] watchdog: make Siemens Simatic watchdog driver
 default on platform
Content-Language: en-US
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
 <20230718105213.1275-2-henning.schild@siemens.com>
 <ZLafwOPrw+puH+rF@smile.fi.intel.com>
 <20230718164251.13855c47@md1za8fc.ad001.siemens.net>
 <b1528e3d-15f7-7ab2-b803-917f79efe999@roeck-us.net>
 <20230719091816.6661d535@md1za8fc.ad001.siemens.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230719091816.6661d535@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 00:18, Henning Schild wrote:
> Am Tue, 18 Jul 2023 08:10:09 -0700
> schrieb Guenter Roeck <linux@roeck-us.net>:
> 
>> On 7/18/23 07:42, Henning Schild wrote:
>>> Am Tue, 18 Jul 2023 17:20:48 +0300
>>> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
>>>    
>>>> On Tue, Jul 18, 2023 at 12:52:11PM +0200, Henning Schild wrote:
>>>>> If a user did choose to enable Siemens Simatic platform support
>>>>> they likely want that driver to be enabled without having to flip
>>>>> more config switches. So we make the watchdog driver config switch
>>>>> default to the platform driver switches value.
>>>>
>>>> A nit-pick below.
>>>>
>>>> ...
>>>>   
>>>>>    config SIEMENS_SIMATIC_IPC_WDT
>>>>>    	tristate "Siemens Simatic IPC Watchdog"
>>>>>    	depends on SIEMENS_SIMATIC_IPC
>>>>   
>>>>> +	default SIEMENS_SIMATIC_IPC
>>>>
>>>> It's more natural to group tristate and default, vs. depends and
>>>> select.
>>>
>>> Will be ignored unless maintainer insists.
>>>    
>>
>> Maintainer wants to know why "default SIEMENS_SIMATIC_IPC" is needed
>> or warranted instead of the much simpler and easier to understand
>> "default y".
> 
> I thought a "default y" or "default m" was maybe not the best idea for
> a platform that is not super common. That is why i did not dare to even
> think about defaulting any of the Simatic stuff to not-no.
> 
> But it seems that this would be ok after all. And i would be very happy
> to do so because it means less work on distro configs.
> 
> SIEMENS_SIMATIC_IPC_WDT will drive a platform device which gets
> registered by SIEMENS_SIMATIC_IPC and nothing else. That is why
> "default SIEMENS_SIMATIC_IPC" was chosen.
> 

It depends on SIEMENS_SIMATIC_IPC. "default y" would make it y if
SIEMENS_SIMATIC_IPC=y, and m if SIEMENS_SIMATIC_IPC=m. If
SIEMENS_SIMATIC_IPC=n, it won't even be offered as option, and
default={m,y} will be ignored.

> But if i may i would change that to "default m", not "y" because there
> is an out of tree driver package which if installed on top, should be
> able to override the in-tree drivers.
> 
> So i will go ahead and make that one "default m"
> 

Why make it m as default even if SIEMENS_SIMATIC_IPC=y for whatever
reason ? Presumably anyone selecting SIEMENS_SIMATIC_IPC=y would
also want SIEMENS_SIMATIC_IPC_WDT=y, which is what you had before.
Sorry, I don't understand your logic.

Guenter

