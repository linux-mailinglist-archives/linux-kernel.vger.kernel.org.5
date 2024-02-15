Return-Path: <linux-kernel+bounces-67529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0493D856CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8358A1F21A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90A71386A2;
	Thu, 15 Feb 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoWo3Q9L"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEAD31A60;
	Thu, 15 Feb 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022554; cv=none; b=CH1UkxEWw55BVJceBEL7NgOY/M7nzmrm4Cl73pb/QfUx0A18mPgB78Io/4HzjTPUwBFE2fK+SfvNoFj+upgsxiEyoZQL7IXLZZYziKaF+cdtHUS2lSV/E9MpRv7s4hWskyiPffuyon9OmCZStzrsSQO9bTVprKDYunG+6Tw0sBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022554; c=relaxed/simple;
	bh=/ruk8jX9/WGq73QOc11X011S2e3YQNYcOULuqZ/S4Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp+vPPaHeUVsRHksT2yu5GhIGGkofYDBufjnB0l4RKxxXlFvW6hLUiRGUK7Xuoj5wcxSGJmE89Us1/DFGKxXqv13CSG5mKygTvix1ymqvXmjekTg/Tc9r4oe/HdchYU3wqjoqU3Zvwn/zXHR4blp0FVuy7mJ8DlO72Yij/XyBBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoWo3Q9L; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e2e6bcc115so563444a34.3;
        Thu, 15 Feb 2024 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708022552; x=1708627352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+o70wlUduz1li0fSfRZ7G8yjDLISCYX73d3koZT25b4=;
        b=aoWo3Q9LUYOJxPvN2bAzD0XwCreuy8Y/Vx48WS0uDn0JHkWYBhN/27gCyOS+1uWY04
         fFmkx2TtjpLal6QvOfb6D+UQeE+Si4ie+HYy8lFno/NooAhmefKluGep5gQ8MZ0+65YW
         T6MBdzB2woaBFmX5mAzUuQPvWNyuI4gGPMU5rIUIFbFhqofDteVxFvFF23M78xBwR6HX
         p25vZYpX7BBxFpkGNJxovSgHEC0YaRzMn0KiLwIPU621ezEACWPw37Y44xWkAk9Vl//M
         Tjmb+U2WAZlAKORxGZaAioR6KM1V4D828QewopYYn2bRwaItITry0mR2XkVpgBgYJ4e4
         ejYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708022552; x=1708627352;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+o70wlUduz1li0fSfRZ7G8yjDLISCYX73d3koZT25b4=;
        b=mpXYLsuzk8DNf6q7W10sJ/pRvLS9STORGPFslcPg30ftBVxYMBc+M+ecsMNY/pSg9V
         gs21L6BBmH1lgmhhcxrxzsdeQEAdxhYo4UiDJo8EVSjLFpLJnBvpVrNFkalHlQN61yCj
         QzMuszudW4rfjqtuXJX1s15Lvb/T4NV2u0lr26w9uk24SOpEs+F1azHBQRrikz0r4u4M
         NX1QEM2dsMCMM+LSwn6H3KC5Bs8qL1SrStO4b0sY2Y0I6B+1bUAJiB0VNkDbkpE2052u
         nZ09ouGC4vK8R2cj+yoJrB9mPBbIAhuQxrWGcEqu0FTsMSLsIpT6LGs4n7vTwGLwlvPD
         ZtyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzoctTZK8SWzzPRQqWjbYSYAT1uWh9a0revqt3nU5QY8POMctvdXcZIQVA1da0vcc9t3W8DimH83vp4Tii5mv23Qy7wkIlLBKGl5nL
X-Gm-Message-State: AOJu0YxD3wy8Rjk07VpE32D/+qj2Y91LYvVNgjhqtP8+sRy/mkMoitmO
	fEKoCI93BRonNmcTZ1T2o7YVwWq1orI0QuPWHzCCkBs7os493OeQ
X-Google-Smtp-Source: AGHT+IGTAkWah9VSrIviYpJQRJHPHcA+YvTkdJfpHxjC5vJIab9tzg7UJTIEtzAW0OvvmVkrnWkZ1g==
X-Received: by 2002:a05:6358:5928:b0:176:5a5e:4b7c with SMTP id g40-20020a056358592800b001765a5e4b7cmr3062920rwf.6.1708022551830;
        Thu, 15 Feb 2024 10:42:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p23-20020a637417000000b005dcbb855530sm1055015pgc.76.2024.02.15.10.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 10:42:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a7b70196-2387-4532-94ac-81220fd07088@roeck-us.net>
Date: Thu, 15 Feb 2024 10:42:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: John David Anglin <dave.anglin@bell.net>,
 David Laight <David.Laight@ACULAB.COM>,
 Charlie Jenkins <charlie@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net>
 <a7e9691432374000b9566a0201d004e6@AcuMS.aculab.com>
 <c22f28a2-b042-4abe-b9e4-a925b97073bb@roeck-us.net>
 <4723822c-2acf-4c41-899c-1e3d5659d1d8@bell.net>
 <1e302d8f-4e94-4278-b556-b8fc54956efb@roeck-us.net>
 <e73bdc36-5fb1-4ea8-9f96-608eb1a9b6af@bell.net>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <e73bdc36-5fb1-4ea8-9f96-608eb1a9b6af@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/15/24 09:25, John David Anglin wrote:
> On 2024-02-15 12:06 p.m., Guenter Roeck wrote:
>> On 2/15/24 08:51, John David Anglin wrote:
>>> On 2024-02-15 10:44 a.m., Guenter Roeck wrote:
>>>> On 2/15/24 02:27, David Laight wrote:
>>>>> ...
>>>>>> It would be worthwhile tracking this down since there are
>>>>>> lots of unaligned data accesses (8-byte accesses on 4-byte aligned addresses)
>>>>>> when running the kernel in 64-bit mode.
>>>>>
>>>>> Hmmm....
>>>>> For performance reasons you really don't want any of them.
>>>>> The misaligned 64bit fields need an __attribute((aligned(4)) marker.
>>>>>
>>>>> If the checksum code can do them it really needs to detect
>>>>> and handle the misalignment.
>>>>>
>>>>> The misaligned trap handler probably ought to contain a
>>>>> warn_on_once() to dump stack on the first such error.
>>>>> They can then be fixed one at a time.
>>>>>
>>>>
>>>> Unaligned LDD at unwind_once+0x4a8/0x5e0
>>>>
>>>> Decoded:
>>>>
>>>> Unaligned LDD at unwind_once (arch/parisc/kernel/unwind.c:212 arch/parisc/kernel/unwind.c:243 arch/parisc/kernel/unwind.c:371 arch/parisc/kernel/unwind.c:445)
>>>>
>>>> Source:
>>>>
>>>> static bool pc_is_kernel_fn(unsigned long pc, void *fn)
>>>> {
>>>>         return (unsigned long)dereference_kernel_function_descriptor(fn) == pc;
>>> This looks wrong to me.  Function descriptors should always be 8-byte aligned.  I think this
>>> routine should return false if fn isn't 8-byte aligned.
>>
>> Below you state "Code entry points only need 4-byte alignment."
>>
>> I think that contradicts each other. Also, the calling code is,
>> for example,
>>     pc_is_kernel_fn(pc, syscall_exit)
>>
>> I fail to see how this can be consolidated if it is ok
>> that syscall_exit is 4-byte aligned but, at the same time,
>> must be 8-byte aligned to be considered to be a kernel function.
> In the above call, syscall_exit is treated as a function pointer. It points to an 8-byte aligned
> function descriptor.  The descriptor holds the actual address of the function.  It only needs
> 4-byte alignment.
> 
> Descriptors need 8-byte alignment for efficiency on 64-bit parisc. The pc and gp are accessed
> using ldd instructions.
> 

How about the patch below ?

Guenter

---
diff --git a/arch/parisc/kernel/unwind.c b/arch/parisc/kernel/unwind.c
index 27ae40a443b8..c2b9e23cbc0a 100644
--- a/arch/parisc/kernel/unwind.c
+++ b/arch/parisc/kernel/unwind.c
@@ -214,24 +214,14 @@ static bool pc_is_kernel_fn(unsigned long pc, void *fn)

  static int unwind_special(struct unwind_frame_info *info, unsigned long pc, int frame_size)
  {
-       /*
-        * We have to use void * instead of a function pointer, because
-        * function pointers aren't a pointer to the function on 64-bit.
-        * Make them const so the compiler knows they live in .text
-        * Note: We could use dereference_kernel_function_descriptor()
-        * instead but we want to keep it simple here.
-        */
-       extern void * const ret_from_kernel_thread;
-       extern void * const syscall_exit;
-       extern void * const intr_return;
-       extern void * const _switch_to_ret;
+       void (*ret_from_kernel_thread)(void);
+       void (*syscall_exit)(void);
+       void (*intr_return)(void);
+       void (*_switch_to_ret)(void);
  #ifdef CONFIG_IRQSTACKS
-       extern void * const _call_on_stack;
+       void (*_call_on_stack)(void);
  #endif /* CONFIG_IRQSTACKS */
-       void *ptr;
-
-       ptr = dereference_kernel_function_descriptor(&handle_interruption);
-       if (pc_is_kernel_fn(pc, ptr)) {
+       if (pc_is_kernel_fn(pc, handle_interruption)) {
                 struct pt_regs *regs = (struct pt_regs *)(info->sp - frame_size - PT_SZ_ALGN);
                 dbg("Unwinding through handle_interruption()\n");
                 info->prev_sp = regs->gr[30];


