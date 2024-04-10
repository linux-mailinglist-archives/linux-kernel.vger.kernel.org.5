Return-Path: <linux-kernel+bounces-139443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959618A036D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8891F22869
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058AB28FD;
	Wed, 10 Apr 2024 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RkkB7C1d"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920451C0DEF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788367; cv=none; b=XGmToE8Jx4zKui5NWYWjl22zhG25P6GlDljuF4iuz1F2K4C+20EoykRh4SHLCP//aTUyam7Xe2wqdBAI/RjEzlzqTOL2SGRxkIn91LRXdk8aeLJ+1lOoiOMYB8nIFMSKxAhzTMMN0RApB4+ZbG1EgVdWNu+aJtjJ/CMgO2VhFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788367; c=relaxed/simple;
	bh=CM4Nfxlau91i+wTCngy88tyM8dxynNHwdKc70IzsoDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRfXiWvBWJ36ZeoCrHZDAv5q6d9sQnstdjuZy/K6jbpb0dCIzxpaCgNno/UJ+8uNCnuTtasuUL/e3dTzBRM4GfbazwLXKF/pTkmWx4G5uW0Vs7UmQdXh/KcXlVKGDOuyCjucUDUEGsf1D2IPu4QrVPevnBcIewrvDYecdINuzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RkkB7C1d; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a50880ce2aso4485715eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712788363; x=1713393163; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8QwE0M/+UHCtJodiY6DO3J7/Qf3c8/oO3mN4e+iOAjs=;
        b=RkkB7C1dNIBvXbGFDUkYVbREy9QrsdRlTumeDjfDUj/DO1V38garIc7VxpOWCXbb9P
         5o4cPZZtezzgY7dD2ijiFiWul651qM5lzOYpo3hG6L6NQ6Hrz/5MCSdqjXqqqriwEFYF
         NdUS7cDKYcwDeUBoINrb+0IyC+QhGQoJZtqPt90g9nXNtvrsWhCI9PttAuuEL/0uPsVR
         RgD0FvRO3Xzctlc+2Kx8REL/EwtlgMHsDodQrY9lJpBU48nXnSZZirl0oP24J3KaSBP/
         i6qsxMvHURwT5XFVrZ8Fc/m/i0l7r7O/NmvYWt4pjA64f41lNCm/DenCqnnuxCr2nqFJ
         KtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712788363; x=1713393163;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QwE0M/+UHCtJodiY6DO3J7/Qf3c8/oO3mN4e+iOAjs=;
        b=gMZCwap7ta9MCTcCe2Pt8fRV3ufFHj3zW0feIgAUmQHn7b74RJ4lrQWBLmvP70a/OB
         Cq3MAVBbQ+JU20Y88hbxttcG/OzDZQPhjfJR/PQLzhCWikXfUySMNk2Ad5fGJa3Dm7/T
         fXQhaH0Z2lwl/m2qiJwib44MGPm/He8yXXI6Q5NFUiElry44HP3DCepsmty+cCZjac65
         yf3cokl+dHqeMuQ/oSS4aIRwQybC0E89fhzkoOz6WxuyXomwYlyzfGKc9PwX2CaHp9Cz
         8IhBIlN+8d3GeYNJxhVSGKQL4RTjd8AIz31y4NdlUnfJA/ixpBkHh4PNqZhJyFxho8KW
         0mZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5KcF2jncg2TufU8FtCCEoH57Fp+ZYlQ+futF5YQ84Wz937QXv6w4zPcdU+7mixSiGbHkPotY25hXDMbDFNAGiWjW947bpNtAnTF4x
X-Gm-Message-State: AOJu0YxRcgJnHyUWiUFmN6T6lwgo7RYtVNK7vwfh/xWqIaIVZ9/Ckmhk
	sB9RKvTRQsYZ9m/IQMy6niFT/AIil+w889EnT5MH8wUwajK4dscBoHn4yCoiZ9I=
X-Google-Smtp-Source: AGHT+IGx5/hd/E8Yp0sczgMFtCMtxA7z52W92PBZElrVxV9jPGQj2rV/u6V+YaWfxr37Nv+l4bXzlQ==
X-Received: by 2002:a05:6358:b5c1:b0:186:2ac7:316c with SMTP id wb1-20020a056358b5c100b001862ac7316cmr5042482rwc.20.1712788363600;
        Wed, 10 Apr 2024 15:32:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o65-20020a634144000000b005dc36761ad1sm55196pga.33.2024.04.10.15.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 15:32:43 -0700 (PDT)
Date: Wed, 10 Apr 2024 15:32:41 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 07/10] riscv: add ISA extension parsing for Zcmop
Message-ID: <ZhcTiakvfbjb2hon@debug.ba.rivosinc.com>
References: <20240410091106.749233-1-cleger@rivosinc.com>
 <20240410091106.749233-8-cleger@rivosinc.com>
 <ZhcFeVYUQJmBAKuv@debug.ba.rivosinc.com>
 <20240410-jawless-cavalry-a3eaf9c562a4@spud>
 <20240410-judgingly-appease-5df493852b70@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410-judgingly-appease-5df493852b70@spud>

On Wed, Apr 10, 2024 at 11:27:16PM +0100, Conor Dooley wrote:
>On Wed, Apr 10, 2024 at 11:16:11PM +0100, Conor Dooley wrote:
>> On Wed, Apr 10, 2024 at 02:32:41PM -0700, Deepak Gupta wrote:
>> > On Wed, Apr 10, 2024 at 11:11:00AM +0200, Clément Léger wrote:
>> > > Add parsing for Zcmop ISA extension which was ratified in commit
>> > > b854a709c00 ("Zcmop is ratified/1.0") of the riscv-isa-manual.
>> > >
>> > > Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> > > ---
>> > > arch/riscv/include/asm/hwcap.h | 1 +
>> > > arch/riscv/kernel/cpufeature.c | 1 +
>> > > 2 files changed, 2 insertions(+)
>> > >
>> > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>> > > index b7551bad341b..cff7660de268 100644
>> > > --- a/arch/riscv/include/asm/hwcap.h
>> > > +++ b/arch/riscv/include/asm/hwcap.h
>> > > @@ -86,6 +86,7 @@
>> > > #define RISCV_ISA_EXT_ZCB		77
>> > > #define RISCV_ISA_EXT_ZCD		78
>> > > #define RISCV_ISA_EXT_ZCF		79
>> > > +#define RISCV_ISA_EXT_ZCMOP		80
>> > >
>> > > #define RISCV_ISA_EXT_XLINUXENVCFG	127
>> > >
>> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> > > index 09dee071274d..f1450cd7231e 100644
>> > > --- a/arch/riscv/kernel/cpufeature.c
>> > > +++ b/arch/riscv/kernel/cpufeature.c
>> > > @@ -265,6 +265,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>> > > 	__RISCV_ISA_EXT_DATA(zcb, RISCV_ISA_EXT_ZCB),
>> > > 	__RISCV_ISA_EXT_DATA(zcd, RISCV_ISA_EXT_ZCD),
>> > > 	__RISCV_ISA_EXT_DATA(zcf, RISCV_ISA_EXT_ZCF),
>> > > +	__RISCV_ISA_EXT_DATA(zcmop, RISCV_ISA_EXT_ZCMOP),
>> >
>> > As per spec zcmop is dependent on zca. So perhaps below ?
>> >
>> > __RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZCMOP, RISCV_ISA_EXT_ZCA)
>>
>> What's zicboz got to do with it, copy-pasto I guess?

Yes, copy-pasta :-)

>> If we're gonna imply stuff like this though I think we need some
>> comments explaining why it's okay.
>
>Also, I'm inclined to call that out specifically in the binding, I've
>not yet checked if dependencies actually work for elements of a string
>array like the do for individual properties. I'll todo list that..

Earlier examples of specifying dependency on envcfg actually had functional
use case.
So you are right, I am not sure if its actually needed in this particular case.

And yes definitley, dependency should be mentioned in binding.



