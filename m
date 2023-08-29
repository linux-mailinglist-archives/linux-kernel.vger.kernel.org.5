Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0216678C6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbjH2OLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbjH2OKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:10:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5EB109
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:10:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdbf10333bso34807015ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693318252; x=1693923052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=W4Pt6z040NHZkdf3YNY29xfoSfcEHKzDfCIB88OLqCc=;
        b=NPn1TD0wCNTp9FNKVOlO7UFRj7ajrtKBdMenkfup4ZPBrvFoEekFMf+Vx4hUDCV5IE
         wcgc0tbmjv5BbNOeNSjFl5T5UcX25g5w4AwmWZD72KLgSx/8tGioGbJQWxLjl7m7hOCZ
         1z8rGu7pXSzkvTTSLStOd9zuF+MD+8Okk/rBNRSf9Qagyv16mbOp54/tWVthMQZo+eUS
         iO3YJfB9fstwhadPQIKcueOjzKxxMJnDgSvNIJ7mQBNLu2kwcsX5fO7X6rwkzrSbfnsL
         NLwyLtMBBDrYMfaDbDBBeGN8FTYMdyRtbEK4Yg2dvciMhHvQl8sjNuwEpMwGLcOP5A12
         MO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318252; x=1693923052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4Pt6z040NHZkdf3YNY29xfoSfcEHKzDfCIB88OLqCc=;
        b=b/daejnHMvOfZCR/awoVbeJ6JSdjXv0RIBe4g1mQDS54j2pDEeFS9c/olAEXA/MRV5
         wYqI9biWx9B3f4KdZ+emnYzr0YZswxN0LNIqkNVwaoqdnYldG5ko44wJe1IauItVcFLz
         gBVY+dIRlJdcUkShR5Ui7g2c7EX5yv4mRqOp91klZMwrvSdUiCuh/LwCl7JakL5gof/w
         4FEIk4vOV8moRV5kdbpg2N4KeCpA11JBLOIqXG0qybhKqYEEBQwrxZRITyRz8PQU6GgJ
         EVvsfkFrNDQsNwBXsBJMD+0hHiji4IjDUbCXQwulDh7AvvjVXIK3GoLdeugSctoz9A2R
         FJJw==
X-Gm-Message-State: AOJu0YyWT2I8/oOQReS9tYmXyqxTpXTdsTqm+pXycejZXiN2J3I2hrnG
        1/ZXWgJyivJ332FYlmyMh/s=
X-Google-Smtp-Source: AGHT+IEk+N26wVkMmMNhjNYMpY3hqw47SM4PfOIPcDcCJx0vg0xZkLDvtBYbHtqsF14aUwyzq5bX0w==
X-Received: by 2002:a17:903:32ce:b0:1bb:9b29:20d9 with SMTP id i14-20020a17090332ce00b001bb9b2920d9mr37832996plr.20.1693318252408;
        Tue, 29 Aug 2023 07:10:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902860700b001bbc8d65de0sm9413274plo.67.2023.08.29.07.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 07:10:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d6343959-82dc-feea-1d3a-b31682e2c0a3@roeck-us.net>
Date:   Tue, 29 Aug 2023 07:10:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ACPI: processor: Move MWAIT quirk out of acpi_processor.c
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     andriy.shevchenko@intel.com, artem.bityutskiy@linux.intel.com,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, lenb@kernel.org, jgross@suse.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
 <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 06:54, Rafael J. Wysocki wrote:
> On Tue, Aug 29, 2023 at 3:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Mon, Jul 10, 2023 at 05:03:29PM +0300, Michal Wilczynski wrote:
>>> Commit 2a2a64714d9c ("ACPI: Disable MWAIT via DMI on broken Compal board")
>>> introduced a workaround for MWAIT for a specific x86 system.
>>>
>>> Move the code outside of acpi_processor.c to acpi/x86/ directory for
>>> consistency and rename the functions associated with it, so their names
>>> start with "acpi_proc_quirk_" to make the goal obvious.
>>>
>>> No intentional functional impact.
>>>
>>
>> Except for:
>>
>> ia64-linux-ld: drivers/acpi/acpi_processor.o: in function `acpi_early_processor_control_setup':
>> acpi_processor.c:(.init.text+0x712): undefined reference to `acpi_proc_quirk_mwait_check'
>> ia64-linux-ld: drivers/acpi/processor_pdc.o: in function `acpi_early_processor_set_pdc':
>> processor_pdc.c:(.init.text+0x72): undefined reference to `acpi_proc_quirk_mwait_check'
>>
>> which breaks all ia64 builds.
>>
>> Time to retire that architecture yet ? No one but me seems to even
>> build test it.
> 
> Including 0-day it seems.  This had been in linux-next for several weeks.
> 

Not sure if 0-day is running on linux-next nowadays. There are other
build failures in there which don't seem to be reported either.

Unfortunately, looking into build failures (and crashes) in linux-next
would be a full-time job. I see those failures, but I just don't have the
time to analyze and report them all.

Guenter

