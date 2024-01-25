Return-Path: <linux-kernel+bounces-39077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25BF83CA9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF87297F40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC9F134720;
	Thu, 25 Jan 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PSmPiuhN"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515013399C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206343; cv=none; b=Pck+q4kprucuMgSwMMiAihQ1otBsVM8Bo0hA+/mlQOd0QvBiTFEVCMDCNIbBdXArm1d8UHK+kqdxjudQl5fYIArZ6DtFryw/mmZuKbSJwElximcQIKOcqExg+ldSo7gNMNJ/FoRVt8kz6NylLa/6Msd2sStC0L98geRkjUPeAw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206343; c=relaxed/simple;
	bh=cw8O2hqO9U01pVygNFVazLWDXfPwaESFBRTWSuf70Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0lZyHauR58aYPrhmnBcLXllHsBQPtCTOaJNBVYfHbRpEOOvkJ3bRaJCnDBzE4Xqbmyuf+KJdkn+OhqSB6hHkfkf6eDHCCVz2cVoQ2/afztH2JZ80I1odJKRAId1AHzgwM2K9a5xKDRLEpUDKZ8IAMvnt46NipZpyMfdAOk8BYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PSmPiuhN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71207524dso31478315ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706206341; x=1706811141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oOQ7PY5RMwdW49c44PeUD39W3uvEolKYcNoKx9tZHuc=;
        b=PSmPiuhN30ywzqBwEXa18j6bNFIJk7vf9IKQb4UwB5mPxikSB6Xr9t1kniyFIFKh6D
         +U5OVWOS7q6VP5w0jxF/2822a1RyoGNob1HK09yoRfl23bf+eZepnUwoNw8ArT8W9mcz
         svuYdYGGShpvNg+qrwugl7uUwqdu43lKdFtDIQJUJEbL6rLVRVuXb7JcW7f0/IGBQe5E
         HuobNgHYb0I75pa8kqAC1f2aJBitzR5r3RIq2L7TqOU7iDBxrgw/jw90lqHkhDoamF5C
         QwfcYIvk+FvvH2HvfUGfQ55nmgttPk8uCTzGYx2CbnHqCo9qX9uDRzy1sVzv1gYzHMkb
         y/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706206341; x=1706811141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOQ7PY5RMwdW49c44PeUD39W3uvEolKYcNoKx9tZHuc=;
        b=uDCCLB0mRNA64V0kSx5VJYoIZdxwLP968wQUbon4qPhv3y2kQgDXHo+ODSP6bygOuo
         wUCMyHgbiCMhS9bx9bySsWxsllbIfIGzDqyDsTWY2e14aaNnERGiOOnMF/W/cZJYSMM5
         Irc6hVloyr78hcw2GO0vhd/lgTn4bC+At65lelTDuv/2CvU6HV2mVVXM6aejRN0wOIvH
         yJGEk0EGJF/VVN2jaSXKay3TYmHvFIxz1azAl64j4ZbsHZ+kOcZzj9y2uEL52xIe3p9N
         vg58IFwceBv6Y/nnfkFC0audT+7+iS7GGUDKA7rHkJTZoYUQDZH8P5GTwff3z0WXFNeX
         pFAA==
X-Gm-Message-State: AOJu0YwGVaA+sHuhJ7a3IDlsYlQ8Q9P9P48aoYqPd/csZH+DAveSAGjE
	Lv74apyis197YE1xOM5I1caKKjRGKPtgd6wza0cvIz4eg9sonXShSyEA4lEnWVE=
X-Google-Smtp-Source: AGHT+IGPUyyPX5hM1Yrkm5iskfPCqBeEPRsk5d1X3OtxSMKWSiBaRZNyP6s8gkZ7PqF+fErCTpo4Gg==
X-Received: by 2002:a17:902:b284:b0:1d4:2d8d:3536 with SMTP id u4-20020a170902b28400b001d42d8d3536mr91755plr.71.1706206340832;
        Thu, 25 Jan 2024 10:12:20 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id jy13-20020a17090342cd00b001d720fa139fsm10390442plb.70.2024.01.25.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 10:12:20 -0800 (PST)
Date: Thu, 25 Jan 2024 10:12:16 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, corbet@lwn.net, aou@eecs.berkeley.edu,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, shuah@kernel.org, brauner@kernel.org,
	guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
	shikemeng@huaweicloud.com, david@redhat.com, charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	vincent.chen@sifive.com, andy.chiu@sifive.com, gerg@kernel.org,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, chenjiahao16@huawei.com,
	ruscur@russell.cc, bgray@linux.ibm.com, alx@kernel.org,
	baruch@tkos.co.il, zhangqing@loongson.cn, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, joey.gouly@arm.com,
	shr@devkernel.io, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 24/28] riscv: select config for shadow stack and
 landing pad instr support
Message-ID: <ZbKkgNX7xfU5KO8X@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-25-debug@rivosinc.com>
 <20240125-snitch-boogieman-5b4a0b142e61@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240125-snitch-boogieman-5b4a0b142e61@spud>

On Thu, Jan 25, 2024 at 06:04:26PM +0000, Conor Dooley wrote:
>On Wed, Jan 24, 2024 at 10:21:49PM -0800, debug@rivosinc.com wrote:
>> From: Deepak Gupta <debug@rivosinc.com>
>>
>> This patch selects config shadow stack support and landing pad instr
>> support. Shadow stack support and landing instr support is hidden behind
>> `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires up path
>> to enumerate CPU support and if cpu support exists, kernel will support
>> cpu assisted user mode cfi.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/Kconfig | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 9d386e9edc45..437b2f9abf3e 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -163,6 +163,7 @@ config RISCV
>>  	select SYSCTL_EXCEPTION_TRACE
>>  	select THREAD_INFO_IN_TASK
>>  	select TRACE_IRQFLAGS_SUPPORT
>> +	select RISCV_USER_CFI
>
>This select makes no sense to me, it will unconditionally enable
>RISCV_USER_CFI. I don't think that that is your intent, since you have a
>detailed option below that allows the user to turn it on or off.
>
>If you remove it, the commit message will need to change too FYI.
>

Selecting this config puts support in Kernel so that it can run tasks who wants
to enable hardware assisted control flow integrity for themselves. But apps still
always need to optin using `prctls`. Those prctls are stubs and return EINVAL when
this config is not selected. Not selecting this config means, kernel will not support
enabling this feature for user mode.

I'll edit commit message to better reflect this.

>Thanks,
>Conor.
>
>>  	select UACCESS_MEMCPY if !MMU
>>  	select ZONE_DMA32 if 64BIT
>>
>> @@ -182,6 +183,20 @@ config HAVE_SHADOW_CALL_STACK
>>  	# https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a484e843e6eeb51f0cb7b8819e50da6d2444d769
>>  	depends on $(ld-option,--no-relax-gp)
>>
>> +config RISCV_USER_CFI
>> +	bool "riscv userspace control flow integrity"
>> +	help
>> +	  Provides CPU assisted control flow integrity to userspace tasks.
>> +	  Control flow integrity is provided by implementing shadow stack for
>> +	  backward edge and indirect branch tracking for forward edge in program.
>> +	  Shadow stack protection is a hardware feature that detects function
>> +	  return address corruption. This helps mitigate ROP attacks.
>> +	  Indirect branch tracking enforces that all indirect branches must land
>> +	  on a landing pad instruction else CPU will fault. This mitigates against
>> +	  JOP / COP attacks. Applications must be enabled to use it, and old user-
>> +	  space does not get protection "for free".
>> +	  default y
>> +
>>  config ARCH_MMAP_RND_BITS_MIN
>>  	default 18 if 64BIT
>>  	default 8
>> --
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv



