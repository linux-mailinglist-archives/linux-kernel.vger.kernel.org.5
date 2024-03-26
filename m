Return-Path: <linux-kernel+bounces-119983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0A988CFB7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1511A328B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6E513D63A;
	Tue, 26 Mar 2024 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="oTImM2O5"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD8413E03F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487331; cv=none; b=qw519ppAbkj8OSsV2SuVQUbJcEJa96peSEqJic5ZbZJPMblYDGh2cqIz2Dkoh7kEZfo/CPuBNUIKEzoIOrUthdFdWYBebGiMCkLXjmWtYJNV8X2l6eXp5s85UpINb1Z2Q1VQnQxQdlkWA2xFQTAuIjxcb/RGfB349MBQ22E1RdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487331; c=relaxed/simple;
	bh=s08b6lHYI+rosZFlnj8/hdEGxrc4jOrRXDBNq5kldF8=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=oZJWJcN3J0Q+67Boa7qSH7uad19aqz3Yw+DLzB4CiNXH8r2MfeBdoiPH6YkSGLbOsYmYxf710+ew0A6XspadYUcxNhUA9qekZMtiGruTW0KV0zrRgCmdh2SvTRI/pc/QolYpfDlhl53QFbQuPvVLXcG9kVv1TNjqTbu3fto44hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=oTImM2O5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0f2798b47so1715785ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1711487329; x=1712092129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVy3Hz+QglZLXZjgfs9SD4hjFJzSIhc79fs9r0XUwbg=;
        b=oTImM2O56e5Ksl/Y4W6NqglhzHPWsTVJI8tLiddc6WBU+Ha01QhJjHFMomqfJUOtCN
         lB+NpJkexPY7T5kp/r1DjXU4/sbXmL1lSpK+KvJE7DLRTALudvs4d1Hu0w2ggXDOsJWv
         FyBnOnwto1Fc5EadEs2ubDrAc4p7AFHQo2l3VFd5qsHnfu5mFb0Cxjek1B4xpXi9Z4Px
         gBDkjoDe48ZSennOJ+aAMVc6kZZfi8SqvBIcF0snK5PGkdXHeC0i6IfU+f5q+FZMA0MT
         5OVC5fkcvrfubuCf4yb2NNWWENJFn5mMthc51NwUr0dxQz0ni1lN3pOtot/xlyPdFn6J
         turw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711487329; x=1712092129;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVy3Hz+QglZLXZjgfs9SD4hjFJzSIhc79fs9r0XUwbg=;
        b=b3QOUPaVujpjziDHptQ0EraWe3q4aJ3lA0JXMDWTMXoCITxrOHEImgoq1gG+Ix2IFU
         up6Bto/F4pm+yTE1iBgh6j3J3iZ/zP3b6zcEiX+a3qiO19JmyoDCojUFOY+GkzH1c87j
         sdcW6xMcwifwum8pdeNQRl02p9ddtWM+vV8A8TWcjh4KQpRwkzDt1vbW3djT+nvmatCR
         0flw0XxER55TpX6uP/4rr6IadRyYbtG9S9n4cr6sMwAEdFLspXigXV3983t7j0VVFEy1
         KmWYyasb1mw5M1M8YQJeZcXKjpMbp1Z4bxH9kvZq7qx0EEFufmFXiMrIFbE8/EiANH1i
         YcUA==
X-Forwarded-Encrypted: i=1; AJvYcCVEXVpTJnOudZE6W9K4FctKgkZSucvZLLL1V+LDsAcVKLNuHYhC8Cu3i+idrqytEO3k+vQSpGKu0gFqF4kxSTVvnpVFJSlqdovqSmSG
X-Gm-Message-State: AOJu0YzNIC72NA/t62lLkj6pp6f7kN13A45hR7cQp0iUSXCpdCUmFuO7
	jLuh2CEq8T3OkNksITjqudCUrO1Xmg5NcMHOrDqz44SvrMm1niqop8DsYYHH49k=
X-Google-Smtp-Source: AGHT+IF2HPw5BzRQJFPhKRUTLLZBWnEaNhZE1YFQ07t8V46j4F5D2XT2+2Uu9b87tXUa1tSe4tum4w==
X-Received: by 2002:a17:902:da88:b0:1e0:b5f1:aac2 with SMTP id j8-20020a170902da8800b001e0b5f1aac2mr3519934plx.10.1711487328512;
        Tue, 26 Mar 2024 14:08:48 -0700 (PDT)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id v13-20020a170902f0cd00b001e09c35e058sm7324705pla.195.2024.03.26.14.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 14:08:46 -0700 (PDT)
Date: Tue, 26 Mar 2024 14:08:46 -0700 (PDT)
X-Google-Original-Date: Tue, 26 Mar 2024 14:08:39 PDT (-0700)
Subject:     Re: [PATCH] riscv: compat_vdso: install compat_vdso.so.dbg to /lib/modules/*/vdso/
In-Reply-To: <1a1bf141-9fbf-4d30-bdd3-fd20f6170c3f@ghiti.fr>
CC: masahiroy@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alex@ghiti.fr
Message-ID: <mhng-db45f75f-4c54-4ade-9c88-cfd6015a9203@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 18 Mar 2024 13:53:42 PDT (-0700), alex@ghiti.fr wrote:
> Hi Masahiro,
>
> On 15/03/2024 05:06, Masahiro Yamada wrote:
>> On Thu, Mar 7, 2024 at 5:12 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>> Hi Masahiro,
>>>
>>> On 24/02/2024 04:37, Masahiro Yamada wrote:
>>>> Ping x 2 ?
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> On Sun, Jan 21, 2024 at 6:48 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>>> On Fri, Nov 17, 2023 at 9:58 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>>>> 'make vdso_install' installs debug vdso files to /lib/modules/*/vdso/.
>>>>>>
>>>>>> Only for the compat vdso on riscv, the installation destination differs;
>>>>>> compat_vdso.so.dbg is installed to /lib/module/*/compat_vdso/.
>>>>>>
>>>>>> To follow the standard install destination and simplify the vdso_install
>>>>>> logic, change the install destination to standard /lib/modules/*/vdso/.
>>>>>>
>>>>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>>>>> ---
>>>>> Ping?
>>>>> (in case "yet more RISC-V updates" happens)
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>    arch/riscv/Makefile | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>>>>>> index a74be78678eb..5cbe596345c1 100644
>>>>>> --- a/arch/riscv/Makefile
>>>>>> +++ b/arch/riscv/Makefile
>>>>>> @@ -146,7 +146,7 @@ endif
>>>>>>    endif
>>>>>>
>>>>>>    vdso-install-y                 += arch/riscv/kernel/vdso/vdso.so.dbg
>>>>>> -vdso-install-$(CONFIG_COMPAT)  += arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg:../compat_vdso/compat_vdso.so
>>>>>> +vdso-install-$(CONFIG_COMPAT)  += arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
>>>>>>
>>>>>>    ifneq ($(CONFIG_XIP_KERNEL),y)
>>>>>>    ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
>>>>>> --
>>>>>> 2.40.1
>>>>>>
>>>>> --
>>>>> Best Regards
>>>>> Masahiro Yamada
>>>>
>>>> --
>>>> Best Regards
>>>> Masahiro Yamada
>>>>
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>>
>>> Couldn't changing this library install path break some existing
>>> application? I mean it kind of breaks where the library is expected to
>>> be right?
>>
>> Do you have a particular library in mind?
>
>
> None in particular.
>
>
>>
>>
>> RISV-V is the only architecture that installs a debug vdso
>> to a different location than the
>> standard lib/modules/*/vdso/.
>>
>>
>> I regard this as a fix.
>
>
> You're probably right, I don't see why the search path would be
> different on riscv, unless it was fixed in userspace but I think this is
> the right thing to do, so:

We do have some weirdness with multlib paths, but I don't think that's 
related to the VDSO paths.

>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Thanks,
>
> Alex
>
>
>>
>>
>>
>>
>>

