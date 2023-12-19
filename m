Return-Path: <linux-kernel+bounces-5861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50565819074
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111892883E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8941C38F91;
	Tue, 19 Dec 2023 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="jB3fLzK5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F338DEE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso58361315e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1703013332; x=1703618132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GdCxlFtHvZGSYIdMb4RLBri/z4TEnZEwsssQH8uZiBs=;
        b=jB3fLzK5ai3JGjaHvVOv8VcyGg7JJ5GTiJRanr09gW4LYo6I7dKNmQpEgv9z4i7l17
         2YcQkFXw7zW5XuEgm4sIDwVLEQmtD4QM4nTAK/ACHqb6wWX8KuEminb2XT4AMadvDHHm
         Mxk0pkrGM81AmyZsZ5ZNG5LN4dkJZPjDUigBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703013332; x=1703618132;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdCxlFtHvZGSYIdMb4RLBri/z4TEnZEwsssQH8uZiBs=;
        b=P5vVHdAgvya58cYUZsPaVR+9fInIRfyL9H3Qb431g7cD04NcHvGbnZfnta5EISj9kE
         63QZInzjXGd+Ez/gkrozoD8ldQo6D81NEY4f2szNjnf2ruzdoc/NwnmcDhT0Nw+qww9/
         RUo2xZThCoT5HQNBKTFJYVYSO9CxzWhKc94C8bwuR0gx5ibGixh5X8DIctGV4HFBycrp
         N4a9jcGY+cV1o15aD4T5bE9DMpjYTheb2TYk7GRr0EHy6BrbNbv++vZ7UjU1SH4VliMf
         S0SzQeO1+szNaE+iXRgHMhsKG8KbdrQWbOC/djiAsomJR/qvufb3njs5FRaeVgYWS5Zj
         7QhQ==
X-Gm-Message-State: AOJu0YwdPzmY8/o25O4ps7/S3MMgyL/LdEZ++3FR9zi8duYfXH9dKFTo
	pAEVi2Cu1egfYsIyD7bhG4ckHZ9s58d+WxHRIog=
X-Google-Smtp-Source: AGHT+IEKnbx9zbyQ3x2Gc8lwVVnhtw0pe85zIssFNeWkRw5m4N3/eAu2iA2Bs/n6nxdwtkB1CYFWVQ==
X-Received: by 2002:a05:600c:548d:b0:40d:2df3:fdf with SMTP id iv13-20020a05600c548d00b0040d2df30fdfmr486112wmb.21.1703013332378;
        Tue, 19 Dec 2023 11:15:32 -0800 (PST)
Received: from [10.80.67.30] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003fee6e170f9sm4286929wmb.45.2023.12.19.11.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 11:15:32 -0800 (PST)
Message-ID: <87013f74-5828-4bef-848b-ffedde8e86f5@citrix.com>
Date: Tue, 19 Dec 2023 19:15:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [x86/entry] be5341eb0d:
 WARNING:CPU:#PID:#at_int80_emulation
Content-Language: en-GB
To: Linus Torvalds <torvalds@linuxfoundation.org>,
 Borislav Petkov <bp@alien8.de>
Cc: kernel test robot <oliver.sang@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 xen-devel@lists.xenproject.org
References: <202312191507.348721d2-oliver.sang@intel.com>
 <20231219095821.GAZYFpPUSKexZAcl05@fat_crate.local>
 <CAHk-=wimbX8UF6ECo53Hm4Vz0tCC7jjN9e3tEhZfoEtsxyfU-A@mail.gmail.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CAHk-=wimbX8UF6ECo53Hm4Vz0tCC7jjN9e3tEhZfoEtsxyfU-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/12/2023 6:20 pm, Linus Torvalds wrote:
> On Tue, 19 Dec 2023 at 01:58, Borislav Petkov <bp@alien8.de> wrote:
>> Looking at the dmesg, I think you missed the most important part - the
>> preceding line:
>>
>> [   13.480504][   T48] CFI failure at int80_emulation+0x67/0xb0 (target: sys_ni_posix_timers+0x0/0x70; expected type: 0xb02b34d9)
>>                         ^^^^^^^^^^^
> So I think the issue here is that sys_ni_posix_timers is just linker
> alias that is used for any non-implemented posix timer system call.

My reading of the original report is that there used to be:

    dmesg.WARNING:CPU:#PID:#at_do_int80_syscall_32

and now there's:

    dmesg.WARNING:CPU:#PID:#at_int80_emulation


i.e. kCFI was broken before, and all we did with be5341eb0d43 was change
the inlining, and therefore how the error was rendered.


> See:
>
>   #define __SYS_NI(abi, name)                                             \
>         SYSCALL_ALIAS(__##abi##_##name, sys_ni_posix_timers);

AFAICT, this is the problem, but it was preexiting too.

This is stuffing a function of type void into an array of function
pointers wanting pt_regs * which is indeed a kCFI violation.

Isn't the fix simply this?

~Andrew

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index fd9d12de7e92..12195164d5a4 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1171,7 +1171,7 @@ asmlinkage long sys_ni_syscall(void);
 
 #endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
 
-asmlinkage long sys_ni_posix_timers(void);
+asmlinkage long sys_ni_posix_timers(const struct pt_regs *regs);
 
 /*
  * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 828aeecbd1e8..29692354a908 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -22,7 +22,7 @@
 #include <asm/syscall_wrapper.h>
 #endif
 
-asmlinkage long sys_ni_posix_timers(void)
+asmlinkage long sys_ni_posix_timers(const struct pt_regs *regs)
 {
        pr_err_once("process %d (%s) attempted a POSIX timer syscall "
                    "while CONFIG_POSIX_TIMERS is not set\n",


