Return-Path: <linux-kernel+bounces-67234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A479685686A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596101F22586
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834E813849B;
	Thu, 15 Feb 2024 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwcSqMyo"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D131369B0;
	Thu, 15 Feb 2024 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011881; cv=none; b=ooTp+jJqh2RD7mKMXJvRaEKxXL4SxlWR2VabXB//CJ6hDFY+qolsKMy9krLongVu1Iwgg6b0nUVP8K/u4hNrDVOk9LKD2MXvmHYQCkN03EkyJ8dODj3rwr3e0O9LBscSIErVUZ+B5kItVjj9PnODofeeyU1H2P60AeyRHV3GJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011881; c=relaxed/simple;
	bh=cF7RZ2ei90P4jrq8L2zSfWpmQDRweJvjYImQjBVUrSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfF14ze4veLP5HZgtFp8W7MyCt48vMKrfr/f2VPbTunil/8FR+dwcBukOlAzQ6StcrcC1bZ2Mxi9wXHIyAXn1SSQG4Ncd/Ugb86tsuxUw7+J+SRFCKvXb6XPovl/zx7YMNp/wG+wqk/UDAR1yiwKwAVpGWP+jQxNmR1atuIHxYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwcSqMyo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d731314e67so7891275ad.1;
        Thu, 15 Feb 2024 07:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708011879; x=1708616679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=daYSfFMwEOlQLZSVRUQJEmuIcA/M/NirswRAJ8iX3Yw=;
        b=RwcSqMyoxaGZyXCudjuiMwEbW5sjd46OP1KqY/g7Gm7j1LiZFrqSyqvhaBIK7qknpt
         rAyB8/IcEDLiN53AQ7eYijayU5rNaE3G5yXpmLBC8r3sSff59lpbWsUWbOkcz06jQat7
         B5mwRb1Ksl0mJ5NTSiDYUTG7DsDY3EV3OwFqnL1EoLpRAfGPJGZbmo0INXrnIap6hkyp
         /daaoAQSAeplArPcnjoGJWny06YxJAySn62Q+4Bvuwqr0SBnERNFtVPSl1XnSiQIACaq
         7DrgcLJn3K9dCFM2GImf4BzqeUJR18E5baYlW87b+edvgRhiF9zAt9qMiV1UZJgPj3Ty
         cEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011879; x=1708616679;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daYSfFMwEOlQLZSVRUQJEmuIcA/M/NirswRAJ8iX3Yw=;
        b=MepWJH5Yg5kFE0AnK+US7qdlmujRZxzucUZfNCbWqx8JBsTRq/ScrnypqQK8JT3YPj
         wjZFCr4WZKMyn3bhQwyLcvUYULnmQsW/JMbToYkijQZ7TbcazuB5PEboINB5WuBdCBsz
         mlcegz7a22XzsnaGPauo6COY1i/outYLsooE3jMMlYfRfU3aGFhHGcyYmuLiu93qJBf9
         Q/Nf1zJEEyY3ArXlTrepsglh1obJZ1xXEi1P2as/Lz1PwQbQ8lGAdIHE02FZ25MKNUi2
         +e+L6y37DZG6HY7mMnpSh7/7jxmSrfk5OQ7wVWfQwU3LnVKyUodesFQjFUfNqXjGhCfs
         S6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXWpvspCsHfoopt3ZUJSjZVHpGSmO4X5+/aM0hU7okwYZ9RPX5sVn7HzmubtHVHBHpF4rm2X9gpxK+KnjxVjRJPrW0fgCcfAAj9o+/
X-Gm-Message-State: AOJu0YwxnEhNeuMGJSxruUNadrIT1XOVJ+l2G80PYxKc49msLxtTJAvf
	P/0+zaX12NDRWhtsX6HrAM3JIQVDSGepvgOk0zB3gVNxOShi/8Cc
X-Google-Smtp-Source: AGHT+IHs6WoCcBjNFg0tiSagaXuPArX4PSc9yW9nfmlD8P+hvnDJ1EmDW6kC2Yfx1ZdjTmwa3mD4ew==
X-Received: by 2002:a17:902:ba94:b0:1d9:a890:e72f with SMTP id k20-20020a170902ba9400b001d9a890e72fmr1663676pls.50.1708011878678;
        Thu, 15 Feb 2024 07:44:38 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902e98300b001da294ff6d5sm1399882plb.189.2024.02.15.07.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 07:44:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c22f28a2-b042-4abe-b9e4-a925b97073bb@roeck-us.net>
Date: Thu, 15 Feb 2024 07:44:36 -0800
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
To: David Laight <David.Laight@ACULAB.COM>,
 Charlie Jenkins <charlie@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net>
 <a7e9691432374000b9566a0201d004e6@AcuMS.aculab.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <a7e9691432374000b9566a0201d004e6@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 02:27, David Laight wrote:
> ...
>> It would be worthwhile tracking this down since there are
>> lots of unaligned data accesses (8-byte accesses on 4-byte aligned addresses)
>> when running the kernel in 64-bit mode.
> 
> Hmmm....
> For performance reasons you really don't want any of them.
> The misaligned 64bit fields need an __attribute((aligned(4)) marker.
> 
> If the checksum code can do them it really needs to detect
> and handle the misalignment.
> 
> The misaligned trap handler probably ought to contain a
> warn_on_once() to dump stack on the first such error.
> They can then be fixed one at a time.
> 

Unaligned LDD at unwind_once+0x4a8/0x5e0

Decoded:

Unaligned LDD at unwind_once (arch/parisc/kernel/unwind.c:212 arch/parisc/kernel/unwind.c:243 arch/parisc/kernel/unwind.c:371 arch/parisc/kernel/unwind.c:445)

Source:

static bool pc_is_kernel_fn(unsigned long pc, void *fn)
{
         return (unsigned long)dereference_kernel_function_descriptor(fn) == pc;
}

Disassembled:

  c38:   50 3c 00 00     ldd 0(r1),ret0
  c3c:   08 1b 02 44     copy dp,r4
  c40:   0f 80 10 da     ldd 0(ret0),r26    <--
  c44:   37 dd 3f a1     ldo -30(sp),ret1
  c48:   51 02 00 20     ldd 10(r8),rp
  c4c:   e8 40 f0 00     bve,l (rp),rp
  c50:   51 1b 00 30     ldd 18(r8),dp

Hmm, interesting. See below for a possible fix. Should I submit a patch ?

Thanks,
Guenter

---
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index ab23e61a6f01..1d2aab619466 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -772,6 +772,7 @@ ENTRY_CFI(_switch_to)
         bv      %r0(%r2)
         mtctl   %r25,%cr30

+       .align  8
  ENTRY(_switch_to_ret)
         mtctl   %r0, %cr0               /* Needed for single stepping */
         callee_rest
@@ -1702,6 +1703,7 @@ ENTRY_CFI(sys_rt_sigreturn_wrapper)
         LDREG   PT_GR28(%r1),%r28  /* reload original r28 for syscall_exit */
  ENDPROC_CFI(sys_rt_sigreturn_wrapper)

+       .align 8
  ENTRY(syscall_exit)
         /* NOTE: Not all syscalls exit this way.  rt_sigreturn will exit
          * via syscall_exit_rfi if the signal was received while the process


