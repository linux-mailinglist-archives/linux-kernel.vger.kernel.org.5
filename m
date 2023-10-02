Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BFC7B4F0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbjJBJ21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbjJBJ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:28:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B04FA4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:28:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso22133172a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696238900; x=1696843700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GnjEkfxn8HRloGbpNCzqYP3xODULl+xCK5wXNCLSzC0=;
        b=HXy8hhHbsd7eQ4WewwaYkQ6TQe+G4rgnEcZu3YDcobuptEi3A2fFI0xoD65d2i6RL3
         8n+gyxllo91Jd+p1xv2VonsGKz8jEJgI7uCvfgtgM/ISHuSBU/T1Ay1VS92IdPIj3ec4
         2LVVcxCu5pFvR/d8j2hEA0S6fw5w2vK7WPu979oUU7/4+nQ3erMz38rXDXxZqX3hSsez
         YGp5DYBJo//uDoYb4znw+maD6jZhNqCQg2zo/2DsBAO40eVPnIs9qM8MA/+S7CGXBMMi
         yB8b93uVmWGH+8V8o/265hFL3sZIC3GjubQM32VoujTwf0jvCzr+WFI/iOsO5U984dCq
         +fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696238900; x=1696843700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnjEkfxn8HRloGbpNCzqYP3xODULl+xCK5wXNCLSzC0=;
        b=WZ42NO5q0JlEsEyfFTPmElKpxDGXS5Owkp2zPZwB8iNp/U/LjddcMICGuTgcCrM/14
         D5T6dqiljs7o/SBKZbW0q+4RtWMwgvtKXs0g7ZWEVpxg+ykchjiDbdDBBRupikrRlHMA
         YLhDT0Y+JGgBLOqF2o/X1kczqhE8fkD87ZRB9bWEc1/mm3O0GKuZMGWW7CJK4Evm6Uo0
         b///3ijzE5iYJV3fC0db2HFouO2rMlBxExkbzbOtQjnI1882mGh0e2wVZynASJtFmEk0
         IdWU26Xp7uH2YTOjP6Dx8DMXS1Vi9f3aYOQFVPxUgPF1iES2sn5wNYBs9JPQqjPGYDs2
         HlNQ==
X-Gm-Message-State: AOJu0Yxg7vhIsaRhmBlBisnFEHIQNiCvNftJANZz1j3Qc6KmjvpvE/Tt
        tjBRLOpm30TKv50ujt2thak4KntEgxOxei7I
X-Google-Smtp-Source: AGHT+IEtJbLI+jiQadbv7srFDSFEZzyJFbLWC3l5QxR6LQEEHHv6Sp3n5sAG3a4YQh7FrYTAg758xw==
X-Received: by 2002:aa7:db50:0:b0:533:efc3:91b6 with SMTP id n16-20020aa7db50000000b00533efc391b6mr10582578edt.11.1696238900403;
        Mon, 02 Oct 2023 02:28:20 -0700 (PDT)
Received: from [192.168.5.6] (PC-176-101-165-146.tvk-net.pl. [176.101.165.146])
        by smtp.gmail.com with ESMTPSA id da11-20020a056402176b00b0053495596f42sm7907258edb.30.2023.10.02.02.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:28:20 -0700 (PDT)
Message-ID: <7f442447-f69f-5cca-1a3b-fae0910eef23@gmail.com>
Date:   Mon, 2 Oct 2023 11:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC kvmtool 18/31] arm64: Populate initial realm contents
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joey Gouly <Joey.Gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, linux-coco@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230127112248.136810-1-suzuki.poulose@arm.com>
 <20230127113932.166089-1-suzuki.poulose@arm.com>
 <20230127113932.166089-19-suzuki.poulose@arm.com>
 <7a0e256d-3ce1-3218-c930-ed518a679b8b@gmail.com>
 <f9b316ad-fe27-cb3a-493e-70f2ced8a6f7@arm.com>
From:   Piotr Sawicki <piotr.sawickas@gmail.com>
In-Reply-To: <f9b316ad-fe27-cb3a-493e-70f2ced8a6f7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Suzuki

> Hi Piotr
> 
> On 02/03/2023 14:03, Piotr Sawicki wrote:
>> Hi,
>>
>>> From: Alexandru Elisei <alexandru.elisei@arm.com>
>>>
>>> Populate the realm memory with the initial contents, which include
>>> the device tree blob, the kernel image, and initrd, if specified,
>>> or the firmware image.
>>>
>>> Populating an image in the realm involves two steps:
>>>   a) Mark the IPA area as RAM - INIT_IPA_REALM
>>>   b) Load the contents into the IPA - POPULATE_REALM
>>>
>>> Wherever we know the actual size of an image in memory, we make
>>> sure the "memory area" is initialised to RAM.
>>> e.g., Linux kernel image size from the header which includes the bss 
>>> etc.
>>> The "file size" on disk for the Linux image is much smaller.
>>> We mark the region of size Image.header.size as RAM (a), from the kernel
>>> load address. And load the Image file into the memory (b) above.
>>> At the moment we only detect the Arm64 Linux Image header format.
>>>
>>> Since we're already touching the code that copies the
>>> initrd in guest memory, let's do a bit of cleaning and remove a
>>> useless local variable.
>>>
>>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>>> [ Make sure the Linux kernel image area is marked as RAM ]
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> 
>>> diff --git a/arm/kvm.c b/arm/kvm.c
>>> index acb627b2..57c5b5f7 100644
>>> --- a/arm/kvm.c
>>> +++ b/arm/kvm.c
>>> @@ -6,6 +6,7 @@
>>>   #include "kvm/fdt.h"
>>>   #include "arm-common/gic.h"
>>> +#include <asm/realm.h>
>>>   #include <sys/resource.h>
>>> @@ -167,6 +168,9 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, 
>>> int fd_kernel, int fd_initrd,
>>>       pr_debug("Loaded kernel to 0x%llx (%llu bytes)",
>>>            kvm->arch.kern_guest_start, kvm->arch.kern_size);
>>
>>
>> I've noticed that multiple calling of the measurement test from the 
>> kvm-unit-tests suite results in different Realm Initial Measurements, 
>> although the kernel image is always the same.
>>
>> After short investigation, I've found that the RIM starts being 
>> different while populating the last 4kB chunk of the kernel image.
>> The issue occurs when the image size is not aligned to the page size 
>> (4kB).
>>
>> After zeroing the unused area of the last chunk, the measurements 
>> become repeatable.
>>
> 
> That is a good point. We could memset() the remaining bits of the 4K 
> page to 0. I will make this change.

It looks that this is somewhat related to the implementation of the 9p 
filesystem (Linux host and/or the FVP emulator).

I'm getting this issue only when the initrd and the guest kernel images 
are located in the shared folder that uses the 9p filesystem. Moving 
those files to the ramdisk (e.g. to the /root folder) and running lkvm 
tool on them resolves the issue.

Kind regards,
Piotr Sawicki


