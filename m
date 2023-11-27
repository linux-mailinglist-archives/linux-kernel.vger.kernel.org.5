Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144387F9D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjK0KYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjK0KYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:24:22 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63009EA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:24:28 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b3febbce3so1440465e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701080667; x=1701685467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wu1INlBttSoNTPvzJ8LrRj387HEl+wYp0ca6zoIWQt8=;
        b=N3z2rswTeEUtZo0ww5rPXx+cnovzUodOl7Mxv3xCa7D5zlO4qAVrVxzmb2rp5oJBXq
         2RPkkCSt130C9ndPiqr9U4/UZi5j9wEo+GucoF/RppYE8UuPp2hqnzT+asqmhIKNRRBh
         HaaomEbI1o5bsPn+9cAFuyXjRg6Kf/7zwWk2KXvRzEig34fkmPWCI33H6IA4ZRFRyAT3
         YRxZbnaXrQv0fxE4JVIwA+09x7ub6SVBqomcVEJwJBJV+kfXzfPzJVrc/Gc0RIF1cMul
         3UgyYdc29H3SwzdSlQVxaYHNR01coFdvoZuYY45fqtWvTAK0HZaCBSfLM+PC8jO0SX20
         IstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701080667; x=1701685467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wu1INlBttSoNTPvzJ8LrRj387HEl+wYp0ca6zoIWQt8=;
        b=PHf0SseF2MUdf5R0Wjw4pfgE/4VJSFr4CjfGHqamgXIuqpQ/c/hzefAahgMp94Ag4a
         olSIrBmGSBvj19yfynn/d0kkimKIN7RP9u6oCRt0hwxtp74GvFC6cmvPfMgXzLVE/QDs
         yG6LAiS05ibyBGA8txZPrcD/qZfomjX/qaC/hx4kxNbVXvjKXqBbPILTjeGKd2QODqIN
         hSOlIE3rfX6pEsnv8qA1fG3BzneWbFwat/1xHff0Iiyi5D+iLq7rKBN+G2Vm0/U0zMle
         wbezlqs+zz77f2iF+KZYeFzXhmGCob8OTXl22YtYA+4h/BbqNWbe2MLDTcBGIcSsuU3o
         QV9Q==
X-Gm-Message-State: AOJu0YypwzrGsBu6JauhHQ72Z1hPQRs4NroKueou9FjVVXfGtedHhLEl
        QNU6n/CU6oVJ9XZNy0Q4C7BL0w==
X-Google-Smtp-Source: AGHT+IFNFSIcXPktRz641S+TwSgPraxmwJhBPLk9O+g+xWRL5SHdqiCk/LWjTGiodXivE9z6GOcheQ==
X-Received: by 2002:a05:600c:45c6:b0:405:39bb:38a8 with SMTP id s6-20020a05600c45c600b0040539bb38a8mr7720726wmo.2.1701080666882;
        Mon, 27 Nov 2023 02:24:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:1a67:8e18:5d34:ea1b? ([2a01:e0a:999:a3a0:1a67:8e18:5d34:ea1b])
        by smtp.gmail.com with ESMTPSA id q17-20020a5d5751000000b00323287186aasm11598473wrw.32.2023.11.27.02.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 02:24:26 -0800 (PST)
Message-ID: <9cb1fadf-bb83-4e9f-9c29-bff53e30b0c6@rivosinc.com>
Date:   Mon, 27 Nov 2023 11:24:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: fix incorrect use of __user pointer
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
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <bf7dfadfc8a94e3f810a8ba238f77543@AcuMS.aculab.com>
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



On 25/11/2023 16:37, David Laight wrote:
> ...
>> @@ -491,7 +486,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>>
>>  	val.data_u64 = 0;
>>  	for (i = 0; i < len; i++) {
>> -		if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
>> +		if (load_u8(regs, addr + i, &val.data_bytes[i]))
>>  			return -1;
>>  	}
> 
> I'd really have thought that you'd want to pull the kernel/user
> check way outside the loop?

Hi David,

I hope the compiler is able to extract that 'if' out of the loop since
regs isn't modified in the loop. Nevertheless, that could be more
"clear" if put outside indeed.

> In any case, for a misaligned read why not just read (addr & ~7)[0]
> and (if needed) (addr & ~7)[1] and then ahift and or together?

Makes sense, the original code was like that but probably copy/pasted
from openSBI I guess. (?)

Let's keep that for the moment (this patch is about fixing wrong __user
address space). I will try to submit another series using what you proposed.

Regards,

Clément

> 
> clang will do it for misaligned structure members with known
> misalignment, but it is almost certainly also better for reads
> with unknown misalignment.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
