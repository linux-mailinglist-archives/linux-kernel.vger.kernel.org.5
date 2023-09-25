Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E347AD2C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjIYILJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjIYILH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:11:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B91A9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:11:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4051d33af1fso18138725e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695629459; x=1696234259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlO0BFPodxqQgy/xN/pC3ASctYK0Q/f9lDJvY2Seqdc=;
        b=x9m+PTS6xKJK5l1FaSEoaOSEqEOLJibRxs1cVn1gFCWfOHmYOcdDhPtQpYReM0Bbf3
         mhFoQ4FL+QixRdg26k3oxsCtUCp2pT6hCUZxXuGjcIjLCA/GC2blTatWbYh8KK+WkyWc
         jE3hpjL1KE3ZPjLUIlcYW3rAcUddhtkogDbBxwcxNLbnChnTVssvsG5WdTWcNKQvjDo3
         gw4qpfILb7UNoqIsGADGGWVmsYEu2+glX/yvCaSU3TANWCHx7B8MB+jvypkcQKEvSJgM
         VANesZOty7HAOBIs6B+Hf9+BcEi5D9eBAxSCDaiuOZPlDEYl4Wu4JNdo8GmwlIBr1sDN
         4qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695629459; x=1696234259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlO0BFPodxqQgy/xN/pC3ASctYK0Q/f9lDJvY2Seqdc=;
        b=f13nvy7Ddv+abLG2DMZgRmK17XH3HnPdyMefcLs1q4a75TS5HIsLUe0dbx/u9L69fp
         b55uVZctP84Bs/7650y7SrXMbuDSjTnEiA2WBNLlTIfL/blXY77g2di9RC4fE28EEy4m
         Qic4Z/nYlBxq7t81nR423EIHtdCGNvztJxDF6tIRGd2fxMS8eLxdSwOdufJ24XTeo5D8
         4V+MyhPAN6rNeWAfAdtLySupRGjTDcgqJpG5chooz0lD/0BIj37k1t8Dk+4n4S2y5SqZ
         81zma2L+x18i0U7HhsB18FeHSVX59SfPFgSbCwgRYLAWm2om8UBEgfN9prm4uNmKkBuS
         gjBw==
X-Gm-Message-State: AOJu0YwfxPB1caUl8xyoL+LA0o3ZlhS+RU/+pWlTQtW3mn3rCm44FQAj
        XA/kZ1liB8HTKxvMPtM7jkHJPICdsMxRq1aQEjI8Hg==
X-Google-Smtp-Source: AGHT+IG6Wm4n3niNWbqpvHgjzURFEXYyn/kqXs/CLOQ9lKrclVE0BGPfD/NzTxMcHKmkToirIL5oWg==
X-Received: by 2002:a05:600c:4f50:b0:405:39bb:38a8 with SMTP id m16-20020a05600c4f5000b0040539bb38a8mr4953600wmq.2.1695629459073;
        Mon, 25 Sep 2023 01:10:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:3df1:f103:36a9:423d? ([2a01:e0a:999:a3a0:3df1:f103:36a9:423d])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c0b4300b003fe1fe56202sm11596335wmr.33.2023.09.25.01.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 01:10:58 -0700 (PDT)
Message-ID: <bda1393a-9e11-4d51-8911-f038918d2ddb@rivosinc.com>
Date:   Mon, 25 Sep 2023 10:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
Content-Language: en-US
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230914131102.179100-1-cleger@rivosinc.com>
 <20230914131700.0ba3ee80@gandalf.local.home>
 <20230914132956.569dad45@gandalf.local.home>
 <a736f219-9a38-4f95-a874-93e1561906d5@rivosinc.com>
 <20230922200042.GA1981-beaub@linux.microsoft.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20230922200042.GA1981-beaub@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/09/2023 22:00, Beau Belgrave wrote:
> On Tue, Sep 19, 2023 at 02:59:12PM +0200, Clément Léger wrote:
>>
>>
>> On 14/09/2023 19:29, Steven Rostedt wrote:
>>> On Thu, 14 Sep 2023 13:17:00 -0400
>>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>>> Now lets look at big endian layout:
>>>>
>>>>  uaddr = 0xbeef0004
>>>>  enabler = 1;
>>>>
>>>>  memory at 0xbeef0000:  00 00 00 00 00 00 00 02
>>>>                                     ^
>>>>                                     addr: 0xbeef0004
>>>>
>>>> 				(enabler is set )
>>>>
>>>> 	bitoffset = uaddr & (sizeof(unsigned long) - 1); bitoffset = 4
>>>> 	bit_offset *= 8;				 bitoffset = 32
>>>> 	uaddr &= ~(sizeof(unsigned long) - 1);		 uaddr = 0xbeef0000
>>>>
>>>> 	ptr = kaddr + (uaddr & ~PAGE_MASK);
>>>>
>>>> 	clear_bit(1 + 32, ptr);
>>>>
>>>>  memory at 0xbeef0000:  00 00 00 00 00 00 00 02
>>>>                                   ^
>>>> 				bit 33 of 0xbeef0000
>>>>
>>>> I don't think that's what you expected!
>>>
>>> I believe the above can be fixed with:
>>>
>>> 	bit_offset = uaddr & (sizeof(unsigned long) - 1);
>>> 	if (bit_offset) {
>>> #ifdef CONFIG_CPU_BIG_ENDIAN
>>> 		bit_offest = 0;
>>> #else
>>> 		bit_offset *= BITS_PER_BYTE;
>>> #endif
>>> 		uaddr &= ~(sizeof(unsigned long) - 1);
>>> 	}
>>>
>>> -- Steve
>>
>>
>> Actually, after looking more in depth at that, it seems like there are
>> actually 2 problems that can happen.
>>
>> First one is atomic access misalignment due to enable_size == 4 and
>> uaddr not being aligned on a (long) boundary on 64 bits architecture.
>> This can generate misaligned exceptions on various architectures. This
>> can be fixed in a more general way according to Masami snippet.
>>
>> Second one that I can see is on 64 bits, big endian architectures with
>> enable_size == 4. In that case, the bit provided by the userspace won't
>> be correctly set since this code kind of assume that the atomic are done
>> on 32bits value. Since the kernel assume long sized atomic operation, on
>> big endian 64 bits architecture, the updated bit will actually be in the
>> next 32 bits word.
>>
>> Can someone confirm my understanding ?
>>
> 
> Actually, I take back some of what I said [1]. If a 32-bit on a 64-bit
> kernel comes in on BE, and is aligned, we do need to offset the bits as
> well (just verified on my ppc64 BE VM).

Yes, that is what I meant in my previous comment. I'll resend my series
which handles that properly (and which includes generic
set_bit_unaligned()).

Thanks,

Clément

> 
> You should be able to use that patch as a base though and add a flag to
> struct user_event_enabler when this case occurs. Then in the
> align_addr_bit() adjust the bits as well upon aligned cases.
> 
> Thanks,
> -Beau
> 
> 1. https://lore.kernel.org/linux-trace-kernel/20230922192231.GA1828-beaub@linux.microsoft.com/
> 
>> Clément
