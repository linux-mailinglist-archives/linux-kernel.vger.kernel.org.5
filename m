Return-Path: <linux-kernel+bounces-31309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A64832C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6824E287E45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4070154789;
	Fri, 19 Jan 2024 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="s4U0ho16"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895F54672
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677822; cv=none; b=DtYRBk/BquE2JCZLDdYQATi0KIRqemoO/5asWTZRZKAxMzA9UnRi1y9OMKpoYmjVKhcaCV68UO+5dDfbMxnMnOhzKpTZV53RohZJiGG0er8y9LQ2th47JFFGXZCJZb2ZsIFG7DmaUIIMt6avO8D0uYGYSg/LdBo6/TU562ujrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677822; c=relaxed/simple;
	bh=7dSFtIOUtnc7d6TIJokRXxaelPW5vKd+VvTdvvJyjLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGjrRE3ODn9ZOMK8yvSOBnRmFMOwCAfA6nsv+3CZDsaAfahagB1S/wQb59Im1UkPV1kxmThvaZy4HyqF7PEcdduDKaHmelEWFW3f1DtqzAM1jXLQ27uSql/o8A/dWCXA2vpTMsDDAjAxQnAJQTMHUKZv+oo4Ue8a2c7N3l6AtUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=s4U0ho16; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6dbc57d15daso497721b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705677820; x=1706282620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4piK4FlIBshk3S545o0PPe5+IQl2dl/fnP0KWlMUlPE=;
        b=s4U0ho16nOIx5WDASy6QZ0Rx9eC1MIXWHn22HB+CJZuxGZWYxICBKofYQYLKsLDNnU
         a5IBvb++eMykZqEOWsOdA8yqGNakJsLL4++23tpUMllmDLejY7J2CHmJEMXXGSSwveKK
         ne/m25EInCbtdXM1eYSzxOE2zx7IqXGLYUCQaA7V/XV2BT6Jo4hLBK1x3UfxX8ocbPc8
         Im5evLq5S1JQbq+b2QbV8tLCbfoEfIVq0n7JAOddZc1A3F2y2zaZK1mfhA2aQF9fTEgs
         obfuNpTLlM3UQ17tnsjW3XCdLGfC3Gx1CsaRAJBBSD1hey49syQweUZzYTkYoXeM0CMx
         3fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705677820; x=1706282620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4piK4FlIBshk3S545o0PPe5+IQl2dl/fnP0KWlMUlPE=;
        b=Ul2sI3P0qUADQZRU/viHniK8aVKfwwKkLJ09m+dPO8I67k5Z0apuQrRNRpV8ZIVRn9
         XtnmbzfLeWRQVfInse2kOO21AYvwVkskSV4V9d/0tuZeyvJ/K53FfxHFvoyZuNy5JkMe
         zmSFNNaT4JcOM5VIWYyonfdxUXFtRc2Q9aEtAznTEIVdSUBE/GTsmkuC+AfQsk0+oDGV
         QYN7L+2pH61Tq4LmvHNIzD6EOQ+XFSL6kcJY7atgBJidjP/JsQ4fTyWsshH1t6rnN4yq
         wbi2G9Ux9z4h2gM7XBwgH7/EiiG4ci0q4uKocK/OTl+qUYkyew2xnA56I1ZVfzcQXIMD
         3oYw==
X-Gm-Message-State: AOJu0Yz+ROrsW90/q/5vYoSFnWIsnPngS7Tku0qDuSdgUmG/A0BtoTLb
	QUZZfJHwj11T7U7q0SBDWmQ/+K3ivIx+41xuEX/gdYzqxjrdMA/gjx2Evt8i26Q=
X-Google-Smtp-Source: AGHT+IEDpAw5jRwxWDGo0pZARDmf9QlhA87xq1E/pHFbxmVfn6Z7N1QSRsRV5TCFojVTVQwO0YNAsA==
X-Received: by 2002:a05:6a20:4281:b0:19a:25c6:4913 with SMTP id o1-20020a056a20428100b0019a25c64913mr3247900pzj.38.1705677819959;
        Fri, 19 Jan 2024 07:23:39 -0800 (PST)
Received: from ghost (50-197-128-209-static.hfc.comcastbusiness.net. [50.197.128.209])
        by smtp.gmail.com with ESMTPSA id ks11-20020a056a004b8b00b006d6b91c6eb6sm5356928pfb.13.2024.01.19.07.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 07:23:39 -0800 (PST)
Date: Fri, 19 Jan 2024 07:23:36 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: lib: Check if output in asm goto supported
Message-ID: <ZaqT2E0rH3UbdnV0@ghost>
References: <20240118-csum_remove_output_operands_asm_goto-v2-1-5d1b73cf93d4@rivosinc.com>
 <20240119-1bff4a21b3d2d5c500a14fcc@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119-1bff4a21b3d2d5c500a14fcc@orel>

On Fri, Jan 19, 2024 at 10:41:14AM +0100, Andrew Jones wrote:
> On Thu, Jan 18, 2024 at 02:36:45PM -0800, Charlie Jenkins wrote:
> > The output field of an asm goto statement is not supported by all
> > compilers. If it is not supported, fallback to the non-optimized code.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Fixes: a04c192eabfb ("riscv: Add checksum library")
> > ---
> > The OutputOperands field for asm goto statements is only supported
> > starting from GCC 11. Split the asm goto to remove the use of this
> > feature.
> > ---
> > Changes in v2:
> > - Use CC_HAS_ASM_GOTO_TIED_OUTPUT
> > - Link to v1: https://lore.kernel.org/r/20240118-csum_remove_output_operands_asm_goto-v1-1-47c672bb9d4b@rivosinc.com
> > ---
> >  arch/riscv/lib/csum.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> > index 06ce8e7250d9..af3df5274ccb 100644
> > --- a/arch/riscv/lib/csum.c
> > +++ b/arch/riscv/lib/csum.c
> > @@ -156,6 +156,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
> >  	end = (const unsigned long *)(buff + len);
> >  	csum = do_csum_common(ptr, end, data);
> >  
> > +#ifdef CC_HAS_ASM_GOTO_TIED_OUTPUT
> 
> Can't we just add another IS_ENABLED() to the if rather than this #ifdef?

Unfortunately no. GCC throws syntax before it determines if a branch
will never be taken, so even though the code is not emitted it will
still fail with IS_ENABLED.

> 
> >  	/*
> >  	 * Zbb support saves 6 instructions, so not worth checking without
> >  	 * alternatives if supported
> > @@ -214,6 +215,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
> >  		return csum >> 16;
> >  	}
> >  no_zbb:
> > +#endif /* CC_HAS_ASM_GOTO_TIED_OUTPUT */
> >  #ifndef CONFIG_32BIT
> >  	csum += ror64(csum, 32);
> >  	csum >>= 32;
> 
> BTW, I wonder how/if the check for CC_HAS_ASM_GOTO_TIED_OUTPUT in
> init/Kconfig is working as expected. I see $CC, as opposed to $(CC),
> being used there. I believe $CC is just the expansion of $C with a
> 'C' appended.

Huh that is strange. It does work but I am not sure how.

- Charlie

> 
> Thanks,
> drew
> 
> > 
> > ---
> > base-commit: 080c4324fa5e81ff3780206a138223abfb57a68e
> > change-id: 20240118-csum_remove_output_operands_asm_goto-49922c141ce7
> > -- 
> > - Charlie
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

