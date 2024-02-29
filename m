Return-Path: <linux-kernel+bounces-87276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D986D210
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CA61F2688D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D597A12E;
	Thu, 29 Feb 2024 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="3X0T5qTt"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066F160653
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231022; cv=none; b=oCuDFEjR0Yf62X+RJV9baXx5FtzTftKumsPdg/sEhx/DGs8Hw525kGGSf6DT0APyi9zu7eQwx57lkvf434bkw8Zv5PErI5Jfn3HgPxxnUgILuoWU/wSvlWQ1+Wa6dpcTSAfGUjdQxqwcKz5grtbDntWtxbbfZGM3gjAtx61qfZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231022; c=relaxed/simple;
	bh=IUs2P2eBk1wf7ezQbtubT+nO2sA2RiLqnI5zaQm0gd4=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=dvB0HPiigmP96eBRmaNXvgV+6PvxMh2zCWE5W1ugbWqoZly3QGptWPo8P5Vq4mOWPe2DEeCepn4wxTmA+janwnoQmfv0giFlsZljHnDHKa6H0t0apcrt7v4AtB0n631LhnpgDODBCkD/lHVFh2Ado4aKkJoFY0p3hLd/ACguBZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=3X0T5qTt; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8b519e438so1098150a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1709231020; x=1709835820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbYjGWbVPUoMA9yoLV4Bq9DdL9YDbwpcvfQ5i1IxNJY=;
        b=3X0T5qTtgCF2MJ5+gFyS39y8RtnaZYouEWL67WNHj9DYPTfIzqgVMrvu2QAbzfvi9m
         jMYZXwgzuaS10zTshKYIzLZOgXTrYEH9cwWmR3XZ+5Xyo6TtFOpwOpu94JmRviPkZfya
         OBeEoTqoli4iMnLpiEclZC9YjscXFCKBblVFFwTIEFxEGcENPm2QNzUTLXFOt9APC+hY
         sjs85sZ+3r/yasSNT0/vh959gzXCQuFulZEwg5y9qNf60zmbdfUgDoWQy6xt0w8QcZVL
         H73YaSMVc0KlkMyrrUFOpA7/jJc5ytitJhPGROd31lrUs20+vi+NNukreE0nFq5UgnrV
         r72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231020; x=1709835820;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbYjGWbVPUoMA9yoLV4Bq9DdL9YDbwpcvfQ5i1IxNJY=;
        b=fiKjo7gGxkGmdUYyU5L5OsWhPRS2PcJiEW8IyCe8YtdDkHTkOzAaQK5U1sdjcm2JPp
         A+h3ab5AJ50YQjRR2U0oWGb9pc6SlYpobHogziUhbE0J+CuESr5pSWLpIqeGpL/HTcBC
         R0aMXn6R13zYAzd1inW3ETOzSZUGPd510BIygRrH0r50VMIOkM9SR6W1uP/RadedCxM7
         Q5wfatM0jXme84QCHbs4evEIHCAlMhSjO50nfXT4WmzAWI+/PUfPxnJuepv2YTAQ5DOd
         NJWi2oUkUpg12oHtkyXVStjScvcLNdiEbYB3GEMsRVKaiu8SZQMqJyKU7M71HfvWJ2zn
         1Hyg==
X-Forwarded-Encrypted: i=1; AJvYcCUIX3tSSnRHz7Nqv4xfBq2oQsV1mxpDnCzoiZlxp9qJ/kF/cEi/GIOjjDcShoUCcfb8MHCglrvzdFUDt+gcCAQft9xmLlzl/TXjdRd7
X-Gm-Message-State: AOJu0YxL0hSIepEGy7XKw8vpvMwdwYlpq6gCrW7TwOWOEU7jmf+pNsZM
	/kXhGP/6kCtOrY3WMLad4C7hQ7jHYSeV6O9tpvqk67vDVvreqeZavtPxl+qLwCGI07nnZuHW/53
	Q
X-Google-Smtp-Source: AGHT+IGQTeBXjtlyAuNzBCl4pxIJl5lxn1BCm16ZbGfviqXJmKWQHlcF7bZ7LSjJ4SHO2MxyFQm++w==
X-Received: by 2002:a17:903:2284:b0:1dc:cbaa:f5dd with SMTP id b4-20020a170903228400b001dccbaaf5ddmr3655020plh.39.1709231020032;
        Thu, 29 Feb 2024 10:23:40 -0800 (PST)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902e81100b001dbcfa0f1acsm1810677plg.83.2024.02.29.10.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:23:39 -0800 (PST)
Date: Thu, 29 Feb 2024 10:23:39 -0800 (PST)
X-Google-Original-Date: Thu, 29 Feb 2024 10:23:34 PST (-0800)
Subject:     Re: [PATCH -fixes v4 2/3] riscv: Add a custom ISA extension for the [ms]envcfg CSR
In-Reply-To: <20240228-goldsmith-shrine-97fc4610e0bc@spud>
CC: samuel.holland@sifive.com, ajones@ventanamicro.com, linux-kernel@vger.kernel.org,
  alex@ghiti.fr, linux-riscv@lists.infradead.org, sorear@fastmail.com, stable@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
Message-ID: <mhng-94e8034f-eda3-45df-bcf0-1bd5bd9cb869@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 28 Feb 2024 02:12:14 PST (-0800), Conor Dooley wrote:
> On Tue, Feb 27, 2024 at 10:55:34PM -0800, Samuel Holland wrote:
>> The [ms]envcfg CSR was added in version 1.12 of the RISC-V privileged
>> ISA (aka S[ms]1p12). However, bits in this CSR are defined by several
>> other extensions which may be implemented separately from any particular
>> version of the privileged ISA (for example, some unrelated errata may
>> prevent an implementation from claiming conformance with Ss1p12). As a
>> result, Linux cannot simply use the privileged ISA version to determine
>> if the CSR is present. It must also check if any of these other
>> extensions are implemented. It also cannot probe the existence of the
>> CSR at runtime, because Linux does not require Sstrict, so (in the
>> absence of additional information) it cannot know if a CSR at that
>> address is [ms]envcfg or part of some non-conforming vendor extension.
>> 
>> Since there are several standard extensions that imply the existence of
>> the [ms]envcfg CSR, it becomes unwieldy to check for all of them
>> wherever the CSR is accessed. Instead, define a custom Xlinuxenvcfg ISA
>> extension bit that is implied by the other extensions and denotes that
>> the CSR exists as defined in the privileged ISA, containing at least one
>> of the fields common between menvcfg and senvcfg.
>
>> This extension does not need to be parsed from the devicetree or ISA
>> string because it can only be implemented as a subset of some other
>> standard extension.
>
> NGL, every time I look at the superset stuff I question whether or not
> it is a good implementation, but it is nice to see that it at least
> makes the creation of quasi-extension flags like this straightforward.

We can always add it to the DT list as a proper extension, but I think 
for this sort of stuff it's good enough for now -- we've already got a 
bunch of complexity for the proper ISA-defined extension dependencies, 
so it's not like we could really get away from it entirely.

> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Cheers,
> Conor.
>
>
>> 
>> Cc: <stable@vger.kernel.org> # v6.7+
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>> 
>> Changes in v4:
>>  - New patch for v4
>> 
>>  arch/riscv/include/asm/hwcap.h |  2 ++
>>  arch/riscv/kernel/cpufeature.c | 14 ++++++++++++--
>>  2 files changed, 14 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>> index 5340f818746b..1f2d2599c655 100644
>> --- a/arch/riscv/include/asm/hwcap.h
>> +++ b/arch/riscv/include/asm/hwcap.h
>> @@ -81,6 +81,8 @@
>>  #define RISCV_ISA_EXT_ZTSO		72
>>  #define RISCV_ISA_EXT_ZACAS		73
>>  
>> +#define RISCV_ISA_EXT_XLINUXENVCFG	127
>> +
>>  #define RISCV_ISA_EXT_MAX		128
>>  #define RISCV_ISA_EXT_INVALID		U32_MAX
>>  
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index c5b13f7dd482..dacffef68ce2 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -201,6 +201,16 @@ static const unsigned int riscv_zvbb_exts[] = {
>>  	RISCV_ISA_EXT_ZVKB
>>  };
>>  
>> +/*
>> + * While the [ms]envcfg CSRs were not defined until version 1.12 of the RISC-V
>> + * privileged ISA, the existence of the CSRs is implied by any extension which
>> + * specifies [ms]envcfg bit(s). Hence, we define a custom ISA extension for the
>> + * existence of the CSR, and treat it as a subset of those other extensions.
>> + */
>> +static const unsigned int riscv_xlinuxenvcfg_exts[] = {
>> +	RISCV_ISA_EXT_XLINUXENVCFG
>> +};
>> +
>>  /*
>>   * The canonical order of ISA extension names in the ISA string is defined in
>>   * chapter 27 of the unprivileged specification.
>> @@ -250,8 +260,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>  	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
>>  	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
>>  	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
>> -	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
>> -	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
>> +	__RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
>> +	__RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts),
>>  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>>  	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>>  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
>> -- 
>> 2.43.1
>> 

