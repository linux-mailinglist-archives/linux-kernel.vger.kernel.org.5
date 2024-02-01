Return-Path: <linux-kernel+bounces-47590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574AA844FE3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19E7B220F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA4E3A8FE;
	Thu,  1 Feb 2024 03:45:33 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B615E9C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759133; cv=none; b=NBuGzef9Zc5aNVRlMIGYToMyihU7dw3GtaP+MQrd5RW05Dr4H6iqmKtZPbGzZuLZN1aD9/Rp5IwQIQbVRF/7GAka+TPQVE+kVU/TE3RDvZmZJYhxjm/22TOxJk9Y0klPJ0YHT5F2CPtH8ECe7MN59Byl8ZGCMQDWiyG6XWrba3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759133; c=relaxed/simple;
	bh=x3WIoSNADotrc9sqjymJkZO1f23pArUE6DC4hQ5aYRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/beBuOuDfvF0yvA+OyJ8eJ4e2ec9yUzhYudvZDEznMBk4tlOdfqmTwiMmIH/2N60dXEnc0Sx7SIL6Gsq1w0aGaRuVO2opOrxSYC4qiQdzSptqw02GPQYeH1133oxu9PRaYewmEOcoxLqkctCDfjA96AiGgwfT4oVJB7ibwp4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7393de183so3691325ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706759131; x=1707363931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQXOa7LLPA5mB3r9PE/ky7/S4vcRmc/Br7XQyR94fo0=;
        b=eGUo8zZ4TL0bt+MvtfSm059Fv4K+2LMLfe/0VxDP2/NtO1hLJsBlLHOJCLt6ixMkiJ
         b9xC4gURiTKdu8HcQ7TFcxtV9jE0BNSGEkv2AxmO6qw1+h3Sl0vCT9C+bXWQNTFJInaY
         CMCRHLzIpyAjNOE/amhSYragCvMP+aiC8YicX4Z9DwqZF8WD+DQRJFGKa69k6FqbQ8cs
         fKMCiAscYDv35gbe+arz+FLO7wq7J477FcoCeFXvVW7iy1vWV04MDuewKY7bBc4jE6PP
         kaB4eCGbSL2tR2sNqFLRrxzMuQy8PyPKIaX+9GnbmV8OK3xV4zi4Av9m7zs7IU2ZznZV
         Z1hg==
X-Gm-Message-State: AOJu0YyjK+pGdWWjAN1cl59bJQ1PA8dvBYkp2OXkCtMmWyRJHj2V413d
	/nqjI/3mwBEB5VgraC5ew/J/AElX0N2AVEfBlt3gtZ/FGjVFnMGF
X-Google-Smtp-Source: AGHT+IFU+kNk+ULCHcmfo/aZK9crCvQ3jzOGrofjo4buD7yKUlwRS0hvchEIf3yt781RKndm3iMeCg==
X-Received: by 2002:a17:902:c20b:b0:1d7:2311:8070 with SMTP id 11-20020a170902c20b00b001d723118070mr1020131pll.37.1706759130859;
        Wed, 31 Jan 2024 19:45:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWbTE23w+aY6SO58GQM8848CPSCeHcgtEIaYruFrAbBi6wGjLUR7fJ/+T1OngtW0R001QZ8GH14t+w8vukY/AXyPnljE6Ynym95EVRs+E8O02Ha89r+DVa4Q85QNYJMPW3sZiFtTX+4PlXHrWbEALoFyqIoOC9I8860+Z/E36HrtX4QyzgKea8HHBainUiwfY2C4j7u0yT9mE26IcMTOloypyKCw1zY7DaVA3qHHQh0UdKdx60=
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902f20300b001d8f3c7fb96sm564524plc.166.2024.01.31.19.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:45:30 -0800 (PST)
Date: Wed, 31 Jan 2024 19:45:27 -0800
From: Dennis Zhou <dennis@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: alexghiti@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
	aou@eecs.berkeley.edu, geert@linux-m68k.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix wrong size passed to
 local_flush_tlb_range_asid()
Message-ID: <ZbsT16CvwSDXtlAL@snowbird>
References: <ZbdpTPMOw4lsPxBi@snowbird>
 <mhng-d603d0d3-2f72-4dfc-b635-c270ae79fd85@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-d603d0d3-2f72-4dfc-b635-c270ae79fd85@palmer-ri-x1c9a>

Hi Palmer,

On Wed, Jan 31, 2024 at 12:34:40PM -0800, Palmer Dabbelt wrote:
> On Mon, 29 Jan 2024 01:01:00 PST (-0800), dennis@kernel.org wrote:
> > Hi Alexandre,
> > 
> > On Tue, Jan 23, 2024 at 02:27:30PM +0100, Alexandre Ghiti wrote:
> > > local_flush_tlb_range_asid() takes the size as argument, not the end of
> > > the range to flush, so fix this by computing the size from the end and
> > > the start of the range.
> > > 
> > > Fixes: 7a92fc8b4d20 ("mm: Introduce flush_cache_vmap_early()")
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >  arch/riscv/mm/tlbflush.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > > index 8d12b26f5ac3..9619965f6501 100644
> > > --- a/arch/riscv/mm/tlbflush.c
> > > +++ b/arch/riscv/mm/tlbflush.c
> > > @@ -68,7 +68,7 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
> > > 
> > >  void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
> > >  {
> > > -	local_flush_tlb_range_asid(start, end, PAGE_SIZE, FLUSH_TLB_NO_ASID);
> > > +	local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_TLB_NO_ASID);
> > >  }
> > > 
> > >  static void __ipi_flush_tlb_all(void *info)
> > > --
> > > 2.39.2
> > > 
> > 
> > Sorry for the delay, I just pulled this into percpu#for-6.8-fixes. I'll
> > send it to Linus this week.
> 
> Do you mind if we do a shared tag or something?  It's going to conflict with
> https://lore.kernel.org/all/20240117140333.2479667-1-vincent.chen@sifive.com/
> .  No big deal as it's a pretty trivial conflict, but they'll both need
> stable backports.

This alone won't need a stable backport, I merged the bug as part of
enabling the percpu page allocator in the recent 6.8 merge window.

That being said, this is the only patch I'm carrying for v6.8. I'm happy
to drop it and have you pick it up instead. Saves me a tag and a PR.
Lmk if that works for you.

Thanks,
Dennis

