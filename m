Return-Path: <linux-kernel+bounces-43775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3132A8418C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C136B2284A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530E1364C1;
	Tue, 30 Jan 2024 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dVDG6GyA"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC7364A9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580275; cv=none; b=qDajZ8yRH12geJ3efUl6CnGrnKf6SVYC8UnLq3HcJRSNTQlrhhzhubrcFZg/5ti8MI17RRJ+V6cI7sKhifRto8ny/epf6lbBL6lk0sPyLfZdOCyVXBd1I5HOTuX2Xi8cx4zNlIf4CA2vw+fiyaHDwI7m8Xd3Uxjz7luR29noirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580275; c=relaxed/simple;
	bh=fmYpZB3M2nBmPApk3/XtOVDPplTZJfQqEPxd1EoQ35w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk045gESaCwDh0zSGKxiigk3omQeWZgPhfGx3Rc4ddg25h/4J8IiXNpy3q7SJqG1DJTdgT3BC++/35WVXeHOFXXnSM1VH459bqICcEfPeasehXZMmWNY1Y7Fw65xSL9N9iTOR/qSmIlwIgzJiyzXbgvzLj7vLsxELmTuQyTl2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dVDG6GyA; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso2868209a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706580272; x=1707185072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Fim+674pGlDZqdWdDtQcmpj6hFXjEMlMtTI4Aqc3R8=;
        b=dVDG6GyAS6V1ofGxl7GuOd37OmYmN8wWNxNGD+lKaLoAJOCFZFJwcIbW13UGEbvHR0
         LJrAJUaB/b2rUerm3s90LPTYEneolKWpl2vAlafp4LXHYv/zGaAf4C7q3G4FaOwgdi7l
         Ac6fr6o/FNmUonyaq/5Xd2J5d+Sjo/SljBtJoJMnqqU84tKGdcrdy7mTWG1b/GEwZxzd
         n4nxQEsOwtMxUAMPlvGnVdT/5VpkTpFDI+zkJxOTDsSdXReVT3ykPPJCZ7JSC5eRs6bu
         N+/Nz3WBVEZEVIfpb25kbYlOmZjFYnvhqR0a4VsRmXObdBcbdZ3FGls28t1HC185Xavc
         t9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706580272; x=1707185072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fim+674pGlDZqdWdDtQcmpj6hFXjEMlMtTI4Aqc3R8=;
        b=AYxL16zT/ZZVYSPjbngskZxfa+XvXSH8E+lZFQwXWdyVEPcLKn1N+kt5w5N9xfmN+7
         aV+p27m1EPxP6GS1hUmLcr1RS1zoErl3+NUHsLgpII1tjrLSXl586OaFpwztar9ampf2
         RSmYR6atXoLQR07PAwFWc0t+dE6trJDS1lLdPSfJw0ulXW84ho3XSBnW7MfDz7q/0fp5
         UfAh+LLhQbl/sQVXcmwF4OtgVaZHztvsVhr82D6y9tNHuvodqi41xZtijKt52mAAx1Yy
         ct1lkzgFsAxY9fmGBl277Phr9L7MtadjmeYMncuyRQce3qnghXg8TQLOrj+jU2zgWDAj
         h1IQ==
X-Gm-Message-State: AOJu0YwX+x3VzZX6dE1oNKTwZDSpldC1THTLJlKl9G1Brre3V8cHQXOE
	9ot5excUp0f6qprdYrjLHXo2AKNNp9gBjSZpIwXpT485SiMUIewkWy9vuL8TCRc=
X-Google-Smtp-Source: AGHT+IFmSAptn8T/TsbpV8/fisKKcmE5PLrVBGvVUaObTd0DsSBuMD8xee55debl4plk5IqPBv7zLA==
X-Received: by 2002:a05:6a20:ce48:b0:19c:9a25:118d with SMTP id id8-20020a056a20ce4800b0019c9a25118dmr8122763pzb.11.1706580272351;
        Mon, 29 Jan 2024 18:04:32 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902d2d200b001d6eed31a1bsm5983392plc.245.2024.01.29.18.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 18:04:32 -0800 (PST)
Date: Mon, 29 Jan 2024 18:04:29 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Stefan O'Rear <sorear@fastmail.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Yangyu Chen <cyy@cyyself.name>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] riscv: mm: Use hint address in mmap if available
Message-ID: <ZbhZLewEscaayuaG@ghost>
References: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
 <20240129-use_mmap_hint_address-v1-1-4c74da813ba1@rivosinc.com>
 <46b90dbc-3b5f-4f52-8539-0f6fa7e28ce9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46b90dbc-3b5f-4f52-8539-0f6fa7e28ce9@app.fastmail.com>

On Mon, Jan 29, 2024 at 08:53:31PM -0500, Stefan O'Rear wrote:
> On Mon, Jan 29, 2024, at 7:37 PM, Charlie Jenkins wrote:
> > On riscv it is guaranteed that the address returned by mmap is less than
> > the hint address. Allow mmap to return an address all the way up to
> > addr, if provided, rather than just up to the lower address space.
> >
> > This provides a performance benefit as well, allowing mmap to exit after
> > checking that the address is in range rather than searching for a valid
> > address.
> >
> > It is possible to provide an address that uses at most the same number
> > of bits, however it is significantly more computationally expensive to
> > provide that number rather than setting the max to be the hint address.
> > There is the instruction clz/clzw in Zbb that returns the highest set bit
> > which could be used to performantly implement this, but it would still
> > be slower than the current implementation. At worst case, half of the
> > address would not be able to be allocated when a hint address is
> > provided.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/processor.h | 21 ++++++++-------------
> >  1 file changed, 8 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/processor.h 
> > b/arch/riscv/include/asm/processor.h
> > index f19f861cda54..f3ea5166e3b2 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -22,14 +22,11 @@
> >  ({								\
> >  	unsigned long mmap_end;					\
> >  	typeof(addr) _addr = (addr);				\
> > -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > -		mmap_end = STACK_TOP_MAX;			\
> 
> Setting mmap_end in the no-hint case seems to have been lost?
> 
> -s

Thanks for catching that, will fix in v2.

- Charlie

> 
> > -	else if ((_addr) >= VA_USER_SV57)			\
> > -		mmap_end = STACK_TOP_MAX;			\
> > -	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> > -		mmap_end = VA_USER_SV48;			\
> > +	if ((_addr) == 0 ||					\
> > +		(IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
> > +		((_addr + len) > BIT(VA_BITS - 1)))		\
> >  	else							\
> > -		mmap_end = VA_USER_SV39;			\
> > +		mmap_end = (_addr + len);			\
> >  	mmap_end;						\
> >  })
> > 
> > @@ -39,14 +36,12 @@
> >  	typeof(addr) _addr = (addr);				\
> >  	typeof(base) _base = (base);				\
> >  	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
> > -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > +	if ((_addr) == 0 ||					\
> > +	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
> > +	    ((_addr + len) > BIT(VA_BITS - 1)))			\
> >  		mmap_base = (_base);				\
> > -	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
> > -		mmap_base = VA_USER_SV57 - rnd_gap;		\
> > -	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> > -		mmap_base = VA_USER_SV48 - rnd_gap;		\
> >  	else							\
> > -		mmap_base = VA_USER_SV39 - rnd_gap;		\
> > +		mmap_base = (_addr + len) - rnd_gap;		\
> >  	mmap_base;						\
> >  })
> > 
> >
> > -- 
> > 2.43.0
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

