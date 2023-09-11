Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE6179A542
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjIKIBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjIKIBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:01:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE162CDE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:01:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-991c786369cso542188766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1694419261; x=1695024061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o63kaDsYGhtkR3Unx63xkSmEyv+kX4frhCjmTrl0ffw=;
        b=nKwqa8yxk4Pc/7x9OcsvdJhYFdsasqGkYC2fe+I/5maEbB/c8uztMYtwahxir0x8A5
         oD+7e2CUv4WRAU34caKGQwbeyPpkom6J76es0Rl8otatxH09KEpe8uLWwFHUoIRTjnxO
         Bla+/GhDBi2KzNkpdbhhzoOAAfbLqmct7PUlyijztXH356xMfrvFwnMgd9kHlNjXf0LJ
         eEDH5qlQsTRrkREEP/gwbA7Ziy8x7BcEkaeUK9jKTkEDJF2aHVUG+wRHnN3lOq2EjeGR
         kBzewoKZVVbW2ZZH0l3VwcU3+766GrQD2myX+UxMfSbzu8BajufG/0oEdYU71Y1hKpZ4
         Pb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694419261; x=1695024061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o63kaDsYGhtkR3Unx63xkSmEyv+kX4frhCjmTrl0ffw=;
        b=AYHI0ufgCQzkdy+yji00syqzKbNE4hSNVw4LzGdJIaVCBPJNvhwPiWmtDlHZbp5OrR
         kJdrib0IGiz1LgtmocGlnZjJwsGnkviEvPLB0Aq7Ml7jfYfwpDR3sfyQN5ANeOJl0GKx
         6BDYqdppueNVQymMAQAfibR57KEQBNtcEgc/Xrzt/xzLW4MYd4Yd2OPTzXgxvaACVyv/
         b7mfRrIsFjxIOEubNY4inIPuB3wULaC4MPdKI2SCqyOaM0xVdW5DVNTOLp4JHjmkkmW9
         /w36rwmScjRpVPvKLv5bKHW+LYxNaV2USWiT52bUYTRXWLurdxEu6U5ydDvqDmJLkPzc
         7stQ==
X-Gm-Message-State: AOJu0YwESu50cqe5AgqLyQtmSIFIkbVTG5wyxfukNR3e/LAFpAcd2wo6
        9TAMkHa5U/rEfrASYZ+F/m7Hvw==
X-Google-Smtp-Source: AGHT+IFQqqpjFnwX/M/twdOBKrX8oZa/hHf9nnb0uTsD4Fnhmk8SAJ6b8hdSzKx9KZgMoAfZ7OspFQ==
X-Received: by 2002:a17:906:9bc1:b0:9a1:e1cf:6c6c with SMTP id de1-20020a1709069bc100b009a1e1cf6c6cmr7813827ejc.30.1694419260813;
        Mon, 11 Sep 2023 01:01:00 -0700 (PDT)
Received: from ?IPV6:2003:f6:af13:2000:6eb:9718:be72:1555? (p200300f6af13200006eb9718be721555.dip0.t-ipconnect.de. [2003:f6:af13:2000:6eb:9718:be72:1555])
        by smtp.gmail.com with ESMTPSA id ov27-20020a170906fc1b00b00992c92af6f4sm4948364ejb.144.2023.09.11.01.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:01:00 -0700 (PDT)
Message-ID: <ca1a5950-9092-6caf-471c-ebda623173e5@grsecurity.net>
Date:   Mon, 11 Sep 2023 10:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] x86/hyperv/vtl: Replace real_mode_header only under
 Hyper-V
Content-Language: en-US, de-DE
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@kernel.org
References: <20230908102610.1039767-1-minipli@grsecurity.net>
 <20230908150224.GA3196@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <20230908150224.GA3196@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.09.23 17:02, Saurabh Singh Sengar wrote:
> On Fri, Sep 08, 2023 at 12:26:10PM +0200, Mathias Krause wrote:
>> Booting a CONFIG_HYPERV_VTL_MODE=y enabled kernel on bare metal or a
>> non-Hyper-V hypervisor leads to serve memory corruption as
> 
> FWIW, CONFIG_HYPERV_VTL_MODE is not expected to be enabled for non VTL
> platforms.

Fair enough, but there's really no excuse to randomly crashing the
kernel if one forgot to RTFM like I did. The code should (and easily
can) handle such situations, especially if it's just a matter of a two
line change.

> Referring Kconfig documentation:
> "A kernel built with this option must run at VTL2, and will not run as
> a normal guest."

So, maybe, the 'return 0' below should be a 'panic("Need to run on
Hyper-V!")' instead?

But then, looking at the code, most of the VTL specifics only run when
the Hyper-V hypervisor was actually detected during early boot. It's
just hv_vtl_early_init() that runs unconditionally and spoils the game.

Is there really a *hard* requirement / reason for having VTL support
disabled when not running under Hyper-V? At least I can't find any from
the code side. It'll all be fine with the below patch, also enabling
running the same kernel on multiple platforms -- bare metal, KVM, Hyper-V,..

Thanks,
Mathias

> 
> - Saurabh
> 
>> hv_vtl_early_init() will run even though hv_vtl_init_platform() did not.
>> This skips no-oping the 'realmode_reserve' and 'realmode_init' platform
>> hooks, making init_real_mode() -> setup_real_mode() try to copy
>> 'real_mode_blob' over 'real_mode_header' which we set to the stub
>> 'hv_vtl_real_mode_header'. However, as 'real_mode_blob' isn't just a
>> 'struct real_mode_header' -- it's the complete code! -- copying it over
>> 'hv_vtl_real_mode_header' will corrupt quite some memory following it.
>>
>> The real cause for this erroneous behaviour is that hv_vtl_early_init()
>> blindly assumes the kernel is running on Hyper-V, which it may not.
>>
>> Fix this by making sure the code only replaces the real mode header with
>> the stub one iff the kernel is running under Hyper-V.
>>
>> Fixes: 3be1bc2fe9d2 ("x86/hyperv: VTL support for Hyper-V")
>> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Cc: stable@kernel.org
>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
>> ---
>>  arch/x86/hyperv/hv_vtl.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
>> index 57df7821d66c..54c06f4b8b4c 100644
>> --- a/arch/x86/hyperv/hv_vtl.c
>> +++ b/arch/x86/hyperv/hv_vtl.c
>> @@ -12,6 +12,7 @@
>>  #include <asm/desc.h>
>>  #include <asm/i8259.h>
>>  #include <asm/mshyperv.h>
>> +#include <asm/hypervisor.h>
>>  #include <asm/realmode.h>
>>  
>>  extern struct boot_params boot_params;
>> @@ -214,6 +215,9 @@ static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
>>  
>>  static int __init hv_vtl_early_init(void)
>>  {
>> +	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
>> +		return 0;
>> +
>>  	/*
>>  	 * `boot_cpu_has` returns the runtime feature support,
>>  	 * and here is the earliest it can be used.
>> -- 
>> 2.30.2
>>
