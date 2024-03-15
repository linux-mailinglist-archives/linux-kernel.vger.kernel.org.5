Return-Path: <linux-kernel+bounces-104688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433C87D25C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78101F21509
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EB4C3D0;
	Fri, 15 Mar 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXIoeWC8"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1AD45C08;
	Fri, 15 Mar 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522140; cv=none; b=djag8ef7JHpjQaRX/L6gFZNdKtlq/fMUy86F8bzya/yhYk7oBL4ERndAebkfSqL2Skrom+yVfODA1ngFTIxkQHGnKQm0WAcWXjMgh/Q4JEfmhQFHCD+gs2K8woOfs19WkeKKPfXsa2H0gQJrxoDnUoDp70knHCnkDTpr2Lc35FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522140; c=relaxed/simple;
	bh=WqxiZZ9yArKJvLkhTedxFi0hwYxafhZ47j93cBt7nhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cObFnwUoqa1bTOeHHFIB0TIC6RjTblWfSRlFNeVoMhxWroUmVMXVS0QKI7pvo5vL3O46HMY2mzm0PjHSeZl8Rsc8ciYNO1gOUEpyRdTK1PulJc4IKr4pQlxhKhcTdhywB0TUk6p5aXxBmZdb0iq4TAxVqWtUQRix2GjrQ6sSWPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXIoeWC8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6cadfffdbso2042726b3a.3;
        Fri, 15 Mar 2024 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710522138; x=1711126938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sj+qFgvCCXfEMGh2O/q7f+m1Q25u4P6SmHitAOZHz3k=;
        b=XXIoeWC8jSMzMhzgRnH2ezqTvqcjDXjbUSeHBiFKre6IcAdB2/QOYr24GF2OVjsdAd
         pMrvgkLjyreWlMfynDRTKFZZFVBpC0kXp61oB/8jRf0OhKbA6jk1B1msP729ckcBGENL
         89ai2H5s4eYDHuF98BfRy6VFk00aZYS+eyWgaECymXVnvkm/ZjF3OQm3dowEtflJyuw+
         U3XjRFZRRkQcwgVl7SKtQQgP1lmC2MSwm44d0BEqB0ExAHN6qhCMul39GDAtJAYShJG8
         QJCnQ4l7/8IXxthK7cArx1+0wtPXgl7BM0ZN0cTmbuunGWVUgaiP+6R5rjsGVAr2WCfr
         DpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710522138; x=1711126938;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sj+qFgvCCXfEMGh2O/q7f+m1Q25u4P6SmHitAOZHz3k=;
        b=CDbvlj+Yd5bHPYxDFIn4Mseftg6c2S7SeLu5MaGeP7my7CdXLdvpA7HQ20rWCg5pgJ
         Fpdrf2idPSIxmKDFusecTuXXJWFTjF1AvzOdnnhFAqIS4AXiuiWs82VfAB5KEkQgkGCG
         lgESizOExPnCRxmXccfQZqCQgChLbPaCmIPtxSbfkFX0DUqcR4tjSjbxDFXJY87MYwWJ
         KtvHp3b4yOIu4GjzWKzVtOceiIXAJadxeq9csdk6getgsWJihgONhInlFZqCWXU/SZXh
         2gMzCyGPvfKdP4/RtHtDStquxvB2wvoAE+hHdRIg1K4B8xNl6Nr54y3IPjTjharcn1qz
         xipw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9GRTHf0hJO8CSORgDoMZg4rterjI7tuzWMCaiqoAsy8mCfTfR2theJIXwd5XSMSyaTDRK4sAYo7nDxJjw2hZ4sRKGI6Jdyr3MGlP4dVELjclhAS9kK/u1NDok7wIWAajbyCKokHC2bK2
X-Gm-Message-State: AOJu0YyFmL1ZTaoAmRjI653PwAF9Qm+jvP28a4nJqBju4R7j9/ZkFTR2
	mhhPJJnLG2N0nQkqhSdn/QUZP3csGhY56YWi0X/UgvRCqx3+kGB3
X-Google-Smtp-Source: AGHT+IEgfb3w29Ej6pA9MX6qO0/Lh3+C4pZtbv+3134SeoyRpu77GZCtQc/xLj9Cia11t55uViOl4Q==
X-Received: by 2002:a05:6a00:2d8f:b0:6e7:38c:2b52 with SMTP id fb15-20020a056a002d8f00b006e7038c2b52mr752213pfb.13.1710522137711;
        Fri, 15 Mar 2024 10:02:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p30-20020a056a000a1e00b006e69cffc87dsm3613750pfh.84.2024.03.15.10.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 10:02:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6fee0d55-30a7-4811-9d82-f9613f857a5e@roeck-us.net>
Date: Fri, 15 Mar 2024 10:02:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
Content-Language: en-US
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, x86@kernel.org,
 Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
 <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/15/24 09:42, Linus Torvalds wrote:
> On Fri, 15 Mar 2024 at 09:17, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> [    3.291087] RIP: 0010:rapl_cpu_online+0xf2/0x110
>> [    3.291087] Code: 05 ff 8e 07 03 40 42 0f 00 48 89 43 60 e8 56 5f 12 00 8b 15 b4 84 61 02 48 8b 05 01 8f 07 03 48 c7 83 90 00 00 00 e0 84 80 b6 <48> 89 9c d0 38 01 00 00 e9 2b ff ff ff b8 f4 ff ff ff e9 47 ff ff
> 
> The code is
> 
>    mov    %rax,0x60(%rbx)
>    call   0x125f5f
>    mov    0x26184b4(%rip),%edx
>    mov    0x3078f01(%rip),%rax
>    movq   $0xffffffffb68084e0,0x90(%rbx)
>    mov    %rbx,0x138(%rax,%rdx,8)                <-- trapping instruction
>    jmp    <backwards>
> 
> with %rdx being some index having the value 0xffffffed (-19).
> 
> That's ENODEV.
> 
> Without line numbers (if you have debug info for that kernel, it's
> good to run "scripts/decode_stacktrace.sh" on stack traces) it's hard

Sorry, I should have done that.

> to really know what's up, but I strongly suspect that it's this:
> 
>          rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;

Correct:

[    2.632164] RIP: 0010:rapl_cpu_online (arch/x86/events/rapl.c:581)

which does point to that line. Here is a complete decoded backtrace:

[    2.632164] Call Trace:
[    2.632164]  <TASK>
[    2.632164] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
[    2.632164] ? page_fault_oops (arch/x86/mm/fault.c:713)
[    2.632164] ? search_exception_tables (kernel/extable.c:59)
[    2.632164] ? fixup_exception (arch/x86/mm/extable.c:328)
[    2.632164] ? exc_page_fault (arch/x86/mm/fault.c:1503 arch/x86/mm/fault.c:1563)
[    2.632164] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)
[    2.632164] ? __pfx_rapl_cpu_online (arch/x86/events/rapl.c:566)
[    2.632164] ? rapl_cpu_online (arch/x86/events/rapl.c:581)
[    2.632164] cpuhp_invoke_callback.constprop.0 (kernel/cpu.c:195)
[    2.632164] __cpuhp_setup_state_cpuslocked (kernel/cpu.c:2541)
[    2.632164] ? __pfx_rapl_cpu_online (arch/x86/events/rapl.c:566)
[    2.632164] rapl_pmu_init (./include/linux/cpuhotplug.h:274 arch/x86/events/rapl.c:843)
[    2.632164] ? __pfx_rapl_pmu_init (arch/x86/events/rapl.c:816)
[    2.632164] do_one_initcall (init/main.c:1241)
[    2.632164] kernel_init_freeable (init/main.c:1302 init/main.c:1319 init/main.c:1338 init/main.c:1551)
[    2.632164] ? __pfx_kernel_init (init/main.c:1432)
[    2.632164] kernel_init (init/main.c:1442)
[    2.632164] ret_from_fork (arch/x86/kernel/process.c:153)
[    2.632164] ? __pfx_kernel_init (init/main.c:1432)
[    2.632164] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)

Guenter


