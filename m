Return-Path: <linux-kernel+bounces-141433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6168A1EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BF5B2961C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8290578C61;
	Thu, 11 Apr 2024 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nFJ78eNR"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A093E47A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858025; cv=none; b=WirjouPalD0Zesk2cPwpX7+O98uQtObXzPCil6zpcDXLxiMT/El0sE+T7Op2yXYDNgxphHtX36OI7ZIco4UMVVVAn/7tDb12ftOAlH7kOPZ3K9uI+/NokDduRpMpGNw35J/OObwvEi5NKSiMd542o7NS4+dBrFCsLORyPFkH/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858025; c=relaxed/simple;
	bh=YNm3q05GBcoPy402fbEtHnVeUxD5k5EjIxg4a5DtEsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5ndLYbpo2m6zouH7VQmz3GdiRmn1DC1K9SK/xHRP93YXIPTOkeB+jpq4xfVSFL+6aoW+KRK762A/2yyNuowDECp/PEzds3onEFzwTxxggTCkaqj+6kxUUMmWBLBDYuTK38ib6MWLO2e3FFFG+4SJkg5k9pM1IJGqqPhM/hbV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nFJ78eNR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso112275b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712858023; x=1713462823; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sNBRHOyPI+Ix6+A4cvuQZL/n3YEyzqDCW+Z4zO41EyQ=;
        b=nFJ78eNRobWHN0T2ES+bCBF3YSl+9MbyUrPNeykx4QChKIav4eSOh93fGPdNd17KNG
         nUMOlLjgxpnk2esSVI42BYmZhbAtACDn+o7wo/zN8SnLHAL/M1YPL1vGHKt/LzDarCux
         mBRPzIDWevugHygXtWdbpHqMrKiw5mXfDZrcFGOfoiROba/ul7mmmMg0RY287yL+7nI3
         g3lFWEn7ZfIM5pzUBJDQBf0azHYq0GGTfvpT0ZS0JYBOIlZdJWWHjIMuG3RJ3EEgdrV/
         th/6tq82AEEWEClzeg629BSWlE10tr31xb177o9bH+FQu5UFPESEtkBqQaTktNb5698a
         Fe3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858023; x=1713462823;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNBRHOyPI+Ix6+A4cvuQZL/n3YEyzqDCW+Z4zO41EyQ=;
        b=eL75HL2dt9YHTAVGBGAB4EsFSBTz5KwT3xw+vKmxGDnkGRZ72VMBMiNMOTRcFt5oyT
         1BcfFUfjAir+x/ZJ/+ICbBbkC1IkZBs6e1pH3rl2BunYBJCuS3yVHdMWMP/hrOJ8h8UT
         cKNcI9DtNTGBgMZ6oFrZSE6GFH8+xnasl9ULOsSO2lZDsM+taOLtkfnJdACPLI+TsClh
         Yn0GWBRxP6w8Rax3O15YwUTk5SYJHYaJcnebl2g3VsRrsR7HxNpHOcOcKvx4eXzVSJQq
         PMorkYCr1x2Lh3El2BkDZN3TkBXBAEZWZLaZqcNgMQT8DoYG4V5OJ4NDpa3oPYYwSadM
         lz+A==
X-Forwarded-Encrypted: i=1; AJvYcCXGj0ZfuQ1wGcmWRDg55OutjDjGGncIV6Kg3G140Mx1xss8i6Z8mui/kzVMC7QIZ1MCrDYuXZtymZnYAJ7cJ8u8UVN6CIKLjl+Rp5ZA
X-Gm-Message-State: AOJu0YxQuahHz14ZEZcldarT/sjh0GjX+rmnt1XHDrc44veTQ8jXmcVi
	Plisf6QWzYQQ0InkpELuH5t5ruKrGb0mpH400YkZIgcMGgNiVDRQb2VzBrOiT/o=
X-Google-Smtp-Source: AGHT+IHvTlKfIjzPeOBTC79yWowwoTcXJYi0DJrQEFv7vxDpvjIWBOVWUaYo1AptR3Y6sfvrZ3mgAQ==
X-Received: by 2002:a05:6a20:5648:b0:1a7:4b6f:7934 with SMTP id is8-20020a056a20564800b001a74b6f7934mr552627pzc.17.1712858022568;
        Thu, 11 Apr 2024 10:53:42 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a25-20020a63bd19000000b005e43cb66a7asm1356148pgf.87.2024.04.11.10.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 10:53:42 -0700 (PDT)
Date: Thu, 11 Apr 2024 10:53:39 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, andy.chiu@sifive.com,
	hankuan.chen@sifive.com, guoren@kernel.org, greentime.hu@sifive.com,
	cleger@rivosinc.com, apatel@ventanamicro.com,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	mchitale@ventanamicro.com, dbarboza@ventanamicro.com,
	waylingii@gmail.com, sameo@rivosinc.com, alexghiti@rivosinc.com,
	akpm@linux-foundation.org, shikemeng@huaweicloud.com,
	rppt@kernel.org, charlie@rivosinc.com, xiao.w.wang@intel.com,
	willy@infradead.org, jszhang@kernel.org, leobras@redhat.com,
	songshuaishuai@tinylab.org, haxel@fzi.de, samuel.holland@sifive.com,
	namcaov@gmail.com, bjorn@rivosinc.com, cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com, falcon@tinylab.org,
	viro@zeniv.linux.org.uk, bhe@redhat.com, chenjiahao16@huawei.com,
	hca@linux.ibm.com, arnd@arndb.de, kent.overstreet@linux.dev,
	boqun.feng@gmail.com, oleg@redhat.com, paulmck@kernel.org,
	broonie@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 02/12] riscv: add landing pad for asm routines.
Message-ID: <ZhgjoyObf+nMihA4@debug.ba.rivosinc.com>
References: <20240409061043.3269676-1-debug@rivosinc.com>
 <20240409061043.3269676-3-debug@rivosinc.com>
 <CABCJKuee-6GGDDjvByCkikR02gka2BNhwRVBw6UAwEcmSQposQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKuee-6GGDDjvByCkikR02gka2BNhwRVBw6UAwEcmSQposQ@mail.gmail.com>

On Thu, Apr 11, 2024 at 05:15:17PM +0000, Sami Tolvanen wrote:
>On Tue, Apr 9, 2024 at 6:12 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> SYM_* macros are used to define assembly routines. In this patch series,
>> re-define those macros in risc-v arch specific include file to include
>> a landing pad instruction at the beginning. This is done only when the
>> compiler flag for landing pad is enabled (i.e. __riscv_zicfilp).
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/linkage.h | 42 ++++++++++++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/linkage.h b/arch/riscv/include/asm/linkage.h
>> index 9e88ba23cd2b..bb43ae7dadeb 100644
>> --- a/arch/riscv/include/asm/linkage.h
>> +++ b/arch/riscv/include/asm/linkage.h
>> @@ -6,7 +6,49 @@
>>  #ifndef _ASM_RISCV_LINKAGE_H
>>  #define _ASM_RISCV_LINKAGE_H
>>
>> +#ifdef __ASSEMBLY__
>> +#include <asm/assembler.h>
>> +#endif
>> +
>>  #define __ALIGN                .balign 4
>>  #define __ALIGN_STR    ".balign 4"
>>
>> +#ifdef __riscv_zicfilp
>> +/*
>> + * A landing pad instruction is needed at start of asm routines
>> + * re-define macros for asm routines to have a landing pad at
>> + * the beginning of function. Currently use label value of 0x1.
>> + * Eventually, label should be calculated as a hash over function
>> + * signature.
>> + */
>
>I haven't seen the compiler implementation for fine-grained Zicfilp
>yet, but in the kernel at least, this would ideally reuse as much of
>the KCFI plumbing as possible. For example, since only C code has type
>information, we left the type hash computation for the compiler, which
>allows assembly functions to just reference the appropriate
>__kcfi_typeid_* symbol.

Fine-grained compiler support hasn't made it in yet.

For reference, compiler that I've been using
https://github.com/sifive/riscv-gnu-toolchain/tree/cfi-dev

Honestly speaking, I didn't realize that kcfi plumbing has made it into
riscv as well. I realized that just after sending the patches.

In principle, I agree it should converge with software based kcfi scheme
as much as possible. However blocker that I see is `hash` is placed just
before function. This breaks for code mapped as execute only scenarios.
And ideally would like to have immediates at callsites instead of loads
(purely perf reason and not security).

But yes in next version, I'll take a look and try to converge as much as
possible.

>
>Sami

