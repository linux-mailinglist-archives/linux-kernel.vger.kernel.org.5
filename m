Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032BB7FA021
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjK0M54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjK0M5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:57:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878E182
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:58:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b2a85c99bso5378575e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701089880; x=1701694680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLrTr1cbGhjwm5HZ0GV+BmfoECIMxFKEN669d3URKW0=;
        b=tc+kkX4ZbSs/YwSwsPYPhXrNAwAtkF0GoyiPa0Xrmj6bHGizqxrFlKhtVUsPHdTZnP
         BKATtsi+zINCeVa0hRZtVt96vhpXIkFWZgIG+3h+m7TczhO6kAqW48KwM7c6RjOaRlCH
         n3w7fnZXRdiq8k3/Rp00P1yhgk7plMFRrDdct/360Pmt+nW3K45ZCKzUvEsQ7B4psH6Y
         0/3NK+h9vg+r0yKOVUUzxMb+nTmn8OlQ6QJA9VmSLtAYRuhPlhduK5llty4rFnPii0gm
         CzCyExBDlyMdgN7BBiPcDYMq5Qc4Uom+2+rED35sY8R/7/moFyu3lDOeaQ56BYEI7faa
         4v3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089880; x=1701694680;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLrTr1cbGhjwm5HZ0GV+BmfoECIMxFKEN669d3URKW0=;
        b=ZzuAjim/0op6G2uynsZmW9GyTnMtgdjk1vT4BfVIXYeBvpeK+nk8fh2jCR8Mcdv+JW
         bbHRT3eNnu4HRxktmmTmMG83GkfJkrp97K1qmTE5MqCKFIFypxUfC+w5xilktHvkv3P3
         Y3PrsWEz81yEXa1Hsu//L8DGc4Qvk7ZSM9YjATN7DGPbVFGRZ+aY7+Zf3xBXIekie6rI
         oTAjgKxydm+2l75hjofgVU2X+I99rhNYYrJtEhl4e368ckm+fre2PEUiLlAtfnQe4DS0
         YA5t93NoOW2N+YoyEfQW9YDQdZZIfIZtGr3NcBN7raAzijSGJu6f4tQmhe/K24TEH5TW
         Ev7Q==
X-Gm-Message-State: AOJu0YxqD1D2S3Qaa6rElBViORaCmzmoUwGJ/3HmBVflKLI73uUsHOfM
        thTfKnAmfkNbVeJGyLq9SIZbOQ==
X-Google-Smtp-Source: AGHT+IGuVtiV25r0CbMNM4DRWKPCnn9fsUeYezrnHcCtlNwkSjKhQ8ymsNrFcAeRR4C7auBUyea85w==
X-Received: by 2002:a05:600c:5024:b0:40a:771f:6a56 with SMTP id n36-20020a05600c502400b0040a771f6a56mr8042955wmr.4.1701089879839;
        Mon, 27 Nov 2023 04:57:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:c123:224a:77e5:3aba? ([2a01:e0a:999:a3a0:c123:224a:77e5:3aba])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d42c8000000b00332fa6cc8acsm4818252wrr.87.2023.11.27.04.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 04:57:59 -0800 (PST)
Message-ID: <d156242a-f104-4925-9736-624a4ba8210d@rivosinc.com>
Date:   Mon, 27 Nov 2023 13:57:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: fix incorrect use of __user pointer
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        kernel test robot <lkp@intel.com>
References: <20231124113803.165431-1-cleger@rivosinc.com>
 <b4ee0ab3-9772-439c-bc9c-474f6f2862ba@codethink.co.uk>
 <300ba40f-4dce-44f1-8809-5a0abcb41aa4@rivosinc.com>
In-Reply-To: <300ba40f-4dce-44f1-8809-5a0abcb41aa4@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/11/2023 13:46, Clément Léger wrote:
> 
> 
>>> @@ -369,16 +366,14 @@ static inline int get_insn(struct pt_regs *regs,
>>> ulong epc, ulong *r_insn)
>>>               *r_insn = insn;
>>>               return 0;
>>>           }
>>> -        insn_addr++;
>>> -        if (__read_insn(regs, tmp, insn_addr))
>>> +        epc += sizeof(u16);
>>> +        if (__read_insn(regs, tmp, epc, u16))
>>>               return -EFAULT;
>>>           *r_insn = (tmp << 16) | insn;
>>>             return 0;
>>>       } else {
>>> -        u32 __user *insn_addr = (u32 __user *)epc;
>>> -
>>> -        if (__read_insn(regs, insn, insn_addr))
>>> +        if (__read_insn(regs, insn, epc, u32))
>>>               return -EFAULT;
>>>           if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) {
>>>               *r_insn = insn;
>>> @@ -491,7 +486,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>>>         val.data_u64 = 0;
>>>       for (i = 0; i < len; i++) {
>>> -        if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
>>> +        if (load_u8(regs, addr + i, &val.data_bytes[i]))
>>>               return -1;
>>>       }
>>>   @@ -589,7 +584,7 @@ int handle_misaligned_store(struct pt_regs *regs)
>>>           return -EOPNOTSUPP;
>>>         for (i = 0; i < len; i++) {
>>> -        if (store_u8(regs, (void *)(addr + i), val.data_bytes[i]))
>>> +        if (store_u8(regs, addr + i, val.data_bytes[i]))
>>>
>>
>> Would it not be easier to have a switch here for memcpy or copy_to_user?
> 
> Most probably yes. I'll update the V3 with these modifications. We'll
> get rid of store_u8()/load_u8() entirely.

While memcpy/copy_from_user will be slower than David Laight proposed
solution (read two 4/8 bytes long once and shifting the content) it is
more maintainable and this path of code will not suffer a few lost cycle
(emulating misaligned access is already horribly slow...).

BTW, need to check but maybe we can get rid of all the specific M_MODE
code entirely (__read_insn) also.

Clément

> 
> Thanks,
> 
> Clément
> 
>>
>>                return -1;
>>>       }
>>>   
>>
