Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D1E7F9DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjK0Kh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjK0KhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:37:24 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C666FE1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:37:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b3febbce3so1458665e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701081449; x=1701686249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwIyasNfIAcPjx/IdeRHiVql5CVlCc1OjrkJjoCKOOg=;
        b=YSb5Eyy1yobLhJ6tzzQxz7N9vk1zMyi1fLkNQiAG11tWa2dMUMtRRCCapbHSfPsUta
         jOHNb2LxPVJ6Oqx7IdL363MjXOFbJH2qZQ/xWo1MynCDWT7ehDKsYWhXfr8j0L/0BfUX
         iRgC22e4UvvqPPV7FmIzZ+PPSuE/o6NTg5mPJY/iKPxS13SZtSgozz7Mge872bHEv6s+
         IWfMspE0Gac+ztumk2xHCkEn6FhTqTYWnRjSO6YfEfa3DRWD0+Lsv/dA2ICEfKOZTbwv
         JgMcZEDsOj2LkB3afYZaP7RH1r7BmU15mrmPcsTEus4SwlYwreZkPhd649O+cslt+kA/
         wG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081449; x=1701686249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwIyasNfIAcPjx/IdeRHiVql5CVlCc1OjrkJjoCKOOg=;
        b=j4driVCQrvmqLi/tO4u6sSv3b020g4n5BTP8Kanr12mig+mxciaqGI3ZZHrYanH/6u
         Pdpetotk6yH/mKWaNI01KRXE0zfZ/Ffm7wQI0UIJ1P1cqliufnkEsGprkTYQB2BdXPtv
         v/1TdTWvCcMZHD30thS5+UKIbMhf8nPj0wWOcZ38OHf2cJVOUFu2j/m9prX8G9M5IY9C
         i39lyLq2KPJcsEWF0zWsmHo2m1OtUF4/ZzAaWDvEfoYcy+AzUm4e8y7nNjoTNXk5AhJI
         T2JckpLkXxqaSajvV2VXZFcLwfP3zNd/1m5b+36pWKwNdoUK1i6GlfXZvCE9pW9MyKMo
         EOig==
X-Gm-Message-State: AOJu0YzcYyGHxhwVU6akQs6C2A6M3fofFCDaFjCOzHqj4jXo/t0WS1AC
        BXggZFc8JK296YHjtXG8LzaKXg==
X-Google-Smtp-Source: AGHT+IEAEBm/57tYeRAJVKRhhb7Pa23fplEZDBTI7FQXChqci9y/hUk3AXOX7mcg7jjeCWpriCTIRw==
X-Received: by 2002:a05:600c:524d:b0:40b:46b5:4960 with SMTP id fc13-20020a05600c524d00b0040b46b54960mr1428453wmb.3.1701081449091;
        Mon, 27 Nov 2023 02:37:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:1a67:8e18:5d34:ea1b? ([2a01:e0a:999:a3a0:1a67:8e18:5d34:ea1b])
        by smtp.gmail.com with ESMTPSA id jg28-20020a05600ca01c00b004063cd8105csm14071976wmb.22.2023.11.27.02.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 02:37:28 -0800 (PST)
Message-ID: <603c39d4-2764-4f85-b173-069ced2a3a13@rivosinc.com>
Date:   Mon, 27 Nov 2023 11:37:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: fix incorrect use of __user pointer
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        kernel test robot <lkp@intel.com>
References: <20231124113803.165431-1-cleger@rivosinc.com>
 <bf7dfadfc8a94e3f810a8ba238f77543@AcuMS.aculab.com>
 <9cb1fadf-bb83-4e9f-9c29-bff53e30b0c6@rivosinc.com>
 <72fb7d8085a644e4a3e2e540a9ed6847@AcuMS.aculab.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <72fb7d8085a644e4a3e2e540a9ed6847@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/11/2023 11:35, David Laight wrote:
> From: Clément Léger
>> Sent: 27 November 2023 10:24
>>
>> On 25/11/2023 16:37, David Laight wrote:
>>> ...
>>>> @@ -491,7 +486,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>>>>
>>>>  	val.data_u64 = 0;
>>>>  	for (i = 0; i < len; i++) {
>>>> -		if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
>>>> +		if (load_u8(regs, addr + i, &val.data_bytes[i]))
>>>>  			return -1;
>>>>  	}
>>>
>>> I'd really have thought that you'd want to pull the kernel/user
>>> check way outside the loop?
>>
>> Hi David,
>>
>> I hope the compiler is able to extract that 'if' out of the loop since
>> regs isn't modified in the loop. Nevertheless, that could be more
>> "clear" if put outside indeed.
> 
> If has access regs->xxx then the compiler can't do so because it
> will must assume that the assignment might alias into 'regs'.
> That is even true for byte writes if 'strict-aliasing' is enabled
> - which it isn't for linux kernel builds.
> 
> It might do so if 'regs' were 'const'; it tends to assume that if
> it can't change  something nothing can - although that isn't true.

Ok, good to know ! As I said, I'll modify that in a subsequent patch.

Thanks,

Clément

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
