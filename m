Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D7379F563
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjIMXS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjIMXS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:18:27 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0391BCB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:18:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fac346f6aso271964b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694647102; x=1695251902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJc42z8P6nDzPilZwKRjToDvpsRhMtSMczHRpoRzj48=;
        b=T0E7LKpLIReSPfYVKhj6Igsp0z6EtS8zkdfnP29ZUeQQp5xUOarGnKcWW9CyeuIeQw
         R8MnZhLkr5kbTTUYLCpaPyaUER77eeYHeKyDUidIO9P8f3hz6YvFOV89ysYADGtUDc4H
         fF2yMTe5DKtD5hOfsVBC9YtUEztrdVG+02XfUlZ7yk4dsuei94qqGUyZClmwEtBg+71d
         rX+BF3jiTQvd4ZeiHysP3cV8BayCOofKGjpFhzBTWy595l2nlbmQCWkW2gkHg5XGYbRd
         2w5zIop+BLPHZAh6xuOtNgJvPQeF919WKVKzprrfh+Fft3eA9GoLQjjVPNwTLKpK3LPB
         yyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694647102; x=1695251902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJc42z8P6nDzPilZwKRjToDvpsRhMtSMczHRpoRzj48=;
        b=Zg0fCwjaVQt+XT5eJj2Ow/B8+MIusUC8iCCogWZ/ivj8i5c1dJfe4y8RCEhquRDYU8
         zHKKWs5o8GadsmR7YwdwB5nJRtnyVo0tEC8fjj4Uxs2/XVE9/LU4GbaWW/1eyGZ9KaEW
         mpghDparxAStX8lPANeG2e1f7aiHlZcHc3ah2aPSWfLlLZUtGUPjWyCd0ThkFHyG/Ll7
         dKdkFchvgF0SYGvP+Wp9vDS30iVD8LCx0rq1eLgwrRJ4r7ru1Ec/0C4wG3jaorwiOPyu
         AF1h6SHdPlHb1f+G8bjy/DCcCGtge4MQXeizYrIko+tRerzZAhwy8FNPRVrZbCxf7JhR
         DasQ==
X-Gm-Message-State: AOJu0YyMqtmiSUfm1enEZLrmE1Ld7WcJDoJhj2HNZtD9Ru8eGuoe0b5Z
        0vHxgCV3sbckRd4oYsCwXWGeXg==
X-Google-Smtp-Source: AGHT+IE4DGy87y+n2xFtGQCzV+yeP59IPRKOAVAY/oRuATv4grqW3U7iJJ0ORADF01Dj7WzbJFc6qg==
X-Received: by 2002:a05:6a00:24d4:b0:68e:2fcd:f4de with SMTP id d20-20020a056a0024d400b0068e2fcdf4demr4462782pfv.20.1694647102487;
        Wed, 13 Sep 2023 16:18:22 -0700 (PDT)
Received: from ghost ([50.168.177.73])
        by smtp.gmail.com with ESMTPSA id z23-20020aa785d7000000b0068fbad48817sm94255pfn.123.2023.09.13.16.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 16:18:21 -0700 (PDT)
Date:   Wed, 13 Sep 2023 19:18:18 -0400
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 2/5] riscv: Add checksum library
Message-ID: <ZQJDOj/6lUumg7WP@ghost>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-2-77cc2ad9e9d7@rivosinc.com>
 <1818c4114b0e4144a9df21f235984840@AcuMS.aculab.com>
 <ZQEn+8Bi8dxNgg3g@ghost>
 <b503e341f2334d6b9b902a6e621ed7c3@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b503e341f2334d6b9b902a6e621ed7c3@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 08:47:49AM +0000, David Laight wrote:
> From: Charlie Jenkins
> > Sent: 13 September 2023 04:10
> > 
> > On Tue, Sep 12, 2023 at 08:45:38AM +0000, David Laight wrote:
> > > From: Charlie Jenkins
> > > > Sent: 11 September 2023 23:57
> > > >
> > > > Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
> > > > will load from the buffer in groups of 32 bits, and when compiled for
> > > > 64-bit will load in groups of 64 bits. Benchmarking by proxy compiling
> > > > csum_ipv6_magic (64-bit version) for an x86 chip as well as running
> > > > the riscv generated code in QEMU, discovered that summing in a
> > > > tree-like structure is about 4% faster than doing 64-bit reads.
> > > >
> > > ...
> > > > +	sum   = saddr->s6_addr32[0];
> > > > +	sum  += saddr->s6_addr32[1];
> > > > +	sum1  = saddr->s6_addr32[2];
> > > > +	sum1 += saddr->s6_addr32[3];
> > > > +
> > > > +	sum2  = daddr->s6_addr32[0];
> > > > +	sum2 += daddr->s6_addr32[1];
> > > > +	sum3  = daddr->s6_addr32[2];
> > > > +	sum3 += daddr->s6_addr32[3];
> > > > +
> > > > +	sum4  = csum;
> > > > +	sum4 += ulen;
> > > > +	sum4 += uproto;
> > > > +
> > > > +	sum  += sum1;
> > > > +	sum2 += sum3;
> > > > +
> > > > +	sum += sum2;
> > > > +	sum += sum4;
> > >
> > > Have you got gcc to compile that as-is?
> > >
> > > Whenever I've tried to get a 'tree add' compiled so that the
> > > early adds can be executed in parallel gcc always pessimises
> > > it to a linear sequence of adds.
> > >
> > > But I agree that adding 32bit values to a 64bit register
> > > may be no slower than trying to do an 'add carry' sequence
> > > that is guaranteed to only do one add/clock.
> > > (And on Intel cpu from core-2 until IIRC Haswell adc took 2 clocks!)
> > >
> > > IIRC RISCV doesn't have a carry flag, so the adc sequence
> > > is hard - probably takes two extra instructions per value.
> > > Although with parallel execute it may not matter.
> > > Consider:
> > > 	val = buf[offset];
> > > 	sum += val;
> > > 	carry += sum < val;
> > > 	val = buf[offset1];
> > > 	sum += val;
> > > 	...
> > > the compare and 'carry +=' can be executed at the same time
> > > as the following two instructions.
> > > You do then a final sum += carry; sum += sum < carry;
> > >
> > > Assuming all instructions are 1 clock and any read delays
> > > get filled with other instructions (by source or hardware
> > > instruction re-ordering) even without parallel execute
> > > that is 4 clocks for 64 bits, which is much the same as the
> > > 2 clocks for 32 bits.
> > >
> > > Remember that all the 32bit values can summed first as
> > > they won't overflow.
> > >
> > > 	David
> 
> > Yeah it does seem like the tree-add does just do a linear add. All three
> > of them were pretty much the same on riscv so I used the version that
> > did best on x86 with the knowledge that my QEMU setup does not
> > accurately represent real hardware.
> 
> The problem there is that any measurement on x86 has pretty much
> no relevance to what any RISCV cpu might do.
> The multiple execution units and out of order execution on x86
> are far different from anything any RISCV cpu is likely to have
> for many years.
> You might get nearer running on one of the Atom cpu - but it won't
> really match.
> There are too many fundamental differences between the architectures.
> 
> All you can do is to find and read the instruction timings for
> a target physical cpu and look for things like:
> - Whether arithmetic results are available next clock.
>   (It probably is)
> - How many clocks it takes for read data to be available.
>   I suspect the cpu will stall if the data is needed.
>   A block of sequential reads is one way to avoid the stall.
>   On x86 the instruction that needs the data is just deferred
>   until it is available, the following instructions execute
>   (provided their input are all available).
> - Clock delays for taken/not taken predicted/not predicted branches.
>   
> > I don't quite understand how doing the carry in the middle of each
> > stage, even though it can be executed at the same time, would be faster
> > than just doing a single overflow check at the end.
> 
> You need to do half as many reads and adds.
> 
I missed that you were talking about 64-bit reads. I was talking to
somebody about this a couple weeks ago and they mentioned a counter
example that showed that adding the carry after was not the same as
adding it in the middle. Even though addition is commutative, I wasn't
sure if the overflow checking was. I can't rememeber what the counter
example was, but I have a feeling it was flawed.
> > I can just revert
> > back to the non-tree add version since there is no improvement on riscv.
> 
> The 'tree' version is only likely to be faster on cpu (like x86)
> that can (at least sometimes) do two memory reads in one clock
> and can do two adds and two read in the same clock.
> Even then, without out of order execution, it is hard to get right.
> 
> Oh, you might want to try getting the default csum_fold() to
> be the faster 'arc' version rather than adding your own version.
> 
> 	David
> 
> > I can also revert back to the default version that uses carry += sum < val
> > as well.
> > 
> > - Charlie
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
