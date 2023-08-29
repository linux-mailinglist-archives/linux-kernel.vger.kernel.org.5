Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0022778C7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbjH2OpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjH2Ooy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:44:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84ACC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:44:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c1f7f7151fso10407015ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693320291; x=1693925091;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+rGTB+48zmHkW5Ip2UuHS5SfFJEUX2etU06P2q7Ut4=;
        b=FKocU6+DFFVLNWdivRs0quPgzj9rMXVG5YAQP5esBA7BqEYrrkrQNwe3SFfsVg/P/8
         Jgtfr6AvD+lj/5dQPVggIesstGPhPQzVcD6BGdd2FcoVIWzKrHa31QJ7KBMD83vgN0iF
         V72kIf8gbJP/KmLN6NB/34DQEjECWgt2NOqmWBujPn+H4cQUSntdINKrcJ7yEd62hstD
         Lrxd+JAnbd1uG4ibPADfK7nE6zrsHLmkDgyepqLjeTJZ/Em3WxYzgzpJ4cYCkU+u0ca4
         uPt6uxgFDVzhio9HUbgXp10SDBuvBH4SJ2iCEQrUGGpT1tm/ysZamOiAk15zWpcqj6C5
         8uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693320291; x=1693925091;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+rGTB+48zmHkW5Ip2UuHS5SfFJEUX2etU06P2q7Ut4=;
        b=WMw56zN35J2UEgyyQ23PSg3Lk6e1zo8oQ5S0BEkz/T+9/FK/+bLH+RiB0aAh//uF7p
         aZfBUaB8Fb37furTnqq9EdTKCNttx7W+Wj49WwPc+i8FxCJryFK98NAAV9yil/5BYwIc
         gSa9SNgrrOPXFCStDpEnaPMY+dG9g3+9odrYUyv4aJ7z6KwwmV50CInuFSIaTLYi3bsH
         eI/VjZv3vC+WtUsvDONIBqWl9zQhnAN3HjwoBE3pErcUmX49pbUOvXuMx8685Q+HOmmd
         Ris8enfWFkJ18698prIgzf5ndVFJxckL86BrCeGlzN9bx8LgpXurCnK0Lfyn28AyNXFq
         jaTA==
X-Gm-Message-State: AOJu0Yx+Yib3nI6x2caLmGRAexcAo6+g278plcVwUofHnRqaJVXkYC0V
        FFYRymwElODhglmASebcHYs=
X-Google-Smtp-Source: AGHT+IGGrKNAd0fTswqQnCDYNLsZiB1gx98rO3aov17wG8s3z8TAGy/BgqxlzmIZjs8lQ82cAfIBqw==
X-Received: by 2002:a17:902:e887:b0:1bd:e9de:ccc3 with SMTP id w7-20020a170902e88700b001bde9deccc3mr27510971plg.50.1693320291576;
        Tue, 29 Aug 2023 07:44:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jf15-20020a170903268f00b001bb3beb2bc6sm9394894plb.65.2023.08.29.07.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 07:44:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4bf71d86-d8a9-dce8-6a14-fc4b47325a7b@roeck-us.net>
Date:   Tue, 29 Aug 2023 07:44:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
 <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
 <ZO36g3IOX7UU0X5l@smile.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] ACPI: processor: Move MWAIT quirk out of acpi_processor.c
In-Reply-To: <ZO36g3IOX7UU0X5l@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 07:02, Andy Shevchenko wrote:
> On Tue, Aug 29, 2023 at 03:54:18PM +0200, Rafael J. Wysocki wrote:
>> On Tue, Aug 29, 2023 at 3:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>> On Mon, Jul 10, 2023 at 05:03:29PM +0300, Michal Wilczynski wrote:
>>>> Commit 2a2a64714d9c ("ACPI: Disable MWAIT via DMI on broken Compal board")
>>>> introduced a workaround for MWAIT for a specific x86 system.
>>>>
>>>> Move the code outside of acpi_processor.c to acpi/x86/ directory for
>>>> consistency and rename the functions associated with it, so their names
>>>> start with "acpi_proc_quirk_" to make the goal obvious.
>>>>
>>>> No intentional functional impact.
>>>
>>> Except for:
>>>
>>> ia64-linux-ld: drivers/acpi/acpi_processor.o: in function `acpi_early_processor_control_setup':
>>> acpi_processor.c:(.init.text+0x712): undefined reference to `acpi_proc_quirk_mwait_check'
>>> ia64-linux-ld: drivers/acpi/processor_pdc.o: in function `acpi_early_processor_set_pdc':
>>> processor_pdc.c:(.init.text+0x72): undefined reference to `acpi_proc_quirk_mwait_check'
>>>
>>> which breaks all ia64 builds.
>>>
>>> Time to retire that architecture yet ? No one but me seems to even
>>> build test it.
>>
>> Including 0-day it seems.  This had been in linux-next for several weeks.
> 
> IIRC someone explicitly asked to shut down 0-day on ia64. Maybe I'm mistaken?
> I would suggest to ask internally Dave Hansen et al for this.
> 

Actually, that is correct. Build testing it was removed from 0-day on request
from Ard Biesheuvel in preparation of its removal from the Linux kernel.

I'll stop build testing it as well.

Thanks,
Guenter

