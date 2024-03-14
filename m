Return-Path: <linux-kernel+bounces-103612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEF987C1EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2981C20EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33174BF2;
	Thu, 14 Mar 2024 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwd8xETA"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD3745F1;
	Thu, 14 Mar 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436429; cv=none; b=twSHBm/KwnRa37a863T5QAJiH5MzYdlmwuFN93i7Fi9eoe50CJ/533V1y+CI3rhOPu+1wB65B0W+MZVmkHvLfhJ6A+IU0tZUqmKZpsCMVfi/2U0OtnmY/7aC0c4GnpyPybchjYzAPbhq00lvqLy7f5v1FJvTa3Rk9Zxp/KiiEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436429; c=relaxed/simple;
	bh=5ctYKauamGZM8xjOSEeX91Zqu4OcyHg0TVr5GHusde0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dK+kbTjrrn2JLcVDQhitJ86oRkfe9cqIn174GC+oHlxheEDhS2/XpdT75P6bA4Zo7QE4CQIDwFAIqktxZLIMLOGbXYe9QD4VxOsMIDlIMHhHLvz97Ui3uAttFDAZiG/AllFnebHsnLfAWD6e7O4tbbyhEHI1pVbj2Akz/QiLWmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lwd8xETA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513d4559fb4so792395e87.3;
        Thu, 14 Mar 2024 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710436425; x=1711041225; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+M3+Zqg40rEJxNyjhViMm+Dubqv8yuAMPQy7BFgEE4=;
        b=Lwd8xETAZn0FFVFi2pVlCc356gZeDI+Xzm83cSZTf1vgqIT5IGQt3j4XXFFtSKaPzO
         TYoDh8wR2FCsIWwnCXhWtBhCnoX+2CA5hqi0GXslL0QqUviMlZlg959j9MMkkHRUuIop
         zqfxXpNfmQdiJqidKjDcfVwwnqcrotGbQjhFl2JWDQAZPj2SJT5tzvwCFmiqaVhWw8GJ
         hHjR9/MwbKaA8OwlyntFeZGCyre9t6u1HawG1eVSbvmqzQvhvneeAWwwA9Bw1oBv44GG
         lYN8Ee6QWWCnNyTyP7XmK5l063uzKezpOu1z/F+pcfrFarkIX9Lq0vBUMLEsHSYrPBh+
         eb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436425; x=1711041225;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+M3+Zqg40rEJxNyjhViMm+Dubqv8yuAMPQy7BFgEE4=;
        b=S4fQJ12MmOjI+fBZ4qQk+9QlD5qK7Y/zn+y1cYEvFgTLC3XtqpOsdaiEbVrPY1grgr
         cEUEEhHTPQQx+83JlggEyhiYss7KuqXeh0ka0w3MZZ4uuoJ1xwa2ITyE/nQX/9lVbMwm
         mFBZ++rYjaTcp/vf/6SFsFdLUB53LlHTNzKe0Nv3VVyJjo6hL8rPzSqdgDQP80cdDmVR
         kcmC2qQDCSKa4MIYp8hJD01rqeGm6f0zPVr2P5Ha9cumOuldzeLiRCUJ1fWyepKCdajf
         1UhS3hXDii/QhN1GI4D9MnyMVl02u6PD2R4xo1ZfhWHcRyjkIm7rNErmZqmrxbs3XrPL
         /aig==
X-Forwarded-Encrypted: i=1; AJvYcCVISdxCXB6227qmaPZAujj3hMowq9kMDDfQaRfLUkI/6NjjT81qFoo3chq/eXdY9jiN8kTEFoc7n+CEA8X8Hzbp0oTFJVEdiUbJ5nLPkaKY3i3audszXlXzrQ8+j9ALydCE
X-Gm-Message-State: AOJu0YzbLfVtzsVwMA7VBhxpAgQkrWbyXVnKBNq0dqVNFTd7LiKifa3k
	OFT2Shk3fHj1lFDPLkzRCTa9wAugHJnfXOJAI4CxTe85X6CPjJt0
X-Google-Smtp-Source: AGHT+IF9aa8cn3L1z4VPQ4bDgYTS4V0NxqVVMSZhUutiD4N8IiuY+rVUaFiKGCmRcail6ROrjgqaLg==
X-Received: by 2002:a05:6512:53a:b0:513:b432:a37d with SMTP id o26-20020a056512053a00b00513b432a37dmr1592117lfc.25.1710436425247;
        Thu, 14 Mar 2024 10:13:45 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id ay15-20020a05600c1e0f00b00413079f9065sm3104772wmb.8.2024.03.14.10.13.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2024 10:13:44 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai <xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add arm64 JIT support for PROBE_MEM32
 pseudo instructions.
In-Reply-To: <CAP01T75tG5tXqRJsMn6iU1xvmEqeuTg=ja=LUPqqXkrJiYL2XQ@mail.gmail.com>
References: <20240314150003.123020-1-puranjay12@gmail.com>
 <20240314150003.123020-2-puranjay12@gmail.com>
 <CAP01T75tG5tXqRJsMn6iU1xvmEqeuTg=ja=LUPqqXkrJiYL2XQ@mail.gmail.com>
Date: Thu, 14 Mar 2024 17:13:42 +0000
Message-ID: <mb61pfrwsohx5.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Thu, 14 Mar 2024 at 16:00, Puranjay Mohan <puranjay12@gmail.com> wrote:
>>
>> Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
>> instructions.  They are similar to PROBE_MEM instructions with the
>> following differences:
>> - PROBE_MEM32 supports store.
>> - PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
>>   src/dst register
>> - PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in R28
>>   in the prologue). Due to bpf_arena constructions such R28 + reg +
>>   off16 access is guaranteed to be within arena virtual range, so no
>>   address check at run-time.
>> - PROBE_MEM32 allows STX and ST. If they fault the store is a nop. When
>>   LDX faults the destination register is zeroed.
>>
>> To support these on arm64, we do tmp2 = R28 + src/dst reg and then use
>> tmp2 as the new src/dst register. This allows us to reuse most of the
>> code for normal [LDX | STX | ST].
>>
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> ---
>
> Hi Alexei,
> Puranjay and I were discussing this stuff off list and noticed that
> atomic instructions are not handled.
> It turns out that will cause a kernel crash right now because the
> 32-bit offset into arena will be dereferenced directly.
>
> e.g. something like this:
>
> @@ -55,6 +56,7 @@ int arena_list_add(void *ctx)
>                 test_val++;
>                 n->value = i;
>                 arena_sum += i;
> +               __sync_fetch_and_add(&arena_sum, 0);
>                 list_add_head(&n->node, list_head);
>         }
>  #else
>
> I will try to prepare a fix for the x86 JIT. Puranjay will do the same
> for his set.

Yes, testing the change mentioned by Kumar on ARM64 causes a crashes as well:

bpf_testmod: loading out-of-tree module taints kernel.
 bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
 Mem abort info:
   ESR = 0x0000000096000006
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x06: level 2 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp=00000004043cc000
 [0000000000000010] pgd=0800000410d8f003, p4d=0800000410d8f003, pud=0800000405972003, pmd=0000000000000000
 Internal error: Oops: 0000000096000006 [#1] SMP
 Modules linked in: bpf_testmod(OE) nls_ascii nls_cp437 sunrpc vfat fat aes_ce_blk aes_ce_cipher ghash_ce sha1_ce button sch_fq_codel dm_mod dax configfs dmi_sysfs sha2_ce sha256_arm64 efivarfs
 CPU: 8 PID: 5631 Comm: test_progs Tainted: G           OE      6.8.0+ #2
 Hardware name: Amazon EC2 c6g.16xlarge/, BIOS 1.0 11/1/2018
 pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : bpf_prog_8771c336cb6a18eb_arena_list_add+0x204/0x2b8
 lr : bpf_prog_8771c336cb6a18eb_arena_list_add+0x144/0x2b8
 sp : ffff80008b84bc30
 x29: ffff80008b84bca0 x28: ffff8000a5008000 x27: ffff80008b84bc38
 x26: 0000000000000000 x25: ffff80008b84bc60 x24: 0000000000000000
 x23: 0000000000000000 x22: 0000000000000058 x21: 0000000000000838
 x20: 0000000000000000 x19: 0000000100001fe0 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffcc66d2c8
 x14: 0000000000000000 x13: 0000000000000000 x12: 000000000004058c
 x11: ffff8000a5008010 x10: 00000000ffffffff x9 : 00000000000002cf
 x8 : ffff800082ff4ab8 x7 : 0000000100001000 x6 : 0000000000000001
 x5 : 0000000010e5e3fd x4 : 000000003619b978 x3 : 0000000000000010
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000001fe0
 Call trace:
  bpf_prog_8771c336cb6a18eb_arena_list_add+0x204/0x2b8
  bpf_prog_test_run_syscall+0x100/0x340
  __sys_bpf+0x8e8/0xa20
  __arm64_sys_bpf+0x2c/0x48
  invoke_syscall+0x50/0x128
  el0_svc_common.constprop.0+0x48/0xf8
  do_el0_svc+0x28/0x40
  el0_svc+0x58/0x190
  el0t_64_sync_handler+0x13c/0x158
  el0t_64_sync+0x1a8/0x1b0
 Code: 8b010042 8b1c006b f9000162 d2800001 (f821307f)
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: disabled
 CPU features: 0x0,00000120,7002014a,21407a0b
 Memory Limit: none
 Rebooting in 5 seconds..

I will send v2 with the arm64 JIT fix, but I guess verifier has to be modified
as well to add BPF_PROBE_MEM32 to atomic instructions.

Thanks,
Puranjay

